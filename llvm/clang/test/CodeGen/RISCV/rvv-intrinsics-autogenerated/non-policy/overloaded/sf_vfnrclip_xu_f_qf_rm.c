// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -target-feature +xsfvfnrclipxfqf \
// RUN:  -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:  opt -S -passes=mem2reg | FileCheck %s

#include <sifive_vector.h>

// CHECK-LABEL: @test_sf_vfnrclip_xu_f_qf_u8mf8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i8> @llvm.riscv.sf.vfnrclip.xu.f.qf.nxv1i8.nxv1f32.i64(<vscale x 1 x i8> poison, <vscale x 1 x float> [[VS2:%.*]], float [[RS1:%.*]], i64 2, i64 [[VL:%.*]])
// CHECK-NEXT:    ret <vscale x 1 x i8> [[TMP0]]
//
vuint8mf8_t test_sf_vfnrclip_xu_f_qf_u8mf8(vfloat32mf2_t vs2, float rs1, size_t vl) {
  return __riscv_sf_vfnrclip_xu_f_qf(vs2, rs1, 2, vl);
}

// CHECK-LABEL: @test_sf_vfnrclip_xu_f_qf_u8mf4(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i8> @llvm.riscv.sf.vfnrclip.xu.f.qf.nxv2i8.nxv2f32.i64(<vscale x 2 x i8> poison, <vscale x 2 x float> [[VS2:%.*]], float [[RS1:%.*]], i64 2, i64 [[VL:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x i8> [[TMP0]]
//
vuint8mf4_t test_sf_vfnrclip_xu_f_qf_u8mf4(vfloat32m1_t vs2, float rs1, size_t vl) {
  return __riscv_sf_vfnrclip_xu_f_qf(vs2, rs1, 2, vl);
}

// CHECK-LABEL: @test_sf_vfnrclip_xu_f_qf_u8mf2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i8> @llvm.riscv.sf.vfnrclip.xu.f.qf.nxv4i8.nxv4f32.i64(<vscale x 4 x i8> poison, <vscale x 4 x float> [[VS2:%.*]], float [[RS1:%.*]], i64 2, i64 [[VL:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i8> [[TMP0]]
//
vuint8mf2_t test_sf_vfnrclip_xu_f_qf_u8mf2(vfloat32m2_t vs2, float rs1, size_t vl) {
  return __riscv_sf_vfnrclip_xu_f_qf(vs2, rs1, 2, vl);
}

// CHECK-LABEL: @test_sf_vfnrclip_xu_f_qf_u8m1(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.sf.vfnrclip.xu.f.qf.nxv8i8.nxv8f32.i64(<vscale x 8 x i8> poison, <vscale x 8 x float> [[VS2:%.*]], float [[RS1:%.*]], i64 2, i64 [[VL:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_sf_vfnrclip_xu_f_qf_u8m1(vfloat32m4_t vs2, float rs1, size_t vl) {
  return __riscv_sf_vfnrclip_xu_f_qf(vs2, rs1, 2, vl);
}

// CHECK-LABEL: @test_sf_vfnrclip_xu_f_qf_u8m2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.sf.vfnrclip.xu.f.qf.nxv16i8.nxv16f32.i64(<vscale x 16 x i8> poison, <vscale x 16 x float> [[VS2:%.*]], float [[RS1:%.*]], i64 2, i64 [[VL:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_sf_vfnrclip_xu_f_qf_u8m2(vfloat32m8_t vs2, float rs1, size_t vl) {
  return __riscv_sf_vfnrclip_xu_f_qf(vs2, rs1, 2, vl);
}

// CHECK-LABEL: @test_sf_vfnrclip_xu_f_qf_u8mf8_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i8> @llvm.riscv.sf.vfnrclip.xu.f.qf.mask.nxv1i8.nxv1f32.i64(<vscale x 1 x i8> poison, <vscale x 1 x float> [[VS2:%.*]], float [[RS1:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 2, i64 [[VL:%.*]], i64 3)
// CHECK-NEXT:    ret <vscale x 1 x i8> [[TMP0]]
//
vuint8mf8_t test_sf_vfnrclip_xu_f_qf_u8mf8_m(vbool64_t mask, vfloat32mf2_t vs2, float rs1, size_t vl) {
  return __riscv_sf_vfnrclip_xu_f_qf(mask, vs2, rs1, 2, vl);
}

// CHECK-LABEL: @test_sf_vfnrclip_xu_f_qf_u8mf4_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i8> @llvm.riscv.sf.vfnrclip.xu.f.qf.mask.nxv2i8.nxv2f32.i64(<vscale x 2 x i8> poison, <vscale x 2 x float> [[VS2:%.*]], float [[RS1:%.*]], <vscale x 2 x i1> [[MASK:%.*]], i64 2, i64 [[VL:%.*]], i64 3)
// CHECK-NEXT:    ret <vscale x 2 x i8> [[TMP0]]
//
vuint8mf4_t test_sf_vfnrclip_xu_f_qf_u8mf4_m(vbool32_t mask, vfloat32m1_t vs2, float rs1, size_t vl) {
  return __riscv_sf_vfnrclip_xu_f_qf(mask, vs2, rs1, 2, vl);
}

// CHECK-LABEL: @test_sf_vfnrclip_xu_f_qf_u8mf2_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i8> @llvm.riscv.sf.vfnrclip.xu.f.qf.mask.nxv4i8.nxv4f32.i64(<vscale x 4 x i8> poison, <vscale x 4 x float> [[VS2:%.*]], float [[RS1:%.*]], <vscale x 4 x i1> [[MASK:%.*]], i64 2, i64 [[VL:%.*]], i64 3)
// CHECK-NEXT:    ret <vscale x 4 x i8> [[TMP0]]
//
vuint8mf2_t test_sf_vfnrclip_xu_f_qf_u8mf2_m(vbool16_t mask, vfloat32m2_t vs2, float rs1, size_t vl) {
  return __riscv_sf_vfnrclip_xu_f_qf(mask, vs2, rs1, 2, vl);
}

// CHECK-LABEL: @test_sf_vfnrclip_xu_f_qf_u8m1_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.sf.vfnrclip.xu.f.qf.mask.nxv8i8.nxv8f32.i64(<vscale x 8 x i8> poison, <vscale x 8 x float> [[VS2:%.*]], float [[RS1:%.*]], <vscale x 8 x i1> [[MASK:%.*]], i64 2, i64 [[VL:%.*]], i64 3)
// CHECK-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_sf_vfnrclip_xu_f_qf_u8m1_m(vbool8_t mask, vfloat32m4_t vs2, float rs1, size_t vl) {
  return __riscv_sf_vfnrclip_xu_f_qf(mask, vs2, rs1, 2, vl);
}

// CHECK-LABEL: @test_sf_vfnrclip_xu_f_qf_u8m2_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.sf.vfnrclip.xu.f.qf.mask.nxv16i8.nxv16f32.i64(<vscale x 16 x i8> poison, <vscale x 16 x float> [[VS2:%.*]], float [[RS1:%.*]], <vscale x 16 x i1> [[MASK:%.*]], i64 2, i64 [[VL:%.*]], i64 3)
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_sf_vfnrclip_xu_f_qf_u8m2_m(vbool4_t mask, vfloat32m8_t vs2, float rs1, size_t vl) {
  return __riscv_sf_vfnrclip_xu_f_qf(mask, vs2, rs1, 2, vl);
}

