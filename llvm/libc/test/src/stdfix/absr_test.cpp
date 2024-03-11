//===-- Unittests for absr ------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "AbsTest.h"

#include "src/stdfix/absr.h"

LIST_ABS_TESTS(fract, LIBC_NAMESPACE::absr);
