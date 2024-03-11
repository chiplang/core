; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfhmin,+zvfhmin,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfhmin,+zvfhmin,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN

define <vscale x 1 x half> @vfdiv_vv_nxv1f16(<vscale x 1 x half> %va, <vscale x 1 x half> %vb) {
; ZVFH-LABEL: vfdiv_vv_nxv1f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; ZVFH-NEXT:    vfdiv.vv v8, v8, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vv_nxv1f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v9, v9, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %vc = fdiv <vscale x 1 x half> %va, %vb
  ret <vscale x 1 x half> %vc
}

define <vscale x 1 x half> @vfdiv_vf_nxv1f16(<vscale x 1 x half> %va, half %b) {
; ZVFH-LABEL: vfdiv_vf_nxv1f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; ZVFH-NEXT:    vfdiv.vf v8, v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vf_nxv1f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v9, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v9, v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 1 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 1 x half> %head, <vscale x 1 x half> poison, <vscale x 1 x i32> zeroinitializer
  %vc = fdiv <vscale x 1 x half> %va, %splat
  ret <vscale x 1 x half> %vc
}

define <vscale x 2 x half> @vfdiv_vv_nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x half> %vb) {
; ZVFH-LABEL: vfdiv_vv_nxv2f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFH-NEXT:    vfdiv.vv v8, v8, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vv_nxv2f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v9, v9, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %vc = fdiv <vscale x 2 x half> %va, %vb
  ret <vscale x 2 x half> %vc
}

define <vscale x 2 x half> @vfdiv_vf_nxv2f16(<vscale x 2 x half> %va, half %b) {
; ZVFH-LABEL: vfdiv_vf_nxv2f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFH-NEXT:    vfdiv.vf v8, v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vf_nxv2f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v9, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v9, v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 2 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 2 x half> %head, <vscale x 2 x half> poison, <vscale x 2 x i32> zeroinitializer
  %vc = fdiv <vscale x 2 x half> %va, %splat
  ret <vscale x 2 x half> %vc
}

define <vscale x 4 x half> @vfdiv_vv_nxv4f16(<vscale x 4 x half> %va, <vscale x 4 x half> %vb) {
; ZVFH-LABEL: vfdiv_vv_nxv4f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; ZVFH-NEXT:    vfdiv.vv v8, v8, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vv_nxv4f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v10, v12, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %vc = fdiv <vscale x 4 x half> %va, %vb
  ret <vscale x 4 x half> %vc
}

define <vscale x 4 x half> @vfdiv_vf_nxv4f16(<vscale x 4 x half> %va, half %b) {
; ZVFH-LABEL: vfdiv_vf_nxv4f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; ZVFH-NEXT:    vfdiv.vf v8, v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vf_nxv4f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v10, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v9, v10
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v9
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v10, v10, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 4 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 4 x half> %head, <vscale x 4 x half> poison, <vscale x 4 x i32> zeroinitializer
  %vc = fdiv <vscale x 4 x half> %va, %splat
  ret <vscale x 4 x half> %vc
}

define <vscale x 8 x half> @vfdiv_vv_nxv8f16(<vscale x 8 x half> %va, <vscale x 8 x half> %vb) {
; ZVFH-LABEL: vfdiv_vv_nxv8f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; ZVFH-NEXT:    vfdiv.vv v8, v8, v10
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vv_nxv8f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v10
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v12, v16, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %vc = fdiv <vscale x 8 x half> %va, %vb
  ret <vscale x 8 x half> %vc
}

define <vscale x 8 x half> @vfdiv_vf_nxv8f16(<vscale x 8 x half> %va, half %b) {
; ZVFH-LABEL: vfdiv_vf_nxv8f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; ZVFH-NEXT:    vfdiv.vf v8, v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vf_nxv8f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v12, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v10, v12
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v12, v12, v16
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 8 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 8 x half> %head, <vscale x 8 x half> poison, <vscale x 8 x i32> zeroinitializer
  %vc = fdiv <vscale x 8 x half> %va, %splat
  ret <vscale x 8 x half> %vc
}

define <vscale x 8 x half> @vfdiv_fv_nxv8f16(<vscale x 8 x half> %va, half %b) {
; ZVFH-LABEL: vfdiv_fv_nxv8f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; ZVFH-NEXT:    vfrdiv.vf v8, v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_fv_nxv8f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v12, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v10, v12
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v12, v16, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 8 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 8 x half> %head, <vscale x 8 x half> poison, <vscale x 8 x i32> zeroinitializer
  %vc = fdiv <vscale x 8 x half> %splat, %va
  ret <vscale x 8 x half> %vc
}

define <vscale x 16 x half> @vfdiv_vv_nxv16f16(<vscale x 16 x half> %va, <vscale x 16 x half> %vb) {
; ZVFH-LABEL: vfdiv_vv_nxv16f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFH-NEXT:    vfdiv.vv v8, v8, v12
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vv_nxv16f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v12
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v16, v24, v16
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    ret
  %vc = fdiv <vscale x 16 x half> %va, %vb
  ret <vscale x 16 x half> %vc
}

define <vscale x 16 x half> @vfdiv_vf_nxv16f16(<vscale x 16 x half> %va, half %b) {
; ZVFH-LABEL: vfdiv_vf_nxv16f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFH-NEXT:    vfdiv.vf v8, v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vf_nxv16f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v16, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v12, v16
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v16, v16, v24
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 16 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 16 x half> %head, <vscale x 16 x half> poison, <vscale x 16 x i32> zeroinitializer
  %vc = fdiv <vscale x 16 x half> %va, %splat
  ret <vscale x 16 x half> %vc
}

define <vscale x 32 x half> @vfdiv_vv_nxv32f16(<vscale x 32 x half> %va, <vscale x 32 x half> %vb) {
; ZVFH-LABEL: vfdiv_vv_nxv32f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m8, ta, ma
; ZVFH-NEXT:    vfdiv.vv v8, v8, v16
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vv_nxv32f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v16
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v0, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v24, v0, v24
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v24
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v20
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v16, v16, v24
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v12, v16
; ZVFHMIN-NEXT:    ret
  %vc = fdiv <vscale x 32 x half> %va, %vb
  ret <vscale x 32 x half> %vc
}

define <vscale x 32 x half> @vfdiv_vf_nxv32f16(<vscale x 32 x half> %va, half %b) {
; ZVFH-LABEL: vfdiv_vf_nxv32f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m8, ta, ma
; ZVFH-NEXT:    vfdiv.vf v8, v8, fa0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfdiv_vf_nxv32f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v16, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v24, v16
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v0, v24
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v16, v16, v0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfdiv.vv v16, v16, v0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v12, v16
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 32 x half> poison, half %b, i32 0
  %splat = shufflevector <vscale x 32 x half> %head, <vscale x 32 x half> poison, <vscale x 32 x i32> zeroinitializer
  %vc = fdiv <vscale x 32 x half> %va, %splat
  ret <vscale x 32 x half> %vc
}

define <vscale x 1 x float> @vfdiv_vv_nxv1f32(<vscale x 1 x float> %va, <vscale x 1 x float> %vb) {
; CHECK-LABEL: vfdiv_vv_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %vc = fdiv <vscale x 1 x float> %va, %vb
  ret <vscale x 1 x float> %vc
}

define <vscale x 1 x float> @vfdiv_vf_nxv1f32(<vscale x 1 x float> %va, float %b) {
; CHECK-LABEL: vfdiv_vf_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x float> poison, float %b, i32 0
  %splat = shufflevector <vscale x 1 x float> %head, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %vc = fdiv <vscale x 1 x float> %va, %splat
  ret <vscale x 1 x float> %vc
}

define <vscale x 2 x float> @vfdiv_vv_nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x float> %vb) {
; CHECK-LABEL: vfdiv_vv_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %vc = fdiv <vscale x 2 x float> %va, %vb
  ret <vscale x 2 x float> %vc
}

define <vscale x 2 x float> @vfdiv_vf_nxv2f32(<vscale x 2 x float> %va, float %b) {
; CHECK-LABEL: vfdiv_vf_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x float> poison, float %b, i32 0
  %splat = shufflevector <vscale x 2 x float> %head, <vscale x 2 x float> poison, <vscale x 2 x i32> zeroinitializer
  %vc = fdiv <vscale x 2 x float> %va, %splat
  ret <vscale x 2 x float> %vc
}

define <vscale x 4 x float> @vfdiv_vv_nxv4f32(<vscale x 4 x float> %va, <vscale x 4 x float> %vb) {
; CHECK-LABEL: vfdiv_vv_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v10
; CHECK-NEXT:    ret
  %vc = fdiv <vscale x 4 x float> %va, %vb
  ret <vscale x 4 x float> %vc
}

define <vscale x 4 x float> @vfdiv_vf_nxv4f32(<vscale x 4 x float> %va, float %b) {
; CHECK-LABEL: vfdiv_vf_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x float> poison, float %b, i32 0
  %splat = shufflevector <vscale x 4 x float> %head, <vscale x 4 x float> poison, <vscale x 4 x i32> zeroinitializer
  %vc = fdiv <vscale x 4 x float> %va, %splat
  ret <vscale x 4 x float> %vc
}

define <vscale x 8 x float> @vfdiv_vv_nxv8f32(<vscale x 8 x float> %va, <vscale x 8 x float> %vb) {
; CHECK-LABEL: vfdiv_vv_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v12
; CHECK-NEXT:    ret
  %vc = fdiv <vscale x 8 x float> %va, %vb
  ret <vscale x 8 x float> %vc
}

define <vscale x 8 x float> @vfdiv_vf_nxv8f32(<vscale x 8 x float> %va, float %b) {
; CHECK-LABEL: vfdiv_vf_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x float> poison, float %b, i32 0
  %splat = shufflevector <vscale x 8 x float> %head, <vscale x 8 x float> poison, <vscale x 8 x i32> zeroinitializer
  %vc = fdiv <vscale x 8 x float> %va, %splat
  ret <vscale x 8 x float> %vc
}

define <vscale x 8 x float> @vfdiv_fv_nxv8f32(<vscale x 8 x float> %va, float %b) {
; CHECK-LABEL: vfdiv_fv_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vfrdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x float> poison, float %b, i32 0
  %splat = shufflevector <vscale x 8 x float> %head, <vscale x 8 x float> poison, <vscale x 8 x i32> zeroinitializer
  %vc = fdiv <vscale x 8 x float> %splat, %va
  ret <vscale x 8 x float> %vc
}

define <vscale x 16 x float> @vfdiv_vv_nxv16f32(<vscale x 16 x float> %va, <vscale x 16 x float> %vb) {
; CHECK-LABEL: vfdiv_vv_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v16
; CHECK-NEXT:    ret
  %vc = fdiv <vscale x 16 x float> %va, %vb
  ret <vscale x 16 x float> %vc
}

define <vscale x 16 x float> @vfdiv_vf_nxv16f32(<vscale x 16 x float> %va, float %b) {
; CHECK-LABEL: vfdiv_vf_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x float> poison, float %b, i32 0
  %splat = shufflevector <vscale x 16 x float> %head, <vscale x 16 x float> poison, <vscale x 16 x i32> zeroinitializer
  %vc = fdiv <vscale x 16 x float> %va, %splat
  ret <vscale x 16 x float> %vc
}

define <vscale x 1 x double> @vfdiv_vv_nxv1f64(<vscale x 1 x double> %va, <vscale x 1 x double> %vb) {
; CHECK-LABEL: vfdiv_vv_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v9
; CHECK-NEXT:    ret
  %vc = fdiv <vscale x 1 x double> %va, %vb
  ret <vscale x 1 x double> %vc
}

define <vscale x 1 x double> @vfdiv_vf_nxv1f64(<vscale x 1 x double> %va, double %b) {
; CHECK-LABEL: vfdiv_vf_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x double> poison, double %b, i32 0
  %splat = shufflevector <vscale x 1 x double> %head, <vscale x 1 x double> poison, <vscale x 1 x i32> zeroinitializer
  %vc = fdiv <vscale x 1 x double> %va, %splat
  ret <vscale x 1 x double> %vc
}

define <vscale x 2 x double> @vfdiv_vv_nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x double> %vb) {
; CHECK-LABEL: vfdiv_vv_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v10
; CHECK-NEXT:    ret
  %vc = fdiv <vscale x 2 x double> %va, %vb
  ret <vscale x 2 x double> %vc
}

define <vscale x 2 x double> @vfdiv_vf_nxv2f64(<vscale x 2 x double> %va, double %b) {
; CHECK-LABEL: vfdiv_vf_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x double> poison, double %b, i32 0
  %splat = shufflevector <vscale x 2 x double> %head, <vscale x 2 x double> poison, <vscale x 2 x i32> zeroinitializer
  %vc = fdiv <vscale x 2 x double> %va, %splat
  ret <vscale x 2 x double> %vc
}

define <vscale x 4 x double> @vfdiv_vv_nxv4f64(<vscale x 4 x double> %va, <vscale x 4 x double> %vb) {
; CHECK-LABEL: vfdiv_vv_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v12
; CHECK-NEXT:    ret
  %vc = fdiv <vscale x 4 x double> %va, %vb
  ret <vscale x 4 x double> %vc
}

define <vscale x 4 x double> @vfdiv_vf_nxv4f64(<vscale x 4 x double> %va, double %b) {
; CHECK-LABEL: vfdiv_vf_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x double> poison, double %b, i32 0
  %splat = shufflevector <vscale x 4 x double> %head, <vscale x 4 x double> poison, <vscale x 4 x i32> zeroinitializer
  %vc = fdiv <vscale x 4 x double> %va, %splat
  ret <vscale x 4 x double> %vc
}

define <vscale x 8 x double> @vfdiv_vv_nxv8f64(<vscale x 8 x double> %va, <vscale x 8 x double> %vb) {
; CHECK-LABEL: vfdiv_vv_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vfdiv.vv v8, v8, v16
; CHECK-NEXT:    ret
  %vc = fdiv <vscale x 8 x double> %va, %vb
  ret <vscale x 8 x double> %vc
}

define <vscale x 8 x double> @vfdiv_vf_nxv8f64(<vscale x 8 x double> %va, double %b) {
; CHECK-LABEL: vfdiv_vf_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vfdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x double> poison, double %b, i32 0
  %splat = shufflevector <vscale x 8 x double> %head, <vscale x 8 x double> poison, <vscale x 8 x i32> zeroinitializer
  %vc = fdiv <vscale x 8 x double> %va, %splat
  ret <vscale x 8 x double> %vc
}

define <vscale x 8 x double> @vfdiv_fv_nxv8f64(<vscale x 8 x double> %va, double %b) {
; CHECK-LABEL: vfdiv_fv_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vfrdiv.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x double> poison, double %b, i32 0
  %splat = shufflevector <vscale x 8 x double> %head, <vscale x 8 x double> poison, <vscale x 8 x i32> zeroinitializer
  %vc = fdiv <vscale x 8 x double> %splat, %va
  ret <vscale x 8 x double> %vc
}

define <vscale x 8 x float> @vfdiv_vv_mask_nxv8f32(<vscale x 8 x float> %va, <vscale x 8 x float> %vb, <vscale x 8 x i1> %mask) {
; CHECK-LABEL: vfdiv_vv_mask_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vmv.v.i v16, 0
; CHECK-NEXT:    vmerge.vvm v12, v16, v12, v0
; CHECK-NEXT:    vfdiv.vv v8, v8, v12
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x float> poison, float 0.0, i32 0
  %splat = shufflevector <vscale x 8 x float> %head, <vscale x 8 x float> poison, <vscale x 8 x i32> zeroinitializer
  %vs = select <vscale x 8 x i1> %mask, <vscale x 8 x float> %vb, <vscale x 8 x float> %splat
  %vc = fdiv <vscale x 8 x float> %va, %vs
  ret <vscale x 8 x float> %vc
}

define <vscale x 8 x float> @vfdiv_vf_mask_nxv8f32(<vscale x 8 x float> %va, float %b, <vscale x 8 x i1> %mask) {
; CHECK-LABEL: vfdiv_vf_mask_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vmv.v.i v12, 0
; CHECK-NEXT:    vfmerge.vfm v12, v12, fa0, v0
; CHECK-NEXT:    vfdiv.vv v8, v8, v12
; CHECK-NEXT:    ret
  %head0 = insertelement <vscale x 8 x float> poison, float 0.0, i32 0
  %splat0 = shufflevector <vscale x 8 x float> %head0, <vscale x 8 x float> poison, <vscale x 8 x i32> zeroinitializer
  %head1 = insertelement <vscale x 8 x float> poison, float %b, i32 0
  %splat1 = shufflevector <vscale x 8 x float> %head1, <vscale x 8 x float> poison, <vscale x 8 x i32> zeroinitializer
  %vs = select <vscale x 8 x i1> %mask, <vscale x 8 x float> %splat1, <vscale x 8 x float> %splat0
  %vc = fdiv <vscale x 8 x float> %va, %vs
  ret <vscale x 8 x float> %vc
}
