// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 2
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -target-feature +zfh \
// RUN:   -target-feature +zvfh -disable-O0-optnone  \
// RUN:   -emit-llvm %s -o - | opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i1> @test_vmsleu_vv_u8mf8_b64_mu
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], <vscale x 1 x i1> [[MASKEDOFF:%.*]], <vscale x 1 x i8> [[OP1:%.*]], <vscale x 1 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.vmsleu.mask.nxv1i8.nxv1i8.i64(<vscale x 1 x i1> [[MASKEDOFF]], <vscale x 1 x i8> [[OP1]], <vscale x 1 x i8> [[OP2]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmsleu_vv_u8mf8_b64_mu(vbool64_t mask, vbool64_t maskedoff, vuint8mf8_t op1, vuint8mf8_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i1> @test_vmsleu_vx_u8mf8_b64_mu
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], <vscale x 1 x i1> [[MASKEDOFF:%.*]], <vscale x 1 x i8> [[OP1:%.*]], i8 noundef zeroext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.vmsleu.mask.nxv1i8.i8.i64(<vscale x 1 x i1> [[MASKEDOFF]], <vscale x 1 x i8> [[OP1]], i8 [[OP2]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmsleu_vx_u8mf8_b64_mu(vbool64_t mask, vbool64_t maskedoff, vuint8mf8_t op1, uint8_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i1> @test_vmsleu_vv_u8mf4_b32_mu
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i1> [[MASKEDOFF:%.*]], <vscale x 2 x i8> [[OP1:%.*]], <vscale x 2 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.vmsleu.mask.nxv2i8.nxv2i8.i64(<vscale x 2 x i1> [[MASKEDOFF]], <vscale x 2 x i8> [[OP1]], <vscale x 2 x i8> [[OP2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmsleu_vv_u8mf4_b32_mu(vbool32_t mask, vbool32_t maskedoff, vuint8mf4_t op1, vuint8mf4_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i1> @test_vmsleu_vx_u8mf4_b32_mu
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i1> [[MASKEDOFF:%.*]], <vscale x 2 x i8> [[OP1:%.*]], i8 noundef zeroext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.vmsleu.mask.nxv2i8.i8.i64(<vscale x 2 x i1> [[MASKEDOFF]], <vscale x 2 x i8> [[OP1]], i8 [[OP2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmsleu_vx_u8mf4_b32_mu(vbool32_t mask, vbool32_t maskedoff, vuint8mf4_t op1, uint8_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsleu_vv_u8mf2_b16_mu
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i1> [[MASKEDOFF:%.*]], <vscale x 4 x i8> [[OP1:%.*]], <vscale x 4 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.vmsleu.mask.nxv4i8.nxv4i8.i64(<vscale x 4 x i1> [[MASKEDOFF]], <vscale x 4 x i8> [[OP1]], <vscale x 4 x i8> [[OP2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsleu_vv_u8mf2_b16_mu(vbool16_t mask, vbool16_t maskedoff, vuint8mf2_t op1, vuint8mf2_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsleu_vx_u8mf2_b16_mu
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i1> [[MASKEDOFF:%.*]], <vscale x 4 x i8> [[OP1:%.*]], i8 noundef zeroext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.vmsleu.mask.nxv4i8.i8.i64(<vscale x 4 x i1> [[MASKEDOFF]], <vscale x 4 x i8> [[OP1]], i8 [[OP2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsleu_vx_u8mf2_b16_mu(vbool16_t mask, vbool16_t maskedoff, vuint8mf2_t op1, uint8_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsleu_vv_u8m1_b8_mu
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i1> [[MASKEDOFF:%.*]], <vscale x 8 x i8> [[OP1:%.*]], <vscale x 8 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.vmsleu.mask.nxv8i8.nxv8i8.i64(<vscale x 8 x i1> [[MASKEDOFF]], <vscale x 8 x i8> [[OP1]], <vscale x 8 x i8> [[OP2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsleu_vv_u8m1_b8_mu(vbool8_t mask, vbool8_t maskedoff, vuint8m1_t op1, vuint8m1_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsleu_vx_u8m1_b8_mu
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i1> [[MASKEDOFF:%.*]], <vscale x 8 x i8> [[OP1:%.*]], i8 noundef zeroext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.vmsleu.mask.nxv8i8.i8.i64(<vscale x 8 x i1> [[MASKEDOFF]], <vscale x 8 x i8> [[OP1]], i8 [[OP2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsleu_vx_u8m1_b8_mu(vbool8_t mask, vbool8_t maskedoff, vuint8m1_t op1, uint8_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsleu_vv_u8m2_b4_mu
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i1> [[MASKEDOFF:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.vmsleu.mask.nxv16i8.nxv16i8.i64(<vscale x 16 x i1> [[MASKEDOFF]], <vscale x 16 x i8> [[OP1]], <vscale x 16 x i8> [[OP2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsleu_vv_u8m2_b4_mu(vbool4_t mask, vbool4_t maskedoff, vuint8m2_t op1, vuint8m2_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsleu_vx_u8m2_b4_mu
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i1> [[MASKEDOFF:%.*]], <vscale x 16 x i8> [[OP1:%.*]], i8 noundef zeroext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.vmsleu.mask.nxv16i8.i8.i64(<vscale x 16 x i1> [[MASKEDOFF]], <vscale x 16 x i8> [[OP1]], i8 [[OP2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsleu_vx_u8m2_b4_mu(vbool4_t mask, vbool4_t maskedoff, vuint8m2_t op1, uint8_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i1> @test_vmsleu_vv_u8m4_b2_mu
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i1> [[MASKEDOFF:%.*]], <vscale x 32 x i8> [[OP1:%.*]], <vscale x 32 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i1> @llvm.riscv.vmsleu.mask.nxv32i8.nxv32i8.i64(<vscale x 32 x i1> [[MASKEDOFF]], <vscale x 32 x i8> [[OP1]], <vscale x 32 x i8> [[OP2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i1> [[TMP0]]
//
vbool2_t test_vmsleu_vv_u8m4_b2_mu(vbool2_t mask, vbool2_t maskedoff, vuint8m4_t op1, vuint8m4_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i1> @test_vmsleu_vx_u8m4_b2_mu
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i1> [[MASKEDOFF:%.*]], <vscale x 32 x i8> [[OP1:%.*]], i8 noundef zeroext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i1> @llvm.riscv.vmsleu.mask.nxv32i8.i8.i64(<vscale x 32 x i1> [[MASKEDOFF]], <vscale x 32 x i8> [[OP1]], i8 [[OP2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i1> [[TMP0]]
//
vbool2_t test_vmsleu_vx_u8m4_b2_mu(vbool2_t mask, vbool2_t maskedoff, vuint8m4_t op1, uint8_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i1> @test_vmsleu_vv_u8m8_b1_mu
// CHECK-RV64-SAME: (<vscale x 64 x i1> [[MASK:%.*]], <vscale x 64 x i1> [[MASKEDOFF:%.*]], <vscale x 64 x i8> [[OP1:%.*]], <vscale x 64 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i1> @llvm.riscv.vmsleu.mask.nxv64i8.nxv64i8.i64(<vscale x 64 x i1> [[MASKEDOFF]], <vscale x 64 x i8> [[OP1]], <vscale x 64 x i8> [[OP2]], <vscale x 64 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i1> [[TMP0]]
//
vbool1_t test_vmsleu_vv_u8m8_b1_mu(vbool1_t mask, vbool1_t maskedoff, vuint8m8_t op1, vuint8m8_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i1> @test_vmsleu_vx_u8m8_b1_mu
// CHECK-RV64-SAME: (<vscale x 64 x i1> [[MASK:%.*]], <vscale x 64 x i1> [[MASKEDOFF:%.*]], <vscale x 64 x i8> [[OP1:%.*]], i8 noundef zeroext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i1> @llvm.riscv.vmsleu.mask.nxv64i8.i8.i64(<vscale x 64 x i1> [[MASKEDOFF]], <vscale x 64 x i8> [[OP1]], i8 [[OP2]], <vscale x 64 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i1> [[TMP0]]
//
vbool1_t test_vmsleu_vx_u8m8_b1_mu(vbool1_t mask, vbool1_t maskedoff, vuint8m8_t op1, uint8_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i1> @test_vmsleu_vv_u16mf4_b64_mu
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], <vscale x 1 x i1> [[MASKEDOFF:%.*]], <vscale x 1 x i16> [[OP1:%.*]], <vscale x 1 x i16> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.vmsleu.mask.nxv1i16.nxv1i16.i64(<vscale x 1 x i1> [[MASKEDOFF]], <vscale x 1 x i16> [[OP1]], <vscale x 1 x i16> [[OP2]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmsleu_vv_u16mf4_b64_mu(vbool64_t mask, vbool64_t maskedoff, vuint16mf4_t op1, vuint16mf4_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i1> @test_vmsleu_vx_u16mf4_b64_mu
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], <vscale x 1 x i1> [[MASKEDOFF:%.*]], <vscale x 1 x i16> [[OP1:%.*]], i16 noundef zeroext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.vmsleu.mask.nxv1i16.i16.i64(<vscale x 1 x i1> [[MASKEDOFF]], <vscale x 1 x i16> [[OP1]], i16 [[OP2]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmsleu_vx_u16mf4_b64_mu(vbool64_t mask, vbool64_t maskedoff, vuint16mf4_t op1, uint16_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i1> @test_vmsleu_vv_u16mf2_b32_mu
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i1> [[MASKEDOFF:%.*]], <vscale x 2 x i16> [[OP1:%.*]], <vscale x 2 x i16> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.vmsleu.mask.nxv2i16.nxv2i16.i64(<vscale x 2 x i1> [[MASKEDOFF]], <vscale x 2 x i16> [[OP1]], <vscale x 2 x i16> [[OP2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmsleu_vv_u16mf2_b32_mu(vbool32_t mask, vbool32_t maskedoff, vuint16mf2_t op1, vuint16mf2_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i1> @test_vmsleu_vx_u16mf2_b32_mu
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i1> [[MASKEDOFF:%.*]], <vscale x 2 x i16> [[OP1:%.*]], i16 noundef zeroext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.vmsleu.mask.nxv2i16.i16.i64(<vscale x 2 x i1> [[MASKEDOFF]], <vscale x 2 x i16> [[OP1]], i16 [[OP2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmsleu_vx_u16mf2_b32_mu(vbool32_t mask, vbool32_t maskedoff, vuint16mf2_t op1, uint16_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsleu_vv_u16m1_b16_mu
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i1> [[MASKEDOFF:%.*]], <vscale x 4 x i16> [[OP1:%.*]], <vscale x 4 x i16> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.vmsleu.mask.nxv4i16.nxv4i16.i64(<vscale x 4 x i1> [[MASKEDOFF]], <vscale x 4 x i16> [[OP1]], <vscale x 4 x i16> [[OP2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsleu_vv_u16m1_b16_mu(vbool16_t mask, vbool16_t maskedoff, vuint16m1_t op1, vuint16m1_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsleu_vx_u16m1_b16_mu
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i1> [[MASKEDOFF:%.*]], <vscale x 4 x i16> [[OP1:%.*]], i16 noundef zeroext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.vmsleu.mask.nxv4i16.i16.i64(<vscale x 4 x i1> [[MASKEDOFF]], <vscale x 4 x i16> [[OP1]], i16 [[OP2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsleu_vx_u16m1_b16_mu(vbool16_t mask, vbool16_t maskedoff, vuint16m1_t op1, uint16_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsleu_vv_u16m2_b8_mu
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i1> [[MASKEDOFF:%.*]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.vmsleu.mask.nxv8i16.nxv8i16.i64(<vscale x 8 x i1> [[MASKEDOFF]], <vscale x 8 x i16> [[OP1]], <vscale x 8 x i16> [[OP2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsleu_vv_u16m2_b8_mu(vbool8_t mask, vbool8_t maskedoff, vuint16m2_t op1, vuint16m2_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsleu_vx_u16m2_b8_mu
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i1> [[MASKEDOFF:%.*]], <vscale x 8 x i16> [[OP1:%.*]], i16 noundef zeroext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.vmsleu.mask.nxv8i16.i16.i64(<vscale x 8 x i1> [[MASKEDOFF]], <vscale x 8 x i16> [[OP1]], i16 [[OP2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsleu_vx_u16m2_b8_mu(vbool8_t mask, vbool8_t maskedoff, vuint16m2_t op1, uint16_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsleu_vv_u16m4_b4_mu
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i1> [[MASKEDOFF:%.*]], <vscale x 16 x i16> [[OP1:%.*]], <vscale x 16 x i16> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.vmsleu.mask.nxv16i16.nxv16i16.i64(<vscale x 16 x i1> [[MASKEDOFF]], <vscale x 16 x i16> [[OP1]], <vscale x 16 x i16> [[OP2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsleu_vv_u16m4_b4_mu(vbool4_t mask, vbool4_t maskedoff, vuint16m4_t op1, vuint16m4_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsleu_vx_u16m4_b4_mu
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i1> [[MASKEDOFF:%.*]], <vscale x 16 x i16> [[OP1:%.*]], i16 noundef zeroext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.vmsleu.mask.nxv16i16.i16.i64(<vscale x 16 x i1> [[MASKEDOFF]], <vscale x 16 x i16> [[OP1]], i16 [[OP2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsleu_vx_u16m4_b4_mu(vbool4_t mask, vbool4_t maskedoff, vuint16m4_t op1, uint16_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i1> @test_vmsleu_vv_u16m8_b2_mu
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i1> [[MASKEDOFF:%.*]], <vscale x 32 x i16> [[OP1:%.*]], <vscale x 32 x i16> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i1> @llvm.riscv.vmsleu.mask.nxv32i16.nxv32i16.i64(<vscale x 32 x i1> [[MASKEDOFF]], <vscale x 32 x i16> [[OP1]], <vscale x 32 x i16> [[OP2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i1> [[TMP0]]
//
vbool2_t test_vmsleu_vv_u16m8_b2_mu(vbool2_t mask, vbool2_t maskedoff, vuint16m8_t op1, vuint16m8_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i1> @test_vmsleu_vx_u16m8_b2_mu
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i1> [[MASKEDOFF:%.*]], <vscale x 32 x i16> [[OP1:%.*]], i16 noundef zeroext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i1> @llvm.riscv.vmsleu.mask.nxv32i16.i16.i64(<vscale x 32 x i1> [[MASKEDOFF]], <vscale x 32 x i16> [[OP1]], i16 [[OP2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i1> [[TMP0]]
//
vbool2_t test_vmsleu_vx_u16m8_b2_mu(vbool2_t mask, vbool2_t maskedoff, vuint16m8_t op1, uint16_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i1> @test_vmsleu_vv_u32mf2_b64_mu
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], <vscale x 1 x i1> [[MASKEDOFF:%.*]], <vscale x 1 x i32> [[OP1:%.*]], <vscale x 1 x i32> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.vmsleu.mask.nxv1i32.nxv1i32.i64(<vscale x 1 x i1> [[MASKEDOFF]], <vscale x 1 x i32> [[OP1]], <vscale x 1 x i32> [[OP2]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmsleu_vv_u32mf2_b64_mu(vbool64_t mask, vbool64_t maskedoff, vuint32mf2_t op1, vuint32mf2_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i1> @test_vmsleu_vx_u32mf2_b64_mu
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], <vscale x 1 x i1> [[MASKEDOFF:%.*]], <vscale x 1 x i32> [[OP1:%.*]], i32 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.vmsleu.mask.nxv1i32.i32.i64(<vscale x 1 x i1> [[MASKEDOFF]], <vscale x 1 x i32> [[OP1]], i32 [[OP2]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmsleu_vx_u32mf2_b64_mu(vbool64_t mask, vbool64_t maskedoff, vuint32mf2_t op1, uint32_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i1> @test_vmsleu_vv_u32m1_b32_mu
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i1> [[MASKEDOFF:%.*]], <vscale x 2 x i32> [[OP1:%.*]], <vscale x 2 x i32> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.vmsleu.mask.nxv2i32.nxv2i32.i64(<vscale x 2 x i1> [[MASKEDOFF]], <vscale x 2 x i32> [[OP1]], <vscale x 2 x i32> [[OP2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmsleu_vv_u32m1_b32_mu(vbool32_t mask, vbool32_t maskedoff, vuint32m1_t op1, vuint32m1_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i1> @test_vmsleu_vx_u32m1_b32_mu
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i1> [[MASKEDOFF:%.*]], <vscale x 2 x i32> [[OP1:%.*]], i32 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.vmsleu.mask.nxv2i32.i32.i64(<vscale x 2 x i1> [[MASKEDOFF]], <vscale x 2 x i32> [[OP1]], i32 [[OP2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmsleu_vx_u32m1_b32_mu(vbool32_t mask, vbool32_t maskedoff, vuint32m1_t op1, uint32_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsleu_vv_u32m2_b16_mu
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i1> [[MASKEDOFF:%.*]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.vmsleu.mask.nxv4i32.nxv4i32.i64(<vscale x 4 x i1> [[MASKEDOFF]], <vscale x 4 x i32> [[OP1]], <vscale x 4 x i32> [[OP2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsleu_vv_u32m2_b16_mu(vbool16_t mask, vbool16_t maskedoff, vuint32m2_t op1, vuint32m2_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsleu_vx_u32m2_b16_mu
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i1> [[MASKEDOFF:%.*]], <vscale x 4 x i32> [[OP1:%.*]], i32 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.vmsleu.mask.nxv4i32.i32.i64(<vscale x 4 x i1> [[MASKEDOFF]], <vscale x 4 x i32> [[OP1]], i32 [[OP2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsleu_vx_u32m2_b16_mu(vbool16_t mask, vbool16_t maskedoff, vuint32m2_t op1, uint32_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsleu_vv_u32m4_b8_mu
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i1> [[MASKEDOFF:%.*]], <vscale x 8 x i32> [[OP1:%.*]], <vscale x 8 x i32> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.vmsleu.mask.nxv8i32.nxv8i32.i64(<vscale x 8 x i1> [[MASKEDOFF]], <vscale x 8 x i32> [[OP1]], <vscale x 8 x i32> [[OP2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsleu_vv_u32m4_b8_mu(vbool8_t mask, vbool8_t maskedoff, vuint32m4_t op1, vuint32m4_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsleu_vx_u32m4_b8_mu
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i1> [[MASKEDOFF:%.*]], <vscale x 8 x i32> [[OP1:%.*]], i32 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.vmsleu.mask.nxv8i32.i32.i64(<vscale x 8 x i1> [[MASKEDOFF]], <vscale x 8 x i32> [[OP1]], i32 [[OP2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsleu_vx_u32m4_b8_mu(vbool8_t mask, vbool8_t maskedoff, vuint32m4_t op1, uint32_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsleu_vv_u32m8_b4_mu
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i1> [[MASKEDOFF:%.*]], <vscale x 16 x i32> [[OP1:%.*]], <vscale x 16 x i32> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.vmsleu.mask.nxv16i32.nxv16i32.i64(<vscale x 16 x i1> [[MASKEDOFF]], <vscale x 16 x i32> [[OP1]], <vscale x 16 x i32> [[OP2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsleu_vv_u32m8_b4_mu(vbool4_t mask, vbool4_t maskedoff, vuint32m8_t op1, vuint32m8_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsleu_vx_u32m8_b4_mu
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i1> [[MASKEDOFF:%.*]], <vscale x 16 x i32> [[OP1:%.*]], i32 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.vmsleu.mask.nxv16i32.i32.i64(<vscale x 16 x i1> [[MASKEDOFF]], <vscale x 16 x i32> [[OP1]], i32 [[OP2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsleu_vx_u32m8_b4_mu(vbool4_t mask, vbool4_t maskedoff, vuint32m8_t op1, uint32_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i1> @test_vmsleu_vv_u64m1_b64_mu
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], <vscale x 1 x i1> [[MASKEDOFF:%.*]], <vscale x 1 x i64> [[OP1:%.*]], <vscale x 1 x i64> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.vmsleu.mask.nxv1i64.nxv1i64.i64(<vscale x 1 x i1> [[MASKEDOFF]], <vscale x 1 x i64> [[OP1]], <vscale x 1 x i64> [[OP2]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmsleu_vv_u64m1_b64_mu(vbool64_t mask, vbool64_t maskedoff, vuint64m1_t op1, vuint64m1_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i1> @test_vmsleu_vx_u64m1_b64_mu
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], <vscale x 1 x i1> [[MASKEDOFF:%.*]], <vscale x 1 x i64> [[OP1:%.*]], i64 noundef [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.vmsleu.mask.nxv1i64.i64.i64(<vscale x 1 x i1> [[MASKEDOFF]], <vscale x 1 x i64> [[OP1]], i64 [[OP2]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmsleu_vx_u64m1_b64_mu(vbool64_t mask, vbool64_t maskedoff, vuint64m1_t op1, uint64_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i1> @test_vmsleu_vv_u64m2_b32_mu
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i1> [[MASKEDOFF:%.*]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.vmsleu.mask.nxv2i64.nxv2i64.i64(<vscale x 2 x i1> [[MASKEDOFF]], <vscale x 2 x i64> [[OP1]], <vscale x 2 x i64> [[OP2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmsleu_vv_u64m2_b32_mu(vbool32_t mask, vbool32_t maskedoff, vuint64m2_t op1, vuint64m2_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i1> @test_vmsleu_vx_u64m2_b32_mu
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i1> [[MASKEDOFF:%.*]], <vscale x 2 x i64> [[OP1:%.*]], i64 noundef [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.vmsleu.mask.nxv2i64.i64.i64(<vscale x 2 x i1> [[MASKEDOFF]], <vscale x 2 x i64> [[OP1]], i64 [[OP2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmsleu_vx_u64m2_b32_mu(vbool32_t mask, vbool32_t maskedoff, vuint64m2_t op1, uint64_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsleu_vv_u64m4_b16_mu
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i1> [[MASKEDOFF:%.*]], <vscale x 4 x i64> [[OP1:%.*]], <vscale x 4 x i64> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.vmsleu.mask.nxv4i64.nxv4i64.i64(<vscale x 4 x i1> [[MASKEDOFF]], <vscale x 4 x i64> [[OP1]], <vscale x 4 x i64> [[OP2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsleu_vv_u64m4_b16_mu(vbool16_t mask, vbool16_t maskedoff, vuint64m4_t op1, vuint64m4_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsleu_vx_u64m4_b16_mu
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i1> [[MASKEDOFF:%.*]], <vscale x 4 x i64> [[OP1:%.*]], i64 noundef [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.vmsleu.mask.nxv4i64.i64.i64(<vscale x 4 x i1> [[MASKEDOFF]], <vscale x 4 x i64> [[OP1]], i64 [[OP2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsleu_vx_u64m4_b16_mu(vbool16_t mask, vbool16_t maskedoff, vuint64m4_t op1, uint64_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsleu_vv_u64m8_b8_mu
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i1> [[MASKEDOFF:%.*]], <vscale x 8 x i64> [[OP1:%.*]], <vscale x 8 x i64> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.vmsleu.mask.nxv8i64.nxv8i64.i64(<vscale x 8 x i1> [[MASKEDOFF]], <vscale x 8 x i64> [[OP1]], <vscale x 8 x i64> [[OP2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsleu_vv_u64m8_b8_mu(vbool8_t mask, vbool8_t maskedoff, vuint64m8_t op1, vuint64m8_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsleu_vx_u64m8_b8_mu
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i1> [[MASKEDOFF:%.*]], <vscale x 8 x i64> [[OP1:%.*]], i64 noundef [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.vmsleu.mask.nxv8i64.i64.i64(<vscale x 8 x i1> [[MASKEDOFF]], <vscale x 8 x i64> [[OP1]], i64 [[OP2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsleu_vx_u64m8_b8_mu(vbool8_t mask, vbool8_t maskedoff, vuint64m8_t op1, uint64_t op2, size_t vl) {
  return __riscv_vmsleu_mu(mask, maskedoff, op1, op2, vl);
}

