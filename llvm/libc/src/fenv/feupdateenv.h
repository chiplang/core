//===-- Implementation header for feupdateenv -------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIBC_SRC_FENV_FEUPDATEENV_H
#define LLVM_LIBC_SRC_FENV_FEUPDATEENV_H

#include <fenv.h>

namespace LIBC_NAMESPACE {

int feupdateenv(const fenv_t *);

} // namespace LIBC_NAMESPACE

#endif // LLVM_LIBC_SRC_FENV_FEUPDATEENV_H
