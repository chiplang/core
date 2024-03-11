//===-- String to integer conversion utils ----------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIBC_SRC___SUPPORT_STR_TO_INTEGER_H
#define LLVM_LIBC_SRC___SUPPORT_STR_TO_INTEGER_H

#include "src/__support/CPP/limits.h"
#include "src/__support/CPP/type_traits.h"
#include "src/__support/common.h"
#include "src/__support/ctype_utils.h"
#include "src/__support/str_to_num_result.h"
#include "src/errno/libc_errno.h" // For ERANGE

namespace LIBC_NAMESPACE {
namespace internal {

// Returns a pointer to the first character in src that is not a whitespace
// character (as determined by isspace())
// TODO: Change from returning a pointer to returning a length.
LIBC_INLINE const char *
first_non_whitespace(const char *__restrict src,
                     size_t src_len = cpp::numeric_limits<size_t>::max()) {
  size_t src_cur = 0;
  while (src_cur < src_len && internal::isspace(src[src_cur])) {
    ++src_cur;
  }
  return src + src_cur;
}

LIBC_INLINE int b36_char_to_int(char input) {
  if (isdigit(input))
    return input - '0';
  if (isalpha(input))
    return (input | 32) + 10 - 'a';
  return 0;
}

// checks if the next 3 characters of the string pointer are the start of a
// hexadecimal number. Does not advance the string pointer.
LIBC_INLINE bool
is_hex_start(const char *__restrict src,
             size_t src_len = cpp::numeric_limits<size_t>::max()) {
  if (src_len < 3)
    return false;
  return *src == '0' && (*(src + 1) | 32) == 'x' && isalnum(*(src + 2)) &&
         b36_char_to_int(*(src + 2)) < 16;
}

// Takes the address of the string pointer and parses the base from the start of
// it.
LIBC_INLINE int infer_base(const char *__restrict src, size_t src_len) {
  // A hexadecimal number is defined as "the prefix 0x or 0X followed by a
  // sequence of the decimal digits and the letters a (or A) through f (or F)
  // with values 10 through 15 respectively." (C standard 6.4.4.1)
  if (is_hex_start(src, src_len))
    return 16;
  // An octal number is defined as "the prefix 0 optionally followed by a
  // sequence of the digits 0 through 7 only" (C standard 6.4.4.1) and so any
  // number that starts with 0, including just 0, is an octal number.
  if (src_len > 0 && src[0] == '0')
    return 8;
  // A decimal number is defined as beginning "with a nonzero digit and
  // consist[ing] of a sequence of decimal digits." (C standard 6.4.4.1)
  return 10;
}

// Takes a pointer to a string and the base to convert to. This function is used
// as the backend for all of the string to int functions.
template <class T>
LIBC_INLINE StrToNumResult<T>
strtointeger(const char *__restrict src, int base,
             const size_t src_len = cpp::numeric_limits<size_t>::max()) {
  // TODO: Rewrite to support numbers longer than long long
  unsigned long long result = 0;
  bool is_number = false;
  size_t src_cur = 0;
  int error_val = 0;

  if (src_len == 0)
    return {0, 0, 0};

  if (base < 0 || base == 1 || base > 36)
    return {0, 0, EINVAL};

  src_cur = first_non_whitespace(src, src_len) - src;

  char result_sign = '+';
  if (src[src_cur] == '+' || src[src_cur] == '-') {
    result_sign = src[src_cur];
    ++src_cur;
  }

  if (base == 0)
    base = infer_base(src + src_cur, src_len - src_cur);

  if (base == 16 && is_hex_start(src + src_cur, src_len - src_cur))
    src_cur = src_cur + 2;

  constexpr bool IS_UNSIGNED = (cpp::numeric_limits<T>::min() == 0);
  const bool is_positive = (result_sign == '+');
  unsigned long long constexpr NEGATIVE_MAX =
      !IS_UNSIGNED
          ? static_cast<unsigned long long>(cpp::numeric_limits<T>::max()) + 1
          : cpp::numeric_limits<T>::max();
  unsigned long long const abs_max =
      (is_positive ? cpp::numeric_limits<T>::max() : NEGATIVE_MAX);
  unsigned long long const abs_max_div_by_base = abs_max / base;
  while (src_cur < src_len && isalnum(src[src_cur])) {
    int cur_digit = b36_char_to_int(src[src_cur]);
    if (cur_digit >= base)
      break;

    is_number = true;
    ++src_cur;

    // If the number has already hit the maximum value for the current type then
    // the result cannot change, but we still need to advance src to the end of
    // the number.
    if (result == abs_max) {
      error_val = ERANGE;
      continue;
    }

    if (result > abs_max_div_by_base) {
      result = abs_max;
      error_val = ERANGE;
    } else {
      result = result * base;
    }
    if (result > abs_max - cur_digit) {
      result = abs_max;
      error_val = ERANGE;
    } else {
      result = result + cur_digit;
    }
  }

  ptrdiff_t str_len = is_number ? (src_cur) : 0;

  if (error_val == ERANGE) {
    if (is_positive || IS_UNSIGNED)
      return {cpp::numeric_limits<T>::max(), str_len, error_val};
    else // T is signed and there is a negative overflow
      return {cpp::numeric_limits<T>::min(), str_len, error_val};
  }

  return {is_positive
              ? static_cast<T>(result)
              : static_cast<T>(-static_cast<cpp::make_unsigned_t<T>>(result)),
          str_len, error_val};
}

} // namespace internal
} // namespace LIBC_NAMESPACE

#endif // LLVM_LIBC_SRC___SUPPORT_STR_TO_INTEGER_H
