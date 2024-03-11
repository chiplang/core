//===---------- Linux implementation of the mlock function ----------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "src/sys/mman/mlock2.h"

#include "src/__support/OSUtil/syscall.h" // For internal syscall function.

#include "src/errno/libc_errno.h"
#include <sys/syscall.h> // For syscall numbers.

namespace LIBC_NAMESPACE {
#ifdef SYS_mlock2
LLVM_LIBC_FUNCTION(int, mlock2, (const void *addr, size_t len, int flags)) {
  long ret = syscall_impl(SYS_mlock2, cpp::bit_cast<long>(addr), len, flags);
  if (ret < 0) {
    libc_errno = static_cast<int>(-ret);
    return -1;
  }
  return 0;
}
#endif
} // namespace LIBC_NAMESPACE
