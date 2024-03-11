//===-- Single-precision acos function ------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "src/math/acosf.h"
#include "src/__support/FPUtil/FEnvImpl.h"
#include "src/__support/FPUtil/FPBits.h"
#include "src/__support/FPUtil/PolyEval.h"
#include "src/__support/FPUtil/except_value_utils.h"
#include "src/__support/FPUtil/multiply_add.h"
#include "src/__support/FPUtil/sqrt.h"
#include "src/__support/macros/optimization.h" // LIBC_UNLIKELY

#include <errno.h>

#include "inv_trigf_utils.h"

namespace LIBC_NAMESPACE {

static constexpr size_t N_EXCEPTS = 4;

// Exceptional values when |x| <= 0.5
static constexpr fputil::ExceptValues<float, N_EXCEPTS> ACOSF_EXCEPTS = {{
    // (inputs, RZ output, RU offset, RD offset, RN offset)
    // x = 0x1.110b46p-26, acosf(x) = 0x1.921fb4p0 (RZ)
    {0x328885a3, 0x3fc90fda, 1, 0, 1},
    // x = -0x1.110b46p-26, acosf(x) = 0x1.921fb4p0 (RZ)
    {0xb28885a3, 0x3fc90fda, 1, 0, 1},
    // x = 0x1.04c444p-12, acosf(x) = 0x1.920f68p0 (RZ)
    {0x39826222, 0x3fc907b4, 1, 0, 1},
    // x = -0x1.04c444p-12, acosf(x) = 0x1.923p0 (RZ)
    {0xb9826222, 0x3fc91800, 1, 0, 1},
}};

LLVM_LIBC_FUNCTION(float, acosf, (float x)) {
  using FPBits = typename fputil::FPBits<float>;
  using Sign = fputil::Sign;
  FPBits xbits(x);
  uint32_t x_uint = xbits.uintval();
  uint32_t x_abs = xbits.uintval() & 0x7fff'ffffU;
  uint32_t x_sign = x_uint >> 31;

  // |x| <= 0.5
  if (LIBC_UNLIKELY(x_abs <= 0x3f00'0000U)) {
    // |x| < 0x1p-10
    if (LIBC_UNLIKELY(x_abs < 0x3a80'0000U)) {
      // When |x| < 2^-10, we use the following approximation:
      //   acos(x) = pi/2 - asin(x)
      //           ~ pi/2 - x - x^3 / 6

      // Check for exceptional values
      if (auto r = ACOSF_EXCEPTS.lookup(x_uint); LIBC_UNLIKELY(r.has_value()))
        return r.value();

      double xd = static_cast<double>(x);
      return static_cast<float>(fputil::multiply_add(
          -0x1.5555555555555p-3 * xd, xd * xd, M_MATH_PI_2 - xd));
    }

    // For |x| <= 0.5, we approximate acosf(x) by:
    //   acos(x) = pi/2 - asin(x) = pi/2 - x * P(x^2)
    // Where P(X^2) = Q(X) is a degree-20 minimax even polynomial approximating
    // asin(x)/x on [0, 0.5] generated by Sollya with:
    // > Q = fpminimax(asin(x)/x, [|0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20|],
    //                 [|1, D...|], [0, 0.5]);
    double xd = static_cast<double>(x);
    double xsq = xd * xd;
    double x3 = xd * xsq;
    double r = asin_eval(xsq);
    return static_cast<float>(fputil::multiply_add(-x3, r, M_MATH_PI_2 - xd));
  }

  // |x| >= 1, return 0, 2pi, or NaNs.
  if (LIBC_UNLIKELY(x_abs >= 0x3f80'0000U)) {
    if (x_abs == 0x3f80'0000U)
      return x_sign ? /* x == -1.0f */ fputil::round_result_slightly_down(
                          0x1.921fb6p+1f)
                    : /* x == 1.0f */ 0.0f;

    if (x_abs <= 0x7f80'0000U) {
      fputil::set_errno_if_required(EDOM);
      fputil::raise_except_if_required(FE_INVALID);
    }
    return x + FPBits::quiet_nan().get_val();
  }

  // When 0.5 < |x| < 1, we perform range reduction as follow:
  //
  // Assume further that 0.5 < x <= 1, and let:
  //   y = acos(x)
  // We use the double angle formula:
  //   x = cos(y) = 1 - 2 sin^2(y/2)
  // So:
  //   sin(y/2) = sqrt( (1 - x)/2 )
  // And hence:
  //   y = 2 * asin( sqrt( (1 - x)/2 ) )
  // Let u = (1 - x)/2, then
  //   acos(x) = 2 * asin( sqrt(u) )
  // Moreover, since 0.5 < x <= 1,
  //   0 <= u < 1/4, and 0 <= sqrt(u) < 0.5,
  // And hence we can reuse the same polynomial approximation of asin(x) when
  // |x| <= 0.5:
  //   acos(x) ~ 2 * sqrt(u) * P(u).
  //
  // When -1 < x <= -0.5, we use the identity:
  //   acos(x) = pi - acos(-x)
  // which is reduced to the postive case.

  xbits.set_sign(Sign::POS);
  double xd = static_cast<double>(xbits.get_val());
  double u = fputil::multiply_add(-0.5, xd, 0.5);
  double cv = 2 * fputil::sqrt(u);

  double r3 = asin_eval(u);
  double r = fputil::multiply_add(cv * u, r3, cv);
  return static_cast<float>(x_sign ? M_MATH_PI - r : r);
}

} // namespace LIBC_NAMESPACE
