// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 2
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -target-feature +zfh \
// RUN:   -target-feature +zvfh -disable-O0-optnone  \
// RUN:   -emit-llvm %s -o - | opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_f32mf2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 1 x float>, <vscale x 1 x float> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 1 x float>, <vscale x 1 x float> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x float>, <vscale x 1 x float> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.nxv1f32.i64(<vscale x 1 x float> [[TMP0]], <vscale x 1 x float> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_f32mf2x2(float *base, ptrdiff_t bstride, vfloat32mf2x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_f32m1x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 2 x float>, <vscale x 2 x float> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.nxv2f32.i64(<vscale x 2 x float> [[TMP0]], <vscale x 2 x float> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_f32m1x2(float *base, ptrdiff_t bstride, vfloat32m1x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_f32m2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 4 x float>, <vscale x 4 x float> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.nxv4f32.i64(<vscale x 4 x float> [[TMP0]], <vscale x 4 x float> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_f32m2x2(float *base, ptrdiff_t bstride, vfloat32m2x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_f32m4x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 8 x float>, <vscale x 8 x float> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 8 x float>, <vscale x 8 x float> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x float>, <vscale x 8 x float> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.nxv8f32.i64(<vscale x 8 x float> [[TMP0]], <vscale x 8 x float> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_f32m4x2(float *base, ptrdiff_t bstride, vfloat32m4x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_i32mf2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.nxv1i32.i64(<vscale x 1 x i32> [[TMP0]], <vscale x 1 x i32> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_i32mf2x2(int32_t *base, ptrdiff_t bstride, vint32mf2x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_i32m1x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.nxv2i32.i64(<vscale x 2 x i32> [[TMP0]], <vscale x 2 x i32> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_i32m1x2(int32_t *base, ptrdiff_t bstride, vint32m1x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_i32m2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.nxv4i32.i64(<vscale x 4 x i32> [[TMP0]], <vscale x 4 x i32> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_i32m2x2(int32_t *base, ptrdiff_t bstride, vint32m2x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_i32m4x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 8 x i32>, <vscale x 8 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.nxv8i32.i64(<vscale x 8 x i32> [[TMP0]], <vscale x 8 x i32> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_i32m4x2(int32_t *base, ptrdiff_t bstride, vint32m4x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_u32mf2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.nxv1i32.i64(<vscale x 1 x i32> [[TMP0]], <vscale x 1 x i32> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_u32mf2x2(uint32_t *base, ptrdiff_t bstride, vuint32mf2x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_u32m1x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.nxv2i32.i64(<vscale x 2 x i32> [[TMP0]], <vscale x 2 x i32> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_u32m1x2(uint32_t *base, ptrdiff_t bstride, vuint32m1x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_u32m2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.nxv4i32.i64(<vscale x 4 x i32> [[TMP0]], <vscale x 4 x i32> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_u32m2x2(uint32_t *base, ptrdiff_t bstride, vuint32m2x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_u32m4x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 8 x i32>, <vscale x 8 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.nxv8i32.i64(<vscale x 8 x i32> [[TMP0]], <vscale x 8 x i32> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_u32m4x2(uint32_t *base, ptrdiff_t bstride, vuint32m4x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_f32mf2x2_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 1 x float>, <vscale x 1 x float> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 1 x float>, <vscale x 1 x float> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x float>, <vscale x 1 x float> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.mask.nxv1f32.i64(<vscale x 1 x float> [[TMP0]], <vscale x 1 x float> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_f32mf2x2_m(vbool64_t mask, float *base, ptrdiff_t bstride, vfloat32mf2x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_f32m1x2_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 2 x float>, <vscale x 2 x float> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.mask.nxv2f32.i64(<vscale x 2 x float> [[TMP0]], <vscale x 2 x float> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_f32m1x2_m(vbool32_t mask, float *base, ptrdiff_t bstride, vfloat32m1x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_f32m2x2_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 4 x float>, <vscale x 4 x float> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.mask.nxv4f32.i64(<vscale x 4 x float> [[TMP0]], <vscale x 4 x float> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_f32m2x2_m(vbool16_t mask, float *base, ptrdiff_t bstride, vfloat32m2x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_f32m4x2_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 8 x float>, <vscale x 8 x float> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 8 x float>, <vscale x 8 x float> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x float>, <vscale x 8 x float> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.mask.nxv8f32.i64(<vscale x 8 x float> [[TMP0]], <vscale x 8 x float> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_f32m4x2_m(vbool8_t mask, float *base, ptrdiff_t bstride, vfloat32m4x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_i32mf2x2_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.mask.nxv1i32.i64(<vscale x 1 x i32> [[TMP0]], <vscale x 1 x i32> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_i32mf2x2_m(vbool64_t mask, int32_t *base, ptrdiff_t bstride, vint32mf2x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_i32m1x2_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.mask.nxv2i32.i64(<vscale x 2 x i32> [[TMP0]], <vscale x 2 x i32> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_i32m1x2_m(vbool32_t mask, int32_t *base, ptrdiff_t bstride, vint32m1x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_i32m2x2_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.mask.nxv4i32.i64(<vscale x 4 x i32> [[TMP0]], <vscale x 4 x i32> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_i32m2x2_m(vbool16_t mask, int32_t *base, ptrdiff_t bstride, vint32m2x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_i32m4x2_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 8 x i32>, <vscale x 8 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.mask.nxv8i32.i64(<vscale x 8 x i32> [[TMP0]], <vscale x 8 x i32> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_i32m4x2_m(vbool8_t mask, int32_t *base, ptrdiff_t bstride, vint32m4x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_u32mf2x2_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.mask.nxv1i32.i64(<vscale x 1 x i32> [[TMP0]], <vscale x 1 x i32> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_u32mf2x2_m(vbool64_t mask, uint32_t *base, ptrdiff_t bstride, vuint32mf2x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_u32m1x2_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.mask.nxv2i32.i64(<vscale x 2 x i32> [[TMP0]], <vscale x 2 x i32> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_u32m1x2_m(vbool32_t mask, uint32_t *base, ptrdiff_t bstride, vuint32m1x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_u32m2x2_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.mask.nxv4i32.i64(<vscale x 4 x i32> [[TMP0]], <vscale x 4 x i32> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_u32m2x2_m(vbool16_t mask, uint32_t *base, ptrdiff_t bstride, vuint32m2x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg2e32_v_u32m4x2_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 8 x i32>, <vscale x 8 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i32>, <vscale x 8 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg2.mask.nxv8i32.i64(<vscale x 8 x i32> [[TMP0]], <vscale x 8 x i32> [[TMP1]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg2e32_v_u32m4x2_m(vbool8_t mask, uint32_t *base, ptrdiff_t bstride, vuint32m4x2_t v_tuple, size_t vl) {
  return __riscv_vssseg2e32(mask, base, bstride, v_tuple, vl);
}

