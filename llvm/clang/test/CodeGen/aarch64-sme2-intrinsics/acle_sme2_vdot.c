// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sme2 -target-feature +sme-i16i64 -target-feature +sme-f64f64 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sme2 -target-feature +sme-i16i64 -target-feature +sme-f64f64 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sme2 -target-feature +sme-i16i64 -target-feature +sme-f64f64 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sme2 -target-feature +sme-i16i64 -target-feature +sme-f64f64 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sme2 -target-feature +sme-i16i64 -S -disable-O0-optnone -Werror -Wall -o /dev/null %s
#include <arm_sme.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3) A1##A2##A3
#endif

// CHECK-LABEL: @test_svvdot_lane_za32_bf16_vg1x2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x bfloat> @llvm.vector.extract.nxv8bf16.nxv16bf16(<vscale x 16 x bfloat> [[ZN:%.*]], i64 0)
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x bfloat> @llvm.vector.extract.nxv8bf16.nxv16bf16(<vscale x 16 x bfloat> [[ZN]], i64 8)
// CHECK-NEXT:    tail call void @llvm.aarch64.sme.fvdot.lane.za32.vg1x2.nxv8bf16(i32 [[SLICE_BASE:%.*]], <vscale x 8 x bfloat> [[TMP0]], <vscale x 8 x bfloat> [[TMP1]], <vscale x 8 x bfloat> [[ZM:%.*]], i32 3)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z32test_svvdot_lane_za32_bf16_vg1x2j14svbfloat16x2_tu14__SVBfloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x bfloat> @llvm.vector.extract.nxv8bf16.nxv16bf16(<vscale x 16 x bfloat> [[ZN:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x bfloat> @llvm.vector.extract.nxv8bf16.nxv16bf16(<vscale x 16 x bfloat> [[ZN]], i64 8)
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sme.fvdot.lane.za32.vg1x2.nxv8bf16(i32 [[SLICE_BASE:%.*]], <vscale x 8 x bfloat> [[TMP0]], <vscale x 8 x bfloat> [[TMP1]], <vscale x 8 x bfloat> [[ZM:%.*]], i32 3)
// CPP-CHECK-NEXT:    ret void
//
void test_svvdot_lane_za32_bf16_vg1x2(uint32_t slice_base, svbfloat16x2_t zn, svbfloat16_t zm) __arm_streaming __arm_inout("za") {
  SVE_ACLE_FUNC(svvdot_lane_za32,_bf16,_vg1x2)(slice_base, zn, zm, 3);
}

// CHECK-LABEL: @test_svvdot_lane_za32_f16_vg1x2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x half> @llvm.vector.extract.nxv8f16.nxv16f16(<vscale x 16 x half> [[ZN:%.*]], i64 0)
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x half> @llvm.vector.extract.nxv8f16.nxv16f16(<vscale x 16 x half> [[ZN]], i64 8)
// CHECK-NEXT:    tail call void @llvm.aarch64.sme.fvdot.lane.za32.vg1x2.nxv8f16(i32 [[SLICE_BASE:%.*]], <vscale x 8 x half> [[TMP0]], <vscale x 8 x half> [[TMP1]], <vscale x 8 x half> [[ZM:%.*]], i32 3)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z31test_svvdot_lane_za32_f16_vg1x2j13svfloat16x2_tu13__SVFloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x half> @llvm.vector.extract.nxv8f16.nxv16f16(<vscale x 16 x half> [[ZN:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x half> @llvm.vector.extract.nxv8f16.nxv16f16(<vscale x 16 x half> [[ZN]], i64 8)
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sme.fvdot.lane.za32.vg1x2.nxv8f16(i32 [[SLICE_BASE:%.*]], <vscale x 8 x half> [[TMP0]], <vscale x 8 x half> [[TMP1]], <vscale x 8 x half> [[ZM:%.*]], i32 3)
// CPP-CHECK-NEXT:    ret void
//
void test_svvdot_lane_za32_f16_vg1x2(uint32_t slice_base, svfloat16x2_t zn, svfloat16_t zm) __arm_streaming __arm_inout("za") {
  SVE_ACLE_FUNC(svvdot_lane_za32,_f16,_vg1x2)(slice_base, zn, zm, 3);
}

// CHECK-LABEL: @test_svvdot_lane_za32_s16_vg1x2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv16i16(<vscale x 16 x i16> [[ZN:%.*]], i64 0)
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv16i16(<vscale x 16 x i16> [[ZN]], i64 8)
// CHECK-NEXT:    tail call void @llvm.aarch64.sme.svdot.lane.za32.vg1x2.nxv8i16(i32 [[SLICE_BASE:%.*]], <vscale x 8 x i16> [[TMP0]], <vscale x 8 x i16> [[TMP1]], <vscale x 8 x i16> [[ZM:%.*]], i32 3)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z31test_svvdot_lane_za32_s16_vg1x2j11svint16x2_tu11__SVInt16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv16i16(<vscale x 16 x i16> [[ZN:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv16i16(<vscale x 16 x i16> [[ZN]], i64 8)
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sme.svdot.lane.za32.vg1x2.nxv8i16(i32 [[SLICE_BASE:%.*]], <vscale x 8 x i16> [[TMP0]], <vscale x 8 x i16> [[TMP1]], <vscale x 8 x i16> [[ZM:%.*]], i32 3)
// CPP-CHECK-NEXT:    ret void
//
void test_svvdot_lane_za32_s16_vg1x2(uint32_t slice_base, svint16x2_t zn, svint16_t zm) __arm_streaming __arm_inout("za") {
  SVE_ACLE_FUNC(svvdot_lane_za32,_s16,_vg1x2)(slice_base, zn, zm, 3);
}

// CHECK-LABEL: @test_svvdot_lane_za32_u16_vg1x2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv16i16(<vscale x 16 x i16> [[ZN:%.*]], i64 0)
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv16i16(<vscale x 16 x i16> [[ZN]], i64 8)
// CHECK-NEXT:    tail call void @llvm.aarch64.sme.uvdot.lane.za32.vg1x2.nxv8i16(i32 [[SLICE_BASE:%.*]], <vscale x 8 x i16> [[TMP0]], <vscale x 8 x i16> [[TMP1]], <vscale x 8 x i16> [[ZM:%.*]], i32 3)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z31test_svvdot_lane_za32_u16_vg1x2j12svuint16x2_tu12__SVUint16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv16i16(<vscale x 16 x i16> [[ZN:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv16i16(<vscale x 16 x i16> [[ZN]], i64 8)
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sme.uvdot.lane.za32.vg1x2.nxv8i16(i32 [[SLICE_BASE:%.*]], <vscale x 8 x i16> [[TMP0]], <vscale x 8 x i16> [[TMP1]], <vscale x 8 x i16> [[ZM:%.*]], i32 3)
// CPP-CHECK-NEXT:    ret void
//
void test_svvdot_lane_za32_u16_vg1x2(uint32_t slice_base, svuint16x2_t zn, svuint16_t zm) __arm_streaming __arm_inout("za") {
  SVE_ACLE_FUNC(svvdot_lane_za32,_u16,_vg1x2)(slice_base, zn, zm, 3);
}

// CHECK-LABEL: @test_svvdot_lane_za32_s8_vg1x4(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN:%.*]], i64 0)
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 16)
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 32)
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 48)
// CHECK-NEXT:    tail call void @llvm.aarch64.sme.svdot.lane.za32.vg1x4.nxv16i8(i32 [[SLICE_BASE:%.*]], <vscale x 16 x i8> [[TMP0]], <vscale x 16 x i8> [[TMP1]], <vscale x 16 x i8> [[TMP2]], <vscale x 16 x i8> [[TMP3]], <vscale x 16 x i8> [[ZM:%.*]], i32 3)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z30test_svvdot_lane_za32_s8_vg1x4j10svint8x4_tu10__SVInt8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 16)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 32)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 48)
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sme.svdot.lane.za32.vg1x4.nxv16i8(i32 [[SLICE_BASE:%.*]], <vscale x 16 x i8> [[TMP0]], <vscale x 16 x i8> [[TMP1]], <vscale x 16 x i8> [[TMP2]], <vscale x 16 x i8> [[TMP3]], <vscale x 16 x i8> [[ZM:%.*]], i32 3)
// CPP-CHECK-NEXT:    ret void
//
void test_svvdot_lane_za32_s8_vg1x4(uint32_t slice_base, svint8x4_t zn, svint8_t zm) __arm_streaming __arm_inout("za") {
  SVE_ACLE_FUNC(svvdot_lane_za32,_s8,_vg1x4)(slice_base, zn, zm, 3);
}

// CHECK-LABEL: @test_svvdot_lane_za32_u8_vg1x4(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN:%.*]], i64 0)
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 16)
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 32)
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 48)
// CHECK-NEXT:    tail call void @llvm.aarch64.sme.uvdot.lane.za32.vg1x4.nxv16i8(i32 [[SLICE_BASE:%.*]], <vscale x 16 x i8> [[TMP0]], <vscale x 16 x i8> [[TMP1]], <vscale x 16 x i8> [[TMP2]], <vscale x 16 x i8> [[TMP3]], <vscale x 16 x i8> [[ZM:%.*]], i32 3)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z30test_svvdot_lane_za32_u8_vg1x4j11svuint8x4_tu11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 16)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 32)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 48)
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sme.uvdot.lane.za32.vg1x4.nxv16i8(i32 [[SLICE_BASE:%.*]], <vscale x 16 x i8> [[TMP0]], <vscale x 16 x i8> [[TMP1]], <vscale x 16 x i8> [[TMP2]], <vscale x 16 x i8> [[TMP3]], <vscale x 16 x i8> [[ZM:%.*]], i32 3)
// CPP-CHECK-NEXT:    ret void
//
void test_svvdot_lane_za32_u8_vg1x4(uint32_t slice_base, svuint8x4_t zn, svuint8_t zm) __arm_streaming __arm_inout("za") {
  SVE_ACLE_FUNC(svvdot_lane_za32,_u8,_vg1x4)(slice_base, zn, zm, 3);
}

// CHECK-LABEL: @test_svvdot_lane_za64_s16_vg1x4(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv32i16(<vscale x 32 x i16> [[ZN:%.*]], i64 0)
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv32i16(<vscale x 32 x i16> [[ZN]], i64 8)
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv32i16(<vscale x 32 x i16> [[ZN]], i64 16)
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv32i16(<vscale x 32 x i16> [[ZN]], i64 24)
// CHECK-NEXT:    tail call void @llvm.aarch64.sme.svdot.lane.za64.vg1x4.nxv8i16(i32 [[SLICE_BASE:%.*]], <vscale x 8 x i16> [[TMP0]], <vscale x 8 x i16> [[TMP1]], <vscale x 8 x i16> [[TMP2]], <vscale x 8 x i16> [[TMP3]], <vscale x 8 x i16> [[ZM:%.*]], i32 1)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z31test_svvdot_lane_za64_s16_vg1x4j11svint16x4_tu11__SVInt16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv32i16(<vscale x 32 x i16> [[ZN:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv32i16(<vscale x 32 x i16> [[ZN]], i64 8)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv32i16(<vscale x 32 x i16> [[ZN]], i64 16)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv32i16(<vscale x 32 x i16> [[ZN]], i64 24)
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sme.svdot.lane.za64.vg1x4.nxv8i16(i32 [[SLICE_BASE:%.*]], <vscale x 8 x i16> [[TMP0]], <vscale x 8 x i16> [[TMP1]], <vscale x 8 x i16> [[TMP2]], <vscale x 8 x i16> [[TMP3]], <vscale x 8 x i16> [[ZM:%.*]], i32 1)
// CPP-CHECK-NEXT:    ret void
//
void test_svvdot_lane_za64_s16_vg1x4(uint32_t slice_base, svint16x4_t zn, svint16_t zm) __arm_streaming __arm_inout("za") {
  SVE_ACLE_FUNC(svvdot_lane_za64,_s16,_vg1x4)(slice_base, zn, zm, 1);
}

// CHECK-LABEL: @test_svvdot_lane_za64_u16_vg1x4(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv32i16(<vscale x 32 x i16> [[ZN:%.*]], i64 0)
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv32i16(<vscale x 32 x i16> [[ZN]], i64 8)
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv32i16(<vscale x 32 x i16> [[ZN]], i64 16)
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv32i16(<vscale x 32 x i16> [[ZN]], i64 24)
// CHECK-NEXT:    tail call void @llvm.aarch64.sme.uvdot.lane.za64.vg1x4.nxv8i16(i32 [[SLICE_BASE:%.*]], <vscale x 8 x i16> [[TMP0]], <vscale x 8 x i16> [[TMP1]], <vscale x 8 x i16> [[TMP2]], <vscale x 8 x i16> [[TMP3]], <vscale x 8 x i16> [[ZM:%.*]], i32 1)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z31test_svvdot_lane_za64_u16_vg1x4j12svuint16x4_tu12__SVUint16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv32i16(<vscale x 32 x i16> [[ZN:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv32i16(<vscale x 32 x i16> [[ZN]], i64 8)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv32i16(<vscale x 32 x i16> [[ZN]], i64 16)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 8 x i16> @llvm.vector.extract.nxv8i16.nxv32i16(<vscale x 32 x i16> [[ZN]], i64 24)
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sme.uvdot.lane.za64.vg1x4.nxv8i16(i32 [[SLICE_BASE:%.*]], <vscale x 8 x i16> [[TMP0]], <vscale x 8 x i16> [[TMP1]], <vscale x 8 x i16> [[TMP2]], <vscale x 8 x i16> [[TMP3]], <vscale x 8 x i16> [[ZM:%.*]], i32 1)
// CPP-CHECK-NEXT:    ret void
//
void test_svvdot_lane_za64_u16_vg1x4(uint32_t slice_base, svuint16x4_t zn, svuint16_t zm) __arm_streaming __arm_inout("za") {
  SVE_ACLE_FUNC(svvdot_lane_za64,_u16,_vg1x4)(slice_base, zn, zm, 1);
}


// CHECK-LABEL: @test_svsuvdot_lane_za32_s8_vg1x4(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN:%.*]], i64 0)
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 16)
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 32)
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 48)
// CHECK-NEXT:    tail call void @llvm.aarch64.sme.suvdot.lane.za32.vg1x4.nxv16i8(i32 [[SLICE_BASE:%.*]], <vscale x 16 x i8> [[TMP0]], <vscale x 16 x i8> [[TMP1]], <vscale x 16 x i8> [[TMP2]], <vscale x 16 x i8> [[TMP3]], <vscale x 16 x i8> [[ZM:%.*]], i32 3)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z32test_svsuvdot_lane_za32_s8_vg1x4j10svint8x4_tu10__SVInt8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 16)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 32)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 48)
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sme.suvdot.lane.za32.vg1x4.nxv16i8(i32 [[SLICE_BASE:%.*]], <vscale x 16 x i8> [[TMP0]], <vscale x 16 x i8> [[TMP1]], <vscale x 16 x i8> [[TMP2]], <vscale x 16 x i8> [[TMP3]], <vscale x 16 x i8> [[ZM:%.*]], i32 3)
// CPP-CHECK-NEXT:    ret void
//
void test_svsuvdot_lane_za32_s8_vg1x4(uint32_t slice_base, svint8x4_t zn, svint8_t zm) __arm_streaming __arm_inout("za") {
  SVE_ACLE_FUNC(svsuvdot_lane_za32,_s8,_vg1x4)(slice_base, zn, zm, 3);
}


// CHECK-LABEL: @test_svusvdot_lane_za32_u8_vg1x4(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN:%.*]], i64 0)
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 16)
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 32)
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 48)
// CHECK-NEXT:    tail call void @llvm.aarch64.sme.usvdot.lane.za32.vg1x4.nxv16i8(i32 [[SLICE_BASE:%.*]], <vscale x 16 x i8> [[TMP0]], <vscale x 16 x i8> [[TMP1]], <vscale x 16 x i8> [[TMP2]], <vscale x 16 x i8> [[TMP3]], <vscale x 16 x i8> [[ZM:%.*]], i32 3)
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z32test_svusvdot_lane_za32_u8_vg1x4j11svuint8x4_tu11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 16)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 32)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 16 x i8> @llvm.vector.extract.nxv16i8.nxv64i8(<vscale x 64 x i8> [[ZN]], i64 48)
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sme.usvdot.lane.za32.vg1x4.nxv16i8(i32 [[SLICE_BASE:%.*]], <vscale x 16 x i8> [[TMP0]], <vscale x 16 x i8> [[TMP1]], <vscale x 16 x i8> [[TMP2]], <vscale x 16 x i8> [[TMP3]], <vscale x 16 x i8> [[ZM:%.*]], i32 3)
// CPP-CHECK-NEXT:    ret void
//
void test_svusvdot_lane_za32_u8_vg1x4(uint32_t slice_base, svuint8x4_t zn, svuint8_t zm) __arm_streaming __arm_inout("za") {
  SVE_ACLE_FUNC(svusvdot_lane_za32,_u8,_vg1x4)(slice_base, zn, zm, 3);
}

