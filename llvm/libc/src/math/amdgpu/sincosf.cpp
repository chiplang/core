//===-- Implementation of the sincosf function for GPU --------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "src/math/sincosf.h"
#include "src/__support/common.h"

#include "declarations.h"

namespace LIBC_NAMESPACE {

LLVM_LIBC_FUNCTION(void, sincosf, (float x, float *sinptr, float *cosptr)) {
  *sinptr = __ocml_sincos_f32(x, cosptr);
}

} // namespace LIBC_NAMESPACE
