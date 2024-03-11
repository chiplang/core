// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 2
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -target-feature +zfh \
// RUN:   -target-feature +zvfh -disable-O0-optnone  \
// RUN:   -emit-llvm %s -o - | opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_i8mf8x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.nxv1i8.i64(<vscale x 1 x i8> [[TMP0]], <vscale x 1 x i8> [[TMP1]], <vscale x 1 x i8> [[TMP2]], <vscale x 1 x i8> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_i8mf8x4(int8_t *base, vint8mf8x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_i8mf4x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.nxv2i8.i64(<vscale x 2 x i8> [[TMP0]], <vscale x 2 x i8> [[TMP1]], <vscale x 2 x i8> [[TMP2]], <vscale x 2 x i8> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_i8mf4x4(int8_t *base, vint8mf4x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_i8mf2x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.nxv4i8.i64(<vscale x 4 x i8> [[TMP0]], <vscale x 4 x i8> [[TMP1]], <vscale x 4 x i8> [[TMP2]], <vscale x 4 x i8> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_i8mf2x4(int8_t *base, vint8mf2x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_i8m1x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.nxv8i8.i64(<vscale x 8 x i8> [[TMP0]], <vscale x 8 x i8> [[TMP1]], <vscale x 8 x i8> [[TMP2]], <vscale x 8 x i8> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_i8m1x4(int8_t *base, vint8m1x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_i8m2x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.nxv16i8.i64(<vscale x 16 x i8> [[TMP0]], <vscale x 16 x i8> [[TMP1]], <vscale x 16 x i8> [[TMP2]], <vscale x 16 x i8> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_i8m2x4(int8_t *base, vint8m2x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_u8mf8x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.nxv1i8.i64(<vscale x 1 x i8> [[TMP0]], <vscale x 1 x i8> [[TMP1]], <vscale x 1 x i8> [[TMP2]], <vscale x 1 x i8> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_u8mf8x4(uint8_t *base, vuint8mf8x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_u8mf4x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.nxv2i8.i64(<vscale x 2 x i8> [[TMP0]], <vscale x 2 x i8> [[TMP1]], <vscale x 2 x i8> [[TMP2]], <vscale x 2 x i8> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_u8mf4x4(uint8_t *base, vuint8mf4x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_u8mf2x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.nxv4i8.i64(<vscale x 4 x i8> [[TMP0]], <vscale x 4 x i8> [[TMP1]], <vscale x 4 x i8> [[TMP2]], <vscale x 4 x i8> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_u8mf2x4(uint8_t *base, vuint8mf2x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_u8m1x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.nxv8i8.i64(<vscale x 8 x i8> [[TMP0]], <vscale x 8 x i8> [[TMP1]], <vscale x 8 x i8> [[TMP2]], <vscale x 8 x i8> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_u8m1x4(uint8_t *base, vuint8m1x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_u8m2x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.nxv16i8.i64(<vscale x 16 x i8> [[TMP0]], <vscale x 16 x i8> [[TMP1]], <vscale x 16 x i8> [[TMP2]], <vscale x 16 x i8> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_u8m2x4(uint8_t *base, vuint8m2x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_i8mf8x4_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.mask.nxv1i8.i64(<vscale x 1 x i8> [[TMP0]], <vscale x 1 x i8> [[TMP1]], <vscale x 1 x i8> [[TMP2]], <vscale x 1 x i8> [[TMP3]], ptr [[BASE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_i8mf8x4_m(vbool64_t mask, int8_t *base, vint8mf8x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_i8mf4x4_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.mask.nxv2i8.i64(<vscale x 2 x i8> [[TMP0]], <vscale x 2 x i8> [[TMP1]], <vscale x 2 x i8> [[TMP2]], <vscale x 2 x i8> [[TMP3]], ptr [[BASE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_i8mf4x4_m(vbool32_t mask, int8_t *base, vint8mf4x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_i8mf2x4_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.mask.nxv4i8.i64(<vscale x 4 x i8> [[TMP0]], <vscale x 4 x i8> [[TMP1]], <vscale x 4 x i8> [[TMP2]], <vscale x 4 x i8> [[TMP3]], ptr [[BASE]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_i8mf2x4_m(vbool16_t mask, int8_t *base, vint8mf2x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_i8m1x4_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.mask.nxv8i8.i64(<vscale x 8 x i8> [[TMP0]], <vscale x 8 x i8> [[TMP1]], <vscale x 8 x i8> [[TMP2]], <vscale x 8 x i8> [[TMP3]], ptr [[BASE]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_i8m1x4_m(vbool8_t mask, int8_t *base, vint8m1x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_i8m2x4_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.mask.nxv16i8.i64(<vscale x 16 x i8> [[TMP0]], <vscale x 16 x i8> [[TMP1]], <vscale x 16 x i8> [[TMP2]], <vscale x 16 x i8> [[TMP3]], ptr [[BASE]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_i8m2x4_m(vbool4_t mask, int8_t *base, vint8m2x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_u8mf8x4_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8>, <vscale x 1 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.mask.nxv1i8.i64(<vscale x 1 x i8> [[TMP0]], <vscale x 1 x i8> [[TMP1]], <vscale x 1 x i8> [[TMP2]], <vscale x 1 x i8> [[TMP3]], ptr [[BASE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_u8mf8x4_m(vbool64_t mask, uint8_t *base, vuint8mf8x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_u8mf4x4_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8>, <vscale x 2 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.mask.nxv2i8.i64(<vscale x 2 x i8> [[TMP0]], <vscale x 2 x i8> [[TMP1]], <vscale x 2 x i8> [[TMP2]], <vscale x 2 x i8> [[TMP3]], ptr [[BASE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_u8mf4x4_m(vbool32_t mask, uint8_t *base, vuint8mf4x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_u8mf2x4_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8>, <vscale x 4 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.mask.nxv4i8.i64(<vscale x 4 x i8> [[TMP0]], <vscale x 4 x i8> [[TMP1]], <vscale x 4 x i8> [[TMP2]], <vscale x 4 x i8> [[TMP3]], ptr [[BASE]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_u8mf2x4_m(vbool16_t mask, uint8_t *base, vuint8mf2x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_u8m1x4_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.mask.nxv8i8.i64(<vscale x 8 x i8> [[TMP0]], <vscale x 8 x i8> [[TMP1]], <vscale x 8 x i8> [[TMP2]], <vscale x 8 x i8> [[TMP3]], ptr [[BASE]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_u8m1x4_m(vbool8_t mask, uint8_t *base, vuint8m1x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vsseg4e8_v_u8m2x4_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg4.mask.nxv16i8.i64(<vscale x 16 x i8> [[TMP0]], <vscale x 16 x i8> [[TMP1]], <vscale x 16 x i8> [[TMP2]], <vscale x 16 x i8> [[TMP3]], ptr [[BASE]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg4e8_v_u8m2x4_m(vbool4_t mask, uint8_t *base, vuint8m2x4_t v_tuple, size_t vl) {
  return __riscv_vsseg4e8(mask, base, v_tuple, vl);
}

