// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 3
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sme-f64f64 -target-feature +sme-i16i64 -target-feature +bf16 -S -O1 -Werror -emit-llvm -o - %s | FileCheck %s -check-prefixes=CHECK,CHECK-C
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sme-f64f64 -target-feature +sme-i16i64 -target-feature +bf16 -S -O1 -Werror -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefixes=CHECK,CHECK-CXX
// RUN: %clang_cc1 -fclang-abi-compat=latest -DSME_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sme-f64f64 -target-feature +sme-i16i64 -target-feature +bf16 -S -O1 -Werror -emit-llvm -o - %s | FileCheck %s -check-prefixes=CHECK,CHECK-C
// RUN: %clang_cc1 -fclang-abi-compat=latest -DSME_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sme-f64f64 -target-feature +sme-i16i64 -target-feature +bf16 -S -O1 -Werror -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefixes=CHECK,CHECK-CXX
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64-none-linux-gnu -target-feature +sme-f64f64 -target-feature +sme-i16i64 -target-feature +bf16 -S -O1 -Werror -o /dev/null %s

#include <arm_sme.h>

#ifdef SME_OVERLOADED_FORMS
#define SME_ACLE_FUNC(A1,A2_UNUSED,A3) A1##A3
#else
#define SME_ACLE_FUNC(A1,A2,A3) A1##A2##A3
#endif

// CHECK-C-LABEL: define dso_local void @test_svmops_za64_s16(
// CHECK-C-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x i16> [[ZN:%.*]], <vscale x 8 x i16> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
// CHECK-C-NEXT:  entry:
// CHECK-C-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-C-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-C-NEXT:    tail call void @llvm.aarch64.sme.smops.wide.nxv8i16(i32 7, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x i16> [[ZN]], <vscale x 8 x i16> [[ZM]])
// CHECK-C-NEXT:    ret void
//
// CHECK-CXX-LABEL: define dso_local void @_Z20test_svmops_za64_s16u10__SVBool_tS_u11__SVInt16_tS0_(
// CHECK-CXX-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x i16> [[ZN:%.*]], <vscale x 8 x i16> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-CXX-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-CXX-NEXT:    tail call void @llvm.aarch64.sme.smops.wide.nxv8i16(i32 7, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x i16> [[ZN]], <vscale x 8 x i16> [[ZM]])
// CHECK-CXX-NEXT:    ret void
//
void test_svmops_za64_s16(svbool_t pn, svbool_t pm, svint16_t zn, svint16_t zm) __arm_streaming __arm_inout("za") {
  SME_ACLE_FUNC(svmops_za64, _s16, _m)(7, pn, pm, zn, zm);
}

// CHECK-C-LABEL: define dso_local void @test_svmops_za64_u16(
// CHECK-C-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x i16> [[ZN:%.*]], <vscale x 8 x i16> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-C-NEXT:  entry:
// CHECK-C-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-C-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-C-NEXT:    tail call void @llvm.aarch64.sme.umops.wide.nxv8i16(i32 0, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x i16> [[ZN]], <vscale x 8 x i16> [[ZM]])
// CHECK-C-NEXT:    ret void
//
// CHECK-CXX-LABEL: define dso_local void @_Z20test_svmops_za64_u16u10__SVBool_tS_u12__SVUint16_tS0_(
// CHECK-CXX-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x i16> [[ZN:%.*]], <vscale x 8 x i16> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-CXX-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-CXX-NEXT:    tail call void @llvm.aarch64.sme.umops.wide.nxv8i16(i32 0, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x i16> [[ZN]], <vscale x 8 x i16> [[ZM]])
// CHECK-CXX-NEXT:    ret void
//
void test_svmops_za64_u16(svbool_t pn, svbool_t pm, svuint16_t zn, svuint16_t zm) __arm_streaming __arm_inout("za") {
  SME_ACLE_FUNC(svmops_za64, _u16, _m)(0, pn, pm, zn, zm);
}

// CHECK-C-LABEL: define dso_local void @test_svmops_za64_f64(
// CHECK-C-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 2 x double> [[ZN:%.*]], <vscale x 2 x double> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-C-NEXT:  entry:
// CHECK-C-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PN]])
// CHECK-C-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PM]])
// CHECK-C-NEXT:    tail call void @llvm.aarch64.sme.mops.nxv2f64(i32 7, <vscale x 2 x i1> [[TMP0]], <vscale x 2 x i1> [[TMP1]], <vscale x 2 x double> [[ZN]], <vscale x 2 x double> [[ZM]])
// CHECK-C-NEXT:    ret void
//
// CHECK-CXX-LABEL: define dso_local void @_Z20test_svmops_za64_f64u10__SVBool_tS_u13__SVFloat64_tS0_(
// CHECK-CXX-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 2 x double> [[ZN:%.*]], <vscale x 2 x double> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PN]])
// CHECK-CXX-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PM]])
// CHECK-CXX-NEXT:    tail call void @llvm.aarch64.sme.mops.nxv2f64(i32 7, <vscale x 2 x i1> [[TMP0]], <vscale x 2 x i1> [[TMP1]], <vscale x 2 x double> [[ZN]], <vscale x 2 x double> [[ZM]])
// CHECK-CXX-NEXT:    ret void
//
void test_svmops_za64_f64(svbool_t pn, svbool_t pm, svfloat64_t zn, svfloat64_t zm) __arm_streaming __arm_inout("za") {
  SME_ACLE_FUNC(svmops_za64, _f64, _m)(7, pn, pm, zn, zm);
}

// CHECK-C-LABEL: define dso_local void @test_svsumops_za64_s16(
// CHECK-C-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x i16> [[ZN:%.*]], <vscale x 8 x i16> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-C-NEXT:  entry:
// CHECK-C-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-C-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-C-NEXT:    tail call void @llvm.aarch64.sme.sumops.wide.nxv8i16(i32 0, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x i16> [[ZN]], <vscale x 8 x i16> [[ZM]])
// CHECK-C-NEXT:    ret void
//
// CHECK-CXX-LABEL: define dso_local void @_Z22test_svsumops_za64_s16u10__SVBool_tS_u11__SVInt16_tu12__SVUint16_t(
// CHECK-CXX-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x i16> [[ZN:%.*]], <vscale x 8 x i16> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-CXX-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-CXX-NEXT:    tail call void @llvm.aarch64.sme.sumops.wide.nxv8i16(i32 0, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x i16> [[ZN]], <vscale x 8 x i16> [[ZM]])
// CHECK-CXX-NEXT:    ret void
//
void test_svsumops_za64_s16(svbool_t pn, svbool_t pm, svint16_t zn, svuint16_t zm) __arm_streaming __arm_inout("za") {
 SME_ACLE_FUNC(svsumops_za64, _s16, _m)(0, pn, pm, zn, zm);
}

// CHECK-C-LABEL: define dso_local void @test_svusmops_za64_u16(
// CHECK-C-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x i16> [[ZN:%.*]], <vscale x 8 x i16> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-C-NEXT:  entry:
// CHECK-C-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-C-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-C-NEXT:    tail call void @llvm.aarch64.sme.usmops.wide.nxv8i16(i32 7, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x i16> [[ZN]], <vscale x 8 x i16> [[ZM]])
// CHECK-C-NEXT:    ret void
//
// CHECK-CXX-LABEL: define dso_local void @_Z22test_svusmops_za64_u16u10__SVBool_tS_u12__SVUint16_tu11__SVInt16_t(
// CHECK-CXX-SAME: <vscale x 16 x i1> [[PN:%.*]], <vscale x 16 x i1> [[PM:%.*]], <vscale x 8 x i16> [[ZN:%.*]], <vscale x 8 x i16> [[ZM:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PN]])
// CHECK-CXX-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PM]])
// CHECK-CXX-NEXT:    tail call void @llvm.aarch64.sme.usmops.wide.nxv8i16(i32 7, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i1> [[TMP1]], <vscale x 8 x i16> [[ZN]], <vscale x 8 x i16> [[ZM]])
// CHECK-CXX-NEXT:    ret void
//
void test_svusmops_za64_u16(svbool_t pn, svbool_t pm, svuint16_t zn, svint16_t zm) __arm_streaming __arm_inout("za") {
  SME_ACLE_FUNC(svusmops_za64, _u16, _m)(7, pn, pm, zn, zm);
}
//// NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
// CHECK: {{.*}}
