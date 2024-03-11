// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple thumbv8.1m.main-none-none-eabi -target-feature +mve.fp -mfloat-abi hard -O0 -disable-O0-optnone -S -emit-llvm -o - %s | opt -S -passes='mem2reg,sroa,early-cse<>' | FileCheck %s
// RUN: %clang_cc1 -triple thumbv8.1m.main-none-none-eabi -target-feature +mve.fp -mfloat-abi hard -O0 -disable-O0-optnone -DPOLYMORPHIC -S -emit-llvm -o - %s | opt -S -passes='mem2reg,sroa,early-cse<>' | FileCheck %s

// REQUIRES: aarch64-registered-target || arm-registered-target

#include <arm_mve.h>

// CHECK-LABEL: @test_vdupq_n_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <8 x half> poison, half [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <8 x half> [[DOTSPLATINSERT]], <8 x half> poison, <8 x i32> zeroinitializer
// CHECK-NEXT:    ret <8 x half> [[DOTSPLAT]]
//
float16x8_t test_vdupq_n_f16(float16_t a)
{
    return vdupq_n_f16(a);
}

// CHECK-LABEL: @test_vdupq_n_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <4 x float> poison, float [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <4 x float> [[DOTSPLATINSERT]], <4 x float> poison, <4 x i32> zeroinitializer
// CHECK-NEXT:    ret <4 x float> [[DOTSPLAT]]
//
float32x4_t test_vdupq_n_f32(float32_t a)
{
    return vdupq_n_f32(a);
}

// CHECK-LABEL: @test_vdupq_n_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <16 x i8> poison, i8 [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <16 x i8> [[DOTSPLATINSERT]], <16 x i8> poison, <16 x i32> zeroinitializer
// CHECK-NEXT:    ret <16 x i8> [[DOTSPLAT]]
//
int8x16_t test_vdupq_n_s8(int8_t a)
{
    return vdupq_n_s8(a);
}

// CHECK-LABEL: @test_vdupq_n_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <8 x i16> poison, i16 [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <8 x i16> [[DOTSPLATINSERT]], <8 x i16> poison, <8 x i32> zeroinitializer
// CHECK-NEXT:    ret <8 x i16> [[DOTSPLAT]]
//
int16x8_t test_vdupq_n_s16(int16_t a)
{
    return vdupq_n_s16(a);
}

// CHECK-LABEL: @test_vdupq_n_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <4 x i32> poison, i32 [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <4 x i32> [[DOTSPLATINSERT]], <4 x i32> poison, <4 x i32> zeroinitializer
// CHECK-NEXT:    ret <4 x i32> [[DOTSPLAT]]
//
int32x4_t test_vdupq_n_s32(int32_t a)
{
    return vdupq_n_s32(a);
}

// CHECK-LABEL: @test_vdupq_n_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <16 x i8> poison, i8 [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <16 x i8> [[DOTSPLATINSERT]], <16 x i8> poison, <16 x i32> zeroinitializer
// CHECK-NEXT:    ret <16 x i8> [[DOTSPLAT]]
//
uint8x16_t test_vdupq_n_u8(uint8_t a)
{
    return vdupq_n_u8(a);
}

// CHECK-LABEL: @test_vdupq_n_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <8 x i16> poison, i16 [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <8 x i16> [[DOTSPLATINSERT]], <8 x i16> poison, <8 x i32> zeroinitializer
// CHECK-NEXT:    ret <8 x i16> [[DOTSPLAT]]
//
uint16x8_t test_vdupq_n_u16(uint16_t a)
{
    return vdupq_n_u16(a);
}

// CHECK-LABEL: @test_vdupq_n_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <4 x i32> poison, i32 [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <4 x i32> [[DOTSPLATINSERT]], <4 x i32> poison, <4 x i32> zeroinitializer
// CHECK-NEXT:    ret <4 x i32> [[DOTSPLAT]]
//
uint32x4_t test_vdupq_n_u32(uint32_t a)
{
    return vdupq_n_u32(a);
}

// CHECK-LABEL: @test_vdupq_m_n_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <8 x half> poison, half [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <8 x half> [[DOTSPLATINSERT]], <8 x half> poison, <8 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = select <8 x i1> [[TMP1]], <8 x half> [[DOTSPLAT]], <8 x half> [[INACTIVE:%.*]]
// CHECK-NEXT:    ret <8 x half> [[TMP2]]
//
float16x8_t test_vdupq_m_n_f16(float16x8_t inactive, float16_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vdupq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vdupq_m_n_f16(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vdupq_m_n_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <4 x float> poison, float [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <4 x float> [[DOTSPLATINSERT]], <4 x float> poison, <4 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = select <4 x i1> [[TMP1]], <4 x float> [[DOTSPLAT]], <4 x float> [[INACTIVE:%.*]]
// CHECK-NEXT:    ret <4 x float> [[TMP2]]
//
float32x4_t test_vdupq_m_n_f32(float32x4_t inactive, float32_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vdupq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vdupq_m_n_f32(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vdupq_m_n_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 [[TMP0]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <16 x i8> poison, i8 [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <16 x i8> [[DOTSPLATINSERT]], <16 x i8> poison, <16 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = select <16 x i1> [[TMP1]], <16 x i8> [[DOTSPLAT]], <16 x i8> [[INACTIVE:%.*]]
// CHECK-NEXT:    ret <16 x i8> [[TMP2]]
//
int8x16_t test_vdupq_m_n_s8(int8x16_t inactive, int8_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vdupq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vdupq_m_n_s8(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vdupq_m_n_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <8 x i16> poison, i16 [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <8 x i16> [[DOTSPLATINSERT]], <8 x i16> poison, <8 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = select <8 x i1> [[TMP1]], <8 x i16> [[DOTSPLAT]], <8 x i16> [[INACTIVE:%.*]]
// CHECK-NEXT:    ret <8 x i16> [[TMP2]]
//
int16x8_t test_vdupq_m_n_s16(int16x8_t inactive, int16_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vdupq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vdupq_m_n_s16(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vdupq_m_n_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <4 x i32> poison, i32 [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <4 x i32> [[DOTSPLATINSERT]], <4 x i32> poison, <4 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = select <4 x i1> [[TMP1]], <4 x i32> [[DOTSPLAT]], <4 x i32> [[INACTIVE:%.*]]
// CHECK-NEXT:    ret <4 x i32> [[TMP2]]
//
int32x4_t test_vdupq_m_n_s32(int32x4_t inactive, int32_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vdupq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vdupq_m_n_s32(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vdupq_m_n_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 [[TMP0]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <16 x i8> poison, i8 [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <16 x i8> [[DOTSPLATINSERT]], <16 x i8> poison, <16 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = select <16 x i1> [[TMP1]], <16 x i8> [[DOTSPLAT]], <16 x i8> [[INACTIVE:%.*]]
// CHECK-NEXT:    ret <16 x i8> [[TMP2]]
//
uint8x16_t test_vdupq_m_n_u8(uint8x16_t inactive, uint8_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vdupq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vdupq_m_n_u8(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vdupq_m_n_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <8 x i16> poison, i16 [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <8 x i16> [[DOTSPLATINSERT]], <8 x i16> poison, <8 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = select <8 x i1> [[TMP1]], <8 x i16> [[DOTSPLAT]], <8 x i16> [[INACTIVE:%.*]]
// CHECK-NEXT:    ret <8 x i16> [[TMP2]]
//
uint16x8_t test_vdupq_m_n_u16(uint16x8_t inactive, uint16_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vdupq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vdupq_m_n_u16(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vdupq_m_n_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <4 x i32> poison, i32 [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <4 x i32> [[DOTSPLATINSERT]], <4 x i32> poison, <4 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = select <4 x i1> [[TMP1]], <4 x i32> [[DOTSPLAT]], <4 x i32> [[INACTIVE:%.*]]
// CHECK-NEXT:    ret <4 x i32> [[TMP2]]
//
uint32x4_t test_vdupq_m_n_u32(uint32x4_t inactive, uint32_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vdupq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vdupq_m_n_u32(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vdupq_x_n_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <8 x half> poison, half [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <8 x half> [[DOTSPLATINSERT]], <8 x half> poison, <8 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = select <8 x i1> [[TMP1]], <8 x half> [[DOTSPLAT]], <8 x half> undef
// CHECK-NEXT:    ret <8 x half> [[TMP2]]
//
float16x8_t test_vdupq_x_n_f16(float16_t a, mve_pred16_t p)
{
    return vdupq_x_n_f16(a, p);
}

// CHECK-LABEL: @test_vdupq_x_n_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <4 x float> poison, float [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <4 x float> [[DOTSPLATINSERT]], <4 x float> poison, <4 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = select <4 x i1> [[TMP1]], <4 x float> [[DOTSPLAT]], <4 x float> undef
// CHECK-NEXT:    ret <4 x float> [[TMP2]]
//
float32x4_t test_vdupq_x_n_f32(float32_t a, mve_pred16_t p)
{
    return vdupq_x_n_f32(a, p);
}

// CHECK-LABEL: @test_vdupq_x_n_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 [[TMP0]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <16 x i8> poison, i8 [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <16 x i8> [[DOTSPLATINSERT]], <16 x i8> poison, <16 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = select <16 x i1> [[TMP1]], <16 x i8> [[DOTSPLAT]], <16 x i8> undef
// CHECK-NEXT:    ret <16 x i8> [[TMP2]]
//
int8x16_t test_vdupq_x_n_s8(int8_t a, mve_pred16_t p)
{
    return vdupq_x_n_s8(a, p);
}

// CHECK-LABEL: @test_vdupq_x_n_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <8 x i16> poison, i16 [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <8 x i16> [[DOTSPLATINSERT]], <8 x i16> poison, <8 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = select <8 x i1> [[TMP1]], <8 x i16> [[DOTSPLAT]], <8 x i16> undef
// CHECK-NEXT:    ret <8 x i16> [[TMP2]]
//
int16x8_t test_vdupq_x_n_s16(int16_t a, mve_pred16_t p)
{
    return vdupq_x_n_s16(a, p);
}

// CHECK-LABEL: @test_vdupq_x_n_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <4 x i32> poison, i32 [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <4 x i32> [[DOTSPLATINSERT]], <4 x i32> poison, <4 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = select <4 x i1> [[TMP1]], <4 x i32> [[DOTSPLAT]], <4 x i32> undef
// CHECK-NEXT:    ret <4 x i32> [[TMP2]]
//
int32x4_t test_vdupq_x_n_s32(int32_t a, mve_pred16_t p)
{
    return vdupq_x_n_s32(a, p);
}

// CHECK-LABEL: @test_vdupq_x_n_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 [[TMP0]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <16 x i8> poison, i8 [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <16 x i8> [[DOTSPLATINSERT]], <16 x i8> poison, <16 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = select <16 x i1> [[TMP1]], <16 x i8> [[DOTSPLAT]], <16 x i8> undef
// CHECK-NEXT:    ret <16 x i8> [[TMP2]]
//
uint8x16_t test_vdupq_x_n_u8(uint8_t a, mve_pred16_t p)
{
    return vdupq_x_n_u8(a, p);
}

// CHECK-LABEL: @test_vdupq_x_n_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <8 x i16> poison, i16 [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <8 x i16> [[DOTSPLATINSERT]], <8 x i16> poison, <8 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = select <8 x i1> [[TMP1]], <8 x i16> [[DOTSPLAT]], <8 x i16> undef
// CHECK-NEXT:    ret <8 x i16> [[TMP2]]
//
uint16x8_t test_vdupq_x_n_u16(uint16_t a, mve_pred16_t p)
{
    return vdupq_x_n_u16(a, p);
}

// CHECK-LABEL: @test_vdupq_x_n_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <4 x i32> poison, i32 [[A:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <4 x i32> [[DOTSPLATINSERT]], <4 x i32> poison, <4 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = select <4 x i1> [[TMP1]], <4 x i32> [[DOTSPLAT]], <4 x i32> undef
// CHECK-NEXT:    ret <4 x i32> [[TMP2]]
//
uint32x4_t test_vdupq_x_n_u32(uint32_t a, mve_pred16_t p)
{
    return vdupq_x_n_u32(a, p);
}

