; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v -target-abi=ilp32d \
; RUN:   -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v -target-abi=lp64d \
; RUN:   -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfhmin,+v -target-abi=ilp32d \
; RUN:   -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfhmin,+v -target-abi=lp64d \
; RUN:   -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN

declare <2 x half> @llvm.vp.sqrt.v2f16(<2 x half>, <2 x i1>, i32)

define <2 x half> @vfsqrt_vv_v2f16(<2 x half> %va, <2 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_v2f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_v2f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v9, v9, v0.t
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <2 x half> @llvm.vp.sqrt.v2f16(<2 x half> %va, <2 x i1> %m, i32 %evl)
  ret <2 x half> %v
}

define <2 x half> @vfsqrt_vv_v2f16_unmasked(<2 x half> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_v2f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_v2f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v9, v9
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %head = insertelement <2 x i1> poison, i1 true, i32 0
  %m = shufflevector <2 x i1> %head, <2 x i1> poison, <2 x i32> zeroinitializer
  %v = call <2 x half> @llvm.vp.sqrt.v2f16(<2 x half> %va, <2 x i1> %m, i32 %evl)
  ret <2 x half> %v
}

declare <4 x half> @llvm.vp.sqrt.v4f16(<4 x half>, <4 x i1>, i32)

define <4 x half> @vfsqrt_vv_v4f16(<4 x half> %va, <4 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_v4f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_v4f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v9, v9, v0.t
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <4 x half> @llvm.vp.sqrt.v4f16(<4 x half> %va, <4 x i1> %m, i32 %evl)
  ret <4 x half> %v
}

define <4 x half> @vfsqrt_vv_v4f16_unmasked(<4 x half> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_v4f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_v4f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v9, v9
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %head = insertelement <4 x i1> poison, i1 true, i32 0
  %m = shufflevector <4 x i1> %head, <4 x i1> poison, <4 x i32> zeroinitializer
  %v = call <4 x half> @llvm.vp.sqrt.v4f16(<4 x half> %va, <4 x i1> %m, i32 %evl)
  ret <4 x half> %v
}

declare <8 x half> @llvm.vp.sqrt.v8f16(<8 x half>, <8 x i1>, i32)

define <8 x half> @vfsqrt_vv_v8f16(<8 x half> %va, <8 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_v8f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_v8f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v10, v10, v0.t
; ZVFHMIN-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %v = call <8 x half> @llvm.vp.sqrt.v8f16(<8 x half> %va, <8 x i1> %m, i32 %evl)
  ret <8 x half> %v
}

define <8 x half> @vfsqrt_vv_v8f16_unmasked(<8 x half> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_v8f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_v8f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v10, v10
; ZVFHMIN-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %head = insertelement <8 x i1> poison, i1 true, i32 0
  %m = shufflevector <8 x i1> %head, <8 x i1> poison, <8 x i32> zeroinitializer
  %v = call <8 x half> @llvm.vp.sqrt.v8f16(<8 x half> %va, <8 x i1> %m, i32 %evl)
  ret <8 x half> %v
}

declare <16 x half> @llvm.vp.sqrt.v16f16(<16 x half>, <16 x i1>, i32)

define <16 x half> @vfsqrt_vv_v16f16(<16 x half> %va, <16 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_v16f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_v16f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v12, v12, v0.t
; ZVFHMIN-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %v = call <16 x half> @llvm.vp.sqrt.v16f16(<16 x half> %va, <16 x i1> %m, i32 %evl)
  ret <16 x half> %v
}

define <16 x half> @vfsqrt_vv_v16f16_unmasked(<16 x half> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_v16f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_v16f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v12, v12
; ZVFHMIN-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %head = insertelement <16 x i1> poison, i1 true, i32 0
  %m = shufflevector <16 x i1> %head, <16 x i1> poison, <16 x i32> zeroinitializer
  %v = call <16 x half> @llvm.vp.sqrt.v16f16(<16 x half> %va, <16 x i1> %m, i32 %evl)
  ret <16 x half> %v
}

declare <2 x float> @llvm.vp.sqrt.v2f32(<2 x float>, <2 x i1>, i32)

define <2 x float> @vfsqrt_vv_v2f32(<2 x float> %va, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <2 x float> @llvm.vp.sqrt.v2f32(<2 x float> %va, <2 x i1> %m, i32 %evl)
  ret <2 x float> %v
}

define <2 x float> @vfsqrt_vv_v2f32_unmasked(<2 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v2f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <2 x i1> poison, i1 true, i32 0
  %m = shufflevector <2 x i1> %head, <2 x i1> poison, <2 x i32> zeroinitializer
  %v = call <2 x float> @llvm.vp.sqrt.v2f32(<2 x float> %va, <2 x i1> %m, i32 %evl)
  ret <2 x float> %v
}

declare <4 x float> @llvm.vp.sqrt.v4f32(<4 x float>, <4 x i1>, i32)

define <4 x float> @vfsqrt_vv_v4f32(<4 x float> %va, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <4 x float> @llvm.vp.sqrt.v4f32(<4 x float> %va, <4 x i1> %m, i32 %evl)
  ret <4 x float> %v
}

define <4 x float> @vfsqrt_vv_v4f32_unmasked(<4 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v4f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <4 x i1> poison, i1 true, i32 0
  %m = shufflevector <4 x i1> %head, <4 x i1> poison, <4 x i32> zeroinitializer
  %v = call <4 x float> @llvm.vp.sqrt.v4f32(<4 x float> %va, <4 x i1> %m, i32 %evl)
  ret <4 x float> %v
}

declare <8 x float> @llvm.vp.sqrt.v8f32(<8 x float>, <8 x i1>, i32)

define <8 x float> @vfsqrt_vv_v8f32(<8 x float> %va, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <8 x float> @llvm.vp.sqrt.v8f32(<8 x float> %va, <8 x i1> %m, i32 %evl)
  ret <8 x float> %v
}

define <8 x float> @vfsqrt_vv_v8f32_unmasked(<8 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v8f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <8 x i1> poison, i1 true, i32 0
  %m = shufflevector <8 x i1> %head, <8 x i1> poison, <8 x i32> zeroinitializer
  %v = call <8 x float> @llvm.vp.sqrt.v8f32(<8 x float> %va, <8 x i1> %m, i32 %evl)
  ret <8 x float> %v
}

declare <16 x float> @llvm.vp.sqrt.v16f32(<16 x float>, <16 x i1>, i32)

define <16 x float> @vfsqrt_vv_v16f32(<16 x float> %va, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <16 x float> @llvm.vp.sqrt.v16f32(<16 x float> %va, <16 x i1> %m, i32 %evl)
  ret <16 x float> %v
}

define <16 x float> @vfsqrt_vv_v16f32_unmasked(<16 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v16f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <16 x i1> poison, i1 true, i32 0
  %m = shufflevector <16 x i1> %head, <16 x i1> poison, <16 x i32> zeroinitializer
  %v = call <16 x float> @llvm.vp.sqrt.v16f32(<16 x float> %va, <16 x i1> %m, i32 %evl)
  ret <16 x float> %v
}

declare <2 x double> @llvm.vp.sqrt.v2f64(<2 x double>, <2 x i1>, i32)

define <2 x double> @vfsqrt_vv_v2f64(<2 x double> %va, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <2 x double> @llvm.vp.sqrt.v2f64(<2 x double> %va, <2 x i1> %m, i32 %evl)
  ret <2 x double> %v
}

define <2 x double> @vfsqrt_vv_v2f64_unmasked(<2 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v2f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <2 x i1> poison, i1 true, i32 0
  %m = shufflevector <2 x i1> %head, <2 x i1> poison, <2 x i32> zeroinitializer
  %v = call <2 x double> @llvm.vp.sqrt.v2f64(<2 x double> %va, <2 x i1> %m, i32 %evl)
  ret <2 x double> %v
}

declare <4 x double> @llvm.vp.sqrt.v4f64(<4 x double>, <4 x i1>, i32)

define <4 x double> @vfsqrt_vv_v4f64(<4 x double> %va, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <4 x double> @llvm.vp.sqrt.v4f64(<4 x double> %va, <4 x i1> %m, i32 %evl)
  ret <4 x double> %v
}

define <4 x double> @vfsqrt_vv_v4f64_unmasked(<4 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v4f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <4 x i1> poison, i1 true, i32 0
  %m = shufflevector <4 x i1> %head, <4 x i1> poison, <4 x i32> zeroinitializer
  %v = call <4 x double> @llvm.vp.sqrt.v4f64(<4 x double> %va, <4 x i1> %m, i32 %evl)
  ret <4 x double> %v
}

declare <8 x double> @llvm.vp.sqrt.v8f64(<8 x double>, <8 x i1>, i32)

define <8 x double> @vfsqrt_vv_v8f64(<8 x double> %va, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <8 x double> @llvm.vp.sqrt.v8f64(<8 x double> %va, <8 x i1> %m, i32 %evl)
  ret <8 x double> %v
}

define <8 x double> @vfsqrt_vv_v8f64_unmasked(<8 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v8f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <8 x i1> poison, i1 true, i32 0
  %m = shufflevector <8 x i1> %head, <8 x i1> poison, <8 x i32> zeroinitializer
  %v = call <8 x double> @llvm.vp.sqrt.v8f64(<8 x double> %va, <8 x i1> %m, i32 %evl)
  ret <8 x double> %v
}

declare <15 x double> @llvm.vp.sqrt.v15f64(<15 x double>, <15 x i1>, i32)

define <15 x double> @vfsqrt_vv_v15f64(<15 x double> %va, <15 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v15f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <15 x double> @llvm.vp.sqrt.v15f64(<15 x double> %va, <15 x i1> %m, i32 %evl)
  ret <15 x double> %v
}

define <15 x double> @vfsqrt_vv_v15f64_unmasked(<15 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v15f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <15 x i1> poison, i1 true, i32 0
  %m = shufflevector <15 x i1> %head, <15 x i1> poison, <15 x i32> zeroinitializer
  %v = call <15 x double> @llvm.vp.sqrt.v15f64(<15 x double> %va, <15 x i1> %m, i32 %evl)
  ret <15 x double> %v
}

declare <16 x double> @llvm.vp.sqrt.v16f64(<16 x double>, <16 x i1>, i32)

define <16 x double> @vfsqrt_vv_v16f64(<16 x double> %va, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v16f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <16 x double> @llvm.vp.sqrt.v16f64(<16 x double> %va, <16 x i1> %m, i32 %evl)
  ret <16 x double> %v
}

define <16 x double> @vfsqrt_vv_v16f64_unmasked(<16 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v16f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <16 x i1> poison, i1 true, i32 0
  %m = shufflevector <16 x i1> %head, <16 x i1> poison, <16 x i32> zeroinitializer
  %v = call <16 x double> @llvm.vp.sqrt.v16f64(<16 x double> %va, <16 x i1> %m, i32 %evl)
  ret <16 x double> %v
}

declare <32 x double> @llvm.vp.sqrt.v32f64(<32 x double>, <32 x i1>, i32)

define <32 x double> @vfsqrt_vv_v32f64(<32 x double> %va, <32 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v32f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf4, ta, ma
; CHECK-NEXT:    li a2, 16
; CHECK-NEXT:    vslidedown.vi v24, v0, 2
; CHECK-NEXT:    mv a1, a0
; CHECK-NEXT:    bltu a0, a2, .LBB26_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    li a1, 16
; CHECK-NEXT:  .LBB26_2:
; CHECK-NEXT:    vsetvli zero, a1, e64, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    addi a1, a0, -16
; CHECK-NEXT:    sltu a0, a0, a1
; CHECK-NEXT:    addi a0, a0, -1
; CHECK-NEXT:    and a0, a0, a1
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    vfsqrt.v v16, v16, v0.t
; CHECK-NEXT:    ret
  %v = call <32 x double> @llvm.vp.sqrt.v32f64(<32 x double> %va, <32 x i1> %m, i32 %evl)
  ret <32 x double> %v
}

define <32 x double> @vfsqrt_vv_v32f64_unmasked(<32 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_v32f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a2, 16
; CHECK-NEXT:    mv a1, a0
; CHECK-NEXT:    bltu a0, a2, .LBB27_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    li a1, 16
; CHECK-NEXT:  .LBB27_2:
; CHECK-NEXT:    vsetvli zero, a1, e64, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    addi a1, a0, -16
; CHECK-NEXT:    sltu a0, a0, a1
; CHECK-NEXT:    addi a0, a0, -1
; CHECK-NEXT:    and a0, a0, a1
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v16, v16
; CHECK-NEXT:    ret
  %head = insertelement <32 x i1> poison, i1 true, i32 0
  %m = shufflevector <32 x i1> %head, <32 x i1> poison, <32 x i32> zeroinitializer
  %v = call <32 x double> @llvm.vp.sqrt.v32f64(<32 x double> %va, <32 x i1> %m, i32 %evl)
  ret <32 x double> %v
}
