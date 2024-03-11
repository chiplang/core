//===-- Utility class to test different flavors of [l|ll]round --*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIBC_TEST_SRC_MATH_SMOKE_ROUNDTOINTEGERTEST_H
#define LLVM_LIBC_TEST_SRC_MATH_SMOKE_ROUNDTOINTEGERTEST_H

#include "src/__support/FPUtil/FEnvImpl.h"
#include "src/__support/FPUtil/FPBits.h"
#include "test/UnitTest/FPMatcher.h"
#include "test/UnitTest/Test.h"

#include <errno.h>
#include <math.h>

static constexpr int ROUNDING_MODES[4] = {FE_UPWARD, FE_DOWNWARD, FE_TOWARDZERO,
                                          FE_TONEAREST};

template <typename F, typename I, bool TestModes = false>
class RoundToIntegerTestTemplate : public LIBC_NAMESPACE::testing::Test {
public:
  typedef I (*RoundToIntegerFunc)(F);

private:
  using FPBits = LIBC_NAMESPACE::fputil::FPBits<F>;
  using StorageType = typename FPBits::StorageType;
  using Sign = LIBC_NAMESPACE::fputil::Sign;

  const F zero = FPBits::zero(Sign::POS).get_val();
  const F neg_zero = FPBits::zero(Sign::NEG).get_val();
  const F inf = FPBits::inf(Sign::POS).get_val();
  const F neg_inf = FPBits::inf(Sign::NEG).get_val();
  const F nan = FPBits::quiet_nan().get_val();

  static constexpr StorageType MAX_SUBNORMAL =
      FPBits::max_subnormal().uintval();
  static constexpr StorageType MIN_SUBNORMAL =
      FPBits::min_subnormal().uintval();

  static constexpr I INTEGER_MIN = I(1) << (sizeof(I) * 8 - 1);
  static constexpr I INTEGER_MAX = -(INTEGER_MIN + 1);

  void test_one_input(RoundToIntegerFunc func, F input, I expected,
                      bool expectError) {
    LIBC_NAMESPACE::libc_errno = 0;
    LIBC_NAMESPACE::fputil::clear_except(FE_ALL_EXCEPT);

    ASSERT_EQ(func(input), expected);

    if (expectError) {
      ASSERT_FP_EXCEPTION(FE_INVALID);
      ASSERT_MATH_ERRNO(EDOM);
    } else {
      ASSERT_FP_EXCEPTION(0);
      ASSERT_MATH_ERRNO(0);
    }
  }

public:
  void SetUp() override {
    if (math_errhandling & MATH_ERREXCEPT) {
      // We will disable all exceptions so that the test will not
      // crash with SIGFPE. We can still use fetestexcept to check
      // if the appropriate flag was raised.
      LIBC_NAMESPACE::fputil::disable_except(FE_ALL_EXCEPT);
    }
  }

  void do_infinity_and_na_n_test(RoundToIntegerFunc func) {
    test_one_input(func, inf, INTEGER_MAX, true);
    test_one_input(func, neg_inf, INTEGER_MIN, true);
    // This is currently never enabled, the
    // LLVM_LIBC_IMPLEMENTATION_DEFINED_TEST_BEHAVIOR CMake option in
    // libc/CMakeLists.txt is not forwarded to C++.
#if LIBC_COPT_IMPLEMENTATION_DEFINED_TEST_BEHAVIOR
    // Result is not well-defined, we always returns INTEGER_MAX
    test_one_input(func, nan, INTEGER_MAX, true);
#endif // LIBC_COPT_IMPLEMENTATION_DEFINED_TEST_BEHAVIOR
  }

  void testInfinityAndNaN(RoundToIntegerFunc func) {
    if (TestModes) {
      for (int mode : ROUNDING_MODES) {
        LIBC_NAMESPACE::fputil::set_round(mode);
        do_infinity_and_na_n_test(func);
      }
    } else {
      do_infinity_and_na_n_test(func);
    }
  }

  void do_round_numbers_test(RoundToIntegerFunc func) {
    test_one_input(func, zero, I(0), false);
    test_one_input(func, neg_zero, I(0), false);
    test_one_input(func, F(1.0), I(1), false);
    test_one_input(func, F(-1.0), I(-1), false);
    test_one_input(func, F(10.0), I(10), false);
    test_one_input(func, F(-10.0), I(-10), false);
    test_one_input(func, F(1234.0), I(1234), false);
    test_one_input(func, F(-1234.0), I(-1234), false);
  }

  void testRoundNumbers(RoundToIntegerFunc func) {
    if (TestModes) {
      for (int mode : ROUNDING_MODES) {
        LIBC_NAMESPACE::fputil::set_round(mode);
        do_round_numbers_test(func);
      }
    } else {
      do_round_numbers_test(func);
    }
  }

  void testSubnormalRange(RoundToIntegerFunc func) {
    constexpr StorageType COUNT = 1'000'001;
    constexpr StorageType STEP = (MAX_SUBNORMAL - MIN_SUBNORMAL) / COUNT;
    for (StorageType i = MIN_SUBNORMAL; i <= MAX_SUBNORMAL; i += STEP) {
      F x = FPBits(i).get_val();
      if (x == F(0.0))
        continue;
      // All subnormal numbers should round to zero.
      if (TestModes) {
        if (x > 0) {
          LIBC_NAMESPACE::fputil::set_round(FE_UPWARD);
          test_one_input(func, x, I(1), false);
          LIBC_NAMESPACE::fputil::set_round(FE_DOWNWARD);
          test_one_input(func, x, I(0), false);
          LIBC_NAMESPACE::fputil::set_round(FE_TOWARDZERO);
          test_one_input(func, x, I(0), false);
          LIBC_NAMESPACE::fputil::set_round(FE_TONEAREST);
          test_one_input(func, x, I(0), false);
        } else {
          LIBC_NAMESPACE::fputil::set_round(FE_UPWARD);
          test_one_input(func, x, I(0), false);
          LIBC_NAMESPACE::fputil::set_round(FE_DOWNWARD);
          test_one_input(func, x, I(-1), false);
          LIBC_NAMESPACE::fputil::set_round(FE_TOWARDZERO);
          test_one_input(func, x, I(0), false);
          LIBC_NAMESPACE::fputil::set_round(FE_TONEAREST);
          test_one_input(func, x, I(0), false);
        }
      } else {
        test_one_input(func, x, 0L, false);
      }
    }
  }
};

#define LIST_ROUND_TO_INTEGER_TESTS_HELPER(F, I, func, TestModes)              \
  using LlvmLibcRoundToIntegerTest =                                           \
      RoundToIntegerTestTemplate<F, I, TestModes>;                             \
  TEST_F(LlvmLibcRoundToIntegerTest, InfinityAndNaN) {                         \
    testInfinityAndNaN(&func);                                                 \
  }                                                                            \
  TEST_F(LlvmLibcRoundToIntegerTest, RoundNumbers) {                           \
    testRoundNumbers(&func);                                                   \
  }                                                                            \
  TEST_F(LlvmLibcRoundToIntegerTest, SubnormalRange) {                         \
    testSubnormalRange(&func);                                                 \
  }

#define LIST_ROUND_TO_INTEGER_TESTS(F, I, func)                                \
  LIST_ROUND_TO_INTEGER_TESTS_HELPER(F, I, func, false)

#define LIST_ROUND_TO_INTEGER_TESTS_WITH_MODES(F, I, func)                     \
  LIST_ROUND_TO_INTEGER_TESTS_HELPER(F, I, func, true)

#endif // LLVM_LIBC_TEST_SRC_MATH_SMOKE_ROUNDTOINTEGERTEST_H
