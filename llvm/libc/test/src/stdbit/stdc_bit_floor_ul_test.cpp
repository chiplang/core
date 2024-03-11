//===-- Unittests for stdc_bit_floor_ul -----------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "src/__support/CPP/limits.h"
#include "src/stdbit/stdc_bit_floor_ul.h"
#include "test/UnitTest/Test.h"

TEST(LlvmLibcStdcBitfloorUlTest, Zero) {
  EXPECT_EQ(LIBC_NAMESPACE::stdc_bit_floor_ul(0UL), 0UL);
}

TEST(LlvmLibcStdcBitfloorUlTest, Ones) {
  for (unsigned i = 0U; i != ULONG_WIDTH; ++i)
    EXPECT_EQ(LIBC_NAMESPACE::stdc_bit_floor_ul(ULONG_MAX >> i),
              1UL << (ULONG_WIDTH - i - 1));
}
