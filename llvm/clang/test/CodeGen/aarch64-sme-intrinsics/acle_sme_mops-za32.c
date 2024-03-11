// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 3
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sme -target-feature +bf16 -S -O1 -Werror -emit-llvm -o - %s | FileCheck %s -check-prefixes=CHECK,CHECK-C
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sme -target-feature +bf16 -S -O1 -Werror -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefixes=CHECK,CHECK-CXX
// RUN: %clang_cc1 -fclang-abi-compat=latest -DSME_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sme -target-feature +bf16 -S -O1 -Werror -emit-llvm -o - %s | FileCheck %s -check-prefixes=CHECK,CHECK-C
// RUN: %clang_cc1 -fclang-abi-compat=latest -DSME_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sme -target-feature +bf16 -S -O1 -Werror -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefixes=CHECK,CHECK-CXX
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sme -target-feature +bf16 -S -O1 -Werror -o /dev/null %s

#include <arm_sme.h>

#ifdef SME_OVERLOADED_FORMS
#define SME_ACLE_FUNC(A1,A2_UNUSED,A3) A1##A3
#else
#define SME_ACLE_FUNC(A1,A2,A3) A1##A2##A3
#endif

// CHECK-C-LABEL: define dso_local void @test_svmops_za32_s8(
// CHECK-C-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 16 x i8> [[ZN:%.*]], <vscale x 16 x i8> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
// CHECK-C-NEXT:  entry:
// CHECK-C-NEXT:    tail call void @llvm.aarch64.sme.smops.wide.nxv16i8(i32 0, <vscale x 16 x i1> [[PN]], <vscale x 16 x i1> [[PM]], <vscale x 16 x i8> [[ZN]], <vscale x 16 x i8> [[ZM]])
// CHECK-C-NEXT:    ret void
//
// CHECK-CXX-LABEL: define dso_local void @_Z19test_svmops_za32_s8u10__SVBool_tS_u10__SVInt8_tS0_(
// CHECK-CXX-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 16 x i8> [[ZN:%.*]], <vscale x 16 x i8> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    tail call void @llvm.aarch64.sme.smops.wide.nxv16i8(i32 0, <vscale x 16 x i1> [[PN]], <vscale x 16 x i1> [[PM]], <vscale x 16 x i8> [[ZN]], <vscale x 16 x i8> [[ZM]])
// CHECK-CXX-NEXT:    ret void
//
void test_svmops_za32_s8(svbool_t pn, svbool_t pm, svint8_t zn, svint8_t zm) __arm_streaming __arm_inout("za") {
  SME_ACLE_FUNC(svmops_za32, _s8, _m)(0, pn, pm, zn, zm);
}

// CHECK-C-LABEL: define dso_local void @test_svmops_za32_u8(
// CHECK-C-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 16 x i8> [[ZN:%.*]], <vscale x 16 x i8> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-C-NEXT:  entry:
// CHECK-C-NEXT:    tail call void @llvm.aarch64.sme.umops.wide.nxv16i8(i32 0, <vscale x 16 x i1> [[PN]], <vscale x 16 x i1> [[PM]], <vscale x 16 x i8> [[ZN]], <vscale x 16 x i8> [[ZM]])
// CHECK-C-NEXT:    ret void
//
// CHECK-CXX-LABEL: define dso_local void @_Z19test_svmops_za32_u8u10__SVBool_tS_u11__SVUint8_tS0_(
// CHECK-CXX-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 16 x i8> [[ZN:%.*]], <vscale x 16 x i8> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    tail call void @llvm.aarch64.sme.umops.wide.nxv16i8(i32 0, <vscale x 16 x i1> [[PN]], <vscale x 16 x i1> [[PM]], <vscale x 16 x i8> [[ZN]], <vscale x 16 x i8> [[ZM]])
// CHECK-CXX-NEXT:    ret void
//
void test_svmops_za32_u8(svbool_t pn, svbool_t pm, svuint8_t zn, svuint8_t zm) __arm_streaming __arm_inout("za") {
  SME_ACLE_FUNC(svmops_za32, _u8, _m)(0, pn, pm, zn, zm);
}

// CHECK-C-LABEL: define dso_local void @test_svmops_za32_bf16(
// CHECK-C-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x bfloat> [[ZN:%.*]], <vscale x 8 x bfloat> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-C-NEXT:  entry:
// CHECK-C-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-C-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-C-NEXT:    tail call void @llvm.aarch64.sme.mops.wide.nxv8bf16(i32 0, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x bfloat> [[ZN]], <vscale x 8 x bfloat> [[ZM]])
// CHECK-C-NEXT:    ret void
//
// CHECK-CXX-LABEL: define dso_local void @_Z21test_svmops_za32_bf16u10__SVBool_tS_u14__SVBfloat16_tS0_(
// CHECK-CXX-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x bfloat> [[ZN:%.*]], <vscale x 8 x bfloat> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-CXX-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-CXX-NEXT:    tail call void @llvm.aarch64.sme.mops.wide.nxv8bf16(i32 0, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x bfloat> [[ZN]], <vscale x 8 x bfloat> [[ZM]])
// CHECK-CXX-NEXT:    ret void
//
void test_svmops_za32_bf16(svbool_t pn, svbool_t pm, svbfloat16_t zn, svbfloat16_t zm) __arm_streaming __arm_inout("za") {
  SME_ACLE_FUNC(svmops_za32, _bf16, _m)(0, pn, pm, zn, zm);
}

// CHECK-C-LABEL: define dso_local void @test_svmops_za32_f16(
// CHECK-C-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x half> [[ZN:%.*]], <vscale x 8 x half> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-C-NEXT:  entry:
// CHECK-C-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-C-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-C-NEXT:    tail call void @llvm.aarch64.sme.mops.wide.nxv8f16(i32 1, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[ZN]], <vscale x 8 x half> [[ZM]])
// CHECK-C-NEXT:    ret void
//
// CHECK-CXX-LABEL: define dso_local void @_Z20test_svmops_za32_f16u10__SVBool_tS_u13__SVFloat16_tS0_(
// CHECK-CXX-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x half> [[ZN:%.*]], <vscale x 8 x half> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-CXX-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-CXX-NEXT:    tail call void @llvm.aarch64.sme.mops.wide.nxv8f16(i32 1, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x half> [[ZN]], <vscale x 8 x half> [[ZM]])
// CHECK-CXX-NEXT:    ret void
//
void test_svmops_za32_f16(svbool_t pn, svbool_t pm, svfloat16_t zn, svfloat16_t zm) __arm_streaming __arm_inout("za") {
  SME_ACLE_FUNC(svmops_za32, _f16, _m)(1, pn, pm, zn, zm);
}

// CHECK-C-LABEL: define dso_local void @test_svmops_za32_f32(
// CHECK-C-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 4 x float> [[ZN:%.*]], <vscale x 4 x float> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-C-NEXT:  entry:
// CHECK-C-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PN]])
// CHECK-C-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PM]])
// CHECK-C-NEXT:    tail call void @llvm.aarch64.sme.mops.nxv4f32(i32 1, <vscale x 4 x i1> [[TMP0]], <vscale x 4 x i1> [[TMP1]], <vscale x 4 x float> [[ZN]], <vscale x 4 x float> [[ZM]])
// CHECK-C-NEXT:    ret void
//
// CHECK-CXX-LABEL: define dso_local void @_Z20test_svmops_za32_f32u10__SVBool_tS_u13__SVFloat32_tS0_(
// CHECK-CXX-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 4 x float> [[ZN:%.*]], <vscale x 4 x float> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PN]])
// CHECK-CXX-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PM]])
// CHECK-CXX-NEXT:    tail call void @llvm.aarch64.sme.mops.nxv4f32(i32 1, <vscale x 4 x i1> [[TMP0]], <vscale x 4 x i1> [[TMP1]], <vscale x 4 x float> [[ZN]], <vscale x 4 x float> [[ZM]])
// CHECK-CXX-NEXT:    ret void
//
void test_svmops_za32_f32(svbool_t pn, svbool_t pm, svfloat32_t zn, svfloat32_t zm) __arm_streaming __arm_inout("za") {
  SME_ACLE_FUNC(svmops_za32, _f32, _m)(1, pn, pm, zn, zm);
}

// CHECK-C-LABEL: define dso_local void @test_svsumops_za32_s8(
// CHECK-C-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 16 x i8> [[ZN:%.*]], <vscale x 16 x i8> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-C-NEXT:  entry:
// CHECK-C-NEXT:    tail call void @llvm.aarch64.sme.sumops.wide.nxv16i8(i32 0, <vscale x 16 x i1> [[PN]], <vscale x 16 x i1> [[PM]], <vscale x 16 x i8> [[ZN]], <vscale x 16 x i8> [[ZM]])
// CHECK-C-NEXT:    ret void
//
// CHECK-CXX-LABEL: define dso_local void @_Z21test_svsumops_za32_s8u10__SVBool_tS_u10__SVInt8_tu11__SVUint8_t(
// CHECK-CXX-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 16 x i8> [[ZN:%.*]], <vscale x 16 x i8> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    tail call void @llvm.aarch64.sme.sumops.wide.nxv16i8(i32 0, <vscale x 16 x i1> [[PN]], <vscale x 16 x i1> [[PM]], <vscale x 16 x i8> [[ZN]], <vscale x 16 x i8> [[ZM]])
// CHECK-CXX-NEXT:    ret void
//
void test_svsumops_za32_s8(svbool_t pn, svbool_t pm, svint8_t zn, svuint8_t zm) __arm_streaming __arm_inout("za") {
 SME_ACLE_FUNC(svsumops_za32, _s8, _m)(0, pn, pm, zn, zm);
}

// CHECK-C-LABEL: define dso_local void @test_svusmops_za32_u8(
// CHECK-C-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 16 x i8> [[ZN:%.*]], <vscale x 16 x i8> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-C-NEXT:  entry:
// CHECK-C-NEXT:    tail call void @llvm.aarch64.sme.usmops.wide.nxv16i8(i32 0, <vscale x 16 x i1> [[PN]], <vscale x 16 x i1> [[PM]], <vscale x 16 x i8> [[ZN]], <vscale x 16 x i8> [[ZM]])
// CHECK-C-NEXT:    ret void
//
// CHECK-CXX-LABEL: define dso_local void @_Z21test_svusmops_za32_u8u10__SVBool_tS_u11__SVUint8_tu10__SVInt8_t(
// CHECK-CXX-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 16 x i8> [[ZN:%.*]], <vscale x 16 x i8> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    tail call void @llvm.aarch64.sme.usmops.wide.nxv16i8(i32 0, <vscale x 16 x i1> [[PN]], <vscale x 16 x i1> [[PM]], <vscale x 16 x i8> [[ZN]], <vscale x 16 x i8> [[ZM]])
// CHECK-CXX-NEXT:    ret void
//
void test_svusmops_za32_u8(svbool_t pn, svbool_t pm, svuint8_t zn, svint8_t zm) __arm_streaming __arm_inout("za") {
  SME_ACLE_FUNC(svusmops_za32, _u8, _m)(0, pn, pm, zn, zm);
}
//// NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
// CHECK: {{.*}}
