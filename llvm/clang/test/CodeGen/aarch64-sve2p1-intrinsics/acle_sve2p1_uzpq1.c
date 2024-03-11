// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 2
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve2p1 -target-feature +bf16\
// RUN:   -S -Werror -emit-llvm -disable-O0-optnone -o - %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve2p1 -target-feature +bf16\
// RUN:   -S -Werror -emit-llvm -disable-O0-optnone -o - %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve2p1 -target-feature +bf16\
// RUN:   -S -Werror -emit-llvm -disable-O0-optnone -o - -x c++ %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve2p1 -target-feature +bf16\
// RUN:   -S -Werror -emit-llvm -disable-O0-optnone -o - -x c++ %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve2p1 -target-feature +bf16\
// RUN:   -S -disable-O0-optnone -Werror -Wall -o /dev/null %s

#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1, A2_UNUSED) A1
#else
#define SVE_ACLE_FUNC(A1, A2) A1##A2
#endif

// CHECK-LABEL: define dso_local <vscale x 16 x i8> @test_svuzpq1_u8
// CHECK-SAME: (<vscale x 16 x i8> [[ZN:%.*]], <vscale x 16 x i8> [[ZM:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.uzpq1.nxv16i8(<vscale x 16 x i8> [[ZN]], <vscale x 16 x i8> [[ZM]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: define dso_local <vscale x 16 x i8> @_Z15test_svuzpq1_u8u11__SVUint8_tS_
// CPP-CHECK-SAME: (<vscale x 16 x i8> [[ZN:%.*]], <vscale x 16 x i8> [[ZM:%.*]]) #[[ATTR0:[0-9]+]] {
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.uzpq1.nxv16i8(<vscale x 16 x i8> [[ZN]], <vscale x 16 x i8> [[ZM]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svuint8_t test_svuzpq1_u8(svuint8_t zn, svuint8_t zm) {
    return SVE_ACLE_FUNC(svuzpq1,_u8)(zn, zm);
}

// CHECK-LABEL: define dso_local <vscale x 8 x i16> @test_svuzpq1_u16
// CHECK-SAME: (<vscale x 8 x i16> [[ZN:%.*]], <vscale x 8 x i16> [[ZM:%.*]]) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.uzpq1.nxv8i16(<vscale x 8 x i16> [[ZN]], <vscale x 8 x i16> [[ZM]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
// CPP-CHECK-LABEL: define dso_local <vscale x 8 x i16> @_Z16test_svuzpq1_u16u12__SVUint16_tS_
// CPP-CHECK-SAME: (<vscale x 8 x i16> [[ZN:%.*]], <vscale x 8 x i16> [[ZM:%.*]]) #[[ATTR0]] {
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.uzpq1.nxv8i16(<vscale x 8 x i16> [[ZN]], <vscale x 8 x i16> [[ZM]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
svuint16_t test_svuzpq1_u16(svuint16_t zn, svuint16_t zm) {
  return SVE_ACLE_FUNC(svuzpq1,_u16)(zn, zm);
}

// CHECK-LABEL: define dso_local <vscale x 4 x i32> @test_svuzpq1_u32
// CHECK-SAME: (<vscale x 4 x i32> [[ZN:%.*]], <vscale x 4 x i32> [[ZM:%.*]]) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.uzpq1.nxv4i32(<vscale x 4 x i32> [[ZN]], <vscale x 4 x i32> [[ZM]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
// CPP-CHECK-LABEL: define dso_local <vscale x 4 x i32> @_Z16test_svuzpq1_u32u12__SVUint32_tS_
// CPP-CHECK-SAME: (<vscale x 4 x i32> [[ZN:%.*]], <vscale x 4 x i32> [[ZM:%.*]]) #[[ATTR0]] {
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.uzpq1.nxv4i32(<vscale x 4 x i32> [[ZN]], <vscale x 4 x i32> [[ZM]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
svuint32_t test_svuzpq1_u32(svuint32_t zn, svuint32_t zm) {
    return SVE_ACLE_FUNC(svuzpq1,_u32)(zn, zm);
}

// CHECK-LABEL: define dso_local <vscale x 2 x i64> @test_svuzpq1_u64
// CHECK-SAME: (<vscale x 2 x i64> [[ZN:%.*]], <vscale x 2 x i64> [[ZM:%.*]]) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.uzpq1.nxv2i64(<vscale x 2 x i64> [[ZN]], <vscale x 2 x i64> [[ZM]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
// CPP-CHECK-LABEL: define dso_local <vscale x 2 x i64> @_Z16test_svuzpq1_u64u12__SVUint64_tS_
// CPP-CHECK-SAME: (<vscale x 2 x i64> [[ZN:%.*]], <vscale x 2 x i64> [[ZM:%.*]]) #[[ATTR0]] {
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.uzpq1.nxv2i64(<vscale x 2 x i64> [[ZN]], <vscale x 2 x i64> [[ZM]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
svuint64_t test_svuzpq1_u64(svuint64_t zn, svuint64_t zm) {
    return SVE_ACLE_FUNC(svuzpq1,_u64)(zn, zm);
}


// CHECK-LABEL: define dso_local <vscale x 16 x i8> @test_svuzpq1_s8
// CHECK-SAME: (<vscale x 16 x i8> [[ZN:%.*]], <vscale x 16 x i8> [[ZM:%.*]]) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.uzpq1.nxv16i8(<vscale x 16 x i8> [[ZN]], <vscale x 16 x i8> [[ZM]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: define dso_local <vscale x 16 x i8> @_Z15test_svuzpq1_s8u10__SVInt8_tS_
// CPP-CHECK-SAME: (<vscale x 16 x i8> [[ZN:%.*]], <vscale x 16 x i8> [[ZM:%.*]]) #[[ATTR0]] {
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.uzpq1.nxv16i8(<vscale x 16 x i8> [[ZN]], <vscale x 16 x i8> [[ZM]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svint8_t test_svuzpq1_s8(svint8_t zn, svint8_t zm) {
    return SVE_ACLE_FUNC(svuzpq1,_s8)(zn, zm);
}

// CHECK-LABEL: define dso_local <vscale x 8 x i16> @test_svuzpq1_s16
// CHECK-SAME: (<vscale x 8 x i16> [[ZN:%.*]], <vscale x 8 x i16> [[ZM:%.*]]) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.uzpq1.nxv8i16(<vscale x 8 x i16> [[ZN]], <vscale x 8 x i16> [[ZM]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
// CPP-CHECK-LABEL: define dso_local <vscale x 8 x i16> @_Z16test_svuzpq1_s16u11__SVInt16_tS_
// CPP-CHECK-SAME: (<vscale x 8 x i16> [[ZN:%.*]], <vscale x 8 x i16> [[ZM:%.*]]) #[[ATTR0]] {
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.uzpq1.nxv8i16(<vscale x 8 x i16> [[ZN]], <vscale x 8 x i16> [[ZM]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
svint16_t test_svuzpq1_s16(svint16_t zn, svint16_t zm) {
    return SVE_ACLE_FUNC(svuzpq1,_s16)(zn, zm);
}

// CHECK-LABEL: define dso_local <vscale x 4 x i32> @test_svuzpq1_s32
// CHECK-SAME: (<vscale x 4 x i32> [[ZN:%.*]], <vscale x 4 x i32> [[ZM:%.*]]) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.uzpq1.nxv4i32(<vscale x 4 x i32> [[ZN]], <vscale x 4 x i32> [[ZM]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
// CPP-CHECK-LABEL: define dso_local <vscale x 4 x i32> @_Z16test_svuzpq1_s32u11__SVInt32_tS_
// CPP-CHECK-SAME: (<vscale x 4 x i32> [[ZN:%.*]], <vscale x 4 x i32> [[ZM:%.*]]) #[[ATTR0]] {
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.uzpq1.nxv4i32(<vscale x 4 x i32> [[ZN]], <vscale x 4 x i32> [[ZM]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
svint32_t test_svuzpq1_s32(svint32_t zn, svint32_t zm) {
  return SVE_ACLE_FUNC(svuzpq1,_s32)(zn, zm);
}

// CHECK-LABEL: define dso_local <vscale x 2 x i64> @test_svuzpq1_s64
// CHECK-SAME: (<vscale x 2 x i64> [[ZN:%.*]], <vscale x 2 x i64> [[ZM:%.*]]) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.uzpq1.nxv2i64(<vscale x 2 x i64> [[ZN]], <vscale x 2 x i64> [[ZM]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
// CPP-CHECK-LABEL: define dso_local <vscale x 2 x i64> @_Z16test_svuzpq1_s64u11__SVInt64_tS_
// CPP-CHECK-SAME: (<vscale x 2 x i64> [[ZN:%.*]], <vscale x 2 x i64> [[ZM:%.*]]) #[[ATTR0]] {
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.uzpq1.nxv2i64(<vscale x 2 x i64> [[ZN]], <vscale x 2 x i64> [[ZM]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
svint64_t test_svuzpq1_s64(svint64_t zn, svint64_t zm) {
    return SVE_ACLE_FUNC(svuzpq1,_s64)(zn, zm);
}


// CHECK-LABEL: define dso_local <vscale x 8 x half> @test_svuzpq1_f16
// CHECK-SAME: (<vscale x 8 x half> [[ZN:%.*]], <vscale x 8 x half> [[ZM:%.*]]) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.uzpq1.nxv8f16(<vscale x 8 x half> [[ZN]], <vscale x 8 x half> [[ZM]])
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
// CPP-CHECK-LABEL: define dso_local <vscale x 8 x half> @_Z16test_svuzpq1_f16u13__SVFloat16_tS_
// CPP-CHECK-SAME: (<vscale x 8 x half> [[ZN:%.*]], <vscale x 8 x half> [[ZM:%.*]]) #[[ATTR0]] {
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.uzpq1.nxv8f16(<vscale x 8 x half> [[ZN]], <vscale x 8 x half> [[ZM]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
svfloat16_t test_svuzpq1_f16(svfloat16_t zn, svfloat16_t zm) {
    return SVE_ACLE_FUNC(svuzpq1,_f16)(zn, zm);
}

// CHECK-LABEL: define dso_local <vscale x 4 x float> @test_svuzpq1_f32
// CHECK-SAME: (<vscale x 4 x float> [[ZN:%.*]], <vscale x 4 x float> [[ZM:%.*]]) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.uzpq1.nxv4f32(<vscale x 4 x float> [[ZN]], <vscale x 4 x float> [[ZM]])
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
// CPP-CHECK-LABEL: define dso_local <vscale x 4 x float> @_Z16test_svuzpq1_f32u13__SVFloat32_tS_
// CPP-CHECK-SAME: (<vscale x 4 x float> [[ZN:%.*]], <vscale x 4 x float> [[ZM:%.*]]) #[[ATTR0]] {
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.uzpq1.nxv4f32(<vscale x 4 x float> [[ZN]], <vscale x 4 x float> [[ZM]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
svfloat32_t test_svuzpq1_f32(svfloat32_t zn, svfloat32_t zm) {
    return SVE_ACLE_FUNC(svuzpq1,_f32)(zn, zm);
}

// CHECK-LABEL: define dso_local <vscale x 2 x double> @test_svuzpq1_f64
// CHECK-SAME: (<vscale x 2 x double> [[ZN:%.*]], <vscale x 2 x double> [[ZM:%.*]]) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.uzpq1.nxv2f64(<vscale x 2 x double> [[ZN]], <vscale x 2 x double> [[ZM]])
// CHECK-NEXT:    ret <vscale x 2 x double> [[TMP0]]
//
// CPP-CHECK-LABEL: define dso_local <vscale x 2 x double> @_Z16test_svuzpq1_f64u13__SVFloat64_tS_
// CPP-CHECK-SAME: (<vscale x 2 x double> [[ZN:%.*]], <vscale x 2 x double> [[ZM:%.*]]) #[[ATTR0]] {
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.uzpq1.nxv2f64(<vscale x 2 x double> [[ZN]], <vscale x 2 x double> [[ZM]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x double> [[TMP0]]
//
svfloat64_t test_svuzpq1_f64(svfloat64_t zn, svfloat64_t zm) {
    return SVE_ACLE_FUNC(svuzpq1,_f64)(zn, zm);
}

// CHECK-LABEL: define dso_local <vscale x 8 x bfloat> @test_svuzpq1_bf16
// CHECK-SAME: (<vscale x 8 x bfloat> [[ZN:%.*]], <vscale x 8 x bfloat> [[ZM:%.*]]) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x bfloat> @llvm.aarch64.sve.uzpq1.nxv8bf16(<vscale x 8 x bfloat> [[ZN]], <vscale x 8 x bfloat> [[ZM]])
// CHECK-NEXT:    ret <vscale x 8 x bfloat> [[TMP0]]
//
// CPP-CHECK-LABEL: define dso_local <vscale x 8 x bfloat> @_Z17test_svuzpq1_bf16u14__SVBfloat16_tS_
// CPP-CHECK-SAME: (<vscale x 8 x bfloat> [[ZN:%.*]], <vscale x 8 x bfloat> [[ZM:%.*]]) #[[ATTR0]] {
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x bfloat> @llvm.aarch64.sve.uzpq1.nxv8bf16(<vscale x 8 x bfloat> [[ZN]], <vscale x 8 x bfloat> [[ZM]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x bfloat> [[TMP0]]
//
svbfloat16_t test_svuzpq1_bf16(svbfloat16_t zn, svbfloat16_t zm) {
    return SVE_ACLE_FUNC(svuzpq1,_bf16)(zn, zm);
}


