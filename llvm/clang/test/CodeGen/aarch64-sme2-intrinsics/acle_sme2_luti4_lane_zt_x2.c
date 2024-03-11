// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py

// REQUIRES: aarch64-registered-target

// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sme2 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sme2 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sme2 -S -disable-O0-optnone -Werror -Wall -o /dev/null %s

#include <arm_sme.h>

// CHECK-LABEL: @test_svluti4_lane_zt_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sme.luti4.lane.zt.x2.nxv16i8(i32 0, <vscale x 16 x i8> [[ZN:%.*]], i32 3)
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP0]], 0
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 32 x i8> @llvm.vector.insert.nxv32i8.nxv16i8(<vscale x 32 x i8> poison, <vscale x 16 x i8> [[TMP1]], i64 0)
// CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP0]], 1
// CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 32 x i8> @llvm.vector.insert.nxv32i8.nxv16i8(<vscale x 32 x i8> [[TMP2]], <vscale x 16 x i8> [[TMP3]], i64 16)
// CHECK-NEXT:    ret <vscale x 32 x i8> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z23test_svluti4_lane_zt_u8u11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sme.luti4.lane.zt.x2.nxv16i8(i32 0, <vscale x 16 x i8> [[ZN:%.*]], i32 3)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP0]], 0
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 32 x i8> @llvm.vector.insert.nxv32i8.nxv16i8(<vscale x 32 x i8> poison, <vscale x 16 x i8> [[TMP1]], i64 0)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP0]], 1
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 32 x i8> @llvm.vector.insert.nxv32i8.nxv16i8(<vscale x 32 x i8> [[TMP2]], <vscale x 16 x i8> [[TMP3]], i64 16)
// CPP-CHECK-NEXT:    ret <vscale x 32 x i8> [[TMP4]]
//
svuint8x2_t test_svluti4_lane_zt_u8(svuint8_t zn) __arm_streaming __arm_in("zt0") {
  return svluti4_lane_zt_u8_x2(0, zn, 3);
}


// CHECK-LABEL: @test_svluti4_lane_zt_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sme.luti4.lane.zt.x2.nxv16i8(i32 0, <vscale x 16 x i8> [[ZN:%.*]], i32 3)
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP0]], 0
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 32 x i8> @llvm.vector.insert.nxv32i8.nxv16i8(<vscale x 32 x i8> poison, <vscale x 16 x i8> [[TMP1]], i64 0)
// CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP0]], 1
// CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 32 x i8> @llvm.vector.insert.nxv32i8.nxv16i8(<vscale x 32 x i8> [[TMP2]], <vscale x 16 x i8> [[TMP3]], i64 16)
// CHECK-NEXT:    ret <vscale x 32 x i8> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z23test_svluti4_lane_zt_s8u11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.aarch64.sme.luti4.lane.zt.x2.nxv16i8(i32 0, <vscale x 16 x i8> [[ZN:%.*]], i32 3)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP0]], 0
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 32 x i8> @llvm.vector.insert.nxv32i8.nxv16i8(<vscale x 32 x i8> poison, <vscale x 16 x i8> [[TMP1]], i64 0)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP0]], 1
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 32 x i8> @llvm.vector.insert.nxv32i8.nxv16i8(<vscale x 32 x i8> [[TMP2]], <vscale x 16 x i8> [[TMP3]], i64 16)
// CPP-CHECK-NEXT:    ret <vscale x 32 x i8> [[TMP4]]
//
svint8x2_t test_svluti4_lane_zt_s8(svuint8_t zn) __arm_streaming __arm_in("zt0") {
  return svluti4_lane_zt_s8_x2(0, zn, 3);
}

// CHECK-LABEL: @test_svluti4_lane_zt_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sme.luti4.lane.zt.x2.nxv8i16(i32 0, <vscale x 16 x i8> [[ZN:%.*]], i32 3)
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]], 0
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i16> @llvm.vector.insert.nxv16i16.nxv8i16(<vscale x 16 x i16> poison, <vscale x 8 x i16> [[TMP1]], i64 0)
// CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]], 1
// CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 16 x i16> @llvm.vector.insert.nxv16i16.nxv8i16(<vscale x 16 x i16> [[TMP2]], <vscale x 8 x i16> [[TMP3]], i64 8)
// CHECK-NEXT:    ret <vscale x 16 x i16> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z24test_svluti4_lane_zt_u16u11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sme.luti4.lane.zt.x2.nxv8i16(i32 0, <vscale x 16 x i8> [[ZN:%.*]], i32 3)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]], 0
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i16> @llvm.vector.insert.nxv16i16.nxv8i16(<vscale x 16 x i16> poison, <vscale x 8 x i16> [[TMP1]], i64 0)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]], 1
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 16 x i16> @llvm.vector.insert.nxv16i16.nxv8i16(<vscale x 16 x i16> [[TMP2]], <vscale x 8 x i16> [[TMP3]], i64 8)
// CPP-CHECK-NEXT:    ret <vscale x 16 x i16> [[TMP4]]
//
svuint16x2_t test_svluti4_lane_zt_u16(svuint8_t zn) __arm_streaming __arm_in("zt0") {
  return svluti4_lane_zt_u16_x2(0, zn, 3);
}


// CHECK-LABEL: @test_svluti4_lane_zt_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sme.luti4.lane.zt.x2.nxv8i16(i32 0, <vscale x 16 x i8> [[ZN:%.*]], i32 3)
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]], 0
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i16> @llvm.vector.insert.nxv16i16.nxv8i16(<vscale x 16 x i16> poison, <vscale x 8 x i16> [[TMP1]], i64 0)
// CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]], 1
// CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 16 x i16> @llvm.vector.insert.nxv16i16.nxv8i16(<vscale x 16 x i16> [[TMP2]], <vscale x 8 x i16> [[TMP3]], i64 8)
// CHECK-NEXT:    ret <vscale x 16 x i16> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z24test_svluti4_lane_zt_s16u11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sme.luti4.lane.zt.x2.nxv8i16(i32 0, <vscale x 16 x i8> [[ZN:%.*]], i32 3)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]], 0
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i16> @llvm.vector.insert.nxv16i16.nxv8i16(<vscale x 16 x i16> poison, <vscale x 8 x i16> [[TMP1]], i64 0)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]], 1
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 16 x i16> @llvm.vector.insert.nxv16i16.nxv8i16(<vscale x 16 x i16> [[TMP2]], <vscale x 8 x i16> [[TMP3]], i64 8)
// CPP-CHECK-NEXT:    ret <vscale x 16 x i16> [[TMP4]]
//
svint16x2_t test_svluti4_lane_zt_s16(svuint8_t zn) __arm_streaming __arm_in("zt0") {
  return svluti4_lane_zt_s16_x2(0, zn, 3);
}

// CHECK-LABEL: @test_svluti4_lane_zt_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x half>, <vscale x 8 x half> } @llvm.aarch64.sme.luti4.lane.zt.x2.nxv8f16(i32 0, <vscale x 16 x i8> [[ZN:%.*]], i32 3)
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x half>, <vscale x 8 x half> } [[TMP0]], 0
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x half> @llvm.vector.insert.nxv16f16.nxv8f16(<vscale x 16 x half> poison, <vscale x 8 x half> [[TMP1]], i64 0)
// CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x half>, <vscale x 8 x half> } [[TMP0]], 1
// CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 16 x half> @llvm.vector.insert.nxv16f16.nxv8f16(<vscale x 16 x half> [[TMP2]], <vscale x 8 x half> [[TMP3]], i64 8)
// CHECK-NEXT:    ret <vscale x 16 x half> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z24test_svluti4_lane_zt_f16u11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x half>, <vscale x 8 x half> } @llvm.aarch64.sme.luti4.lane.zt.x2.nxv8f16(i32 0, <vscale x 16 x i8> [[ZN:%.*]], i32 3)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x half>, <vscale x 8 x half> } [[TMP0]], 0
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x half> @llvm.vector.insert.nxv16f16.nxv8f16(<vscale x 16 x half> poison, <vscale x 8 x half> [[TMP1]], i64 0)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x half>, <vscale x 8 x half> } [[TMP0]], 1
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 16 x half> @llvm.vector.insert.nxv16f16.nxv8f16(<vscale x 16 x half> [[TMP2]], <vscale x 8 x half> [[TMP3]], i64 8)
// CPP-CHECK-NEXT:    ret <vscale x 16 x half> [[TMP4]]
//
svfloat16x2_t test_svluti4_lane_zt_f16(svuint8_t zn) __arm_streaming __arm_in("zt0") {
  return svluti4_lane_zt_f16_x2(0, zn, 3);
}

// CHECK-LABEL: @test_svluti4_lane_zt_bf16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sme.luti4.lane.zt.x2.nxv8bf16(i32 0, <vscale x 16 x i8> [[ZN:%.*]], i32 3)
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } [[TMP0]], 0
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x bfloat> @llvm.vector.insert.nxv16bf16.nxv8bf16(<vscale x 16 x bfloat> poison, <vscale x 8 x bfloat> [[TMP1]], i64 0)
// CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } [[TMP0]], 1
// CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 16 x bfloat> @llvm.vector.insert.nxv16bf16.nxv8bf16(<vscale x 16 x bfloat> [[TMP2]], <vscale x 8 x bfloat> [[TMP3]], i64 8)
// CHECK-NEXT:    ret <vscale x 16 x bfloat> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z25test_svluti4_lane_zt_bf16u11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } @llvm.aarch64.sme.luti4.lane.zt.x2.nxv8bf16(i32 0, <vscale x 16 x i8> [[ZN:%.*]], i32 3)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } [[TMP0]], 0
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x bfloat> @llvm.vector.insert.nxv16bf16.nxv8bf16(<vscale x 16 x bfloat> poison, <vscale x 8 x bfloat> [[TMP1]], i64 0)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x bfloat>, <vscale x 8 x bfloat> } [[TMP0]], 1
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 16 x bfloat> @llvm.vector.insert.nxv16bf16.nxv8bf16(<vscale x 16 x bfloat> [[TMP2]], <vscale x 8 x bfloat> [[TMP3]], i64 8)
// CPP-CHECK-NEXT:    ret <vscale x 16 x bfloat> [[TMP4]]
//
svbfloat16x2_t test_svluti4_lane_zt_bf16(svuint8_t zn) __arm_streaming __arm_in("zt0") {
  return svluti4_lane_zt_bf16_x2(0, zn, 3);
}

// CHECK-LABEL: @test_svluti4_lane_zt_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sme.luti4.lane.zt.x2.nxv4i32(i32 0, <vscale x 16 x i8> [[ZN:%.*]], i32 3)
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]], 0
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.nxv4i32(<vscale x 8 x i32> poison, <vscale x 4 x i32> [[TMP1]], i64 0)
// CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]], 1
// CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.nxv4i32(<vscale x 8 x i32> [[TMP2]], <vscale x 4 x i32> [[TMP3]], i64 4)
// CHECK-NEXT:    ret <vscale x 8 x i32> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z24test_svluti4_lane_zt_u32u11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sme.luti4.lane.zt.x2.nxv4i32(i32 0, <vscale x 16 x i8> [[ZN:%.*]], i32 3)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]], 0
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.nxv4i32(<vscale x 8 x i32> poison, <vscale x 4 x i32> [[TMP1]], i64 0)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]], 1
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.nxv4i32(<vscale x 8 x i32> [[TMP2]], <vscale x 4 x i32> [[TMP3]], i64 4)
// CPP-CHECK-NEXT:    ret <vscale x 8 x i32> [[TMP4]]
//
svuint32x2_t test_svluti4_lane_zt_u32(svuint8_t zn) __arm_streaming __arm_in("zt0") {
  return svluti4_lane_zt_u32_x2(0, zn, 3);
}

// CHECK-LABEL: @test_svluti4_lane_zt_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sme.luti4.lane.zt.x2.nxv4i32(i32 0, <vscale x 16 x i8> [[ZN:%.*]], i32 3)
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]], 0
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.nxv4i32(<vscale x 8 x i32> poison, <vscale x 4 x i32> [[TMP1]], i64 0)
// CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]], 1
// CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.nxv4i32(<vscale x 8 x i32> [[TMP2]], <vscale x 4 x i32> [[TMP3]], i64 4)
// CHECK-NEXT:    ret <vscale x 8 x i32> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z24test_svluti4_lane_zt_s32u11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sme.luti4.lane.zt.x2.nxv4i32(i32 0, <vscale x 16 x i8> [[ZN:%.*]], i32 3)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]], 0
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.nxv4i32(<vscale x 8 x i32> poison, <vscale x 4 x i32> [[TMP1]], i64 0)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]], 1
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.nxv4i32(<vscale x 8 x i32> [[TMP2]], <vscale x 4 x i32> [[TMP3]], i64 4)
// CPP-CHECK-NEXT:    ret <vscale x 8 x i32> [[TMP4]]
//
svint32x2_t test_svluti4_lane_zt_s32(svuint8_t zn) __arm_streaming __arm_in("zt0") {
  return svluti4_lane_zt_s32_x2(0, zn, 3);
}

// CHECK-LABEL: @test_svluti4_lane_zt_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x float>, <vscale x 4 x float> } @llvm.aarch64.sme.luti4.lane.zt.x2.nxv4f32(i32 0, <vscale x 16 x i8> [[ZN:%.*]], i32 3)
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float> } [[TMP0]], 0
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x float> @llvm.vector.insert.nxv8f32.nxv4f32(<vscale x 8 x float> poison, <vscale x 4 x float> [[TMP1]], i64 0)
// CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float> } [[TMP0]], 1
// CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 8 x float> @llvm.vector.insert.nxv8f32.nxv4f32(<vscale x 8 x float> [[TMP2]], <vscale x 4 x float> [[TMP3]], i64 4)
// CHECK-NEXT:    ret <vscale x 8 x float> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z24test_svluti4_lane_zt_f32u11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x float>, <vscale x 4 x float> } @llvm.aarch64.sme.luti4.lane.zt.x2.nxv4f32(i32 0, <vscale x 16 x i8> [[ZN:%.*]], i32 3)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float> } [[TMP0]], 0
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x float> @llvm.vector.insert.nxv8f32.nxv4f32(<vscale x 8 x float> poison, <vscale x 4 x float> [[TMP1]], i64 0)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float> } [[TMP0]], 1
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 8 x float> @llvm.vector.insert.nxv8f32.nxv4f32(<vscale x 8 x float> [[TMP2]], <vscale x 4 x float> [[TMP3]], i64 4)
// CPP-CHECK-NEXT:    ret <vscale x 8 x float> [[TMP4]]
//
svfloat32x2_t test_svluti4_lane_zt_f32(svuint8_t zn) __arm_streaming __arm_in("zt0") {
  return svluti4_lane_zt_f32_x2(0, zn, 3);
}
