//===-- Implementation of the GPU log1pf function -------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "src/math/log1pf.h"
#include "src/__support/common.h"

#include "declarations.h"

namespace LIBC_NAMESPACE {

LLVM_LIBC_FUNCTION(float, log1pf, (float x)) { return __ocml_log1p_f32(x); }

} // namespace LIBC_NAMESPACE
