//===-- Implementation header for nexttoward --------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIBC_SRC_MATH_NEXTTOWARD_H
#define LLVM_LIBC_SRC_MATH_NEXTTOWARD_H

namespace LIBC_NAMESPACE {

double nexttoward(double x, long double y);

} // namespace LIBC_NAMESPACE

#endif // LLVM_LIBC_SRC_MATH_NEXTTOWARD_H
