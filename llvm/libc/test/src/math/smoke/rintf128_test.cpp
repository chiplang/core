//===-- Unittests for rintf128 --------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "RIntTest.h"

#include "src/math/rintf128.h"

LIST_RINT_TESTS(float128, LIBC_NAMESPACE::rintf128)
