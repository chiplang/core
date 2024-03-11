// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 2
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -target-feature +zfh \
// RUN:   -target-feature +zvfh -disable-O0-optnone  \
// RUN:   -emit-llvm %s -o - | opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float> } @test_vlseg4e32ff_v_f32mf2x4_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, i64 } @llvm.riscv.vlseg4ff.mask.nxv1f32.i64(<vscale x 1 x float> poison, <vscale x 1 x float> poison, <vscale x 1 x float> poison, <vscale x 1 x float> poison, ptr [[BASE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float> } poison, <vscale x 1 x float> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float> } [[TMP2]], <vscale x 1 x float> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float> } [[TMP4]], <vscale x 1 x float> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = insertvalue { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float> } [[TMP6]], <vscale x 1 x float> [[TMP7]], 3
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, i64 } [[TMP0]], 4
// CHECK-RV64-NEXT:    store i64 [[TMP9]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float> } [[TMP8]]
//
vfloat32mf2x4_t test_vlseg4e32ff_v_f32mf2x4_m(vbool64_t mask, const float *base, size_t *new_vl, size_t vl) {
  return __riscv_vlseg4e32ff(mask, base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } @test_vlseg4e32ff_v_f32m1x4_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, i64 } @llvm.riscv.vlseg4ff.mask.nxv2f32.i64(<vscale x 2 x float> poison, <vscale x 2 x float> poison, <vscale x 2 x float> poison, <vscale x 2 x float> poison, ptr [[BASE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } poison, <vscale x 2 x float> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP2]], <vscale x 2 x float> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP4]], <vscale x 2 x float> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP6]], <vscale x 2 x float> [[TMP7]], 3
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, i64 } [[TMP0]], 4
// CHECK-RV64-NEXT:    store i64 [[TMP9]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP8]]
//
vfloat32m1x4_t test_vlseg4e32ff_v_f32m1x4_m(vbool32_t mask, const float *base, size_t *new_vl, size_t vl) {
  return __riscv_vlseg4e32ff(mask, base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } @test_vlseg4e32ff_v_f32m2x4_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, i64 } @llvm.riscv.vlseg4ff.mask.nxv4f32.i64(<vscale x 4 x float> poison, <vscale x 4 x float> poison, <vscale x 4 x float> poison, <vscale x 4 x float> poison, ptr [[BASE]], <vscale x 4 x i1> [[MASK]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } poison, <vscale x 4 x float> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } [[TMP2]], <vscale x 4 x float> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } [[TMP4]], <vscale x 4 x float> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = insertvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } [[TMP6]], <vscale x 4 x float> [[TMP7]], 3
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, i64 } [[TMP0]], 4
// CHECK-RV64-NEXT:    store i64 [[TMP9]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } [[TMP8]]
//
vfloat32m2x4_t test_vlseg4e32ff_v_f32m2x4_m(vbool16_t mask, const float *base, size_t *new_vl, size_t vl) {
  return __riscv_vlseg4e32ff(mask, base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } @test_vlseg4e32ff_v_i32mf2x4_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, i64 } @llvm.riscv.vlseg4ff.mask.nxv1i32.i64(<vscale x 1 x i32> poison, <vscale x 1 x i32> poison, <vscale x 1 x i32> poison, <vscale x 1 x i32> poison, ptr [[BASE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } poison, <vscale x 1 x i32> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[TMP2]], <vscale x 1 x i32> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[TMP4]], <vscale x 1 x i32> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = insertvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[TMP6]], <vscale x 1 x i32> [[TMP7]], 3
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, i64 } [[TMP0]], 4
// CHECK-RV64-NEXT:    store i64 [[TMP9]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[TMP8]]
//
vint32mf2x4_t test_vlseg4e32ff_v_i32mf2x4_m(vbool64_t mask, const int32_t *base, size_t *new_vl, size_t vl) {
  return __riscv_vlseg4e32ff(mask, base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } @test_vlseg4e32ff_v_i32m1x4_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } @llvm.riscv.vlseg4ff.mask.nxv2i32.i64(<vscale x 2 x i32> poison, <vscale x 2 x i32> poison, <vscale x 2 x i32> poison, <vscale x 2 x i32> poison, ptr [[BASE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } poison, <vscale x 2 x i32> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP2]], <vscale x 2 x i32> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP4]], <vscale x 2 x i32> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], <vscale x 2 x i32> [[TMP7]], 3
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } [[TMP0]], 4
// CHECK-RV64-NEXT:    store i64 [[TMP9]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP8]]
//
vint32m1x4_t test_vlseg4e32ff_v_i32m1x4_m(vbool32_t mask, const int32_t *base, size_t *new_vl, size_t vl) {
  return __riscv_vlseg4e32ff(mask, base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @test_vlseg4e32ff_v_i32m2x4_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } @llvm.riscv.vlseg4ff.mask.nxv4i32.i64(<vscale x 4 x i32> poison, <vscale x 4 x i32> poison, <vscale x 4 x i32> poison, <vscale x 4 x i32> poison, ptr [[BASE]], <vscale x 4 x i1> [[MASK]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } poison, <vscale x 4 x i32> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP2]], <vscale x 4 x i32> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP4]], <vscale x 4 x i32> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = insertvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP6]], <vscale x 4 x i32> [[TMP7]], 3
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } [[TMP0]], 4
// CHECK-RV64-NEXT:    store i64 [[TMP9]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP8]]
//
vint32m2x4_t test_vlseg4e32ff_v_i32m2x4_m(vbool16_t mask, const int32_t *base, size_t *new_vl, size_t vl) {
  return __riscv_vlseg4e32ff(mask, base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } @test_vlseg4e32ff_v_u32mf2x4_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, i64 } @llvm.riscv.vlseg4ff.mask.nxv1i32.i64(<vscale x 1 x i32> poison, <vscale x 1 x i32> poison, <vscale x 1 x i32> poison, <vscale x 1 x i32> poison, ptr [[BASE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } poison, <vscale x 1 x i32> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[TMP2]], <vscale x 1 x i32> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[TMP4]], <vscale x 1 x i32> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = insertvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[TMP6]], <vscale x 1 x i32> [[TMP7]], 3
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, i64 } [[TMP0]], 4
// CHECK-RV64-NEXT:    store i64 [[TMP9]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[TMP8]]
//
vuint32mf2x4_t test_vlseg4e32ff_v_u32mf2x4_m(vbool64_t mask, const uint32_t *base, size_t *new_vl, size_t vl) {
  return __riscv_vlseg4e32ff(mask, base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } @test_vlseg4e32ff_v_u32m1x4_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } @llvm.riscv.vlseg4ff.mask.nxv2i32.i64(<vscale x 2 x i32> poison, <vscale x 2 x i32> poison, <vscale x 2 x i32> poison, <vscale x 2 x i32> poison, ptr [[BASE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } poison, <vscale x 2 x i32> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP2]], <vscale x 2 x i32> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP4]], <vscale x 2 x i32> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], <vscale x 2 x i32> [[TMP7]], 3
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } [[TMP0]], 4
// CHECK-RV64-NEXT:    store i64 [[TMP9]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP8]]
//
vuint32m1x4_t test_vlseg4e32ff_v_u32m1x4_m(vbool32_t mask, const uint32_t *base, size_t *new_vl, size_t vl) {
  return __riscv_vlseg4e32ff(mask, base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @test_vlseg4e32ff_v_u32m2x4_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } @llvm.riscv.vlseg4ff.mask.nxv4i32.i64(<vscale x 4 x i32> poison, <vscale x 4 x i32> poison, <vscale x 4 x i32> poison, <vscale x 4 x i32> poison, ptr [[BASE]], <vscale x 4 x i1> [[MASK]], i64 [[VL]], i64 3)
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } poison, <vscale x 4 x i32> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP2]], <vscale x 4 x i32> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP4]], <vscale x 4 x i32> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = insertvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP6]], <vscale x 4 x i32> [[TMP7]], 3
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } [[TMP0]], 4
// CHECK-RV64-NEXT:    store i64 [[TMP9]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP8]]
//
vuint32m2x4_t test_vlseg4e32ff_v_u32m2x4_m(vbool16_t mask, const uint32_t *base, size_t *new_vl, size_t vl) {
  return __riscv_vlseg4e32ff(mask, base, new_vl, vl);
}

