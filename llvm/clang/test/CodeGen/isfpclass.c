// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 2
// RUN: %clang_cc1 -triple aarch64-linux-gnu -S -O1 -emit-llvm %s -o - | FileCheck %s

// CHECK-LABEL: define dso_local noundef i1 @check_isfpclass_finite
// CHECK-SAME: (float noundef [[X:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call float @llvm.fabs.f32(float [[X]])
// CHECK-NEXT:    [[TMP1:%.*]] = fcmp one float [[TMP0]], 0x7FF0000000000000
// CHECK-NEXT:    ret i1 [[TMP1]]
//
_Bool check_isfpclass_finite(float x) {
  return __builtin_isfpclass(x, 504 /*Finite*/);
}

// CHECK-LABEL: define dso_local noundef i1 @check_isfpclass_finite_strict
// CHECK-SAME: (float noundef [[X:%.*]]) local_unnamed_addr #[[ATTR2:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.is.fpclass.f32(float [[X]], i32 504) #[[ATTR5:[0-9]+]]
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isfpclass_finite_strict(float x) {
#pragma STDC FENV_ACCESS ON
  return __builtin_isfpclass(x, 504 /*Finite*/);
}

// CHECK-LABEL: define dso_local noundef i1 @check_isfpclass_nan_f32
// CHECK-SAME: (float noundef [[X:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = fcmp uno float [[X]], 0.000000e+00
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isfpclass_nan_f32(float x) {
  return __builtin_isfpclass(x, 3 /*NaN*/);
}

// CHECK-LABEL: define dso_local noundef i1 @check_isfpclass_nan_f32_strict
// CHECK-SAME: (float noundef [[X:%.*]]) local_unnamed_addr #[[ATTR2]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.is.fpclass.f32(float [[X]], i32 3) #[[ATTR5]]
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isfpclass_nan_f32_strict(float x) {
#pragma STDC FENV_ACCESS ON
  return __builtin_isfpclass(x, 3 /*NaN*/);
}

// CHECK-LABEL: define dso_local noundef i1 @check_isfpclass_snan_f64
// CHECK-SAME: (double noundef [[X:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.is.fpclass.f64(double [[X]], i32 1)
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isfpclass_snan_f64(double x) {
  return __builtin_isfpclass(x, 1 /*SNaN*/);
}

// CHECK-LABEL: define dso_local noundef i1 @check_isfpclass_snan_f64_strict
// CHECK-SAME: (double noundef [[X:%.*]]) local_unnamed_addr #[[ATTR2]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.is.fpclass.f64(double [[X]], i32 1) #[[ATTR5]]
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isfpclass_snan_f64_strict(double x) {
#pragma STDC FENV_ACCESS ON
  return __builtin_isfpclass(x, 1 /*NaN*/);
}

// CHECK-LABEL: define dso_local noundef i1 @check_isfpclass_zero_f16
// CHECK-SAME: (half noundef [[X:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = fcmp oeq half [[X]], 0xH0000
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isfpclass_zero_f16(_Float16 x) {
  return __builtin_isfpclass(x, 96 /*Zero*/);
}

// CHECK-LABEL: define dso_local noundef i1 @check_isfpclass_zero_f16_strict
// CHECK-SAME: (half noundef [[X:%.*]]) local_unnamed_addr #[[ATTR2]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.is.fpclass.f16(half [[X]], i32 96) #[[ATTR5]]
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isfpclass_zero_f16_strict(_Float16 x) {
#pragma STDC FENV_ACCESS ON
  return __builtin_isfpclass(x, 96 /*Zero*/);
}

// CHECK-LABEL: define dso_local noundef i1 @check_isnan
// CHECK-SAME: (float noundef [[X:%.*]]) local_unnamed_addr #[[ATTR2]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.is.fpclass.f32(float [[X]], i32 3) #[[ATTR5]]
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isnan(float x) {
#pragma STDC FENV_ACCESS ON
  return __builtin_isnan(x);
}

// CHECK-LABEL: define dso_local noundef i1 @check_isinf
// CHECK-SAME: (float noundef [[X:%.*]]) local_unnamed_addr #[[ATTR2]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.is.fpclass.f32(float [[X]], i32 516) #[[ATTR5]]
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isinf(float x) {
#pragma STDC FENV_ACCESS ON
  return __builtin_isinf(x);
}

// CHECK-LABEL: define dso_local noundef i1 @check_isfinite
// CHECK-SAME: (float noundef [[X:%.*]]) local_unnamed_addr #[[ATTR2]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.is.fpclass.f32(float [[X]], i32 504) #[[ATTR5]]
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isfinite(float x) {
#pragma STDC FENV_ACCESS ON
  return __builtin_isfinite(x);
}

// CHECK-LABEL: define dso_local noundef i1 @check_isnormal
// CHECK-SAME: (float noundef [[X:%.*]]) local_unnamed_addr #[[ATTR2]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.is.fpclass.f32(float [[X]], i32 264) #[[ATTR5]]
// CHECK-NEXT:    ret i1 [[TMP0]]
//
_Bool check_isnormal(float x) {
#pragma STDC FENV_ACCESS ON
  return __builtin_isnormal(x);
}


typedef float __attribute__((ext_vector_type(4))) float4;
typedef double __attribute__((ext_vector_type(4))) double4;
typedef int __attribute__((ext_vector_type(4))) int4;
typedef long __attribute__((ext_vector_type(4))) long4;

// CHECK-LABEL: define dso_local noundef <4 x i32> @check_isfpclass_nan_v4f32
// CHECK-SAME: (<4 x float> noundef [[X:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = fcmp uno <4 x float> [[X]], zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = zext <4 x i1> [[TMP0]] to <4 x i32>
// CHECK-NEXT:    ret <4 x i32> [[TMP1]]
//
int4 check_isfpclass_nan_v4f32(float4 x) {
  return __builtin_isfpclass(x, 3 /*NaN*/);
}

// CHECK-LABEL: define dso_local noundef <4 x i32> @check_isfpclass_nan_strict_v4f32
// CHECK-SAME: (<4 x float> noundef [[X:%.*]]) local_unnamed_addr #[[ATTR2]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <4 x i1> @llvm.is.fpclass.v4f32(<4 x float> [[X]], i32 3) #[[ATTR5]]
// CHECK-NEXT:    [[TMP1:%.*]] = zext <4 x i1> [[TMP0]] to <4 x i32>
// CHECK-NEXT:    ret <4 x i32> [[TMP1]]
//
int4 check_isfpclass_nan_strict_v4f32(float4 x) {
#pragma STDC FENV_ACCESS ON
  return __builtin_isfpclass(x, 3 /*NaN*/);
}

// CHECK-LABEL: define dso_local void @check_isfpclass_nan_v4f64
// CHECK-SAME: (ptr dead_on_unwind noalias nocapture writable writeonly sret(<4 x i64>) align 16 [[AGG_RESULT:%.*]], ptr nocapture noundef readonly [[TMP0:%.*]]) local_unnamed_addr #[[ATTR3:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[X:%.*]] = load <4 x double>, ptr [[TMP0]], align 16, !tbaa [[TBAA2:![0-9]+]]
// CHECK-NEXT:    [[TMP1:%.*]] = fcmp uno <4 x double> [[X]], zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = zext <4 x i1> [[TMP1]] to <4 x i64>
// CHECK-NEXT:    store <4 x i64> [[TMP2]], ptr [[AGG_RESULT]], align 16, !tbaa [[TBAA2]]
// CHECK-NEXT:    ret void
//
long4 check_isfpclass_nan_v4f64(double4 x) {
  return __builtin_isfpclass(x, 3 /*NaN*/);
}
