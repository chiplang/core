// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -passes=mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -passes=mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -fclang-abi-compat=latest -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -passes=mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -fclang-abi-compat=latest -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -passes=mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -o /dev/null %s
#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svclasta_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.clasta.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[FALLBACK:%.*]], <vscale x 16 x i8> [[DATA:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z16test_svclasta_s8u10__SVBool_tu10__SVInt8_tS0_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.clasta.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[FALLBACK:%.*]], <vscale x 16 x i8> [[DATA:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svint8_t test_svclasta_s8(svbool_t pg, svint8_t fallback, svint8_t data)
{
  return SVE_ACLE_FUNC(svclasta,_s8,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.clasta.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[FALLBACK:%.*]], <vscale x 8 x i16> [[DATA:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svclasta_s16u10__SVBool_tu11__SVInt16_tS0_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.clasta.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[FALLBACK:%.*]], <vscale x 8 x i16> [[DATA:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
svint16_t test_svclasta_s16(svbool_t pg, svint16_t fallback, svint16_t data)
{
  return SVE_ACLE_FUNC(svclasta,_s16,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.clasta.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[FALLBACK:%.*]], <vscale x 4 x i32> [[DATA:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svclasta_s32u10__SVBool_tu11__SVInt32_tS0_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.clasta.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[FALLBACK:%.*]], <vscale x 4 x i32> [[DATA:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
svint32_t test_svclasta_s32(svbool_t pg, svint32_t fallback, svint32_t data)
{
  return SVE_ACLE_FUNC(svclasta,_s32,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.clasta.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[FALLBACK:%.*]], <vscale x 2 x i64> [[DATA:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svclasta_s64u10__SVBool_tu11__SVInt64_tS0_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.clasta.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[FALLBACK:%.*]], <vscale x 2 x i64> [[DATA:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
svint64_t test_svclasta_s64(svbool_t pg, svint64_t fallback, svint64_t data)
{
  return SVE_ACLE_FUNC(svclasta,_s64,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.clasta.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[FALLBACK:%.*]], <vscale x 16 x i8> [[DATA:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z16test_svclasta_u8u10__SVBool_tu11__SVUint8_tS0_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.clasta.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[FALLBACK:%.*]], <vscale x 16 x i8> [[DATA:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svuint8_t test_svclasta_u8(svbool_t pg, svuint8_t fallback, svuint8_t data)
{
  return SVE_ACLE_FUNC(svclasta,_u8,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.clasta.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[FALLBACK:%.*]], <vscale x 8 x i16> [[DATA:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svclasta_u16u10__SVBool_tu12__SVUint16_tS0_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.clasta.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[FALLBACK:%.*]], <vscale x 8 x i16> [[DATA:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
svuint16_t test_svclasta_u16(svbool_t pg, svuint16_t fallback, svuint16_t data)
{
  return SVE_ACLE_FUNC(svclasta,_u16,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.clasta.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[FALLBACK:%.*]], <vscale x 4 x i32> [[DATA:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svclasta_u32u10__SVBool_tu12__SVUint32_tS0_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.clasta.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[FALLBACK:%.*]], <vscale x 4 x i32> [[DATA:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
svuint32_t test_svclasta_u32(svbool_t pg, svuint32_t fallback, svuint32_t data)
{
  return SVE_ACLE_FUNC(svclasta,_u32,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.clasta.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[FALLBACK:%.*]], <vscale x 2 x i64> [[DATA:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svclasta_u64u10__SVBool_tu12__SVUint64_tS0_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.clasta.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[FALLBACK:%.*]], <vscale x 2 x i64> [[DATA:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
svuint64_t test_svclasta_u64(svbool_t pg, svuint64_t fallback, svuint64_t data)
{
  return SVE_ACLE_FUNC(svclasta,_u64,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.clasta.nxv8f16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[FALLBACK:%.*]], <vscale x 8 x half> [[DATA:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svclasta_f16u10__SVBool_tu13__SVFloat16_tS0_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.clasta.nxv8f16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[FALLBACK:%.*]], <vscale x 8 x half> [[DATA:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP1]]
//
svfloat16_t test_svclasta_f16(svbool_t pg, svfloat16_t fallback, svfloat16_t data)
{
  return SVE_ACLE_FUNC(svclasta,_f16,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.clasta.nxv4f32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x float> [[FALLBACK:%.*]], <vscale x 4 x float> [[DATA:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svclasta_f32u10__SVBool_tu13__SVFloat32_tS0_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.clasta.nxv4f32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x float> [[FALLBACK:%.*]], <vscale x 4 x float> [[DATA:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
//
svfloat32_t test_svclasta_f32(svbool_t pg, svfloat32_t fallback, svfloat32_t data)
{
  return SVE_ACLE_FUNC(svclasta,_f32,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_f64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.clasta.nxv2f64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x double> [[FALLBACK:%.*]], <vscale x 2 x double> [[DATA:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svclasta_f64u10__SVBool_tu13__SVFloat64_tS0_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.clasta.nxv2f64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x double> [[FALLBACK:%.*]], <vscale x 2 x double> [[DATA:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
//
svfloat64_t test_svclasta_f64(svbool_t pg, svfloat64_t fallback, svfloat64_t data)
{
  return SVE_ACLE_FUNC(svclasta,_f64,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_n_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i8 @llvm.aarch64.sve.clasta.n.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], i8 [[FALLBACK:%.*]], <vscale x 16 x i8> [[DATA:%.*]])
// CHECK-NEXT:    ret i8 [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z18test_svclasta_n_s8u10__SVBool_tau10__SVInt8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call i8 @llvm.aarch64.sve.clasta.n.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], i8 [[FALLBACK:%.*]], <vscale x 16 x i8> [[DATA:%.*]])
// CPP-CHECK-NEXT:    ret i8 [[TMP0]]
//
int8_t test_svclasta_n_s8(svbool_t pg, int8_t fallback, svint8_t data)
{
  return SVE_ACLE_FUNC(svclasta,_n_s8,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_n_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast i16 [[FALLBACK:%.*]] to half
// CHECK-NEXT:    [[TMP2:%.*]] = bitcast <vscale x 8 x i16> [[DATA:%.*]] to <vscale x 8 x half>
// CHECK-NEXT:    [[TMP3:%.*]] = tail call half @llvm.aarch64.sve.clasta.n.nxv8f16(<vscale x 8 x i1> [[TMP0]], half [[TMP1]], <vscale x 8 x half> [[TMP2]])
// CHECK-NEXT:    [[TMP4:%.*]] = bitcast half [[TMP3]] to i16
// CHECK-NEXT:    ret i16 [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z19test_svclasta_n_s16u10__SVBool_tsu11__SVInt16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast i16 [[FALLBACK:%.*]] to half
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = bitcast <vscale x 8 x i16> [[DATA:%.*]] to <vscale x 8 x half>
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call half @llvm.aarch64.sve.clasta.n.nxv8f16(<vscale x 8 x i1> [[TMP0]], half [[TMP1]], <vscale x 8 x half> [[TMP2]])
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = bitcast half [[TMP3]] to i16
// CPP-CHECK-NEXT:    ret i16 [[TMP4]]
//
int16_t test_svclasta_n_s16(svbool_t pg, int16_t fallback, svint16_t data)
{
  return SVE_ACLE_FUNC(svclasta,_n_s16,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_n_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32 [[FALLBACK:%.*]] to float
// CHECK-NEXT:    [[TMP2:%.*]] = bitcast <vscale x 4 x i32> [[DATA:%.*]] to <vscale x 4 x float>
// CHECK-NEXT:    [[TMP3:%.*]] = tail call float @llvm.aarch64.sve.clasta.n.nxv4f32(<vscale x 4 x i1> [[TMP0]], float [[TMP1]], <vscale x 4 x float> [[TMP2]])
// CHECK-NEXT:    [[TMP4:%.*]] = bitcast float [[TMP3]] to i32
// CHECK-NEXT:    ret i32 [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z19test_svclasta_n_s32u10__SVBool_tiu11__SVInt32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32 [[FALLBACK:%.*]] to float
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = bitcast <vscale x 4 x i32> [[DATA:%.*]] to <vscale x 4 x float>
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call float @llvm.aarch64.sve.clasta.n.nxv4f32(<vscale x 4 x i1> [[TMP0]], float [[TMP1]], <vscale x 4 x float> [[TMP2]])
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = bitcast float [[TMP3]] to i32
// CPP-CHECK-NEXT:    ret i32 [[TMP4]]
//
int32_t test_svclasta_n_s32(svbool_t pg, int32_t fallback, svint32_t data)
{
  return SVE_ACLE_FUNC(svclasta,_n_s32,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_n_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast i64 [[FALLBACK:%.*]] to double
// CHECK-NEXT:    [[TMP2:%.*]] = bitcast <vscale x 2 x i64> [[DATA:%.*]] to <vscale x 2 x double>
// CHECK-NEXT:    [[TMP3:%.*]] = tail call double @llvm.aarch64.sve.clasta.n.nxv2f64(<vscale x 2 x i1> [[TMP0]], double [[TMP1]], <vscale x 2 x double> [[TMP2]])
// CHECK-NEXT:    [[TMP4:%.*]] = bitcast double [[TMP3]] to i64
// CHECK-NEXT:    ret i64 [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z19test_svclasta_n_s64u10__SVBool_tlu11__SVInt64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast i64 [[FALLBACK:%.*]] to double
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = bitcast <vscale x 2 x i64> [[DATA:%.*]] to <vscale x 2 x double>
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call double @llvm.aarch64.sve.clasta.n.nxv2f64(<vscale x 2 x i1> [[TMP0]], double [[TMP1]], <vscale x 2 x double> [[TMP2]])
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = bitcast double [[TMP3]] to i64
// CPP-CHECK-NEXT:    ret i64 [[TMP4]]
//
int64_t test_svclasta_n_s64(svbool_t pg, int64_t fallback, svint64_t data)
{
  return SVE_ACLE_FUNC(svclasta,_n_s64,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_n_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i8 @llvm.aarch64.sve.clasta.n.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], i8 [[FALLBACK:%.*]], <vscale x 16 x i8> [[DATA:%.*]])
// CHECK-NEXT:    ret i8 [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z18test_svclasta_n_u8u10__SVBool_thu11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call i8 @llvm.aarch64.sve.clasta.n.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], i8 [[FALLBACK:%.*]], <vscale x 16 x i8> [[DATA:%.*]])
// CPP-CHECK-NEXT:    ret i8 [[TMP0]]
//
uint8_t test_svclasta_n_u8(svbool_t pg, uint8_t fallback, svuint8_t data)
{
  return SVE_ACLE_FUNC(svclasta,_n_u8,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_n_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast i16 [[FALLBACK:%.*]] to half
// CHECK-NEXT:    [[TMP2:%.*]] = bitcast <vscale x 8 x i16> [[DATA:%.*]] to <vscale x 8 x half>
// CHECK-NEXT:    [[TMP3:%.*]] = tail call half @llvm.aarch64.sve.clasta.n.nxv8f16(<vscale x 8 x i1> [[TMP0]], half [[TMP1]], <vscale x 8 x half> [[TMP2]])
// CHECK-NEXT:    [[TMP4:%.*]] = bitcast half [[TMP3]] to i16
// CHECK-NEXT:    ret i16 [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z19test_svclasta_n_u16u10__SVBool_ttu12__SVUint16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast i16 [[FALLBACK:%.*]] to half
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = bitcast <vscale x 8 x i16> [[DATA:%.*]] to <vscale x 8 x half>
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call half @llvm.aarch64.sve.clasta.n.nxv8f16(<vscale x 8 x i1> [[TMP0]], half [[TMP1]], <vscale x 8 x half> [[TMP2]])
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = bitcast half [[TMP3]] to i16
// CPP-CHECK-NEXT:    ret i16 [[TMP4]]
//
uint16_t test_svclasta_n_u16(svbool_t pg, uint16_t fallback, svuint16_t data)
{
  return SVE_ACLE_FUNC(svclasta,_n_u16,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_n_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32 [[FALLBACK:%.*]] to float
// CHECK-NEXT:    [[TMP2:%.*]] = bitcast <vscale x 4 x i32> [[DATA:%.*]] to <vscale x 4 x float>
// CHECK-NEXT:    [[TMP3:%.*]] = tail call float @llvm.aarch64.sve.clasta.n.nxv4f32(<vscale x 4 x i1> [[TMP0]], float [[TMP1]], <vscale x 4 x float> [[TMP2]])
// CHECK-NEXT:    [[TMP4:%.*]] = bitcast float [[TMP3]] to i32
// CHECK-NEXT:    ret i32 [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z19test_svclasta_n_u32u10__SVBool_tju12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32 [[FALLBACK:%.*]] to float
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = bitcast <vscale x 4 x i32> [[DATA:%.*]] to <vscale x 4 x float>
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call float @llvm.aarch64.sve.clasta.n.nxv4f32(<vscale x 4 x i1> [[TMP0]], float [[TMP1]], <vscale x 4 x float> [[TMP2]])
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = bitcast float [[TMP3]] to i32
// CPP-CHECK-NEXT:    ret i32 [[TMP4]]
//
uint32_t test_svclasta_n_u32(svbool_t pg, uint32_t fallback, svuint32_t data)
{
  return SVE_ACLE_FUNC(svclasta,_n_u32,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_n_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast i64 [[FALLBACK:%.*]] to double
// CHECK-NEXT:    [[TMP2:%.*]] = bitcast <vscale x 2 x i64> [[DATA:%.*]] to <vscale x 2 x double>
// CHECK-NEXT:    [[TMP3:%.*]] = tail call double @llvm.aarch64.sve.clasta.n.nxv2f64(<vscale x 2 x i1> [[TMP0]], double [[TMP1]], <vscale x 2 x double> [[TMP2]])
// CHECK-NEXT:    [[TMP4:%.*]] = bitcast double [[TMP3]] to i64
// CHECK-NEXT:    ret i64 [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z19test_svclasta_n_u64u10__SVBool_tmu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast i64 [[FALLBACK:%.*]] to double
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = bitcast <vscale x 2 x i64> [[DATA:%.*]] to <vscale x 2 x double>
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call double @llvm.aarch64.sve.clasta.n.nxv2f64(<vscale x 2 x i1> [[TMP0]], double [[TMP1]], <vscale x 2 x double> [[TMP2]])
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = bitcast double [[TMP3]] to i64
// CPP-CHECK-NEXT:    ret i64 [[TMP4]]
//
uint64_t test_svclasta_n_u64(svbool_t pg, uint64_t fallback, svuint64_t data)
{
  return SVE_ACLE_FUNC(svclasta,_n_u64,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_n_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call half @llvm.aarch64.sve.clasta.n.nxv8f16(<vscale x 8 x i1> [[TMP0]], half [[FALLBACK:%.*]], <vscale x 8 x half> [[DATA:%.*]])
// CHECK-NEXT:    ret half [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z19test_svclasta_n_f16u10__SVBool_tDhu13__SVFloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call half @llvm.aarch64.sve.clasta.n.nxv8f16(<vscale x 8 x i1> [[TMP0]], half [[FALLBACK:%.*]], <vscale x 8 x half> [[DATA:%.*]])
// CPP-CHECK-NEXT:    ret half [[TMP1]]
//
float16_t test_svclasta_n_f16(svbool_t pg, float16_t fallback, svfloat16_t data)
{
  return SVE_ACLE_FUNC(svclasta,_n_f16,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_n_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call float @llvm.aarch64.sve.clasta.n.nxv4f32(<vscale x 4 x i1> [[TMP0]], float [[FALLBACK:%.*]], <vscale x 4 x float> [[DATA:%.*]])
// CHECK-NEXT:    ret float [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z19test_svclasta_n_f32u10__SVBool_tfu13__SVFloat32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call float @llvm.aarch64.sve.clasta.n.nxv4f32(<vscale x 4 x i1> [[TMP0]], float [[FALLBACK:%.*]], <vscale x 4 x float> [[DATA:%.*]])
// CPP-CHECK-NEXT:    ret float [[TMP1]]
//
float32_t test_svclasta_n_f32(svbool_t pg, float32_t fallback, svfloat32_t data)
{
  return SVE_ACLE_FUNC(svclasta,_n_f32,,)(pg, fallback, data);
}

// CHECK-LABEL: @test_svclasta_n_f64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call double @llvm.aarch64.sve.clasta.n.nxv2f64(<vscale x 2 x i1> [[TMP0]], double [[FALLBACK:%.*]], <vscale x 2 x double> [[DATA:%.*]])
// CHECK-NEXT:    ret double [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z19test_svclasta_n_f64u10__SVBool_tdu13__SVFloat64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call double @llvm.aarch64.sve.clasta.n.nxv2f64(<vscale x 2 x i1> [[TMP0]], double [[FALLBACK:%.*]], <vscale x 2 x double> [[DATA:%.*]])
// CPP-CHECK-NEXT:    ret double [[TMP1]]
//
float64_t test_svclasta_n_f64(svbool_t pg, float64_t fallback, svfloat64_t data)
{
  return SVE_ACLE_FUNC(svclasta,_n_f64,,)(pg, fallback, data);
}
