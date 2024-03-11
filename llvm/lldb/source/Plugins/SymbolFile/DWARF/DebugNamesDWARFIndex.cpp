//===-- DebugNamesDWARFIndex.cpp ------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "Plugins/SymbolFile/DWARF/DebugNamesDWARFIndex.h"
#include "Plugins/SymbolFile/DWARF/DWARFDebugInfo.h"
#include "Plugins/SymbolFile/DWARF/DWARFDeclContext.h"
#include "Plugins/SymbolFile/DWARF/SymbolFileDWARFDwo.h"
#include "lldb/Core/Module.h"
#include "lldb/Utility/RegularExpression.h"
#include "lldb/Utility/Stream.h"
#include "llvm/ADT/Sequence.h"
#include <optional>

using namespace lldb_private;
using namespace lldb;
using namespace lldb_private::dwarf;
using namespace lldb_private::plugin::dwarf;

llvm::Expected<std::unique_ptr<DebugNamesDWARFIndex>>
DebugNamesDWARFIndex::Create(Module &module, DWARFDataExtractor debug_names,
                             DWARFDataExtractor debug_str,
                             SymbolFileDWARF &dwarf) {
  auto index_up = std::make_unique<DebugNames>(debug_names.GetAsLLVMDWARF(),
                                               debug_str.GetAsLLVM());
  if (llvm::Error E = index_up->extract())
    return std::move(E);

  return std::unique_ptr<DebugNamesDWARFIndex>(new DebugNamesDWARFIndex(
      module, std::move(index_up), debug_names, debug_str, dwarf));
}

llvm::DenseSet<dw_offset_t>
DebugNamesDWARFIndex::GetUnits(const DebugNames &debug_names) {
  llvm::DenseSet<dw_offset_t> result;
  for (const DebugNames::NameIndex &ni : debug_names) {
    const uint32_t num_cus = ni.getCUCount();
    for (uint32_t cu = 0; cu < num_cus; ++cu)
      result.insert(ni.getCUOffset(cu));
    const uint32_t num_tus = ni.getLocalTUCount();
    for (uint32_t tu = 0; tu < num_tus; ++tu)
      result.insert(ni.getLocalTUOffset(tu));
  }
  return result;
}

std::optional<DIERef>
DebugNamesDWARFIndex::ToDIERef(const DebugNames::Entry &entry) const {
  // Look for a DWARF unit offset (CU offset or local TU offset) as they are
  // both offsets into the .debug_info section.
  std::optional<uint64_t> unit_offset = entry.getCUOffset();
  if (!unit_offset) {
    unit_offset = entry.getLocalTUOffset();
    if (!unit_offset)
      return std::nullopt;
  }

  DWARFUnit *cu =
      m_debug_info.GetUnitAtOffset(DIERef::Section::DebugInfo, *unit_offset);
  if (!cu)
    return std::nullopt;

  cu = &cu->GetNonSkeletonUnit();
  if (std::optional<uint64_t> die_offset = entry.getDIEUnitOffset())
    return DIERef(cu->GetSymbolFileDWARF().GetFileIndex(),
                  DIERef::Section::DebugInfo, cu->GetOffset() + *die_offset);

  return std::nullopt;
}

bool DebugNamesDWARFIndex::ProcessEntry(
    const DebugNames::Entry &entry,
    llvm::function_ref<bool(DWARFDIE die)> callback) {
  std::optional<DIERef> ref = ToDIERef(entry);
  if (!ref)
    return true;
  SymbolFileDWARF &dwarf = *llvm::cast<SymbolFileDWARF>(
      m_module.GetSymbolFile()->GetBackingSymbolFile());
  DWARFDIE die = dwarf.GetDIE(*ref);
  if (!die)
    return true;
  return callback(die);
}

void DebugNamesDWARFIndex::MaybeLogLookupError(llvm::Error error,
                                               const DebugNames::NameIndex &ni,
                                               llvm::StringRef name) {
  // Ignore SentinelErrors, log everything else.
  LLDB_LOG_ERROR(
      GetLog(DWARFLog::Lookups),
      handleErrors(std::move(error), [](const DebugNames::SentinelError &) {}),
      "Failed to parse index entries for index at {1:x}, name {2}: {0}",
      ni.getUnitOffset(), name);
}

void DebugNamesDWARFIndex::GetGlobalVariables(
    ConstString basename, llvm::function_ref<bool(DWARFDIE die)> callback) {
  for (const DebugNames::Entry &entry :
       m_debug_names_up->equal_range(basename.GetStringRef())) {
    if (entry.tag() != DW_TAG_variable)
      continue;

    if (!ProcessEntry(entry, callback))
      return;
  }

  m_fallback.GetGlobalVariables(basename, callback);
}

void DebugNamesDWARFIndex::GetGlobalVariables(
    const RegularExpression &regex,
    llvm::function_ref<bool(DWARFDIE die)> callback) {
  for (const DebugNames::NameIndex &ni: *m_debug_names_up) {
    for (DebugNames::NameTableEntry nte: ni) {
      Mangled mangled_name(nte.getString());
      if (!mangled_name.NameMatches(regex))
        continue;

      uint64_t entry_offset = nte.getEntryOffset();
      llvm::Expected<DebugNames::Entry> entry_or = ni.getEntry(&entry_offset);
      for (; entry_or; entry_or = ni.getEntry(&entry_offset)) {
        if (entry_or->tag() != DW_TAG_variable)
          continue;

        if (!ProcessEntry(*entry_or, callback))
          return;
      }
      MaybeLogLookupError(entry_or.takeError(), ni, nte.getString());
    }
  }

  m_fallback.GetGlobalVariables(regex, callback);
}

void DebugNamesDWARFIndex::GetGlobalVariables(
    DWARFUnit &cu, llvm::function_ref<bool(DWARFDIE die)> callback) {
  uint64_t cu_offset = cu.GetOffset();
  bool found_entry_for_cu = false;
  for (const DebugNames::NameIndex &ni : *m_debug_names_up) {
    // Check if this name index contains an entry for the given CU.
    bool cu_matches = false;
    for (uint32_t i = 0; i < ni.getCUCount(); ++i) {
      if (ni.getCUOffset(i) == cu_offset) {
        cu_matches = true;
        break;
      }
    }
    if (!cu_matches)
      continue;

    for (DebugNames::NameTableEntry nte : ni) {
      uint64_t entry_offset = nte.getEntryOffset();
      llvm::Expected<DebugNames::Entry> entry_or = ni.getEntry(&entry_offset);
      for (; entry_or; entry_or = ni.getEntry(&entry_offset)) {
        if (entry_or->tag() != DW_TAG_variable)
          continue;
        if (entry_or->getCUOffset() != cu_offset)
          continue;

        found_entry_for_cu = true;
        if (!ProcessEntry(*entry_or, callback))
          return;
      }
      MaybeLogLookupError(entry_or.takeError(), ni, nte.getString());
    }
  }
  // If no name index for that particular CU was found, fallback to
  // creating the manual index.
  if (!found_entry_for_cu)
    m_fallback.GetGlobalVariables(cu, callback);
}

void DebugNamesDWARFIndex::GetCompleteObjCClass(
    ConstString class_name, bool must_be_implementation,
    llvm::function_ref<bool(DWARFDIE die)> callback) {
  // Keep a list of incomplete types as fallback for when we don't find the
  // complete type.
  DIEArray incomplete_types;

  for (const DebugNames::Entry &entry :
       m_debug_names_up->equal_range(class_name.GetStringRef())) {
    if (entry.tag() != DW_TAG_structure_type &&
        entry.tag() != DW_TAG_class_type)
      continue;

    std::optional<DIERef> ref = ToDIERef(entry);
    if (!ref)
      continue;

    DWARFUnit *cu = m_debug_info.GetUnit(*ref);
    if (!cu || !cu->Supports_DW_AT_APPLE_objc_complete_type()) {
      incomplete_types.push_back(*ref);
      continue;
    }

    DWARFDIE die = m_debug_info.GetDIE(*ref);
    if (!die) {
      ReportInvalidDIERef(*ref, class_name.GetStringRef());
      continue;
    }

    if (die.GetAttributeValueAsUnsigned(DW_AT_APPLE_objc_complete_type, 0)) {
      // If we find the complete version we're done.
      callback(die);
      return;
    }
    incomplete_types.push_back(*ref);
  }

  auto dierefcallback = DIERefCallback(callback, class_name.GetStringRef());
  for (DIERef ref : incomplete_types)
    if (!dierefcallback(ref))
      return;

  m_fallback.GetCompleteObjCClass(class_name, must_be_implementation, callback);
}

namespace {
using Entry = llvm::DWARFDebugNames::Entry;

/// If `entry` and all of its parents have an `IDX_parent`, use that information
/// to build and return a list of at most `max_parents` parent Entries.
/// `entry` itself is not included in the list.
/// If any parent does not have an `IDX_parent`, or the Entry data is corrupted,
/// nullopt is returned.
std::optional<llvm::SmallVector<Entry, 4>>
getParentChain(Entry entry, uint32_t max_parents) {
  llvm::SmallVector<Entry, 4> parent_entries;

  do {
    if (!entry.hasParentInformation())
      return std::nullopt;

    llvm::Expected<std::optional<Entry>> parent = entry.getParentDIEEntry();
    if (!parent) {
      // Bad data.
      LLDB_LOG_ERROR(
          GetLog(DWARFLog::Lookups), parent.takeError(),
          "Failed to extract parent entry from a non-empty IDX_parent");
      return std::nullopt;
    }

    // Last parent in the chain.
    if (!parent->has_value())
      break;

    parent_entries.push_back(**parent);
    entry = **parent;
  } while (parent_entries.size() < max_parents);

  return parent_entries;
}
} // namespace

void DebugNamesDWARFIndex::GetFullyQualifiedType(
    const DWARFDeclContext &context,
    llvm::function_ref<bool(DWARFDIE die)> callback) {
  if (context.GetSize() == 0)
    return;

  llvm::StringRef leaf_name = context[0].name;
  llvm::SmallVector<llvm::StringRef> parent_names;
  for (auto idx : llvm::seq<int>(1, context.GetSize()))
    parent_names.emplace_back(context[idx].name);

  // For each entry, grab its parent chain and check if we have a match.
  for (const DebugNames::Entry &entry :
       m_debug_names_up->equal_range(leaf_name)) {
    if (!isType(entry.tag()))
      continue;

    // Grab at most one extra parent, subsequent parents are not necessary to
    // test equality.
    std::optional<llvm::SmallVector<Entry, 4>> parent_chain =
        getParentChain(entry, parent_names.size() + 1);

    if (!parent_chain) {
      // Fallback: use the base class implementation.
      if (!ProcessEntry(entry, [&](DWARFDIE die) {
            return GetFullyQualifiedTypeImpl(context, die, callback);
          }))
        return;
      continue;
    }

    if (SameParentChain(parent_names, *parent_chain) &&
        !ProcessEntry(entry, callback))
      return;
  }
}

bool DebugNamesDWARFIndex::SameParentChain(
    llvm::ArrayRef<llvm::StringRef> parent_names,
    llvm::ArrayRef<DebugNames::Entry> parent_entries) const {

  if (parent_entries.size() != parent_names.size())
    return false;

  auto SameAsEntryATName = [this](llvm::StringRef name,
                                  const DebugNames::Entry &entry) {
    // Peek at the AT_name of `entry` and test equality to `name`.
    auto maybe_dieoffset = entry.getDIEUnitOffset();
    if (!maybe_dieoffset)
      return false;
    auto die_ref = ToDIERef(entry);
    if (!die_ref)
      return false;
    return name == m_debug_info.PeekDIEName(*die_ref);
  };

  // If the AT_name of any parent fails to match the expected name, we don't
  // have a match.
  for (auto [parent_name, parent_entry] :
       llvm::zip_equal(parent_names, parent_entries))
    if (!SameAsEntryATName(parent_name, parent_entry))
      return false;
  return true;
}

void DebugNamesDWARFIndex::GetTypes(
    ConstString name, llvm::function_ref<bool(DWARFDIE die)> callback) {
  for (const DebugNames::Entry &entry :
       m_debug_names_up->equal_range(name.GetStringRef())) {
    if (isType(entry.tag())) {
      if (!ProcessEntry(entry, callback))
        return;
    }
  }

  m_fallback.GetTypes(name, callback);
}

void DebugNamesDWARFIndex::GetTypes(
    const DWARFDeclContext &context,
    llvm::function_ref<bool(DWARFDIE die)> callback) {
  auto name = context[0].name;
  for (const DebugNames::Entry &entry : m_debug_names_up->equal_range(name)) {
    if (entry.tag() == context[0].tag) {
      if (!ProcessEntry(entry, callback))
        return;
    }
  }

  m_fallback.GetTypes(context, callback);
}

void DebugNamesDWARFIndex::GetNamespaces(
    ConstString name, llvm::function_ref<bool(DWARFDIE die)> callback) {
  for (const DebugNames::Entry &entry :
       m_debug_names_up->equal_range(name.GetStringRef())) {
    lldb_private::dwarf::Tag entry_tag = entry.tag();
    if (entry_tag == DW_TAG_namespace ||
        entry_tag == DW_TAG_imported_declaration) {
      if (!ProcessEntry(entry, callback))
        return;
    }
  }

  m_fallback.GetNamespaces(name, callback);
}

void DebugNamesDWARFIndex::GetFunctions(
    const Module::LookupInfo &lookup_info, SymbolFileDWARF &dwarf,
    const CompilerDeclContext &parent_decl_ctx,
    llvm::function_ref<bool(DWARFDIE die)> callback) {
  ConstString name = lookup_info.GetLookupName();
  std::set<DWARFDebugInfoEntry *> seen;
  for (const DebugNames::Entry &entry :
       m_debug_names_up->equal_range(name.GetStringRef())) {
    Tag tag = entry.tag();
    if (tag != DW_TAG_subprogram && tag != DW_TAG_inlined_subroutine)
      continue;

    if (std::optional<DIERef> ref = ToDIERef(entry)) {
      if (!ProcessFunctionDIE(lookup_info, *ref, dwarf, parent_decl_ctx,
                              [&](DWARFDIE die) {
                                if (!seen.insert(die.GetDIE()).second)
                                  return true;
                                return callback(die);
                              }))
        return;
    }
  }

  m_fallback.GetFunctions(lookup_info, dwarf, parent_decl_ctx, callback);
}

void DebugNamesDWARFIndex::GetFunctions(
    const RegularExpression &regex,
    llvm::function_ref<bool(DWARFDIE die)> callback) {
  for (const DebugNames::NameIndex &ni: *m_debug_names_up) {
    for (DebugNames::NameTableEntry nte: ni) {
      if (!regex.Execute(nte.getString()))
        continue;

      uint64_t entry_offset = nte.getEntryOffset();
      llvm::Expected<DebugNames::Entry> entry_or = ni.getEntry(&entry_offset);
      for (; entry_or; entry_or = ni.getEntry(&entry_offset)) {
        Tag tag = entry_or->tag();
        if (tag != DW_TAG_subprogram && tag != DW_TAG_inlined_subroutine)
          continue;

        if (!ProcessEntry(*entry_or, callback))
          return;
      }
      MaybeLogLookupError(entry_or.takeError(), ni, nte.getString());
    }
  }

  m_fallback.GetFunctions(regex, callback);
}

void DebugNamesDWARFIndex::Dump(Stream &s) {
  m_fallback.Dump(s);

  std::string data;
  llvm::raw_string_ostream os(data);
  m_debug_names_up->dump(os);
  s.PutCString(os.str());
}
