// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve2p1 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s \
// RUN: | opt -S -passes=mem2reg,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve2p1 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s \
// RUN: | opt -S -passes=mem2reg,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve2p1 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s \
// RUN: | opt -S -passes=mem2reg,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -DTEST_SME2 -triple aarch64-none-linux-gnu -target-feature +sme2 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s \
// RUN: | opt -S -passes=mem2reg,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve2p1 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s\
// RUN: | opt -S -passes=mem2reg,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DTEST_SME2 -triple aarch64-none-linux-gnu -target-feature +sme2 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s \
// RUN: | opt -S -passes=mem2reg,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve2p1 -S -disable-O0-optnone -Werror -Wall -o /dev/null %s
// RUN: %clang_cc1 -DTEST_SME2 -triple aarch64-none-linux-gnu -target-feature +sme2 -S -disable-O0-optnone -Werror -Wall -o /dev/null %s

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

// NOTE: For these tests clang converts the struct parameter into
// several parameters, one for each member of the original struct.
// CHECK-LABEL: @test_svget4_b_0(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i1> @llvm.vector.extract.nxv16i1.nxv64i1(<vscale x 64 x i1> [[TUPLE:%.*]], i64 0)
// CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z15test_svget4_b_010svboolx4_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i1> @llvm.vector.extract.nxv16i1.nxv64i1(<vscale x 64 x i1> [[TUPLE:%.*]], i64 0)
// CPP-CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
svbool_t test_svget4_b_0(svboolx4_t tuple) ATTR
{
  return SVE_ACLE_FUNC(svget4,_b,,)(tuple, 0);
}

// NOTE: For these tests clang converts the struct parameter into
// several parameters, one for each member of the original struct.
// CHECK-LABEL: @test_svget4_b_1(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i1> @llvm.vector.extract.nxv16i1.nxv64i1(<vscale x 64 x i1> [[TUPLE:%.*]], i64 16)
// CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z15test_svget4_b_110svboolx4_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i1> @llvm.vector.extract.nxv16i1.nxv64i1(<vscale x 64 x i1> [[TUPLE:%.*]], i64 16)
// CPP-CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
svbool_t test_svget4_b_1(svboolx4_t tuple) ATTR
{
  return SVE_ACLE_FUNC(svget4,_b,,)(tuple, 1);
}

// NOTE: For these tests clang converts the struct parameter into
// several parameters, one for each member of the original struct.
// CHECK-LABEL: @test_svget4_b_3(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i1> @llvm.vector.extract.nxv16i1.nxv64i1(<vscale x 64 x i1> [[TUPLE:%.*]], i64 48)
// CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z15test_svget4_b_310svboolx4_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i1> @llvm.vector.extract.nxv16i1.nxv64i1(<vscale x 64 x i1> [[TUPLE:%.*]], i64 48)
// CPP-CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
svbool_t test_svget4_b_3(svboolx4_t tuple) ATTR
{
  return SVE_ACLE_FUNC(svget4,_b,,)(tuple, 3);
}
