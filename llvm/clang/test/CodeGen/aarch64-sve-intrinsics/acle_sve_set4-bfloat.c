// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -fclang-abi-compat=latest -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -fclang-abi-compat=latest -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DTEST_SME -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +sme -S -disable-O0-optnone -Werror -Wall -o /dev/null %s

// REQUIRES: aarch64-registered-target

#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

#ifndef TEST_SME
#define ATTR
#else
#define ATTR __arm_streaming
#endif

// CHECK-LABEL: @test_svset4_bf16_0(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 32 x bfloat> @llvm.vector.insert.nxv32bf16.nxv8bf16(<vscale x 32 x bfloat> [[TUPLE:%.*]], <vscale x 8 x bfloat> [[X:%.*]], i64 0)
// CHECK-NEXT:    ret <vscale x 32 x bfloat> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z18test_svset4_bf16_014svbfloat16x4_tu14__SVBfloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 32 x bfloat> @llvm.vector.insert.nxv32bf16.nxv8bf16(<vscale x 32 x bfloat> [[TUPLE:%.*]], <vscale x 8 x bfloat> [[X:%.*]], i64 0)
// CPP-CHECK-NEXT:    ret <vscale x 32 x bfloat> [[TMP0]]
//
svbfloat16x4_t test_svset4_bf16_0(svbfloat16x4_t tuple, svbfloat16_t x) ATTR
{
  return SVE_ACLE_FUNC(svset4,_bf16,,)(tuple, 0, x);
}

// CHECK-LABEL: @test_svset4_bf16_1(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 32 x bfloat> @llvm.vector.insert.nxv32bf16.nxv8bf16(<vscale x 32 x bfloat> [[TUPLE:%.*]], <vscale x 8 x bfloat> [[X:%.*]], i64 8)
// CHECK-NEXT:    ret <vscale x 32 x bfloat> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z18test_svset4_bf16_114svbfloat16x4_tu14__SVBfloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 32 x bfloat> @llvm.vector.insert.nxv32bf16.nxv8bf16(<vscale x 32 x bfloat> [[TUPLE:%.*]], <vscale x 8 x bfloat> [[X:%.*]], i64 8)
// CPP-CHECK-NEXT:    ret <vscale x 32 x bfloat> [[TMP0]]
//
svbfloat16x4_t test_svset4_bf16_1(svbfloat16x4_t tuple, svbfloat16_t x) ATTR
{
  return SVE_ACLE_FUNC(svset4,_bf16,,)(tuple, 1, x);
}

// CHECK-LABEL: @test_svset4_bf16_2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 32 x bfloat> @llvm.vector.insert.nxv32bf16.nxv8bf16(<vscale x 32 x bfloat> [[TUPLE:%.*]], <vscale x 8 x bfloat> [[X:%.*]], i64 16)
// CHECK-NEXT:    ret <vscale x 32 x bfloat> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z18test_svset4_bf16_214svbfloat16x4_tu14__SVBfloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 32 x bfloat> @llvm.vector.insert.nxv32bf16.nxv8bf16(<vscale x 32 x bfloat> [[TUPLE:%.*]], <vscale x 8 x bfloat> [[X:%.*]], i64 16)
// CPP-CHECK-NEXT:    ret <vscale x 32 x bfloat> [[TMP0]]
//
svbfloat16x4_t test_svset4_bf16_2(svbfloat16x4_t tuple, svbfloat16_t x) ATTR
{
  return SVE_ACLE_FUNC(svset4,_bf16,,)(tuple, 2, x);
}

// CHECK-LABEL: @test_svset4_bf16_3(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 32 x bfloat> @llvm.vector.insert.nxv32bf16.nxv8bf16(<vscale x 32 x bfloat> [[TUPLE:%.*]], <vscale x 8 x bfloat> [[X:%.*]], i64 24)
// CHECK-NEXT:    ret <vscale x 32 x bfloat> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z18test_svset4_bf16_314svbfloat16x4_tu14__SVBfloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 32 x bfloat> @llvm.vector.insert.nxv32bf16.nxv8bf16(<vscale x 32 x bfloat> [[TUPLE:%.*]], <vscale x 8 x bfloat> [[X:%.*]], i64 24)
// CPP-CHECK-NEXT:    ret <vscale x 32 x bfloat> [[TMP0]]
//
svbfloat16x4_t test_svset4_bf16_3(svbfloat16x4_t tuple, svbfloat16_t x) ATTR
{
  return SVE_ACLE_FUNC(svset4,_bf16,,)(tuple, 3, x);
}
