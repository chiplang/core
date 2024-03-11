; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64 -mattr=+fullfp16 | FileCheck %s
; RUN: llc < %s -mtriple=aarch64 -mattr=+fullfp16 -global-isel | FileCheck %s


define <4 x i32> @gt_v4f32(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: gt_v4f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    facgt v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
entry:
  %vabs1.i = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %a)
  %vabs1.i2 = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %b)
  %cmp = fcmp ogt <4 x float> %vabs1.i, %vabs1.i2
  %sext = sext <4 x i1> %cmp to <4 x i32>
  ret <4 x i32> %sext
}

define <4 x i32> @ge_v4f32(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: ge_v4f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    facge v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
entry:
  %vabs1.i = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %a)
  %vabs1.i2 = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %b)
  %cmp = fcmp oge <4 x float> %vabs1.i, %vabs1.i2
  %sext = sext <4 x i1> %cmp to <4 x i32>
  ret <4 x i32> %sext
}

define <4 x i32> @lt_v4f32(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: lt_v4f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    facgt v0.4s, v1.4s, v0.4s
; CHECK-NEXT:    ret
entry:
  %vabs1.i = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %a)
  %vabs1.i2 = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %b)
  %cmp = fcmp olt <4 x float> %vabs1.i, %vabs1.i2
  %sext = sext <4 x i1> %cmp to <4 x i32>
  ret <4 x i32> %sext
}

define <4 x i32> @le_v4f32(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: le_v4f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    facge v0.4s, v1.4s, v0.4s
; CHECK-NEXT:    ret
entry:
  %vabs1.i = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %a)
  %vabs1.i2 = tail call <4 x float> @llvm.fabs.v4f32(<4 x float> %b)
  %cmp = fcmp ole <4 x float> %vabs1.i, %vabs1.i2
  %sext = sext <4 x i1> %cmp to <4 x i32>
  ret <4 x i32> %sext
}

define <2 x i32> @gt_v2f32(<2 x float> %a, <2 x float> %b) {
; CHECK-LABEL: gt_v2f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    facgt v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
entry:
  %vabs1.i = tail call <2 x float> @llvm.fabs.v2f32(<2 x float> %a)
  %vabs1.i2 = tail call <2 x float> @llvm.fabs.v2f32(<2 x float> %b)
  %cmp = fcmp ogt <2 x float> %vabs1.i, %vabs1.i2
  %sext = sext <2 x i1> %cmp to <2 x i32>
  ret <2 x i32> %sext
}

define <2 x i32> @ge_v2f32(<2 x float> %a, <2 x float> %b) {
; CHECK-LABEL: ge_v2f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    facge v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
entry:
  %vabs1.i = tail call <2 x float> @llvm.fabs.v2f32(<2 x float> %a)
  %vabs1.i2 = tail call <2 x float> @llvm.fabs.v2f32(<2 x float> %b)
  %cmp = fcmp oge <2 x float> %vabs1.i, %vabs1.i2
  %sext = sext <2 x i1> %cmp to <2 x i32>
  ret <2 x i32> %sext
}

define <4 x i16> @gt_v4f16(<4 x half> %a, <4 x half> %b) {
; CHECK-LABEL: gt_v4f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    facgt v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    ret
entry:
  %vabs1.i = tail call <4 x half> @llvm.fabs.v4f16(<4 x half> %a)
  %vabs1.i2 = tail call <4 x half> @llvm.fabs.v4f16(<4 x half> %b)
  %cmp = fcmp ogt <4 x half> %vabs1.i, %vabs1.i2
  %sext = sext <4 x i1> %cmp to <4 x i16>
  ret <4 x i16> %sext
}

define <4 x i16> @ge_v4f16(<4 x half> %a, <4 x half> %b) {
; CHECK-LABEL: ge_v4f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    facge v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    ret
entry:
  %vabs1.i = tail call <4 x half> @llvm.fabs.v4f16(<4 x half> %a)
  %vabs1.i2 = tail call <4 x half> @llvm.fabs.v4f16(<4 x half> %b)
  %cmp = fcmp oge <4 x half> %vabs1.i, %vabs1.i2
  %sext = sext <4 x i1> %cmp to <4 x i16>
  ret <4 x i16> %sext
}

define <8 x i16> @gt_v8f16(<8 x half> %a, <8 x half> %b) {
; CHECK-LABEL: gt_v8f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    facgt v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
entry:
  %vabs1.i = tail call <8 x half> @llvm.fabs.v8f16(<8 x half> %a)
  %vabs1.i2 = tail call <8 x half> @llvm.fabs.v8f16(<8 x half> %b)
  %cmp = fcmp ogt <8 x half> %vabs1.i, %vabs1.i2
  %sext = sext <8 x i1> %cmp to <8 x i16>
  ret <8 x i16> %sext
}

define <8 x i16> @ge_v8f16(<8 x half> %a, <8 x half> %b) {
; CHECK-LABEL: ge_v8f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    facge v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
entry:
  %vabs1.i = tail call <8 x half> @llvm.fabs.v8f16(<8 x half> %a)
  %vabs1.i2 = tail call <8 x half> @llvm.fabs.v8f16(<8 x half> %b)
  %cmp = fcmp oge <8 x half> %vabs1.i, %vabs1.i2
  %sext = sext <8 x i1> %cmp to <8 x i16>
  ret <8 x i16> %sext
}

define <2 x i64> @gt_v2f64(<2 x double> %a, <2 x double> %b) {
; CHECK-LABEL: gt_v2f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    facgt v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    ret
entry:
  %vabs1.i = tail call <2 x double> @llvm.fabs.v2f64(<2 x double> %a)
  %vabs1.i2 = tail call <2 x double> @llvm.fabs.v2f64(<2 x double> %b)
  %cmp = fcmp ogt <2 x double> %vabs1.i, %vabs1.i2
  %sext = sext <2 x i1> %cmp to <2 x i64>
  ret <2 x i64> %sext
}

define <2 x i64> @ge_v2f64(<2 x double> %a, <2 x double> %b) {
; CHECK-LABEL: ge_v2f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    facge v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    ret
entry:
  %vabs1.i = tail call <2 x double> @llvm.fabs.v2f64(<2 x double> %a)
  %vabs1.i2 = tail call <2 x double> @llvm.fabs.v2f64(<2 x double> %b)
  %cmp = fcmp oge <2 x double> %vabs1.i, %vabs1.i2
  %sext = sext <2 x i1> %cmp to <2 x i64>
  ret <2 x i64> %sext
}

declare <8 x half> @llvm.fabs.v8f16(<8 x half>)
declare <4 x half> @llvm.fabs.v4f16(<4 x half>)
declare <4 x float> @llvm.fabs.v4f32(<4 x float>)
declare <2 x float> @llvm.fabs.v2f32(<2 x float>)
declare <2 x double> @llvm.fabs.v2f64(<2 x double>)
