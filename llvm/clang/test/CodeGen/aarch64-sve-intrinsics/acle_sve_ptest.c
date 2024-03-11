// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -o /dev/null %s
#include <arm_sve.h>

// CHECK-LABEL: @test_svptest_any(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.aarch64.sve.ptest.any.nxv16i1(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i1> [[OP:%.*]])
// CHECK-NEXT:    ret i1 [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z16test_svptest_anyu10__SVBool_tS_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.aarch64.sve.ptest.any.nxv16i1(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i1> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret i1 [[TMP0]]
//
bool test_svptest_any(svbool_t pg, svbool_t op)
{
  return svptest_any(pg, op);
}

// CHECK-LABEL: @test_svptest_first(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.aarch64.sve.ptest.first.nxv16i1(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i1> [[OP:%.*]])
// CHECK-NEXT:    ret i1 [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z18test_svptest_firstu10__SVBool_tS_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.aarch64.sve.ptest.first.nxv16i1(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i1> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret i1 [[TMP0]]
//
bool test_svptest_first(svbool_t pg, svbool_t op)
{
  return svptest_first(pg, op);
}

// CHECK-LABEL: @test_svptest_last(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.aarch64.sve.ptest.last.nxv16i1(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i1> [[OP:%.*]])
// CHECK-NEXT:    ret i1 [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z17test_svptest_lastu10__SVBool_tS_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.aarch64.sve.ptest.last.nxv16i1(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i1> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret i1 [[TMP0]]
//
bool test_svptest_last(svbool_t pg, svbool_t op)
{
  return svptest_last(pg, op);
}
