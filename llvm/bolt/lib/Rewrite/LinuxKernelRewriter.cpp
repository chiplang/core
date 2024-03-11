//===- bolt/Rewrite/LinuxKernelRewriter.cpp -------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Support for updating Linux Kernel metadata.
//
//===----------------------------------------------------------------------===//

#include "bolt/Core/BinaryFunction.h"
#include "bolt/Rewrite/MetadataRewriter.h"
#include "bolt/Rewrite/MetadataRewriters.h"
#include "bolt/Utils/CommandLineOpts.h"
#include "llvm/ADT/DenseSet.h"
#include "llvm/Support/BinaryStreamWriter.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/Errc.h"

#define DEBUG_TYPE "bolt-linux"

using namespace llvm;
using namespace bolt;

namespace opts {

static cl::opt<bool>
    AltInstHasPadLen("alt-inst-has-padlen",
                     cl::desc("specify that .altinstructions has padlen field"),
                     cl::init(false), cl::Hidden, cl::cat(BoltCategory));

static cl::opt<uint32_t>
    AltInstFeatureSize("alt-inst-feature-size",
                       cl::desc("size of feature field in .altinstructions"),
                       cl::init(2), cl::Hidden, cl::cat(BoltCategory));

static cl::opt<bool>
    DumpAltInstructions("dump-alt-instructions",
                        cl::desc("dump Linux alternative instructions info"),
                        cl::init(false), cl::Hidden, cl::cat(BoltCategory));

static cl::opt<bool>
    DumpExceptions("dump-linux-exceptions",
                   cl::desc("dump Linux kernel exception table"),
                   cl::init(false), cl::Hidden, cl::cat(BoltCategory));

static cl::opt<bool>
    DumpORC("dump-orc", cl::desc("dump raw ORC unwind information (sorted)"),
            cl::init(false), cl::Hidden, cl::cat(BoltCategory));

static cl::opt<bool> DumpParavirtualPatchSites(
    "dump-para-sites", cl::desc("dump Linux kernel paravitual patch sites"),
    cl::init(false), cl::Hidden, cl::cat(BoltCategory));

static cl::opt<bool> DumpStaticCalls("dump-static-calls",
                                     cl::desc("dump Linux kernel static calls"),
                                     cl::init(false), cl::Hidden,
                                     cl::cat(BoltCategory));

static cl::opt<bool>
    PrintORC("print-orc",
             cl::desc("print ORC unwind information for instructions"),
             cl::init(true), cl::Hidden, cl::cat(BoltCategory));

} // namespace opts

/// Linux Kernel supports stack unwinding using ORC (oops rewind capability).
/// ORC state at every IP can be described by the following data structure.
struct ORCState {
  int16_t SPOffset;
  int16_t BPOffset;
  int16_t Info;

  bool operator==(const ORCState &Other) const {
    return SPOffset == Other.SPOffset && BPOffset == Other.BPOffset &&
           Info == Other.Info;
  }

  bool operator!=(const ORCState &Other) const { return !(*this == Other); }
};

/// Section terminator ORC entry.
static ORCState NullORC = {0, 0, 0};

/// Basic printer for ORC entry. It does not provide the same level of
/// information as objtool (for now).
inline raw_ostream &operator<<(raw_ostream &OS, const ORCState &E) {
  if (!opts::PrintORC)
    return OS;
  if (E != NullORC)
    OS << format("{sp: %d, bp: %d, info: 0x%x}", E.SPOffset, E.BPOffset,
                 E.Info);
  else
    OS << "{terminator}";

  return OS;
}

namespace {

class LinuxKernelRewriter final : public MetadataRewriter {
  /// Linux Kernel special sections point to a specific instruction in many
  /// cases. Unlike SDTMarkerInfo, these markers can come from different
  /// sections.
  struct LKInstructionMarkerInfo {
    uint64_t SectionOffset;
    int32_t PCRelativeOffset;
    bool IsPCRelative;
    StringRef SectionName;
  };

  /// Map linux kernel program locations/instructions to their pointers in
  /// special linux kernel sections
  std::unordered_map<uint64_t, std::vector<LKInstructionMarkerInfo>> LKMarkers;

  /// Linux ORC sections.
  ErrorOr<BinarySection &> ORCUnwindSection = std::errc::bad_address;
  ErrorOr<BinarySection &> ORCUnwindIPSection = std::errc::bad_address;

  /// Size of entries in ORC sections.
  static constexpr size_t ORC_UNWIND_ENTRY_SIZE = 6;
  static constexpr size_t ORC_UNWIND_IP_ENTRY_SIZE = 4;

  struct ORCListEntry {
    uint64_t IP;        /// Instruction address.
    BinaryFunction *BF; /// Binary function corresponding to the entry.
    ORCState ORC;       /// Stack unwind info in ORC format.

    /// ORC entries are sorted by their IPs. Terminator entries (NullORC)
    /// should precede other entries with the same address.
    bool operator<(const ORCListEntry &Other) const {
      if (IP < Other.IP)
        return 1;
      if (IP > Other.IP)
        return 0;
      return ORC == NullORC && Other.ORC != NullORC;
    }
  };

  using ORCListType = std::vector<ORCListEntry>;
  ORCListType ORCEntries;

  /// Number of entries in the input file ORC sections.
  uint64_t NumORCEntries = 0;

  /// Section containing static call table.
  ErrorOr<BinarySection &> StaticCallSection = std::errc::bad_address;
  uint64_t StaticCallTableAddress = 0;
  static constexpr size_t STATIC_CALL_ENTRY_SIZE = 8;

  struct StaticCallInfo {
    uint32_t ID;              /// Identifier of the entry in the table.
    BinaryFunction *Function; /// Function containing associated call.
    MCSymbol *Label;          /// Label attached to the call.
  };
  using StaticCallListType = std::vector<StaticCallInfo>;
  StaticCallListType StaticCallEntries;

  /// Section containing the Linux exception table.
  ErrorOr<BinarySection &> ExceptionsSection = std::errc::bad_address;
  static constexpr size_t EXCEPTION_TABLE_ENTRY_SIZE = 12;

  /// Functions with exception handling code.
  DenseSet<BinaryFunction *> FunctionsWithExceptions;

  /// Section with paravirtual patch sites.
  ErrorOr<BinarySection &> ParavirtualPatchSection = std::errc::bad_address;

  /// Alignment of paravirtual patch structures.
  static constexpr size_t PARA_PATCH_ALIGN = 8;

  /// .altinstructions section.
  ErrorOr<BinarySection &> AltInstrSection = std::errc::bad_address;

  /// Section containing Linux bug table.
  ErrorOr<BinarySection &> BugTableSection = std::errc::bad_address;

  /// Size of bug_entry struct.
  static constexpr size_t BUG_TABLE_ENTRY_SIZE = 12;

  /// Insert an LKMarker for a given code pointer \p PC from a non-code section
  /// \p SectionName.
  void insertLKMarker(uint64_t PC, uint64_t SectionOffset,
                      int32_t PCRelativeOffset, bool IsPCRelative,
                      StringRef SectionName);

  /// Process linux kernel special sections and their relocations.
  void processLKSections();

  /// Process special linux kernel section, .pci_fixup.
  void processLKPCIFixup();

  /// Process __ksymtab and __ksymtab_gpl.
  void processLKKSymtab(bool IsGPL = false);

  /// Process special linux kernel section, .smp_locks.
  void processLKSMPLocks();

  /// Update LKMarkers' locations for the output binary.
  void updateLKMarkers();

  /// Read ORC unwind information and annotate instructions.
  Error readORCTables();

  /// Update ORC for functions once CFG is constructed.
  Error processORCPostCFG();

  /// Update ORC data in the binary.
  Error rewriteORCTables();

  /// Static call table handling.
  Error readStaticCalls();
  Error rewriteStaticCalls();

  Error readExceptionTable();
  Error rewriteExceptionTable();

  /// Paravirtual instruction patch sites.
  Error readParaInstructions();

  Error readBugTable();

  /// Read alternative instruction info from .altinstructions.
  Error readAltInstructions();

  /// Mark instructions referenced by kernel metadata.
  Error markInstructions();

public:
  LinuxKernelRewriter(BinaryContext &BC)
      : MetadataRewriter("linux-kernel-rewriter", BC) {}

  Error preCFGInitializer() override {
    processLKSections();
    if (Error E = markInstructions())
      return E;

    if (Error E = readORCTables())
      return E;

    if (Error E = readStaticCalls())
      return E;

    if (Error E = readExceptionTable())
      return E;

    if (Error E = readParaInstructions())
      return E;

    if (Error E = readBugTable())
      return E;

    if (Error E = readAltInstructions())
      return E;

    return Error::success();
  }

  Error postCFGInitializer() override {
    if (Error E = processORCPostCFG())
      return E;

    return Error::success();
  }

  Error preEmitFinalizer() override {
    // Since rewriteExceptionTable() can mark functions as non-simple, run it
    // before other rewriters that depend on simple/emit status.
    if (Error E = rewriteExceptionTable())
      return E;

    if (Error E = rewriteORCTables())
      return E;

    if (Error E = rewriteStaticCalls())
      return E;

    return Error::success();
  }

  Error postEmitFinalizer() override {
    updateLKMarkers();

    return Error::success();
  }
};

Error LinuxKernelRewriter::markInstructions() {
  for (const uint64_t PC : llvm::make_first_range(LKMarkers)) {
    BinaryFunction *BF = BC.getBinaryFunctionContainingAddress(PC);

    if (!BF || !BC.shouldEmit(*BF))
      continue;

    const uint64_t Offset = PC - BF->getAddress();
    MCInst *Inst = BF->getInstructionAtOffset(Offset);
    if (!Inst)
      return createStringError(errc::executable_format_error,
                               "no instruction matches kernel marker offset");

    BC.MIB->setOffset(*Inst, static_cast<uint32_t>(Offset));

    BF->setHasSDTMarker(true);
  }

  return Error::success();
}

void LinuxKernelRewriter::insertLKMarker(uint64_t PC, uint64_t SectionOffset,
                                         int32_t PCRelativeOffset,
                                         bool IsPCRelative,
                                         StringRef SectionName) {
  LKMarkers[PC].emplace_back(LKInstructionMarkerInfo{
      SectionOffset, PCRelativeOffset, IsPCRelative, SectionName});
}

void LinuxKernelRewriter::processLKSections() {
  processLKPCIFixup();
  processLKKSymtab();
  processLKKSymtab(true);
  processLKSMPLocks();
}

/// Process .pci_fixup section of Linux Kernel.
/// This section contains a list of entries for different PCI devices and their
/// corresponding hook handler (code pointer where the fixup
/// code resides, usually on x86_64 it is an entry PC relative 32 bit offset).
/// Documentation is in include/linux/pci.h.
void LinuxKernelRewriter::processLKPCIFixup() {
  ErrorOr<BinarySection &> SectionOrError =
      BC.getUniqueSectionByName(".pci_fixup");
  if (!SectionOrError)
    return;

  const uint64_t SectionSize = SectionOrError->getSize();
  const uint64_t SectionAddress = SectionOrError->getAddress();
  assert((SectionSize % 16) == 0 && ".pci_fixup size is not a multiple of 16");

  for (uint64_t I = 12; I + 4 <= SectionSize; I += 16) {
    const uint64_t PC = SectionAddress + I;
    ErrorOr<uint64_t> Offset = BC.getSignedValueAtAddress(PC, 4);
    assert(Offset && "cannot read value from .pci_fixup");
    const int32_t SignedOffset = *Offset;
    const uint64_t HookupAddress = PC + SignedOffset;
    BinaryFunction *HookupFunction =
        BC.getBinaryFunctionAtAddress(HookupAddress);
    assert(HookupFunction && "expected function for entry in .pci_fixup");
    BC.addRelocation(PC, HookupFunction->getSymbol(), Relocation::getPC32(), 0,
                     *Offset);
  }
}

/// Process __ksymtab[_gpl] sections of Linux Kernel.
/// This section lists all the vmlinux symbols that kernel modules can access.
///
/// All the entries are 4 bytes each and hence we can read them by one by one
/// and ignore the ones that are not pointing to the .text section. All pointers
/// are PC relative offsets. Always, points to the beginning of the function.
void LinuxKernelRewriter::processLKKSymtab(bool IsGPL) {
  StringRef SectionName = "__ksymtab";
  if (IsGPL)
    SectionName = "__ksymtab_gpl";
  ErrorOr<BinarySection &> SectionOrError =
      BC.getUniqueSectionByName(SectionName);
  assert(SectionOrError &&
         "__ksymtab[_gpl] section not found in Linux Kernel binary");
  const uint64_t SectionSize = SectionOrError->getSize();
  const uint64_t SectionAddress = SectionOrError->getAddress();
  assert((SectionSize % 4) == 0 &&
         "The size of the __ksymtab[_gpl] section should be a multiple of 4");

  for (uint64_t I = 0; I < SectionSize; I += 4) {
    const uint64_t EntryAddress = SectionAddress + I;
    ErrorOr<uint64_t> Offset = BC.getSignedValueAtAddress(EntryAddress, 4);
    assert(Offset && "Reading valid PC-relative offset for a ksymtab entry");
    const int32_t SignedOffset = *Offset;
    const uint64_t RefAddress = EntryAddress + SignedOffset;
    BinaryFunction *BF = BC.getBinaryFunctionAtAddress(RefAddress);
    if (!BF)
      continue;

    BC.addRelocation(EntryAddress, BF->getSymbol(), Relocation::getPC32(), 0,
                     *Offset);
  }
}

/// .smp_locks section contains PC-relative references to instructions with LOCK
/// prefix. The prefix can be converted to NOP at boot time on non-SMP systems.
void LinuxKernelRewriter::processLKSMPLocks() {
  ErrorOr<BinarySection &> SectionOrError =
      BC.getUniqueSectionByName(".smp_locks");
  if (!SectionOrError)
    return;

  uint64_t SectionSize = SectionOrError->getSize();
  const uint64_t SectionAddress = SectionOrError->getAddress();
  assert((SectionSize % 4) == 0 &&
         "The size of the .smp_locks section should be a multiple of 4");

  for (uint64_t I = 0; I < SectionSize; I += 4) {
    const uint64_t EntryAddress = SectionAddress + I;
    ErrorOr<uint64_t> Offset = BC.getSignedValueAtAddress(EntryAddress, 4);
    assert(Offset && "Reading valid PC-relative offset for a .smp_locks entry");
    int32_t SignedOffset = *Offset;
    uint64_t RefAddress = EntryAddress + SignedOffset;

    BinaryFunction *ContainingBF =
        BC.getBinaryFunctionContainingAddress(RefAddress);
    if (!ContainingBF)
      continue;

    insertLKMarker(RefAddress, I, SignedOffset, true, ".smp_locks");
  }
}

void LinuxKernelRewriter::updateLKMarkers() {
  if (LKMarkers.size() == 0)
    return;

  std::unordered_map<std::string, uint64_t> PatchCounts;
  for (std::pair<const uint64_t, std::vector<LKInstructionMarkerInfo>>
           &LKMarkerInfoKV : LKMarkers) {
    const uint64_t OriginalAddress = LKMarkerInfoKV.first;
    const BinaryFunction *BF =
        BC.getBinaryFunctionContainingAddress(OriginalAddress, false, true);
    if (!BF)
      continue;

    uint64_t NewAddress = BF->translateInputToOutputAddress(OriginalAddress);
    if (NewAddress == 0)
      continue;

    // Apply base address.
    if (OriginalAddress >= 0xffffffff00000000 && NewAddress < 0xffffffff)
      NewAddress = NewAddress + 0xffffffff00000000;

    if (OriginalAddress == NewAddress)
      continue;

    for (LKInstructionMarkerInfo &LKMarkerInfo : LKMarkerInfoKV.second) {
      StringRef SectionName = LKMarkerInfo.SectionName;
      SimpleBinaryPatcher *LKPatcher;
      ErrorOr<BinarySection &> BSec = BC.getUniqueSectionByName(SectionName);
      assert(BSec && "missing section info for kernel section");
      if (!BSec->getPatcher())
        BSec->registerPatcher(std::make_unique<SimpleBinaryPatcher>());
      LKPatcher = static_cast<SimpleBinaryPatcher *>(BSec->getPatcher());
      PatchCounts[std::string(SectionName)]++;
      if (LKMarkerInfo.IsPCRelative)
        LKPatcher->addLE32Patch(LKMarkerInfo.SectionOffset,
                                NewAddress - OriginalAddress +
                                    LKMarkerInfo.PCRelativeOffset);
      else
        LKPatcher->addLE64Patch(LKMarkerInfo.SectionOffset, NewAddress);
    }
  }
  BC.outs() << "BOLT-INFO: patching linux kernel sections. Total patches per "
               "section are as follows:\n";
  for (const std::pair<const std::string, uint64_t> &KV : PatchCounts)
    BC.outs() << "  Section: " << KV.first << ", patch-counts: " << KV.second
              << '\n';
}

Error LinuxKernelRewriter::readORCTables() {
  // NOTE: we should ignore relocations for orc tables as the tables are sorted
  // post-link time and relocations are not updated.
  ORCUnwindSection = BC.getUniqueSectionByName(".orc_unwind");
  ORCUnwindIPSection = BC.getUniqueSectionByName(".orc_unwind_ip");

  if (!ORCUnwindSection && !ORCUnwindIPSection)
    return Error::success();

  if (!ORCUnwindSection || !ORCUnwindIPSection)
    return createStringError(errc::executable_format_error,
                             "missing ORC section");

  NumORCEntries = ORCUnwindIPSection->getSize() / ORC_UNWIND_IP_ENTRY_SIZE;
  if (ORCUnwindSection->getSize() != NumORCEntries * ORC_UNWIND_ENTRY_SIZE ||
      ORCUnwindIPSection->getSize() != NumORCEntries * ORC_UNWIND_IP_ENTRY_SIZE)
    return createStringError(errc::executable_format_error,
                             "ORC entries number mismatch detected");

  const uint64_t IPSectionAddress = ORCUnwindIPSection->getAddress();
  DataExtractor OrcDE = DataExtractor(ORCUnwindSection->getContents(),
                                      BC.AsmInfo->isLittleEndian(),
                                      BC.AsmInfo->getCodePointerSize());
  DataExtractor IPDE = DataExtractor(ORCUnwindIPSection->getContents(),
                                     BC.AsmInfo->isLittleEndian(),
                                     BC.AsmInfo->getCodePointerSize());
  DataExtractor::Cursor ORCCursor(0);
  DataExtractor::Cursor IPCursor(0);
  uint64_t PrevIP = 0;
  for (uint32_t Index = 0; Index < NumORCEntries; ++Index) {
    const uint64_t IP =
        IPSectionAddress + IPCursor.tell() + (int32_t)IPDE.getU32(IPCursor);

    // Consume the status of the cursor.
    if (!IPCursor)
      return createStringError(errc::executable_format_error,
                               "out of bounds while reading ORC IP table: %s",
                               toString(IPCursor.takeError()).c_str());

    if (IP < PrevIP && opts::Verbosity)
      BC.errs() << "BOLT-WARNING: out of order IP 0x" << Twine::utohexstr(IP)
                << " detected while reading ORC\n";

    PrevIP = IP;

    // Store all entries, includes those we are not going to update as the
    // tables need to be sorted globally before being written out.
    ORCEntries.push_back(ORCListEntry());
    ORCListEntry &Entry = ORCEntries.back();

    Entry.IP = IP;
    Entry.ORC.SPOffset = (int16_t)OrcDE.getU16(ORCCursor);
    Entry.ORC.BPOffset = (int16_t)OrcDE.getU16(ORCCursor);
    Entry.ORC.Info = (int16_t)OrcDE.getU16(ORCCursor);
    Entry.BF = nullptr;

    // Consume the status of the cursor.
    if (!ORCCursor)
      return createStringError(errc::executable_format_error,
                               "out of bounds while reading ORC: %s",
                               toString(ORCCursor.takeError()).c_str());

    if (Entry.ORC == NullORC)
      continue;

    BinaryFunction *&BF = Entry.BF;
    BF = BC.getBinaryFunctionContainingAddress(IP, /*CheckPastEnd*/ true);

    // If the entry immediately pointing past the end of the function is not
    // the terminator entry, then it does not belong to this function.
    if (BF && BF->getAddress() + BF->getSize() == IP)
      BF = 0;

    if (!BF) {
      if (opts::Verbosity)
        BC.errs() << "BOLT-WARNING: no binary function found matching ORC 0x"
                  << Twine::utohexstr(IP) << ": " << Entry.ORC << '\n';
      continue;
    }

    BF->setHasORC(true);

    if (!BF->hasInstructions())
      continue;

    MCInst *Inst = BF->getInstructionAtOffset(IP - BF->getAddress());
    if (!Inst)
      return createStringError(
          errc::executable_format_error,
          "no instruction at address 0x%" PRIx64 " in .orc_unwind_ip", IP);

    // Some addresses will have two entries associated with them. The first
    // one being a "weak" section terminator. Since we ignore the terminator,
    // we should only assign one entry per instruction.
    if (BC.MIB->hasAnnotation(*Inst, "ORC"))
      return createStringError(
          errc::executable_format_error,
          "duplicate non-terminal ORC IP 0x%" PRIx64 " in .orc_unwind_ip", IP);

    BC.MIB->addAnnotation(*Inst, "ORC", Entry.ORC);
  }

  BC.outs() << "BOLT-INFO: parsed " << NumORCEntries << " ORC entries\n";

  if (opts::DumpORC) {
    BC.outs() << "BOLT-INFO: ORC unwind information:\n";
    for (const ORCListEntry &E : ORCEntries) {
      BC.outs() << "0x" << Twine::utohexstr(E.IP) << ": " << E.ORC;
      if (E.BF)
        BC.outs() << ": " << *E.BF;
      BC.outs() << '\n';
    }
  }

  // Add entries for functions that don't have explicit ORC info at the start.
  // We'll have the correct info for them even if ORC for the preceding function
  // changes.
  ORCListType NewEntries;
  for (BinaryFunction &BF : llvm::make_second_range(BC.getBinaryFunctions())) {
    auto It = llvm::partition_point(ORCEntries, [&](const ORCListEntry &E) {
      return E.IP <= BF.getAddress();
    });
    if (It != ORCEntries.begin())
      --It;

    if (It->BF == &BF)
      continue;

    if (It->ORC == NullORC && It->IP == BF.getAddress()) {
      assert(!It->BF);
      It->BF = &BF;
      continue;
    }

    NewEntries.push_back({BF.getAddress(), &BF, It->ORC});
    if (It->ORC != NullORC)
      BF.setHasORC(true);
  }

  llvm::copy(NewEntries, std::back_inserter(ORCEntries));
  llvm::sort(ORCEntries);

  if (opts::DumpORC) {
    BC.outs() << "BOLT-INFO: amended ORC unwind information:\n";
    for (const ORCListEntry &E : ORCEntries) {
      BC.outs() << "0x" << Twine::utohexstr(E.IP) << ": " << E.ORC;
      if (E.BF)
        BC.outs() << ": " << *E.BF;
      BC.outs() << '\n';
    }
  }

  return Error::success();
}

Error LinuxKernelRewriter::processORCPostCFG() {
  if (!NumORCEntries)
    return Error::success();

  // Propagate ORC to the rest of the function. We can annotate every
  // instruction in every function, but to minimize the overhead, we annotate
  // the first instruction in every basic block to reflect the state at the
  // entry. This way, the ORC state can be calculated based on annotations
  // regardless of the basic block layout. Note that if we insert/delete
  // instructions, we must take care to attach ORC info to the new/deleted ones.
  for (BinaryFunction &BF : llvm::make_second_range(BC.getBinaryFunctions())) {

    std::optional<ORCState> CurrentState;
    for (BinaryBasicBlock &BB : BF) {
      for (MCInst &Inst : BB) {
        ErrorOr<ORCState> State =
            BC.MIB->tryGetAnnotationAs<ORCState>(Inst, "ORC");

        if (State) {
          CurrentState = *State;
          continue;
        }

        // Get state for the start of the function.
        if (!CurrentState) {
          // A terminator entry (NullORC) can match the function address. If
          // there's also a non-terminator entry, it will be placed after the
          // terminator. Hence, we are looking for the last ORC entry that
          // matches the address.
          auto It =
              llvm::partition_point(ORCEntries, [&](const ORCListEntry &E) {
                return E.IP <= BF.getAddress();
              });
          if (It != ORCEntries.begin())
            --It;

          assert(It->IP == BF.getAddress() && (!It->BF || It->BF == &BF) &&
                 "ORC info at function entry expected.");

          if (It->ORC == NullORC && BF.hasORC()) {
            BC.errs() << "BOLT-WARNING: ORC unwind info excludes prologue for "
                      << BF << '\n';
          }

          It->BF = &BF;

          CurrentState = It->ORC;
          if (It->ORC != NullORC)
            BF.setHasORC(true);
        }

        // While printing ORC, attach info to every instruction for convenience.
        if (opts::PrintORC || &Inst == &BB.front())
          BC.MIB->addAnnotation(Inst, "ORC", *CurrentState);
      }
    }
  }

  return Error::success();
}

Error LinuxKernelRewriter::rewriteORCTables() {
  if (!NumORCEntries)
    return Error::success();

  // Update ORC sections in-place. As we change the code, the number of ORC
  // entries may increase for some functions. However, as we remove terminator
  // redundancy (see below), more space is freed up and we should always be able
  // to fit new ORC tables in the reserved space.
  auto createInPlaceWriter = [&](BinarySection &Section) -> BinaryStreamWriter {
    const size_t Size = Section.getSize();
    uint8_t *NewContents = new uint8_t[Size];
    Section.updateContents(NewContents, Size);
    Section.setOutputFileOffset(Section.getInputFileOffset());
    return BinaryStreamWriter({NewContents, Size}, BC.AsmInfo->isLittleEndian()
                                                       ? endianness::little
                                                       : endianness::big);
  };
  BinaryStreamWriter UnwindWriter = createInPlaceWriter(*ORCUnwindSection);
  BinaryStreamWriter UnwindIPWriter = createInPlaceWriter(*ORCUnwindIPSection);

  uint64_t NumEmitted = 0;
  std::optional<ORCState> LastEmittedORC;
  auto emitORCEntry = [&](const uint64_t IP, const ORCState &ORC,
                          MCSymbol *Label = 0, bool Force = false) -> Error {
    if (LastEmittedORC && ORC == *LastEmittedORC && !Force)
      return Error::success();

    LastEmittedORC = ORC;

    if (++NumEmitted > NumORCEntries)
      return createStringError(errc::executable_format_error,
                               "exceeded the number of allocated ORC entries");

    if (Label)
      ORCUnwindIPSection->addRelocation(UnwindIPWriter.getOffset(), Label,
                                        Relocation::getPC32(), /*Addend*/ 0);

    const int32_t IPValue =
        IP - ORCUnwindIPSection->getAddress() - UnwindIPWriter.getOffset();
    if (Error E = UnwindIPWriter.writeInteger(IPValue))
      return E;

    if (Error E = UnwindWriter.writeInteger(ORC.SPOffset))
      return E;
    if (Error E = UnwindWriter.writeInteger(ORC.BPOffset))
      return E;
    if (Error E = UnwindWriter.writeInteger(ORC.Info))
      return E;

    return Error::success();
  };

  // Emit new ORC entries for the emitted function.
  auto emitORC = [&](const BinaryFunction &BF) -> Error {
    assert(!BF.isSplit() && "Split functions not supported by ORC writer yet.");

    ORCState CurrentState = NullORC;
    for (BinaryBasicBlock *BB : BF.getLayout().blocks()) {
      for (MCInst &Inst : *BB) {
        ErrorOr<ORCState> ErrorOrState =
            BC.MIB->tryGetAnnotationAs<ORCState>(Inst, "ORC");
        if (!ErrorOrState || *ErrorOrState == CurrentState)
          continue;

        // Issue label for the instruction.
        MCSymbol *Label =
            BC.MIB->getOrCreateInstLabel(Inst, "__ORC_", BC.Ctx.get());

        if (Error E = emitORCEntry(0, *ErrorOrState, Label))
          return E;

        CurrentState = *ErrorOrState;
      }
    }

    return Error::success();
  };

  for (ORCListEntry &Entry : ORCEntries) {
    // Emit original entries for functions that we haven't modified.
    if (!Entry.BF || !BC.shouldEmit(*Entry.BF)) {
      // Emit terminator only if it marks the start of a function.
      if (Entry.ORC == NullORC && !Entry.BF)
        continue;
      if (Error E = emitORCEntry(Entry.IP, Entry.ORC))
        return E;
      continue;
    }

    // Emit all ORC entries for a function referenced by an entry and skip over
    // the rest of entries for this function by resetting its ORC attribute.
    if (Entry.BF->hasORC()) {
      if (Error E = emitORC(*Entry.BF))
        return E;
      Entry.BF->setHasORC(false);
    }
  }

  LLVM_DEBUG(dbgs() << "BOLT-DEBUG: emitted " << NumEmitted
                    << " ORC entries\n");

  // Replicate terminator entry at the end of sections to match the original
  // table sizes.
  const BinaryFunction &LastBF = BC.getBinaryFunctions().rbegin()->second;
  const uint64_t LastIP = LastBF.getAddress() + LastBF.getMaxSize();
  while (UnwindWriter.bytesRemaining()) {
    if (Error E = emitORCEntry(LastIP, NullORC, nullptr, /*Force*/ true))
      return E;
  }

  return Error::success();
}

/// The static call site table is created by objtool and contains entries in the
/// following format:
///
///    struct static_call_site {
///      s32 addr;
///      s32 key;
///    };
///
Error LinuxKernelRewriter::readStaticCalls() {
  const BinaryData *StaticCallTable =
      BC.getBinaryDataByName("__start_static_call_sites");
  if (!StaticCallTable)
    return Error::success();

  StaticCallTableAddress = StaticCallTable->getAddress();

  const BinaryData *Stop = BC.getBinaryDataByName("__stop_static_call_sites");
  if (!Stop)
    return createStringError(errc::executable_format_error,
                             "missing __stop_static_call_sites symbol");

  ErrorOr<BinarySection &> ErrorOrSection =
      BC.getSectionForAddress(StaticCallTableAddress);
  if (!ErrorOrSection)
    return createStringError(errc::executable_format_error,
                             "no section matching __start_static_call_sites");

  StaticCallSection = *ErrorOrSection;
  if (!StaticCallSection->containsAddress(Stop->getAddress() - 1))
    return createStringError(errc::executable_format_error,
                             "__stop_static_call_sites not in the same section "
                             "as __start_static_call_sites");

  if ((Stop->getAddress() - StaticCallTableAddress) % STATIC_CALL_ENTRY_SIZE)
    return createStringError(errc::executable_format_error,
                             "static call table size error");

  const uint64_t SectionAddress = StaticCallSection->getAddress();
  DataExtractor DE(StaticCallSection->getContents(),
                   BC.AsmInfo->isLittleEndian(),
                   BC.AsmInfo->getCodePointerSize());
  DataExtractor::Cursor Cursor(StaticCallTableAddress - SectionAddress);
  uint32_t EntryID = 0;
  while (Cursor && Cursor.tell() < Stop->getAddress() - SectionAddress) {
    const uint64_t CallAddress =
        SectionAddress + Cursor.tell() + (int32_t)DE.getU32(Cursor);
    const uint64_t KeyAddress =
        SectionAddress + Cursor.tell() + (int32_t)DE.getU32(Cursor);

    // Consume the status of the cursor.
    if (!Cursor)
      return createStringError(errc::executable_format_error,
                               "out of bounds while reading static calls: %s",
                               toString(Cursor.takeError()).c_str());

    ++EntryID;

    if (opts::DumpStaticCalls) {
      BC.outs() << "Static Call Site: " << EntryID << '\n';
      BC.outs() << "\tCallAddress:   0x" << Twine::utohexstr(CallAddress)
                << "\n\tKeyAddress:    0x" << Twine::utohexstr(KeyAddress)
                << '\n';
    }

    BinaryFunction *BF = BC.getBinaryFunctionContainingAddress(CallAddress);
    if (!BF)
      continue;

    if (!BC.shouldEmit(*BF))
      continue;

    if (!BF->hasInstructions())
      continue;

    MCInst *Inst = BF->getInstructionAtOffset(CallAddress - BF->getAddress());
    if (!Inst)
      return createStringError(errc::executable_format_error,
                               "no instruction at call site address 0x%" PRIx64,
                               CallAddress);

    // Check for duplicate entries.
    if (BC.MIB->hasAnnotation(*Inst, "StaticCall"))
      return createStringError(errc::executable_format_error,
                               "duplicate static call site at 0x%" PRIx64,
                               CallAddress);

    BC.MIB->addAnnotation(*Inst, "StaticCall", EntryID);

    MCSymbol *Label =
        BC.MIB->getOrCreateInstLabel(*Inst, "__SC_", BC.Ctx.get());

    StaticCallEntries.push_back({EntryID, BF, Label});
  }

  BC.outs() << "BOLT-INFO: parsed " << StaticCallEntries.size()
            << " static call entries\n";

  return Error::success();
}

/// The static call table is sorted during boot time in
/// static_call_sort_entries(). This makes it possible to update existing
/// entries in-place ignoring their relative order.
Error LinuxKernelRewriter::rewriteStaticCalls() {
  if (!StaticCallTableAddress || !StaticCallSection)
    return Error::success();

  for (auto &Entry : StaticCallEntries) {
    if (!Entry.Function)
      continue;

    BinaryFunction &BF = *Entry.Function;
    if (!BC.shouldEmit(BF))
      continue;

    // Create a relocation against the label.
    const uint64_t EntryOffset = StaticCallTableAddress -
                                 StaticCallSection->getAddress() +
                                 (Entry.ID - 1) * STATIC_CALL_ENTRY_SIZE;
    StaticCallSection->addRelocation(EntryOffset, Entry.Label,
                                     ELF::R_X86_64_PC32, /*Addend*/ 0);
  }

  return Error::success();
}

/// Instructions that access user-space memory can cause page faults. These
/// faults will be handled by the kernel and execution will resume at the fixup
/// code location if the address was invalid. The kernel uses the exception
/// table to match the faulting instruction to its fixup. The table consists of
/// the following entries:
///
///   struct exception_table_entry {
///     int insn;
///     int fixup;
///     int data;
///   };
///
/// More info at:
/// https://www.kernel.org/doc/Documentation/x86/exception-tables.txt
Error LinuxKernelRewriter::readExceptionTable() {
  ExceptionsSection = BC.getUniqueSectionByName("__ex_table");
  if (!ExceptionsSection)
    return Error::success();

  if (ExceptionsSection->getSize() % EXCEPTION_TABLE_ENTRY_SIZE)
    return createStringError(errc::executable_format_error,
                             "exception table size error");

  const uint64_t SectionAddress = ExceptionsSection->getAddress();
  DataExtractor DE(ExceptionsSection->getContents(),
                   BC.AsmInfo->isLittleEndian(),
                   BC.AsmInfo->getCodePointerSize());
  DataExtractor::Cursor Cursor(0);
  uint32_t EntryID = 0;
  while (Cursor && Cursor.tell() < ExceptionsSection->getSize()) {
    const uint64_t InstAddress =
        SectionAddress + Cursor.tell() + (int32_t)DE.getU32(Cursor);
    const uint64_t FixupAddress =
        SectionAddress + Cursor.tell() + (int32_t)DE.getU32(Cursor);
    const uint64_t Data = DE.getU32(Cursor);

    // Consume the status of the cursor.
    if (!Cursor)
      return createStringError(
          errc::executable_format_error,
          "out of bounds while reading exception table: %s",
          toString(Cursor.takeError()).c_str());

    ++EntryID;

    if (opts::DumpExceptions) {
      BC.outs() << "Exception Entry: " << EntryID << '\n';
      BC.outs() << "\tInsn:  0x" << Twine::utohexstr(InstAddress) << '\n'
                << "\tFixup: 0x" << Twine::utohexstr(FixupAddress) << '\n'
                << "\tData:  0x" << Twine::utohexstr(Data) << '\n';
    }

    MCInst *Inst = nullptr;
    MCSymbol *FixupLabel = nullptr;

    BinaryFunction *InstBF = BC.getBinaryFunctionContainingAddress(InstAddress);
    if (InstBF && BC.shouldEmit(*InstBF)) {
      Inst = InstBF->getInstructionAtOffset(InstAddress - InstBF->getAddress());
      if (!Inst)
        return createStringError(errc::executable_format_error,
                                 "no instruction at address 0x%" PRIx64
                                 " in exception table",
                                 InstAddress);
      BC.MIB->addAnnotation(*Inst, "ExceptionEntry", EntryID);
      FunctionsWithExceptions.insert(InstBF);
    }

    if (!InstBF && opts::Verbosity) {
      BC.outs() << "BOLT-INFO: no function matches instruction at 0x"
                << Twine::utohexstr(InstAddress)
                << " referenced by Linux exception table\n";
    }

    BinaryFunction *FixupBF =
        BC.getBinaryFunctionContainingAddress(FixupAddress);
    if (FixupBF && BC.shouldEmit(*FixupBF)) {
      const uint64_t Offset = FixupAddress - FixupBF->getAddress();
      if (!FixupBF->getInstructionAtOffset(Offset))
        return createStringError(errc::executable_format_error,
                                 "no instruction at fixup address 0x%" PRIx64
                                 " in exception table",
                                 FixupAddress);
      FixupLabel = Offset ? FixupBF->addEntryPointAtOffset(Offset)
                          : FixupBF->getSymbol();
      if (Inst)
        BC.MIB->addAnnotation(*Inst, "Fixup", FixupLabel->getName());
      FunctionsWithExceptions.insert(FixupBF);
    }

    if (!FixupBF && opts::Verbosity) {
      BC.outs() << "BOLT-INFO: no function matches fixup code at 0x"
                << Twine::utohexstr(FixupAddress)
                << " referenced by Linux exception table\n";
    }
  }

  BC.outs() << "BOLT-INFO: parsed "
            << ExceptionsSection->getSize() / EXCEPTION_TABLE_ENTRY_SIZE
            << " exception table entries\n";

  return Error::success();
}

/// Depending on the value of CONFIG_BUILDTIME_TABLE_SORT, the kernel expects
/// the exception table to be sorted. Hence we have to sort it after code
/// reordering.
Error LinuxKernelRewriter::rewriteExceptionTable() {
  // Disable output of functions with exceptions before rewrite support is
  // added.
  for (BinaryFunction *BF : FunctionsWithExceptions)
    BF->setSimple(false);

  return Error::success();
}

/// .parainsrtuctions section contains information for patching parvirtual call
/// instructions during runtime. The entries in the section are in the form:
///
///    struct paravirt_patch_site {
///      u8 *instr;    /* original instructions */
///      u8 type;      /* type of this instruction */
///      u8 len;       /* length of original instruction */
///    };
///
/// Note that the structures are aligned at 8-byte boundary.
Error LinuxKernelRewriter::readParaInstructions() {
  ParavirtualPatchSection = BC.getUniqueSectionByName(".parainstructions");
  if (!ParavirtualPatchSection)
    return Error::success();

  DataExtractor DE = DataExtractor(ParavirtualPatchSection->getContents(),
                                   BC.AsmInfo->isLittleEndian(),
                                   BC.AsmInfo->getCodePointerSize());
  uint32_t EntryID = 0;
  DataExtractor::Cursor Cursor(0);
  while (Cursor && !DE.eof(Cursor)) {
    const uint64_t NextOffset = alignTo(Cursor.tell(), Align(PARA_PATCH_ALIGN));
    if (!DE.isValidOffset(NextOffset))
      break;

    Cursor.seek(NextOffset);

    const uint64_t InstrLocation = DE.getU64(Cursor);
    const uint8_t Type = DE.getU8(Cursor);
    const uint8_t Len = DE.getU8(Cursor);

    if (!Cursor)
      return createStringError(
          errc::executable_format_error,
          "out of bounds while reading .parainstructions: %s",
          toString(Cursor.takeError()).c_str());

    ++EntryID;

    if (opts::DumpParavirtualPatchSites) {
      BC.outs() << "Paravirtual patch site: " << EntryID << '\n';
      BC.outs() << "\tInstr: 0x" << Twine::utohexstr(InstrLocation)
                << "\n\tType:  0x" << Twine::utohexstr(Type) << "\n\tLen:   0x"
                << Twine::utohexstr(Len) << '\n';
    }

    BinaryFunction *BF = BC.getBinaryFunctionContainingAddress(InstrLocation);
    if (!BF && opts::Verbosity) {
      BC.outs() << "BOLT-INFO: no function matches address 0x"
                << Twine::utohexstr(InstrLocation)
                << " referenced by paravirutal patch site\n";
    }

    if (BF && BC.shouldEmit(*BF)) {
      MCInst *Inst =
          BF->getInstructionAtOffset(InstrLocation - BF->getAddress());
      if (!Inst)
        return createStringError(errc::executable_format_error,
                                 "no instruction at address 0x%" PRIx64
                                 " in paravirtual call site %d",
                                 InstrLocation, EntryID);
      BC.MIB->addAnnotation(*Inst, "ParaSite", EntryID);
    }
  }

  BC.outs() << "BOLT-INFO: parsed " << EntryID << " paravirtual patch sites\n";

  return Error::success();
}

/// Process __bug_table section.
/// This section contains information useful for kernel debugging.
/// Each entry in the section is a struct bug_entry that contains a pointer to
/// the ud2 instruction corresponding to the bug, corresponding file name (both
/// pointers use PC relative offset addressing), line number, and flags.
/// The definition of the struct bug_entry can be found in
/// `include/asm-generic/bug.h`
///
/// NB: find_bug() uses linear search to match an address to an entry in the bug
///     table. Hence there is no need to sort entries when rewriting the table.
Error LinuxKernelRewriter::readBugTable() {
  BugTableSection = BC.getUniqueSectionByName("__bug_table");
  if (!BugTableSection)
    return Error::success();

  if (BugTableSection->getSize() % BUG_TABLE_ENTRY_SIZE)
    return createStringError(errc::executable_format_error,
                             "bug table size error");

  const uint64_t SectionAddress = BugTableSection->getAddress();
  DataExtractor DE(BugTableSection->getContents(), BC.AsmInfo->isLittleEndian(),
                   BC.AsmInfo->getCodePointerSize());
  DataExtractor::Cursor Cursor(0);
  uint32_t EntryID = 0;
  while (Cursor && Cursor.tell() < BugTableSection->getSize()) {
    const uint64_t Pos = Cursor.tell();
    const uint64_t InstAddress =
        SectionAddress + Pos + (int32_t)DE.getU32(Cursor);
    Cursor.seek(Pos + BUG_TABLE_ENTRY_SIZE);

    if (!Cursor)
      return createStringError(errc::executable_format_error,
                               "out of bounds while reading __bug_table: %s",
                               toString(Cursor.takeError()).c_str());

    ++EntryID;

    BinaryFunction *BF = BC.getBinaryFunctionContainingAddress(InstAddress);
    if (!BF && opts::Verbosity) {
      BC.outs() << "BOLT-INFO: no function matches address 0x"
                << Twine::utohexstr(InstAddress)
                << " referenced by bug table\n";
    }

    if (BF && BC.shouldEmit(*BF)) {
      MCInst *Inst = BF->getInstructionAtOffset(InstAddress - BF->getAddress());
      if (!Inst)
        return createStringError(errc::executable_format_error,
                                 "no instruction at address 0x%" PRIx64
                                 " referenced by bug table entry %d",
                                 InstAddress, EntryID);
      BC.MIB->addAnnotation(*Inst, "BugEntry", EntryID);
    }
  }

  BC.outs() << "BOLT-INFO: parsed " << EntryID << " bug table entries\n";

  return Error::success();
}

/// The kernel can replace certain instruction sequences depending on hardware
/// it is running on and features specified during boot time. The information
/// about alternative instruction sequences is stored in .altinstructions
/// section. The format of entries in this section is defined in
/// arch/x86/include/asm/alternative.h:
///
///   struct alt_instr {
///     s32 instr_offset;
///     s32 repl_offset;
///     uXX feature;
///     u8  instrlen;
///     u8  replacementlen;
///	    u8  padlen;         // present in older kernels
///   } __packed;
///
/// Note the structures is packed.
Error LinuxKernelRewriter::readAltInstructions() {
  AltInstrSection = BC.getUniqueSectionByName(".altinstructions");
  if (!AltInstrSection)
    return Error::success();

  const uint64_t Address = AltInstrSection->getAddress();
  DataExtractor DE = DataExtractor(AltInstrSection->getContents(),
                                   BC.AsmInfo->isLittleEndian(),
                                   BC.AsmInfo->getCodePointerSize());
  uint64_t EntryID = 0;
  DataExtractor::Cursor Cursor(0);
  while (Cursor && !DE.eof(Cursor)) {
    const uint64_t OrgInstAddress =
        Address + Cursor.tell() + (int32_t)DE.getU32(Cursor);
    const uint64_t AltInstAddress =
        Address + Cursor.tell() + (int32_t)DE.getU32(Cursor);
    const uint64_t Feature = DE.getUnsigned(Cursor, opts::AltInstFeatureSize);
    const uint8_t OrgSize = DE.getU8(Cursor);
    const uint8_t AltSize = DE.getU8(Cursor);

    // Older kernels may have the padlen field.
    const uint8_t PadLen = opts::AltInstHasPadLen ? DE.getU8(Cursor) : 0;

    if (!Cursor)
      return createStringError(
          errc::executable_format_error,
          "out of bounds while reading .altinstructions: %s",
          toString(Cursor.takeError()).c_str());

    ++EntryID;

    if (opts::DumpAltInstructions) {
      BC.outs() << "Alternative instruction entry: " << EntryID
                << "\n\tOrg:     0x" << Twine::utohexstr(OrgInstAddress)
                << "\n\tAlt:     0x" << Twine::utohexstr(AltInstAddress)
                << "\n\tFeature: 0x" << Twine::utohexstr(Feature)
                << "\n\tOrgSize: " << (int)OrgSize
                << "\n\tAltSize: " << (int)AltSize << '\n';
      if (opts::AltInstHasPadLen)
        BC.outs() << "\tPadLen:  " << (int)PadLen << '\n';
    }

    if (AltSize > OrgSize)
      return createStringError(errc::executable_format_error,
                               "error reading .altinstructions");

    BinaryFunction *BF = BC.getBinaryFunctionContainingAddress(OrgInstAddress);
    if (!BF && opts::Verbosity) {
      BC.outs() << "BOLT-INFO: no function matches address 0x"
                << Twine::utohexstr(OrgInstAddress)
                << " of instruction from .altinstructions\n";
    }

    BinaryFunction *AltBF =
        BC.getBinaryFunctionContainingAddress(AltInstAddress);
    if (AltBF && BC.shouldEmit(*AltBF)) {
      BC.errs()
          << "BOLT-WARNING: alternative instruction sequence found in function "
          << *AltBF << '\n';
      AltBF->setIgnored();
    }

    if (!BF || !BC.shouldEmit(*BF))
      continue;

    if (OrgInstAddress + OrgSize > BF->getAddress() + BF->getSize())
      return createStringError(errc::executable_format_error,
                               "error reading .altinstructions");

    MCInst *Inst =
        BF->getInstructionAtOffset(OrgInstAddress - BF->getAddress());
    if (!Inst)
      return createStringError(errc::executable_format_error,
                               "no instruction at address 0x%" PRIx64
                               " referenced by .altinstructions entry %d",
                               OrgInstAddress, EntryID);

    // There could be more than one alternative instruction sequences for the
    // same original instruction. Annotate each alternative separately.
    std::string AnnotationName = "AltInst";
    unsigned N = 2;
    while (BC.MIB->hasAnnotation(*Inst, AnnotationName))
      AnnotationName = "AltInst" + std::to_string(N++);

    BC.MIB->addAnnotation(*Inst, AnnotationName, EntryID);

    // Annotate all instructions from the original sequence. Note that it's not
    // the most efficient way to look for instructions in the address range,
    // but since alternative instructions are uncommon, it will do for now.
    for (uint32_t Offset = 1; Offset < OrgSize; ++Offset) {
      Inst = BF->getInstructionAtOffset(OrgInstAddress + Offset -
                                        BF->getAddress());
      if (Inst)
        BC.MIB->addAnnotation(*Inst, AnnotationName, EntryID);
    }
  }

  BC.outs() << "BOLT-INFO: parsed " << EntryID
            << " alternative instruction entries\n";

  return Error::success();
}

} // namespace

std::unique_ptr<MetadataRewriter>
llvm::bolt::createLinuxKernelRewriter(BinaryContext &BC) {
  return std::make_unique<LinuxKernelRewriter>(BC);
}
