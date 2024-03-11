// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 2
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -target-feature +xsfvqmaccdod \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <sifive_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_sf_vqmaccsu_2x8x2_i32m1
// CHECK-RV64-SAME: (<vscale x 2 x i32> [[VD:%.*]], <vscale x 8 x i8> [[VS1:%.*]], <vscale x 8 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.sf.vqmaccsu.2x8x2.nxv2i32.nxv8i8.nxv8i8.i64(<vscale x 2 x i32> [[VD]], <vscale x 8 x i8> [[VS1]], <vscale x 8 x i8> [[VS2]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_sf_vqmaccsu_2x8x2_i32m1(vint32m1_t vd, vint8m1_t vs1, vuint8m1_t vs2, size_t vl) {
  return __riscv_sf_vqmaccsu_2x8x2_i32m1(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_sf_vqmaccsu_2x8x2_i32m2
// CHECK-RV64-SAME: (<vscale x 4 x i32> [[VD:%.*]], <vscale x 8 x i8> [[VS1:%.*]], <vscale x 16 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.sf.vqmaccsu.2x8x2.nxv4i32.nxv8i8.nxv16i8.i64(<vscale x 4 x i32> [[VD]], <vscale x 8 x i8> [[VS1]], <vscale x 16 x i8> [[VS2]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_sf_vqmaccsu_2x8x2_i32m2(vint32m2_t vd, vint8m1_t vs1, vuint8m2_t vs2, size_t vl) {
  return __riscv_sf_vqmaccsu_2x8x2_i32m2(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_sf_vqmaccsu_2x8x2_i32m4
// CHECK-RV64-SAME: (<vscale x 8 x i32> [[VD:%.*]], <vscale x 8 x i8> [[VS1:%.*]], <vscale x 32 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.sf.vqmaccsu.2x8x2.nxv8i32.nxv8i8.nxv32i8.i64(<vscale x 8 x i32> [[VD]], <vscale x 8 x i8> [[VS1]], <vscale x 32 x i8> [[VS2]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_sf_vqmaccsu_2x8x2_i32m4(vint32m4_t vd, vint8m1_t vs1, vuint8m4_t vs2, size_t vl) {
  return __riscv_sf_vqmaccsu_2x8x2_i32m4(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_sf_vqmaccsu_2x8x2_i32m8
// CHECK-RV64-SAME: (<vscale x 16 x i32> [[VD:%.*]], <vscale x 8 x i8> [[VS1:%.*]], <vscale x 64 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.sf.vqmaccsu.2x8x2.nxv16i32.nxv8i8.nxv64i8.i64(<vscale x 16 x i32> [[VD]], <vscale x 8 x i8> [[VS1]], <vscale x 64 x i8> [[VS2]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_sf_vqmaccsu_2x8x2_i32m8(vint32m8_t vd, vint8m1_t vs1, vuint8m8_t vs2, size_t vl) {
  return __riscv_sf_vqmaccsu_2x8x2_i32m8(vd, vs1, vs2, vl);
}
