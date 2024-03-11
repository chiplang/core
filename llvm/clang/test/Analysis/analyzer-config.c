// RUN: %clang_analyze_cc1 -analyzer-checker=debug.ConfigDumper > %t 2>&1
// RUN: FileCheck --input-file=%t %s --match-full-lines

// CHECK:      [config]
// CHECK-NEXT: add-pop-up-notes = true
// CHECK-NEXT: aggressive-binary-operation-simplification = false
// CHECK-NEXT: alpha.clone.CloneChecker:IgnoredFilesPattern = ""
// CHECK-NEXT: alpha.clone.CloneChecker:MinimumCloneComplexity = 50
// CHECK-NEXT: alpha.clone.CloneChecker:ReportNormalClones = true
// CHECK-NEXT: alpha.cplusplus.STLAlgorithmModeling:AggressiveStdFindModeling = false
// CHECK-NEXT: alpha.osx.cocoa.DirectIvarAssignment:AnnotatedFunctions = false
// CHECK-NEXT: alpha.security.MmapWriteExec:MmapProtExec = 0x04
// CHECK-NEXT: alpha.security.MmapWriteExec:MmapProtRead = 0x01
// CHECK-NEXT: alpha.security.taint.TaintPropagation:Config = ""
// CHECK-NEXT: apply-fixits = false
// CHECK-NEXT: assume-controlled-environment = false
// CHECK-NEXT: avoid-suppressing-null-argument-paths = false
// CHECK-NEXT: c++-allocator-inlining = true
// CHECK-NEXT: c++-container-inlining = false
// CHECK-NEXT: c++-inlining = destructors
// CHECK-NEXT: c++-shared_ptr-inlining = false
// CHECK-NEXT: c++-stdlib-inlining = true
// CHECK-NEXT: c++-temp-dtor-inlining = true
// CHECK-NEXT: c++-template-inlining = true
// CHECK-NEXT: cfg-conditional-static-initializers = true
// CHECK-NEXT: cfg-expand-default-aggr-inits = false
// CHECK-NEXT: cfg-implicit-dtors = true
// CHECK-NEXT: cfg-lifetime = false
// CHECK-NEXT: cfg-loopexit = false
// CHECK-NEXT: cfg-rich-constructors = true
// CHECK-NEXT: cfg-scopes = false
// CHECK-NEXT: cfg-temporary-dtors = true
// CHECK-NEXT: core.BitwiseShift:Pedantic = false
// CHECK-NEXT: core.CallAndMessage:ArgInitializedness = true
// CHECK-NEXT: core.CallAndMessage:ArgPointeeInitializedness = false
// CHECK-NEXT: core.CallAndMessage:CXXDeallocationArg = true
// CHECK-NEXT: core.CallAndMessage:CXXThisMethodCall = true
// CHECK-NEXT: core.CallAndMessage:FunctionPointer = true
// CHECK-NEXT: core.CallAndMessage:NilReceiver = true
// CHECK-NEXT: core.CallAndMessage:ParameterCount = true
// CHECK-NEXT: core.CallAndMessage:UndefReceiver = true
// CHECK-NEXT: core.NullDereference:SuppressAddressSpaces = true
// CHECK-NEXT: cplusplus.Move:WarnOn = KnownsAndLocals
// CHECK-NEXT: cplusplus.SmartPtrModeling:ModelSmartPtrDereference = false
// CHECK-NEXT: crosscheck-with-z3 = false
// CHECK-NEXT: ctu-dir = ""
// CHECK-NEXT: ctu-import-cpp-threshold = 8
// CHECK-NEXT: ctu-import-threshold = 24
// CHECK-NEXT: ctu-index-name = externalDefMap.txt
// CHECK-NEXT: ctu-invocation-list = invocations.yaml
// CHECK-NEXT: ctu-max-nodes-min = 10000
// CHECK-NEXT: ctu-max-nodes-pct = 50
// CHECK-NEXT: ctu-phase1-inlining = small
// CHECK-NEXT: deadcode.DeadStores:ShowFixIts = false
// CHECK-NEXT: deadcode.DeadStores:WarnForDeadNestedAssignments = true
// CHECK-NEXT: debug.AnalysisOrder:* = false
// CHECK-NEXT: debug.AnalysisOrder:Bind = false
// CHECK-NEXT: debug.AnalysisOrder:EndAnalysis = false
// CHECK-NEXT: debug.AnalysisOrder:EndFunction = false
// CHECK-NEXT: debug.AnalysisOrder:EvalCall = false
// CHECK-NEXT: debug.AnalysisOrder:LiveSymbols = false
// CHECK-NEXT: debug.AnalysisOrder:NewAllocator = false
// CHECK-NEXT: debug.AnalysisOrder:PointerEscape = false
// CHECK-NEXT: debug.AnalysisOrder:PostCall = false
// CHECK-NEXT: debug.AnalysisOrder:PostStmtArraySubscriptExpr = false
// CHECK-NEXT: debug.AnalysisOrder:PostStmtCXXConstructExpr = false
// CHECK-NEXT: debug.AnalysisOrder:PostStmtCXXDeleteExpr = false
// CHECK-NEXT: debug.AnalysisOrder:PostStmtCXXNewExpr = false
// CHECK-NEXT: debug.AnalysisOrder:PostStmtCastExpr = false
// CHECK-NEXT: debug.AnalysisOrder:PostStmtOffsetOfExpr = false
// CHECK-NEXT: debug.AnalysisOrder:PreCall = false
// CHECK-NEXT: debug.AnalysisOrder:PreStmtArraySubscriptExpr = false
// CHECK-NEXT: debug.AnalysisOrder:PreStmtCXXConstructExpr = false
// CHECK-NEXT: debug.AnalysisOrder:PreStmtCXXDeleteExpr = false
// CHECK-NEXT: debug.AnalysisOrder:PreStmtCXXNewExpr = false
// CHECK-NEXT: debug.AnalysisOrder:PreStmtCastExpr = false
// CHECK-NEXT: debug.AnalysisOrder:PreStmtOffsetOfExpr = false
// CHECK-NEXT: debug.AnalysisOrder:RegionChanges = false
// CHECK-NEXT: display-checker-name = true
// CHECK-NEXT: display-ctu-progress = false
// CHECK-NEXT: eagerly-assume = true
// CHECK-NEXT: elide-constructors = true
// CHECK-NEXT: expand-macros = false
// CHECK-NEXT: experimental-enable-naive-ctu-analysis = false
// CHECK-NEXT: exploration_strategy = unexplored_first_queue
// CHECK-NEXT: faux-bodies = true
// CHECK-NEXT: graph-trim-interval = 1000
// CHECK-NEXT: ignore-bison-generated-files = true
// CHECK-NEXT: ignore-flex-generated-files = true
// CHECK-NEXT: inline-lambdas = true
// CHECK-NEXT: ipa = dynamic-bifurcate
// CHECK-NEXT: ipa-always-inline-size = 3
// CHECK-NEXT: max-inlinable-size = 100
// CHECK-NEXT: max-nodes = 225000
// CHECK-NEXT: max-symbol-complexity = 35
// CHECK-NEXT: max-times-inline-large = 32
// CHECK-NEXT: min-cfg-size-treat-functions-as-large = 14
// CHECK-NEXT: mode = deep
// CHECK-NEXT: model-path = ""
// CHECK-NEXT: notes-as-events = false
// CHECK-NEXT: nullability:NoDiagnoseCallsToSystemHeaders = false
// CHECK-NEXT: objc-inlining = true
// CHECK-NEXT: optin.cplusplus.UninitializedObject:CheckPointeeInitialization = false
// CHECK-NEXT: optin.cplusplus.UninitializedObject:IgnoreGuardedFields = false
// CHECK-NEXT: optin.cplusplus.UninitializedObject:IgnoreRecordsWithField = ""
// CHECK-NEXT: optin.cplusplus.UninitializedObject:NotesAsWarnings = false
// CHECK-NEXT: optin.cplusplus.UninitializedObject:Pedantic = false
// CHECK-NEXT: optin.cplusplus.VirtualCall:PureOnly = false
// CHECK-NEXT: optin.cplusplus.VirtualCall:ShowFixIts = false
// CHECK-NEXT: optin.osx.cocoa.localizability.NonLocalizedStringChecker:AggressiveReport = false
// CHECK-NEXT: optin.performance.Padding:AllowedPad = 24
// CHECK-NEXT: osx.NumberObjectConversion:Pedantic = false
// CHECK-NEXT: osx.cocoa.RetainCount:TrackNSCFStartParam = false
// CHECK-NEXT: prune-paths = true
// CHECK-NEXT: region-store-small-array-limit = 5
// CHECK-NEXT: region-store-small-struct-limit = 2
// CHECK-NEXT: report-in-main-source-file = false
// CHECK-NEXT: security.cert.env.InvalidPtr:InvalidatingGetEnv = false
// CHECK-NEXT: serialize-stats = false
// CHECK-NEXT: silence-checkers = ""
// CHECK-NEXT: stable-report-filename = false
// CHECK-NEXT: support-symbolic-integer-casts = false
// CHECK-NEXT: suppress-c++-stdlib = true
// CHECK-NEXT: suppress-inlined-defensive-checks = true
// CHECK-NEXT: suppress-null-return-paths = true
// CHECK-NEXT: track-conditions = true
// CHECK-NEXT: track-conditions-debug = false
// CHECK-NEXT: unix.DynamicMemoryModeling:AddNoOwnershipChangeNotes = true
// CHECK-NEXT: unix.DynamicMemoryModeling:Optimistic = false
// CHECK-NEXT: unix.Errno:AllowErrnoReadOutsideConditionExpressions = true
// CHECK-NEXT: unix.StdCLibraryFunctions:DisplayLoadedSummaries = false
// CHECK-NEXT: unix.StdCLibraryFunctions:ModelPOSIX = true
// CHECK-NEXT: unroll-loops = false
// CHECK-NEXT: verbose-report-filename = false
// CHECK-NEXT: widen-loops = false
