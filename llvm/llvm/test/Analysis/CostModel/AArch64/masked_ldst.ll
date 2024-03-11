; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -passes="print<cost-model>" 2>&1 -disable-output -mtriple=aarch64-linux-gnu -mattr=+sve | FileCheck %s

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"

define void @fixed() {
; CHECK-LABEL: 'fixed'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %v2i8 = call <2 x i8> @llvm.masked.load.v2i8.p0(ptr undef, i32 8, <2 x i1> undef, <2 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %v4i8 = call <4 x i8> @llvm.masked.load.v4i8.p0(ptr undef, i32 8, <4 x i1> undef, <4 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %v8i8 = call <8 x i8> @llvm.masked.load.v8i8.p0(ptr undef, i32 8, <8 x i1> undef, <8 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 96 for instruction: %v16i8 = call <16 x i8> @llvm.masked.load.v16i8.p0(ptr undef, i32 8, <16 x i1> undef, <16 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %v2i16 = call <2 x i16> @llvm.masked.load.v2i16.p0(ptr undef, i32 8, <2 x i1> undef, <2 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %v4i16 = call <4 x i16> @llvm.masked.load.v4i16.p0(ptr undef, i32 8, <4 x i1> undef, <4 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %v8i16 = call <8 x i16> @llvm.masked.load.v8i16.p0(ptr undef, i32 8, <8 x i1> undef, <8 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %v2i32 = call <2 x i32> @llvm.masked.load.v2i32.p0(ptr undef, i32 8, <2 x i1> undef, <2 x i32> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %v4i32 = call <4 x i32> @llvm.masked.load.v4i32.p0(ptr undef, i32 8, <4 x i1> undef, <4 x i32> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %v2i64 = call <2 x i64> @llvm.masked.load.v2i64.p0(ptr undef, i32 8, <2 x i1> undef, <2 x i64> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %v2f16 = call <2 x half> @llvm.masked.load.v2f16.p0(ptr undef, i32 8, <2 x i1> undef, <2 x half> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 22 for instruction: %v4f16 = call <4 x half> @llvm.masked.load.v4f16.p0(ptr undef, i32 8, <4 x i1> undef, <4 x half> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 46 for instruction: %v8f16 = call <8 x half> @llvm.masked.load.v8f16.p0(ptr undef, i32 8, <8 x i1> undef, <8 x half> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %v2f32 = call <2 x float> @llvm.masked.load.v2f32.p0(ptr undef, i32 8, <2 x i1> undef, <2 x float> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 22 for instruction: %v4f32 = call <4 x float> @llvm.masked.load.v4f32.p0(ptr undef, i32 8, <4 x i1> undef, <4 x float> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %v2f64 = call <2 x double> @llvm.masked.load.v2f64.p0(ptr undef, i32 8, <2 x i1> undef, <2 x double> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %v4i64 = call <4 x i64> @llvm.masked.load.v4i64.p0(ptr undef, i32 8, <4 x i1> undef, <4 x i64> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 184 for instruction: %v32f16 = call <32 x half> @llvm.masked.load.v32f16.p0(ptr undef, i32 8, <32 x i1> undef, <32 x half> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
entry:
  ; Legal fixed-width integer types
  %v2i8 = call <2 x i8> @llvm.masked.load.v2i8.p0(ptr undef, i32 8, <2 x i1> undef, <2 x i8> undef)
  %v4i8 = call <4 x i8> @llvm.masked.load.v4i8.p0(ptr undef, i32 8, <4 x i1> undef, <4 x i8> undef)
  %v8i8 = call <8 x i8> @llvm.masked.load.v8i8.p0(ptr undef, i32 8, <8 x i1> undef, <8 x i8> undef)
  %v16i8 = call <16 x i8> @llvm.masked.load.v16i8.p0(ptr undef, i32 8, <16 x i1> undef, <16 x i8> undef)
  %v2i16 = call <2 x i16> @llvm.masked.load.v2i16.p0(ptr undef, i32 8, <2 x i1> undef, <2 x i16> undef)
  %v4i16 = call <4 x i16> @llvm.masked.load.v4i16.p0(ptr undef, i32 8, <4 x i1> undef, <4 x i16> undef)
  %v8i16 = call <8 x i16> @llvm.masked.load.v8i16.p0(ptr undef, i32 8, <8 x i1> undef, <8 x i16> undef)
  %v2i32 = call <2 x i32> @llvm.masked.load.v2i32.p0(ptr undef, i32 8, <2 x i1> undef, <2 x i32> undef)
  %v4i32 = call <4 x i32> @llvm.masked.load.v4i32.p0(ptr undef, i32 8, <4 x i1> undef, <4 x i32> undef)
  %v2i64 = call <2 x i64> @llvm.masked.load.v2i64.p0(ptr undef, i32 8, <2 x i1> undef, <2 x i64> undef)

  ; Legal fixed-width floating point types
  %v2f16 = call <2 x half> @llvm.masked.load.v2f16.p0(ptr undef, i32 8, <2 x i1> undef, <2 x half> undef)
  %v4f16 = call <4 x half> @llvm.masked.load.v4f16.p0(ptr undef, i32 8, <4 x i1> undef, <4 x half> undef)
  %v8f16 = call <8 x half> @llvm.masked.load.v8f16.p0(ptr undef, i32 8, <8 x i1> undef, <8 x half> undef)
  %v2f32 = call <2 x float> @llvm.masked.load.v2f32.p0(ptr undef, i32 8, <2 x i1> undef, <2 x float> undef)
  %v4f32 = call <4 x float> @llvm.masked.load.v4f32.p0(ptr undef, i32 8, <4 x i1> undef, <4 x float> undef)
  %v2f64 = call <2 x double> @llvm.masked.load.v2f64.p0(ptr undef, i32 8, <2 x i1> undef, <2 x double> undef)

  ; A couple of examples of illegal fixed-width types
  %v4i64 = call <4 x i64> @llvm.masked.load.v4i64.p0(ptr undef, i32 8, <4 x i1> undef, <4 x i64> undef)
  %v32f16 = call <32 x half> @llvm.masked.load.v32f16.p0(ptr undef, i32 8, <32 x i1> undef, <32 x half> undef)

  ret void
}


define void @scalable() {
; CHECK-LABEL: 'scalable'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %nxv2i8 = call <vscale x 2 x i8> @llvm.masked.load.nxv2i8.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %nxv4i8 = call <vscale x 4 x i8> @llvm.masked.load.nxv4i8.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %nxv8i8 = call <vscale x 8 x i8> @llvm.masked.load.nxv8i8.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %nxv16i8 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr undef, i32 8, <vscale x 16 x i1> undef, <vscale x 16 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %nxv2i16 = call <vscale x 2 x i16> @llvm.masked.load.nxv2i16.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %nxv4i16 = call <vscale x 4 x i16> @llvm.masked.load.nxv4i16.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %nxv8i16 = call <vscale x 8 x i16> @llvm.masked.load.nxv8i16.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %nxv2i32 = call <vscale x 2 x i32> @llvm.masked.load.nxv2i32.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i32> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %nxv4i32 = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i32> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %nxv2i64 = call <vscale x 2 x i64> @llvm.masked.load.nxv2i64.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i64> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %nxv2f16 = call <vscale x 2 x half> @llvm.masked.load.nxv2f16.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x half> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %nxv4f16 = call <vscale x 4 x half> @llvm.masked.load.nxv4f16.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x half> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %nxv8f16 = call <vscale x 8 x half> @llvm.masked.load.nxv8f16.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x half> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %nxv2f32 = call <vscale x 2 x float> @llvm.masked.load.nxv2f32.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x float> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %nxv4f32 = call <vscale x 4 x float> @llvm.masked.load.nxv4f32.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x float> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %nxv2f64 = call <vscale x 2 x double> @llvm.masked.load.nxv2f64.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x double> undef)
; CHECK-NEXT:  Cost Model: Invalid cost for instruction: %nxv1i64 = call <vscale x 1 x i64> @llvm.masked.load.nxv1i64.p0(ptr undef, i32 8, <vscale x 1 x i1> undef, <vscale x 1 x i64> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %nxv4i64 = call <vscale x 4 x i64> @llvm.masked.load.nxv4i64.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i64> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %nxv32f16 = call <vscale x 32 x half> @llvm.masked.load.nxv32f16.p0(ptr undef, i32 8, <vscale x 32 x i1> undef, <vscale x 32 x half> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
entry:
  ; Legal scalable integer types
  %nxv2i8 = call <vscale x 2 x i8> @llvm.masked.load.nxv2i8.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i8> undef)
  %nxv4i8 = call <vscale x 4 x i8> @llvm.masked.load.nxv4i8.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i8> undef)
  %nxv8i8 = call <vscale x 8 x i8> @llvm.masked.load.nxv8i8.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i8> undef)
  %nxv16i8 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr undef, i32 8, <vscale x 16 x i1> undef, <vscale x 16 x i8> undef)
  %nxv2i16 = call <vscale x 2 x i16> @llvm.masked.load.nxv2i16.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i16> undef)
  %nxv4i16 = call <vscale x 4 x i16> @llvm.masked.load.nxv4i16.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i16> undef)
  %nxv8i16 = call <vscale x 8 x i16> @llvm.masked.load.nxv8i16.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i16> undef)
  %nxv2i32 = call <vscale x 2 x i32> @llvm.masked.load.nxv2i32.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i32> undef)
  %nxv4i32 = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i32> undef)
  %nxv2i64 = call <vscale x 2 x i64> @llvm.masked.load.nxv2i64.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i64> undef)

  ; Legal scalable floating point types
  %nxv2f16 = call <vscale x 2 x half> @llvm.masked.load.nxv2f16.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x half> undef)
  %nxv4f16 = call <vscale x 4 x half> @llvm.masked.load.nxv4f16.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x half> undef)
  %nxv8f16 = call <vscale x 8 x half> @llvm.masked.load.nxv8f16.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x half> undef)
  %nxv2f32 = call <vscale x 2 x float> @llvm.masked.load.nxv2f32.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x float> undef)
  %nxv4f32 = call <vscale x 4 x float> @llvm.masked.load.nxv4f32.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x float> undef)
  %nxv2f64 = call <vscale x 2 x double> @llvm.masked.load.nxv2f64.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x double> undef)

  ; A couple of examples of illegal scalable types
  %nxv1i64 = call <vscale x 1 x i64> @llvm.masked.load.nxv1i64.p0(ptr undef, i32 8, <vscale x 1 x i1> undef, <vscale x 1 x i64> undef)
  %nxv4i64 = call <vscale x 4 x i64> @llvm.masked.load.nxv4i64.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i64> undef)
  %nxv32f16 = call <vscale x 32 x half> @llvm.masked.load.nxv32f16.p0(ptr undef, i32 8, <vscale x 32 x i1> undef, <vscale x 32 x half> undef)

  ret void
}


define void @scalable_ext_loads() {
; CHECK-LABEL: 'scalable_ext_loads'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load.nxv16i8 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr undef, i32 8, <vscale x 16 x i1> undef, <vscale x 16 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %zext.nxv16i8to16 = zext <vscale x 16 x i8> %load.nxv16i8 to <vscale x 16 x i16>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load.nxv16i8.2 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr undef, i32 8, <vscale x 16 x i1> undef, <vscale x 16 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %zext.nxv16i8to32 = zext <vscale x 16 x i8> %load.nxv16i8.2 to <vscale x 16 x i32>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load.nxv16i8.3 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr undef, i32 8, <vscale x 16 x i1> undef, <vscale x 16 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 14 for instruction: %zext.nxv16i8to64 = zext <vscale x 16 x i8> %load.nxv16i8.3 to <vscale x 16 x i64>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load.nxv8i8 = call <vscale x 8 x i8> @llvm.masked.load.nxv8i8.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %zext.nxv8i8to16 = zext <vscale x 8 x i8> %load.nxv8i8 to <vscale x 8 x i16>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load.nxv8i8.2 = call <vscale x 8 x i8> @llvm.masked.load.nxv8i8.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %zext.nxv8i8to32 = zext <vscale x 8 x i8> %load.nxv8i8.2 to <vscale x 8 x i32>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load.nxv8i8.3 = call <vscale x 8 x i8> @llvm.masked.load.nxv8i8.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %zext.nxv8i8to64 = zext <vscale x 8 x i8> %load.nxv8i8.3 to <vscale x 8 x i64>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load.nxv4i8 = call <vscale x 4 x i8> @llvm.masked.load.nxv4i8.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %zext.nxv4i8to32 = zext <vscale x 4 x i8> %load.nxv4i8 to <vscale x 4 x i32>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load.nxv4i8.2 = call <vscale x 4 x i8> @llvm.masked.load.nxv4i8.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %zext.nxv4i8to64 = zext <vscale x 4 x i8> %load.nxv4i8.2 to <vscale x 4 x i64>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load.nxv2i8 = call <vscale x 2 x i8> @llvm.masked.load.nxv2i8.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %zext.nxv2i8to64 = zext <vscale x 2 x i8> %load.nxv2i8 to <vscale x 2 x i64>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load.nxv8i16 = call <vscale x 8 x i16> @llvm.masked.load.nxv8i16.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %zext.nxv8i16to32 = zext <vscale x 8 x i16> %load.nxv8i16 to <vscale x 8 x i32>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load.nxv8i16.2 = call <vscale x 8 x i16> @llvm.masked.load.nxv8i16.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %zext.nxv8i16to64 = zext <vscale x 8 x i16> %load.nxv8i16.2 to <vscale x 8 x i64>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load.nxv4i16 = call <vscale x 4 x i16> @llvm.masked.load.nxv4i16.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %zext.nxv4i16to32 = zext <vscale x 4 x i16> %load.nxv4i16 to <vscale x 4 x i32>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load.nxv4i16.2 = call <vscale x 4 x i16> @llvm.masked.load.nxv4i16.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %zext.nxv4i16to64 = zext <vscale x 4 x i16> %load.nxv4i16.2 to <vscale x 4 x i64>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load.nxv2i16 = call <vscale x 2 x i16> @llvm.masked.load.nxv2i16.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %zext.nxv2i16to64 = zext <vscale x 2 x i16> %load.nxv2i16 to <vscale x 2 x i64>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load.nxv4i32 = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i32> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %zext.nxv4i32to64 = zext <vscale x 4 x i32> %load.nxv4i32 to <vscale x 4 x i64>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load.nxv2i32 = call <vscale x 2 x i32> @llvm.masked.load.nxv2i32.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i32> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %zext.nxv2i32to64 = zext <vscale x 2 x i32> %load.nxv2i32 to <vscale x 2 x i64>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load2.nxv16i8 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr undef, i32 8, <vscale x 16 x i1> undef, <vscale x 16 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %sext.nxv16i8to16 = sext <vscale x 16 x i8> %load2.nxv16i8 to <vscale x 16 x i16>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load2.nxv16i8.2 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr undef, i32 8, <vscale x 16 x i1> undef, <vscale x 16 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %sext.nxv16i8to32 = sext <vscale x 16 x i8> %load2.nxv16i8.2 to <vscale x 16 x i32>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load2.nxv16i8.3 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr undef, i32 8, <vscale x 16 x i1> undef, <vscale x 16 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 14 for instruction: %sext.nxv16i8to64 = sext <vscale x 16 x i8> %load2.nxv16i8.3 to <vscale x 16 x i64>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load2.nxv8i8 = call <vscale x 8 x i8> @llvm.masked.load.nxv8i8.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %sext.nxv8i8to16 = sext <vscale x 8 x i8> %load2.nxv8i8 to <vscale x 8 x i16>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load2.nxv8i8.2 = call <vscale x 8 x i8> @llvm.masked.load.nxv8i8.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %sext.nxv8i8to32 = sext <vscale x 8 x i8> %load2.nxv8i8.2 to <vscale x 8 x i32>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load2.nxv8i8.3 = call <vscale x 8 x i8> @llvm.masked.load.nxv8i8.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %sext.nxv8i8to64 = sext <vscale x 8 x i8> %load2.nxv8i8.3 to <vscale x 8 x i64>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load2.nxv4i8 = call <vscale x 4 x i8> @llvm.masked.load.nxv4i8.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %sext.nxv4i8to32 = sext <vscale x 4 x i8> %load2.nxv4i8 to <vscale x 4 x i32>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load2.nxv4i8.2 = call <vscale x 4 x i8> @llvm.masked.load.nxv4i8.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %sext.nxv4i8to64 = sext <vscale x 4 x i8> %load2.nxv4i8.2 to <vscale x 4 x i64>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load2.nxv2i8 = call <vscale x 2 x i8> @llvm.masked.load.nxv2i8.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i8> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %sext.nxv2i8to64 = sext <vscale x 2 x i8> %load2.nxv2i8 to <vscale x 2 x i64>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load2.nxv8i16 = call <vscale x 8 x i16> @llvm.masked.load.nxv8i16.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %sext.nxv8i16to32 = sext <vscale x 8 x i16> %load2.nxv8i16 to <vscale x 8 x i32>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load2.nxv8i16.2 = call <vscale x 8 x i16> @llvm.masked.load.nxv8i16.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %sext.nxv8i16to64 = sext <vscale x 8 x i16> %load2.nxv8i16.2 to <vscale x 8 x i64>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load2.nxv4i16 = call <vscale x 4 x i16> @llvm.masked.load.nxv4i16.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %sext.nxv4i16to32 = sext <vscale x 4 x i16> %load2.nxv4i16 to <vscale x 4 x i32>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load2.nxv4i16.2 = call <vscale x 4 x i16> @llvm.masked.load.nxv4i16.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %sext.nxv4i16to64 = sext <vscale x 4 x i16> %load2.nxv4i16.2 to <vscale x 4 x i64>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load2.nxv2i16 = call <vscale x 2 x i16> @llvm.masked.load.nxv2i16.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i16> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %sext.nxv2i16to64 = sext <vscale x 2 x i16> %load2.nxv2i16 to <vscale x 2 x i64>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load2.nxv4i32 = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i32> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %sext.nxv4i32to64 = sext <vscale x 4 x i32> %load2.nxv4i32 to <vscale x 4 x i64>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %load2.nxv2i32 = call <vscale x 2 x i32> @llvm.masked.load.nxv2i32.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i32> undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %sext.nxv2i32to64 = sext <vscale x 2 x i32> %load2.nxv2i32 to <vscale x 2 x i64>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;


  %load.nxv16i8 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr undef, i32 8, <vscale x 16 x i1> undef, <vscale x 16 x i8> undef)
  %zext.nxv16i8to16 = zext <vscale x 16 x i8> %load.nxv16i8 to <vscale x 16 x i16>
  %load.nxv16i8.2 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr undef, i32 8, <vscale x 16 x i1> undef, <vscale x 16 x i8> undef)
  %zext.nxv16i8to32 = zext <vscale x 16 x i8> %load.nxv16i8.2 to <vscale x 16 x i32>
  %load.nxv16i8.3 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr undef, i32 8, <vscale x 16 x i1> undef, <vscale x 16 x i8> undef)
  %zext.nxv16i8to64 = zext <vscale x 16 x i8> %load.nxv16i8.3 to <vscale x 16 x i64>
  %load.nxv8i8 = call <vscale x 8 x i8> @llvm.masked.load.nxv8i8.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i8> undef)
  %zext.nxv8i8to16 = zext <vscale x 8 x i8> %load.nxv8i8 to <vscale x 8 x i16>
  %load.nxv8i8.2 = call <vscale x 8 x i8> @llvm.masked.load.nxv8i8.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i8> undef)
  %zext.nxv8i8to32 = zext <vscale x 8 x i8> %load.nxv8i8.2 to <vscale x 8 x i32>
  %load.nxv8i8.3 = call <vscale x 8 x i8> @llvm.masked.load.nxv8i8.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i8> undef)
  %zext.nxv8i8to64 = zext <vscale x 8 x i8> %load.nxv8i8.3 to <vscale x 8 x i64>
  %load.nxv4i8 = call <vscale x 4 x i8> @llvm.masked.load.nxv4i8.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i8> undef)
  %zext.nxv4i8to32 = zext <vscale x 4 x i8> %load.nxv4i8 to <vscale x 4 x i32>
  %load.nxv4i8.2 = call <vscale x 4 x i8> @llvm.masked.load.nxv4i8.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i8> undef)
  %zext.nxv4i8to64 = zext <vscale x 4 x i8> %load.nxv4i8.2 to <vscale x 4 x i64>
  %load.nxv2i8 = call <vscale x 2 x i8> @llvm.masked.load.nxv2i8.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i8> undef)
  %zext.nxv2i8to64 = zext <vscale x 2 x i8> %load.nxv2i8 to <vscale x 2 x i64>
  %load.nxv8i16 = call <vscale x 8 x i16> @llvm.masked.load.nxv8i16.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i16> undef)
  %zext.nxv8i16to32 = zext <vscale x 8 x i16> %load.nxv8i16 to <vscale x 8 x i32>
  %load.nxv8i16.2 = call <vscale x 8 x i16> @llvm.masked.load.nxv8i16.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i16> undef)
  %zext.nxv8i16to64 = zext <vscale x 8 x i16> %load.nxv8i16.2 to <vscale x 8 x i64>
  %load.nxv4i16 = call <vscale x 4 x i16> @llvm.masked.load.nxv4i16.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i16> undef)
  %zext.nxv4i16to32 = zext <vscale x 4 x i16> %load.nxv4i16 to <vscale x 4 x i32>
  %load.nxv4i16.2 = call <vscale x 4 x i16> @llvm.masked.load.nxv4i16.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i16> undef)
  %zext.nxv4i16to64 = zext <vscale x 4 x i16> %load.nxv4i16.2 to <vscale x 4 x i64>
  %load.nxv2i16 = call <vscale x 2 x i16> @llvm.masked.load.nxv2i16.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i16> undef)
  %zext.nxv2i16to64 = zext <vscale x 2 x i16> %load.nxv2i16 to <vscale x 2 x i64>
  %load.nxv4i32 = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i32> undef)
  %zext.nxv4i32to64 = zext <vscale x 4 x i32> %load.nxv4i32 to <vscale x 4 x i64>
  %load.nxv2i32 = call <vscale x 2 x i32> @llvm.masked.load.nxv2i32.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i32> undef)
  %zext.nxv2i32to64 = zext <vscale x 2 x i32> %load.nxv2i32 to <vscale x 2 x i64>

  %load2.nxv16i8 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr undef, i32 8, <vscale x 16 x i1> undef, <vscale x 16 x i8> undef)
  %sext.nxv16i8to16 = sext <vscale x 16 x i8> %load2.nxv16i8 to <vscale x 16 x i16>
  %load2.nxv16i8.2 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr undef, i32 8, <vscale x 16 x i1> undef, <vscale x 16 x i8> undef)
  %sext.nxv16i8to32 = sext <vscale x 16 x i8> %load2.nxv16i8.2 to <vscale x 16 x i32>
  %load2.nxv16i8.3 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr undef, i32 8, <vscale x 16 x i1> undef, <vscale x 16 x i8> undef)
  %sext.nxv16i8to64 = sext <vscale x 16 x i8> %load2.nxv16i8.3 to <vscale x 16 x i64>
  %load2.nxv8i8 = call <vscale x 8 x i8> @llvm.masked.load.nxv8i8.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i8> undef)
  %sext.nxv8i8to16 = sext <vscale x 8 x i8> %load2.nxv8i8 to <vscale x 8 x i16>
  %load2.nxv8i8.2 = call <vscale x 8 x i8> @llvm.masked.load.nxv8i8.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i8> undef)
  %sext.nxv8i8to32 = sext <vscale x 8 x i8> %load2.nxv8i8.2 to <vscale x 8 x i32>
  %load2.nxv8i8.3 = call <vscale x 8 x i8> @llvm.masked.load.nxv8i8.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i8> undef)
  %sext.nxv8i8to64 = sext <vscale x 8 x i8> %load2.nxv8i8.3 to <vscale x 8 x i64>
  %load2.nxv4i8 = call <vscale x 4 x i8> @llvm.masked.load.nxv4i8.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i8> undef)
  %sext.nxv4i8to32 = sext <vscale x 4 x i8> %load2.nxv4i8 to <vscale x 4 x i32>
  %load2.nxv4i8.2 = call <vscale x 4 x i8> @llvm.masked.load.nxv4i8.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i8> undef)
  %sext.nxv4i8to64 = sext <vscale x 4 x i8> %load2.nxv4i8.2 to <vscale x 4 x i64>
  %load2.nxv2i8 = call <vscale x 2 x i8> @llvm.masked.load.nxv2i8.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i8> undef)
  %sext.nxv2i8to64 = sext <vscale x 2 x i8> %load2.nxv2i8 to <vscale x 2 x i64>
  %load2.nxv8i16 = call <vscale x 8 x i16> @llvm.masked.load.nxv8i16.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i16> undef)
  %sext.nxv8i16to32 = sext <vscale x 8 x i16> %load2.nxv8i16 to <vscale x 8 x i32>
  %load2.nxv8i16.2 = call <vscale x 8 x i16> @llvm.masked.load.nxv8i16.p0(ptr undef, i32 8, <vscale x 8 x i1> undef, <vscale x 8 x i16> undef)
  %sext.nxv8i16to64 = sext <vscale x 8 x i16> %load2.nxv8i16.2 to <vscale x 8 x i64>
  %load2.nxv4i16 = call <vscale x 4 x i16> @llvm.masked.load.nxv4i16.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i16> undef)
  %sext.nxv4i16to32 = sext <vscale x 4 x i16> %load2.nxv4i16 to <vscale x 4 x i32>
  %load2.nxv4i16.2 = call <vscale x 4 x i16> @llvm.masked.load.nxv4i16.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i16> undef)
  %sext.nxv4i16to64 = sext <vscale x 4 x i16> %load2.nxv4i16.2 to <vscale x 4 x i64>
  %load2.nxv2i16 = call <vscale x 2 x i16> @llvm.masked.load.nxv2i16.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i16> undef)
  %sext.nxv2i16to64 = sext <vscale x 2 x i16> %load2.nxv2i16 to <vscale x 2 x i64>
  %load2.nxv4i32 = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr undef, i32 8, <vscale x 4 x i1> undef, <vscale x 4 x i32> undef)
  %sext.nxv4i32to64 = sext <vscale x 4 x i32> %load2.nxv4i32 to <vscale x 4 x i64>
  %load2.nxv2i32 = call <vscale x 2 x i32> @llvm.masked.load.nxv2i32.p0(ptr undef, i32 8, <vscale x 2 x i1> undef, <vscale x 2 x i32> undef)
  %sext.nxv2i32to64 = sext <vscale x 2 x i32> %load2.nxv2i32 to <vscale x 2 x i64>

  ret void
}


declare <2 x i8> @llvm.masked.load.v2i8.p0(ptr, i32, <2 x i1>, <2 x i8>)
declare <4 x i8> @llvm.masked.load.v4i8.p0(ptr, i32, <4 x i1>, <4 x i8>)
declare <8 x i8> @llvm.masked.load.v8i8.p0(ptr, i32, <8 x i1>, <8 x i8>)
declare <16 x i8> @llvm.masked.load.v16i8.p0(ptr, i32, <16 x i1>, <16 x i8>)
declare <2 x i16> @llvm.masked.load.v2i16.p0(ptr, i32, <2 x i1>, <2 x i16>)
declare <4 x i16> @llvm.masked.load.v4i16.p0(ptr, i32, <4 x i1>, <4 x i16>)
declare <8 x i16> @llvm.masked.load.v8i16.p0(ptr, i32, <8 x i1>, <8 x i16>)
declare <2 x i32> @llvm.masked.load.v2i32.p0(ptr, i32, <2 x i1>, <2 x i32>)
declare <4 x i32> @llvm.masked.load.v4i32.p0(ptr, i32, <4 x i1>, <4 x i32>)
declare <2 x i64> @llvm.masked.load.v2i64.p0(ptr, i32, <2 x i1>, <2 x i64>)
declare <4 x i64> @llvm.masked.load.v4i64.p0(ptr, i32, <4 x i1>, <4 x i64>)
declare <2 x half> @llvm.masked.load.v2f16.p0(ptr, i32, <2 x i1>, <2 x half>)
declare <4 x half> @llvm.masked.load.v4f16.p0(ptr, i32, <4 x i1>, <4 x half>)
declare <8 x half> @llvm.masked.load.v8f16.p0(ptr, i32, <8 x i1>, <8 x half>)
declare <32 x half> @llvm.masked.load.v32f16.p0(ptr, i32, <32 x i1>, <32 x half>)
declare <2 x float> @llvm.masked.load.v2f32.p0(ptr, i32, <2 x i1>, <2 x float>)
declare <4 x float> @llvm.masked.load.v4f32.p0(ptr, i32, <4 x i1>, <4 x float>)
declare <2 x double> @llvm.masked.load.v2f64.p0(ptr, i32, <2 x i1>, <2 x double>)


declare <vscale x 2 x i8> @llvm.masked.load.nxv2i8.p0(ptr, i32, <vscale x 2 x i1>, <vscale x 2 x i8>)
declare <vscale x 4 x i8> @llvm.masked.load.nxv4i8.p0(ptr, i32, <vscale x 4 x i1>, <vscale x 4 x i8>)
declare <vscale x 8 x i8> @llvm.masked.load.nxv8i8.p0(ptr, i32, <vscale x 8 x i1>, <vscale x 8 x i8>)
declare <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr, i32, <vscale x 16 x i1>, <vscale x 16 x i8>)
declare <vscale x 2 x i16> @llvm.masked.load.nxv2i16.p0(ptr, i32, <vscale x 2 x i1>, <vscale x 2 x i16>)
declare <vscale x 4 x i16> @llvm.masked.load.nxv4i16.p0(ptr, i32, <vscale x 4 x i1>, <vscale x 4 x i16>)
declare <vscale x 8 x i16> @llvm.masked.load.nxv8i16.p0(ptr, i32, <vscale x 8 x i1>, <vscale x 8 x i16>)
declare <vscale x 2 x i32> @llvm.masked.load.nxv2i32.p0(ptr, i32, <vscale x 2 x i1>, <vscale x 2 x i32>)
declare <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr, i32, <vscale x 4 x i1>, <vscale x 4 x i32>)
declare <vscale x 2 x i64> @llvm.masked.load.nxv2i64.p0(ptr, i32, <vscale x 2 x i1>, <vscale x 2 x i64>)
declare <vscale x 4 x i64> @llvm.masked.load.nxv4i64.p0(ptr, i32, <vscale x 4 x i1>, <vscale x 4 x i64>)
declare <vscale x 1 x i64> @llvm.masked.load.nxv1i64.p0(ptr, i32, <vscale x 1 x i1>, <vscale x 1 x i64>)
declare <vscale x 2 x half> @llvm.masked.load.nxv2f16.p0(ptr, i32, <vscale x 2 x i1>, <vscale x 2 x half>)
declare <vscale x 4 x half> @llvm.masked.load.nxv4f16.p0(ptr, i32, <vscale x 4 x i1>, <vscale x 4 x half>)
declare <vscale x 8 x half> @llvm.masked.load.nxv8f16.p0(ptr, i32, <vscale x 8 x i1>, <vscale x 8 x half>)
declare <vscale x 32 x half> @llvm.masked.load.nxv32f16.p0(ptr, i32, <vscale x 32 x i1>, <vscale x 32 x half>)
declare <vscale x 2 x float> @llvm.masked.load.nxv2f32.p0(ptr, i32, <vscale x 2 x i1>, <vscale x 2 x float>)
declare <vscale x 4 x float> @llvm.masked.load.nxv4f32.p0(ptr, i32, <vscale x 4 x i1>, <vscale x 4 x float>)
declare <vscale x 2 x double> @llvm.masked.load.nxv2f64.p0(ptr, i32, <vscale x 2 x i1>, <vscale x 2 x double>)