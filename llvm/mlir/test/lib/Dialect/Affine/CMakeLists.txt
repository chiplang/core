# Exclude tests from libMLIR.so
add_mlir_library(MLIRAffineTransformsTestPasses
  TestAffineDataCopy.cpp
  TestAffineLoopUnswitching.cpp
  TestAffineLoopParametricTiling.cpp
  TestAccessAnalysis.cpp
  TestDecomposeAffineOps.cpp
  TestReifyValueBounds.cpp
  TestLoopFusion.cpp
  TestLoopMapping.cpp
  TestLoopPermutation.cpp
  TestVectorizationUtils.cpp

  EXCLUDE_FROM_LIBMLIR

  ADDITIONAL_HEADER_DIRS
  ${MLIR_MAIN_INCLUDE_DIR}/mlir/Dialect/Affine
  ${MLIR_MAIN_INCLUDE_DIR}/mlir/IR

  LINK_COMPONENTS
  Core

  LINK_LIBS PUBLIC
  MLIRArithTransforms
  MLIRAffineAnalysis
  MLIRAffineTransforms
  MLIRAffineUtils
  MLIRIR
  MLIRPass
  MLIRSupport
  MLIRMemRefDialect
  MLIRTensorDialect
  MLIRVectorUtils
  )
