// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sve2p1 \
// RUN:   -S -Werror -emit-llvm -disable-O0-optnone -o - %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -fclang-abi-compat=latest -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve2p1 \
// RUN:   -S -Werror -emit-llvm -disable-O0-optnone -o - %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sve2p1 \
// RUN:   -S -Werror -emit-llvm -disable-O0-optnone -o - -x c++ %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -fclang-abi-compat=latest -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve2p1 \
// RUN:   -S -Werror -emit-llvm -disable-O0-optnone -o - -x c++ %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sve2p1 \
// RUN:   -S -disable-O0-optnone -Werror -Wall -o /dev/null %s
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sme2 -target-feature +sve \
// RUN:   -S -DTEST_SME2 -disable-O0-optnone -Werror -Wall -o /dev/null %s

#include <arm_sve.h>

#ifndef TEST_SME2
#define ATTR
#else
#define ATTR __arm_streaming
#endif

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1, A2_UNUSED, A3, A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1, A2, A3, A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svclamp_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fclamp.nxv8f16(<vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> [[OP2:%.*]], <vscale x 8 x half> [[OP3:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z16test_svclamp_f16u13__SVFloat16_tS_S_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fclamp.nxv8f16(<vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> [[OP2:%.*]], <vscale x 8 x half> [[OP3:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
svfloat16_t test_svclamp_f16(svfloat16_t op1, svfloat16_t op2, svfloat16_t op3) ATTR {
  return SVE_ACLE_FUNC(svclamp, _f16, , )(op1, op2, op3);
}

// CHECK-LABEL: @test_svclamp_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.fclamp.nxv4f32(<vscale x 4 x float> [[OP1:%.*]], <vscale x 4 x float> [[OP2:%.*]], <vscale x 4 x float> [[OP3:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z16test_svclamp_f32u13__SVFloat32_tS_S_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.fclamp.nxv4f32(<vscale x 4 x float> [[OP1:%.*]], <vscale x 4 x float> [[OP2:%.*]], <vscale x 4 x float> [[OP3:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
svfloat32_t test_svclamp_f32(svfloat32_t op1, svfloat32_t op2, svfloat32_t op3) ATTR {
  return SVE_ACLE_FUNC(svclamp, _f32, , )(op1, op2, op3);
}

// CHECK-LABEL: @test_svclamp_f64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.fclamp.nxv2f64(<vscale x 2 x double> [[OP1:%.*]], <vscale x 2 x double> [[OP2:%.*]], <vscale x 2 x double> [[OP3:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x double> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z16test_svclamp_f64u13__SVFloat64_tS_S_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.fclamp.nxv2f64(<vscale x 2 x double> [[OP1:%.*]], <vscale x 2 x double> [[OP2:%.*]], <vscale x 2 x double> [[OP3:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x double> [[TMP0]]
//
svfloat64_t test_svclamp_f64(svfloat64_t op1, svfloat64_t op2, svfloat64_t op3) ATTR {
  return SVE_ACLE_FUNC(svclamp, _f64, , )(op1, op2, op3);
}

