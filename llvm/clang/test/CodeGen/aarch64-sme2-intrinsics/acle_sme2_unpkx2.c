// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py

// REQUIRES: aarch64-registered-target

// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sme2 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sme2 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sme2 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sme2 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sme2 -target-feature -S -disable-O0-optnone -Werror -Wall -o /dev/null %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sme2 -S -disable-O0-optnone -Werror -Wall -o /dev/null %s
#include <arm_sme.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED) A1
#else
#define SVE_ACLE_FUNC(A1,A2) A1##A2
#endif

// CHECK-LABEL: @test_svunpk_s16_x2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sve.sunpk.x2.nxv8i16(<vscale x 16 x i8> [[ZN:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]], 0
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i16> @llvm.vector.insert.nxv16i16.nxv8i16(<vscale x 16 x i16> poison, <vscale x 8 x i16> [[TMP1]], i64 0)
// CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]], 1
// CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 16 x i16> @llvm.vector.insert.nxv16i16.nxv8i16(<vscale x 16 x i16> [[TMP2]], <vscale x 8 x i16> [[TMP3]], i64 8)
// CHECK-NEXT:    ret <vscale x 16 x i16> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z18test_svunpk_s16_x2u10__SVInt8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sve.sunpk.x2.nxv8i16(<vscale x 16 x i8> [[ZN:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]], 0
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i16> @llvm.vector.insert.nxv16i16.nxv8i16(<vscale x 16 x i16> poison, <vscale x 8 x i16> [[TMP1]], i64 0)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]], 1
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 16 x i16> @llvm.vector.insert.nxv16i16.nxv8i16(<vscale x 16 x i16> [[TMP2]], <vscale x 8 x i16> [[TMP3]], i64 8)
// CPP-CHECK-NEXT:    ret <vscale x 16 x i16> [[TMP4]]
//
svint16x2_t test_svunpk_s16_x2(svint8_t zn) __arm_streaming {
  return SVE_ACLE_FUNC(svunpk_s16,_s8_x2)(zn);
}

// CHECK-LABEL: @test_svunpk_u16_x2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sve.uunpk.x2.nxv8i16(<vscale x 16 x i8> [[ZN:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]], 0
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i16> @llvm.vector.insert.nxv16i16.nxv8i16(<vscale x 16 x i16> poison, <vscale x 8 x i16> [[TMP1]], i64 0)
// CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]], 1
// CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 16 x i16> @llvm.vector.insert.nxv16i16.nxv8i16(<vscale x 16 x i16> [[TMP2]], <vscale x 8 x i16> [[TMP3]], i64 8)
// CHECK-NEXT:    ret <vscale x 16 x i16> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z18test_svunpk_u16_x2u11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.aarch64.sve.uunpk.x2.nxv8i16(<vscale x 16 x i8> [[ZN:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]], 0
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i16> @llvm.vector.insert.nxv16i16.nxv8i16(<vscale x 16 x i16> poison, <vscale x 8 x i16> [[TMP1]], i64 0)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]], 1
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 16 x i16> @llvm.vector.insert.nxv16i16.nxv8i16(<vscale x 16 x i16> [[TMP2]], <vscale x 8 x i16> [[TMP3]], i64 8)
// CPP-CHECK-NEXT:    ret <vscale x 16 x i16> [[TMP4]]
//
svuint16x2_t test_svunpk_u16_x2(svuint8_t zn) __arm_streaming {
  return SVE_ACLE_FUNC(svunpk_u16,_u8_x2)(zn);
}

// CHECK-LABEL: @test_svunpk_s32_x2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sve.sunpk.x2.nxv4i32(<vscale x 8 x i16> [[ZN:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]], 0
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.nxv4i32(<vscale x 8 x i32> poison, <vscale x 4 x i32> [[TMP1]], i64 0)
// CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]], 1
// CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.nxv4i32(<vscale x 8 x i32> [[TMP2]], <vscale x 4 x i32> [[TMP3]], i64 4)
// CHECK-NEXT:    ret <vscale x 8 x i32> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z18test_svunpk_s32_x2u11__SVInt16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sve.sunpk.x2.nxv4i32(<vscale x 8 x i16> [[ZN:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]], 0
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.nxv4i32(<vscale x 8 x i32> poison, <vscale x 4 x i32> [[TMP1]], i64 0)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]], 1
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.nxv4i32(<vscale x 8 x i32> [[TMP2]], <vscale x 4 x i32> [[TMP3]], i64 4)
// CPP-CHECK-NEXT:    ret <vscale x 8 x i32> [[TMP4]]
//
svint32x2_t test_svunpk_s32_x2(svint16_t zn) __arm_streaming {
  return SVE_ACLE_FUNC(svunpk_s32,_s16_x2)(zn);
}

// CHECK-LABEL: @test_svunpk_u32_x2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sve.uunpk.x2.nxv4i32(<vscale x 8 x i16> [[ZN:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]], 0
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.nxv4i32(<vscale x 8 x i32> poison, <vscale x 4 x i32> [[TMP1]], i64 0)
// CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]], 1
// CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.nxv4i32(<vscale x 8 x i32> [[TMP2]], <vscale x 4 x i32> [[TMP3]], i64 4)
// CHECK-NEXT:    ret <vscale x 8 x i32> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z18test_svunpk_u32_x2u12__SVUint16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.aarch64.sve.uunpk.x2.nxv4i32(<vscale x 8 x i16> [[ZN:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]], 0
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.nxv4i32(<vscale x 8 x i32> poison, <vscale x 4 x i32> [[TMP1]], i64 0)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP0]], 1
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 8 x i32> @llvm.vector.insert.nxv8i32.nxv4i32(<vscale x 8 x i32> [[TMP2]], <vscale x 4 x i32> [[TMP3]], i64 4)
// CPP-CHECK-NEXT:    ret <vscale x 8 x i32> [[TMP4]]
//
svuint32x2_t test_svunpk_u32_x2(svuint16_t zn) __arm_streaming {
  return SVE_ACLE_FUNC(svunpk_u32,_u16_x2)(zn);
}

// CHECK-LABEL: @test_svunpk_s64_x2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sve.sunpk.x2.nxv2i64(<vscale x 4 x i32> [[ZN:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]], 0
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 4 x i64> @llvm.vector.insert.nxv4i64.nxv2i64(<vscale x 4 x i64> poison, <vscale x 2 x i64> [[TMP1]], i64 0)
// CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]], 1
// CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 4 x i64> @llvm.vector.insert.nxv4i64.nxv2i64(<vscale x 4 x i64> [[TMP2]], <vscale x 2 x i64> [[TMP3]], i64 2)
// CHECK-NEXT:    ret <vscale x 4 x i64> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z18test_svunpk_s64_x2u11__SVInt32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sve.sunpk.x2.nxv2i64(<vscale x 4 x i32> [[ZN:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]], 0
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 4 x i64> @llvm.vector.insert.nxv4i64.nxv2i64(<vscale x 4 x i64> poison, <vscale x 2 x i64> [[TMP1]], i64 0)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]], 1
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 4 x i64> @llvm.vector.insert.nxv4i64.nxv2i64(<vscale x 4 x i64> [[TMP2]], <vscale x 2 x i64> [[TMP3]], i64 2)
// CPP-CHECK-NEXT:    ret <vscale x 4 x i64> [[TMP4]]
//
svint64x2_t test_svunpk_s64_x2(svint32_t zn) __arm_streaming {
  return SVE_ACLE_FUNC(svunpk_s64,_s32_x2)(zn);
}

// CHECK-LABEL: @test_svunpk_u64_x2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sve.uunpk.x2.nxv2i64(<vscale x 4 x i32> [[ZN:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]], 0
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 4 x i64> @llvm.vector.insert.nxv4i64.nxv2i64(<vscale x 4 x i64> poison, <vscale x 2 x i64> [[TMP1]], i64 0)
// CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]], 1
// CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 4 x i64> @llvm.vector.insert.nxv4i64.nxv2i64(<vscale x 4 x i64> [[TMP2]], <vscale x 2 x i64> [[TMP3]], i64 2)
// CHECK-NEXT:    ret <vscale x 4 x i64> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z18test_svunpk_u64_x2u12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.aarch64.sve.uunpk.x2.nxv2i64(<vscale x 4 x i32> [[ZN:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]], 0
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 4 x i64> @llvm.vector.insert.nxv4i64.nxv2i64(<vscale x 4 x i64> poison, <vscale x 2 x i64> [[TMP1]], i64 0)
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]], 1
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 4 x i64> @llvm.vector.insert.nxv4i64.nxv2i64(<vscale x 4 x i64> [[TMP2]], <vscale x 2 x i64> [[TMP3]], i64 2)
// CPP-CHECK-NEXT:    ret <vscale x 4 x i64> [[TMP4]]
//
svuint64x2_t test_svunpk_u64_x2(svuint32_t zn) __arm_streaming {
  return SVE_ACLE_FUNC(svunpk_u64,_u32_x2)(zn);
}
