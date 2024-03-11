// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -fclang-abi-compat=latest -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -fclang-abi-compat=latest -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -o /dev/null %s
#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svtbl_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.tbl.nxv16i8(<vscale x 16 x i8> [[DATA:%.*]], <vscale x 16 x i8> [[INDICES:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z13test_svtbl_s8u10__SVInt8_tu11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.tbl.nxv16i8(<vscale x 16 x i8> [[DATA:%.*]], <vscale x 16 x i8> [[INDICES:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svint8_t test_svtbl_s8(svint8_t data, svuint8_t indices)
{
  return SVE_ACLE_FUNC(svtbl,_s8,,)(data, indices);
}

// CHECK-LABEL: @test_svtbl_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.tbl.nxv8i16(<vscale x 8 x i16> [[DATA:%.*]], <vscale x 8 x i16> [[INDICES:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svtbl_s16u11__SVInt16_tu12__SVUint16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.tbl.nxv8i16(<vscale x 8 x i16> [[DATA:%.*]], <vscale x 8 x i16> [[INDICES:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
svint16_t test_svtbl_s16(svint16_t data, svuint16_t indices)
{
  return SVE_ACLE_FUNC(svtbl,_s16,,)(data, indices);
}

// CHECK-LABEL: @test_svtbl_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.tbl.nxv4i32(<vscale x 4 x i32> [[DATA:%.*]], <vscale x 4 x i32> [[INDICES:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svtbl_s32u11__SVInt32_tu12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.tbl.nxv4i32(<vscale x 4 x i32> [[DATA:%.*]], <vscale x 4 x i32> [[INDICES:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
svint32_t test_svtbl_s32(svint32_t data, svuint32_t indices)
{
  return SVE_ACLE_FUNC(svtbl,_s32,,)(data, indices);
}

// CHECK-LABEL: @test_svtbl_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.tbl.nxv2i64(<vscale x 2 x i64> [[DATA:%.*]], <vscale x 2 x i64> [[INDICES:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svtbl_s64u11__SVInt64_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.tbl.nxv2i64(<vscale x 2 x i64> [[DATA:%.*]], <vscale x 2 x i64> [[INDICES:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
svint64_t test_svtbl_s64(svint64_t data, svuint64_t indices)
{
  return SVE_ACLE_FUNC(svtbl,_s64,,)(data, indices);
}

// CHECK-LABEL: @test_svtbl_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.tbl.nxv16i8(<vscale x 16 x i8> [[DATA:%.*]], <vscale x 16 x i8> [[INDICES:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z13test_svtbl_u8u11__SVUint8_tS_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.tbl.nxv16i8(<vscale x 16 x i8> [[DATA:%.*]], <vscale x 16 x i8> [[INDICES:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svuint8_t test_svtbl_u8(svuint8_t data, svuint8_t indices)
{
  return SVE_ACLE_FUNC(svtbl,_u8,,)(data, indices);
}

// CHECK-LABEL: @test_svtbl_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.tbl.nxv8i16(<vscale x 8 x i16> [[DATA:%.*]], <vscale x 8 x i16> [[INDICES:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svtbl_u16u12__SVUint16_tS_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.tbl.nxv8i16(<vscale x 8 x i16> [[DATA:%.*]], <vscale x 8 x i16> [[INDICES:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
svuint16_t test_svtbl_u16(svuint16_t data, svuint16_t indices)
{
  return SVE_ACLE_FUNC(svtbl,_u16,,)(data, indices);
}

// CHECK-LABEL: @test_svtbl_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.tbl.nxv4i32(<vscale x 4 x i32> [[DATA:%.*]], <vscale x 4 x i32> [[INDICES:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svtbl_u32u12__SVUint32_tS_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.tbl.nxv4i32(<vscale x 4 x i32> [[DATA:%.*]], <vscale x 4 x i32> [[INDICES:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
svuint32_t test_svtbl_u32(svuint32_t data, svuint32_t indices)
{
  return SVE_ACLE_FUNC(svtbl,_u32,,)(data, indices);
}

// CHECK-LABEL: @test_svtbl_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.tbl.nxv2i64(<vscale x 2 x i64> [[DATA:%.*]], <vscale x 2 x i64> [[INDICES:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svtbl_u64u12__SVUint64_tS_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.tbl.nxv2i64(<vscale x 2 x i64> [[DATA:%.*]], <vscale x 2 x i64> [[INDICES:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
svuint64_t test_svtbl_u64(svuint64_t data, svuint64_t indices)
{
  return SVE_ACLE_FUNC(svtbl,_u64,,)(data, indices);
}

// CHECK-LABEL: @test_svtbl_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.tbl.nxv8f16(<vscale x 8 x half> [[DATA:%.*]], <vscale x 8 x i16> [[INDICES:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svtbl_f16u13__SVFloat16_tu12__SVUint16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.tbl.nxv8f16(<vscale x 8 x half> [[DATA:%.*]], <vscale x 8 x i16> [[INDICES:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
svfloat16_t test_svtbl_f16(svfloat16_t data, svuint16_t indices)
{
  return SVE_ACLE_FUNC(svtbl,_f16,,)(data, indices);
}

// CHECK-LABEL: @test_svtbl_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.tbl.nxv4f32(<vscale x 4 x float> [[DATA:%.*]], <vscale x 4 x i32> [[INDICES:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svtbl_f32u13__SVFloat32_tu12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.tbl.nxv4f32(<vscale x 4 x float> [[DATA:%.*]], <vscale x 4 x i32> [[INDICES:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
svfloat32_t test_svtbl_f32(svfloat32_t data, svuint32_t indices)
{
  return SVE_ACLE_FUNC(svtbl,_f32,,)(data, indices);
}

// CHECK-LABEL: @test_svtbl_f64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.tbl.nxv2f64(<vscale x 2 x double> [[DATA:%.*]], <vscale x 2 x i64> [[INDICES:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x double> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svtbl_f64u13__SVFloat64_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.tbl.nxv2f64(<vscale x 2 x double> [[DATA:%.*]], <vscale x 2 x i64> [[INDICES:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x double> [[TMP0]]
//
svfloat64_t test_svtbl_f64(svfloat64_t data, svuint64_t indices)
{
  return SVE_ACLE_FUNC(svtbl,_f64,,)(data, indices);
}
