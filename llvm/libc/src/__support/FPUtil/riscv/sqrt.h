//===-- Square root of IEEE 754 floating point numbers ----------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIBC_SRC___SUPPORT_FPUTIL_RISCV_SQRT_H
#define LLVM_LIBC_SRC___SUPPORT_FPUTIL_RISCV_SQRT_H

#include "src/__support/common.h"
#include "src/__support/macros/properties/architectures.h"

#if !defined(LIBC_TARGET_ARCH_IS_ANY_RISCV)
#error "Invalid include"
#endif

#include "src/__support/FPUtil/generic/sqrt.h"

namespace LIBC_NAMESPACE {
namespace fputil {

#ifdef __riscv_flen
template <> LIBC_INLINE float sqrt<float>(float x) {
  float result;
  __asm__ __volatile__("fsqrt.s %0, %1\n\t" : "=f"(result) : "f"(x));
  return result;
}

#if __riscv_flen >= 64
template <> LIBC_INLINE double sqrt<double>(double x) {
  double result;
  __asm__ __volatile__("fsqrt.d %0, %1\n\t" : "=f"(result) : "f"(x));
  return result;
}
#endif // __riscv_flen >= 64
#endif // __riscv_flen

} // namespace fputil
} // namespace LIBC_NAMESPACE

#endif // LLVM_LIBC_SRC___SUPPORT_FPUTIL_RISCV_SQRT_H
