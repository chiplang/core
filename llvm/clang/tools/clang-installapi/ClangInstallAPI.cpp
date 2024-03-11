//===-- ClangInstallAPI.cpp ----------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This is the entry point to clang-installapi; it is a wrapper
// for functionality in the InstallAPI clang library.
//
//===----------------------------------------------------------------------===//

#include "Options.h"
#include "clang/Basic/Diagnostic.h"
#include "clang/Basic/DiagnosticFrontend.h"
#include "clang/Driver/Driver.h"
#include "clang/Driver/DriverDiagnostic.h"
#include "clang/Driver/Tool.h"
#include "clang/Frontend/TextDiagnosticPrinter.h"
#include "clang/InstallAPI/Frontend.h"
#include "clang/Tooling/Tooling.h"
#include "llvm/ADT/ArrayRef.h"
#include "llvm/Option/Option.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/LLVMDriver.h"
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Support/PrettyStackTrace.h"
#include "llvm/Support/Process.h"
#include "llvm/Support/Signals.h"
#include "llvm/TargetParser/Host.h"
#include "llvm/TextAPI/RecordVisitor.h"
#include "llvm/TextAPI/TextAPIWriter.h"
#include <memory>

using namespace clang;
using namespace clang::installapi;
using namespace clang::driver::options;
using namespace llvm::opt;
using namespace llvm::MachO;

static bool runFrontend(StringRef ProgName, bool Verbose,
                        InstallAPIContext &Ctx,
                        llvm::vfs::InMemoryFileSystem *FS,
                        const ArrayRef<std::string> InitialArgs) {

  std::unique_ptr<llvm::MemoryBuffer> ProcessedInput = createInputBuffer(Ctx);
  // Skip invoking cc1 when there are no header inputs.
  if (!ProcessedInput)
    return true;

  if (Verbose)
    llvm::errs() << getName(Ctx.Type) << " Headers:\n"
                 << ProcessedInput->getBuffer() << "\n\n";

  std::string InputFile = ProcessedInput->getBufferIdentifier().str();
  FS->addFile(InputFile, /*ModTime=*/0, std::move(ProcessedInput));
  // Reconstruct arguments with unique values like target triple or input
  // headers.
  std::vector<std::string> Args = {ProgName.data(), "-target",
                                   Ctx.Slice->getTriple().str().c_str()};
  llvm::copy(InitialArgs, std::back_inserter(Args));
  Args.push_back(InputFile);

  // Create & run invocation.
  clang::tooling::ToolInvocation Invocation(
      std::move(Args), std::make_unique<InstallAPIAction>(Ctx), Ctx.FM);

  return Invocation.run();
}

static bool run(ArrayRef<const char *> Args, const char *ProgName) {
  // Setup Diagnostics engine.
  IntrusiveRefCntPtr<DiagnosticOptions> DiagOpts = new DiagnosticOptions();
  const llvm::opt::OptTable &ClangOpts = clang::driver::getDriverOptTable();
  unsigned MissingArgIndex, MissingArgCount;
  llvm::opt::InputArgList ParsedArgs = ClangOpts.ParseArgs(
      ArrayRef(Args).slice(1), MissingArgIndex, MissingArgCount);
  ParseDiagnosticArgs(*DiagOpts, ParsedArgs);

  IntrusiveRefCntPtr<DiagnosticsEngine> Diag = new clang::DiagnosticsEngine(
      new clang::DiagnosticIDs(), DiagOpts.get(),
      new clang::TextDiagnosticPrinter(llvm::errs(), DiagOpts.get()));

  // Create file manager for all file operations and holding in-memory generated
  // inputs.
  llvm::IntrusiveRefCntPtr<llvm::vfs::OverlayFileSystem> OverlayFileSystem(
      new llvm::vfs::OverlayFileSystem(llvm::vfs::getRealFileSystem()));
  llvm::IntrusiveRefCntPtr<llvm::vfs::InMemoryFileSystem> InMemoryFileSystem(
      new llvm::vfs::InMemoryFileSystem);
  OverlayFileSystem->pushOverlay(InMemoryFileSystem);
  IntrusiveRefCntPtr<clang::FileManager> FM(
      new FileManager(clang::FileSystemOptions(), OverlayFileSystem));

  // Set up driver to parse input arguments.
  auto DriverArgs = llvm::ArrayRef(Args).slice(1);
  clang::driver::Driver Driver(ProgName, llvm::sys::getDefaultTargetTriple(),
                               *Diag, "clang installapi tool");
  auto TargetAndMode =
      clang::driver::ToolChain::getTargetAndModeFromProgramName(ProgName);
  Driver.setTargetAndMode(TargetAndMode);
  bool HasError = false;
  llvm::opt::InputArgList ArgList =
      Driver.ParseArgStrings(DriverArgs, /*UseDriverMode=*/true, HasError);
  if (HasError)
    return EXIT_FAILURE;
  Driver.setCheckInputsExist(false);

  // Capture InstallAPI specific options and diagnose any option errors.
  Options Opts(*Diag, FM.get(), ArgList);
  if (Diag->hasErrorOccurred())
    return EXIT_FAILURE;

  InstallAPIContext Ctx = Opts.createContext();
  if (Diag->hasErrorOccurred())
    return EXIT_FAILURE;

  // Set up compilation.
  std::unique_ptr<CompilerInstance> CI(new CompilerInstance());
  CI->setFileManager(FM.get());
  CI->createDiagnostics();
  if (!CI->hasDiagnostics())
    return EXIT_FAILURE;

  // Execute and gather AST results.
  // An invocation is ran for each unique target triple and for each header
  // access level.
  llvm::MachO::Records FrontendResults;
  for (const auto &[Targ, Trip] : Opts.DriverOpts.Targets) {
    for (const HeaderType Type :
         {HeaderType::Public, HeaderType::Private, HeaderType::Project}) {
      Ctx.Slice = std::make_shared<FrontendRecordsSlice>(Trip);
      Ctx.Type = Type;
      if (!runFrontend(ProgName, Opts.DriverOpts.Verbose, Ctx,
                       InMemoryFileSystem.get(), Opts.getClangFrontendArgs()))
        return EXIT_FAILURE;
      FrontendResults.emplace_back(std::move(Ctx.Slice));
    }
  }

  // After symbols have been collected, prepare to write output.
  auto Out = CI->createOutputFile(Ctx.OutputLoc, /*Binary=*/false,
                                  /*RemoveFileOnSignal=*/false,
                                  /*UseTemporary=*/false,
                                  /*CreateMissingDirectories=*/false);
  if (!Out)
    return EXIT_FAILURE;

  // Assign attributes for serialization.
  auto Symbols = std::make_unique<SymbolSet>();
  for (const auto &FR : FrontendResults) {
    SymbolConverter Converter(Symbols.get(), FR->getTarget());
    FR->visit(Converter);
  }

  InterfaceFile IF(std::move(Symbols));
  for (const auto &TargetInfo : Opts.DriverOpts.Targets) {
    IF.addTarget(TargetInfo.first);
    IF.setFromBinaryAttrs(Ctx.BA, TargetInfo.first);
  }

  // Write output file and perform CI cleanup.
  if (auto Err = TextAPIWriter::writeToStream(*Out, IF, Ctx.FT)) {
    Diag->Report(diag::err_cannot_open_file) << Ctx.OutputLoc;
    CI->clearOutputFiles(/*EraseFiles=*/true);
    return EXIT_FAILURE;
  }

  CI->clearOutputFiles(/*EraseFiles=*/false);
  return EXIT_SUCCESS;
}

int clang_installapi_main(int argc, char **argv,
                          const llvm::ToolContext &ToolContext) {
  // Standard set up, so program fails gracefully.
  llvm::sys::PrintStackTraceOnErrorSignal(argv[0]);
  llvm::PrettyStackTraceProgram StackPrinter(argc, argv);
  llvm::llvm_shutdown_obj Shutdown;

  if (llvm::sys::Process::FixupStandardFileDescriptors())
    return EXIT_FAILURE;

  const char *ProgName =
      ToolContext.NeedsPrependArg ? ToolContext.PrependArg : ToolContext.Path;
  return run(llvm::ArrayRef(argv, argc), ProgName);
}
