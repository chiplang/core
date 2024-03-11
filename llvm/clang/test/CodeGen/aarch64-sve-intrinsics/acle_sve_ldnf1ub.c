// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -o /dev/null %s
#include <arm_sve.h>

// CHECK-LABEL: @test_svldnf1ub_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i8> @llvm.aarch64.sve.ldnf1.nxv8i8(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 8 x i8> [[TMP1]] to <vscale x 8 x i16>
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z18test_svldnf1ub_s16u10__SVBool_tPKh(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i8> @llvm.aarch64.sve.ldnf1.nxv8i8(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 8 x i8> [[TMP1]] to <vscale x 8 x i16>
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
svint16_t test_svldnf1ub_s16(svbool_t pg, const uint8_t *base)
{
  return svldnf1ub_s16(pg, base);
}

// CHECK-LABEL: @test_svldnf1ub_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnf1.nxv4i8(<vscale x 4 x i1> [[TMP0]], ptr [[BASE:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z18test_svldnf1ub_s32u10__SVBool_tPKh(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnf1.nxv4i8(<vscale x 4 x i1> [[TMP0]], ptr [[BASE:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svint32_t test_svldnf1ub_s32(svbool_t pg, const uint8_t *base)
{
  return svldnf1ub_s32(pg, base);
}

// CHECK-LABEL: @test_svldnf1ub_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnf1.nxv2i8(<vscale x 2 x i1> [[TMP0]], ptr [[BASE:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z18test_svldnf1ub_s64u10__SVBool_tPKh(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnf1.nxv2i8(<vscale x 2 x i1> [[TMP0]], ptr [[BASE:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svint64_t test_svldnf1ub_s64(svbool_t pg, const uint8_t *base)
{
  return svldnf1ub_s64(pg, base);
}

// CHECK-LABEL: @test_svldnf1ub_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i8> @llvm.aarch64.sve.ldnf1.nxv8i8(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 8 x i8> [[TMP1]] to <vscale x 8 x i16>
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z18test_svldnf1ub_u16u10__SVBool_tPKh(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i8> @llvm.aarch64.sve.ldnf1.nxv8i8(<vscale x 8 x i1> [[TMP0]], ptr [[BASE:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 8 x i8> [[TMP1]] to <vscale x 8 x i16>
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
svuint16_t test_svldnf1ub_u16(svbool_t pg, const uint8_t *base)
{
  return svldnf1ub_u16(pg, base);
}

// CHECK-LABEL: @test_svldnf1ub_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnf1.nxv4i8(<vscale x 4 x i1> [[TMP0]], ptr [[BASE:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z18test_svldnf1ub_u32u10__SVBool_tPKh(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnf1.nxv4i8(<vscale x 4 x i1> [[TMP0]], ptr [[BASE:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svuint32_t test_svldnf1ub_u32(svbool_t pg, const uint8_t *base)
{
  return svldnf1ub_u32(pg, base);
}

// CHECK-LABEL: @test_svldnf1ub_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnf1.nxv2i8(<vscale x 2 x i1> [[TMP0]], ptr [[BASE:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z18test_svldnf1ub_u64u10__SVBool_tPKh(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnf1.nxv2i8(<vscale x 2 x i1> [[TMP0]], ptr [[BASE:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svuint64_t test_svldnf1ub_u64(svbool_t pg, const uint8_t *base)
{
  return svldnf1ub_u64(pg, base);
}

// CHECK-LABEL: @test_svldnf1ub_vnum_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = getelementptr <vscale x 8 x i8>, ptr [[BASE:%.*]], i64 [[VNUM:%.*]]
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i8> @llvm.aarch64.sve.ldnf1.nxv8i8(<vscale x 8 x i1> [[TMP0]], ptr [[TMP1]])
// CHECK-NEXT:    [[TMP3:%.*]] = zext <vscale x 8 x i8> [[TMP2]] to <vscale x 8 x i16>
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP3]]
//
// CPP-CHECK-LABEL: @_Z23test_svldnf1ub_vnum_s16u10__SVBool_tPKhl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = getelementptr <vscale x 8 x i8>, ptr [[BASE:%.*]], i64 [[VNUM:%.*]]
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i8> @llvm.aarch64.sve.ldnf1.nxv8i8(<vscale x 8 x i1> [[TMP0]], ptr [[TMP1]])
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = zext <vscale x 8 x i8> [[TMP2]] to <vscale x 8 x i16>
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP3]]
//
svint16_t test_svldnf1ub_vnum_s16(svbool_t pg, const uint8_t *base, int64_t vnum)
{
  return svldnf1ub_vnum_s16(pg, base, vnum);
}

// CHECK-LABEL: @test_svldnf1ub_vnum_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = getelementptr <vscale x 4 x i8>, ptr [[BASE:%.*]], i64 [[VNUM:%.*]]
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnf1.nxv4i8(<vscale x 4 x i1> [[TMP0]], ptr [[TMP1]])
// CHECK-NEXT:    [[TMP3:%.*]] = zext <vscale x 4 x i8> [[TMP2]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP3]]
//
// CPP-CHECK-LABEL: @_Z23test_svldnf1ub_vnum_s32u10__SVBool_tPKhl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = getelementptr <vscale x 4 x i8>, ptr [[BASE:%.*]], i64 [[VNUM:%.*]]
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnf1.nxv4i8(<vscale x 4 x i1> [[TMP0]], ptr [[TMP1]])
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = zext <vscale x 4 x i8> [[TMP2]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP3]]
//
svint32_t test_svldnf1ub_vnum_s32(svbool_t pg, const uint8_t *base, int64_t vnum)
{
  return svldnf1ub_vnum_s32(pg, base, vnum);
}

// CHECK-LABEL: @test_svldnf1ub_vnum_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = getelementptr <vscale x 2 x i8>, ptr [[BASE:%.*]], i64 [[VNUM:%.*]]
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnf1.nxv2i8(<vscale x 2 x i1> [[TMP0]], ptr [[TMP1]])
// CHECK-NEXT:    [[TMP3:%.*]] = zext <vscale x 2 x i8> [[TMP2]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP3]]
//
// CPP-CHECK-LABEL: @_Z23test_svldnf1ub_vnum_s64u10__SVBool_tPKhl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = getelementptr <vscale x 2 x i8>, ptr [[BASE:%.*]], i64 [[VNUM:%.*]]
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnf1.nxv2i8(<vscale x 2 x i1> [[TMP0]], ptr [[TMP1]])
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = zext <vscale x 2 x i8> [[TMP2]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP3]]
//
svint64_t test_svldnf1ub_vnum_s64(svbool_t pg, const uint8_t *base, int64_t vnum)
{
  return svldnf1ub_vnum_s64(pg, base, vnum);
}

// CHECK-LABEL: @test_svldnf1ub_vnum_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = getelementptr <vscale x 8 x i8>, ptr [[BASE:%.*]], i64 [[VNUM:%.*]]
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i8> @llvm.aarch64.sve.ldnf1.nxv8i8(<vscale x 8 x i1> [[TMP0]], ptr [[TMP1]])
// CHECK-NEXT:    [[TMP3:%.*]] = zext <vscale x 8 x i8> [[TMP2]] to <vscale x 8 x i16>
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP3]]
//
// CPP-CHECK-LABEL: @_Z23test_svldnf1ub_vnum_u16u10__SVBool_tPKhl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = getelementptr <vscale x 8 x i8>, ptr [[BASE:%.*]], i64 [[VNUM:%.*]]
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i8> @llvm.aarch64.sve.ldnf1.nxv8i8(<vscale x 8 x i1> [[TMP0]], ptr [[TMP1]])
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = zext <vscale x 8 x i8> [[TMP2]] to <vscale x 8 x i16>
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP3]]
//
svuint16_t test_svldnf1ub_vnum_u16(svbool_t pg, const uint8_t *base, int64_t vnum)
{
  return svldnf1ub_vnum_u16(pg, base, vnum);
}

// CHECK-LABEL: @test_svldnf1ub_vnum_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = getelementptr <vscale x 4 x i8>, ptr [[BASE:%.*]], i64 [[VNUM:%.*]]
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnf1.nxv4i8(<vscale x 4 x i1> [[TMP0]], ptr [[TMP1]])
// CHECK-NEXT:    [[TMP3:%.*]] = zext <vscale x 4 x i8> [[TMP2]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP3]]
//
// CPP-CHECK-LABEL: @_Z23test_svldnf1ub_vnum_u32u10__SVBool_tPKhl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = getelementptr <vscale x 4 x i8>, ptr [[BASE:%.*]], i64 [[VNUM:%.*]]
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnf1.nxv4i8(<vscale x 4 x i1> [[TMP0]], ptr [[TMP1]])
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = zext <vscale x 4 x i8> [[TMP2]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP3]]
//
svuint32_t test_svldnf1ub_vnum_u32(svbool_t pg, const uint8_t *base, int64_t vnum)
{
  return svldnf1ub_vnum_u32(pg, base, vnum);
}

// CHECK-LABEL: @test_svldnf1ub_vnum_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = getelementptr <vscale x 2 x i8>, ptr [[BASE:%.*]], i64 [[VNUM:%.*]]
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnf1.nxv2i8(<vscale x 2 x i1> [[TMP0]], ptr [[TMP1]])
// CHECK-NEXT:    [[TMP3:%.*]] = zext <vscale x 2 x i8> [[TMP2]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP3]]
//
// CPP-CHECK-LABEL: @_Z23test_svldnf1ub_vnum_u64u10__SVBool_tPKhl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = getelementptr <vscale x 2 x i8>, ptr [[BASE:%.*]], i64 [[VNUM:%.*]]
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnf1.nxv2i8(<vscale x 2 x i1> [[TMP0]], ptr [[TMP1]])
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = zext <vscale x 2 x i8> [[TMP2]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP3]]
//
svuint64_t test_svldnf1ub_vnum_u64(svbool_t pg, const uint8_t *base, int64_t vnum)
{
  return svldnf1ub_vnum_u64(pg, base, vnum);
}
