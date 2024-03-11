; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=aarch64 -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-SD,CHECK-SD-NOFP16
; RUN: llc -mtriple=aarch64 -mattr=+fullfp16 -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-SD,CHECK-SD-FP16
; RUN: llc -mtriple=aarch64 -global-isel -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-GI,CHECK-GI-NOFP16
; RUN: llc -mtriple=aarch64 -mattr=+fullfp16 -global-isel -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-GI,CHECK-GI-FP16

define double @fadd_f64(double %a, double %b) {
; CHECK-LABEL: fadd_f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fadd d0, d0, d1
; CHECK-NEXT:    ret
entry:
  %c = fadd double %a, %b
  ret double %c
}

define float @fadd_f32(float %a, float %b) {
; CHECK-LABEL: fadd_f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fadd s0, s0, s1
; CHECK-NEXT:    ret
entry:
  %c = fadd float %a, %b
  ret float %c
}

define half @fadd_f16(half %a, half %b) {
; CHECK-SD-NOFP16-LABEL: fadd_f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    fcvt s1, h1
; CHECK-SD-NOFP16-NEXT:    fcvt s0, h0
; CHECK-SD-NOFP16-NEXT:    fadd s0, s0, s1
; CHECK-SD-NOFP16-NEXT:    fcvt h0, s0
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fadd_f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fadd h0, h0, h1
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fadd_f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    fcvt s0, h0
; CHECK-GI-NOFP16-NEXT:    fcvt s1, h1
; CHECK-GI-NOFP16-NEXT:    fadd s0, s0, s1
; CHECK-GI-NOFP16-NEXT:    fcvt h0, s0
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fadd_f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fadd h0, h0, h1
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fadd half %a, %b
  ret half %c
}

define <2 x double> @fadd_v2f64(<2 x double> %a, <2 x double> %b) {
; CHECK-LABEL: fadd_v2f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fadd v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    ret
entry:
  %c = fadd <2 x double> %a, %b
  ret <2 x double> %c
}

define <3 x double> @fadd_v3f64(<3 x double> %a, <3 x double> %b) {
; CHECK-SD-LABEL: fadd_v3f64:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    // kill: def $d3 killed $d3 def $q3
; CHECK-SD-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-SD-NEXT:    // kill: def $d4 killed $d4 def $q4
; CHECK-SD-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-SD-NEXT:    // kill: def $d2 killed $d2 def $q2
; CHECK-SD-NEXT:    // kill: def $d5 killed $d5 def $q5
; CHECK-SD-NEXT:    mov v3.d[1], v4.d[0]
; CHECK-SD-NEXT:    mov v0.d[1], v1.d[0]
; CHECK-SD-NEXT:    fadd v2.2d, v2.2d, v5.2d
; CHECK-SD-NEXT:    // kill: def $d2 killed $d2 killed $q2
; CHECK-SD-NEXT:    fadd v0.2d, v0.2d, v3.2d
; CHECK-SD-NEXT:    ext v1.16b, v0.16b, v0.16b, #8
; CHECK-SD-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-SD-NEXT:    // kill: def $d1 killed $d1 killed $q1
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: fadd_v3f64:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-GI-NEXT:    // kill: def $d3 killed $d3 def $q3
; CHECK-GI-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-GI-NEXT:    // kill: def $d4 killed $d4 def $q4
; CHECK-GI-NEXT:    fadd d2, d2, d5
; CHECK-GI-NEXT:    mov v0.d[1], v1.d[0]
; CHECK-GI-NEXT:    mov v3.d[1], v4.d[0]
; CHECK-GI-NEXT:    fadd v0.2d, v0.2d, v3.2d
; CHECK-GI-NEXT:    mov d1, v0.d[1]
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
entry:
  %c = fadd <3 x double> %a, %b
  ret <3 x double> %c
}

define <4 x double> @fadd_v4f64(<4 x double> %a, <4 x double> %b) {
; CHECK-SD-LABEL: fadd_v4f64:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    fadd v1.2d, v1.2d, v3.2d
; CHECK-SD-NEXT:    fadd v0.2d, v0.2d, v2.2d
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: fadd_v4f64:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    fadd v0.2d, v0.2d, v2.2d
; CHECK-GI-NEXT:    fadd v1.2d, v1.2d, v3.2d
; CHECK-GI-NEXT:    ret
entry:
  %c = fadd <4 x double> %a, %b
  ret <4 x double> %c
}

define <2 x float> @fadd_v2f32(<2 x float> %a, <2 x float> %b) {
; CHECK-LABEL: fadd_v2f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fadd v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
entry:
  %c = fadd <2 x float> %a, %b
  ret <2 x float> %c
}

define <3 x float> @fadd_v3f32(<3 x float> %a, <3 x float> %b) {
; CHECK-LABEL: fadd_v3f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fadd v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
entry:
  %c = fadd <3 x float> %a, %b
  ret <3 x float> %c
}

define <4 x float> @fadd_v4f32(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: fadd_v4f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fadd v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
entry:
  %c = fadd <4 x float> %a, %b
  ret <4 x float> %c
}

define <8 x float> @fadd_v8f32(<8 x float> %a, <8 x float> %b) {
; CHECK-SD-LABEL: fadd_v8f32:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    fadd v1.4s, v1.4s, v3.4s
; CHECK-SD-NEXT:    fadd v0.4s, v0.4s, v2.4s
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: fadd_v8f32:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    fadd v0.4s, v0.4s, v2.4s
; CHECK-GI-NEXT:    fadd v1.4s, v1.4s, v3.4s
; CHECK-GI-NEXT:    ret
entry:
  %c = fadd <8 x float> %a, %b
  ret <8 x float> %c
}

define <7 x half> @fadd_v7f16(<7 x half> %a, <7 x half> %b) {
; CHECK-SD-NOFP16-LABEL: fadd_v7f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    fcvtl v2.4s, v1.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl v3.4s, v0.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl2 v1.4s, v1.8h
; CHECK-SD-NOFP16-NEXT:    fcvtl2 v0.4s, v0.8h
; CHECK-SD-NOFP16-NEXT:    fadd v2.4s, v3.4s, v2.4s
; CHECK-SD-NOFP16-NEXT:    fadd v1.4s, v0.4s, v1.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn v0.4h, v2.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn2 v0.8h, v1.4s
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fadd_v7f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fadd v0.8h, v0.8h, v1.8h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fadd_v7f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    mov h2, v0.h[4]
; CHECK-GI-NOFP16-NEXT:    mov h3, v0.h[5]
; CHECK-GI-NOFP16-NEXT:    mov h4, v1.h[4]
; CHECK-GI-NOFP16-NEXT:    mov h5, v1.h[5]
; CHECK-GI-NOFP16-NEXT:    fcvtl v6.4s, v0.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v7.4s, v1.4h
; CHECK-GI-NOFP16-NEXT:    mov h0, v0.h[6]
; CHECK-GI-NOFP16-NEXT:    mov h1, v1.h[6]
; CHECK-GI-NOFP16-NEXT:    mov v2.h[1], v3.h[0]
; CHECK-GI-NOFP16-NEXT:    mov v4.h[1], v5.h[0]
; CHECK-GI-NOFP16-NEXT:    fadd v3.4s, v6.4s, v7.4s
; CHECK-GI-NOFP16-NEXT:    mov v2.h[2], v0.h[0]
; CHECK-GI-NOFP16-NEXT:    mov v4.h[2], v1.h[0]
; CHECK-GI-NOFP16-NEXT:    fcvtn v0.4h, v3.4s
; CHECK-GI-NOFP16-NEXT:    mov v2.h[3], v0.h[0]
; CHECK-GI-NOFP16-NEXT:    mov v4.h[3], v0.h[0]
; CHECK-GI-NOFP16-NEXT:    mov h1, v0.h[1]
; CHECK-GI-NOFP16-NEXT:    mov h5, v0.h[3]
; CHECK-GI-NOFP16-NEXT:    fcvtl v2.4s, v2.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v3.4s, v4.4h
; CHECK-GI-NOFP16-NEXT:    mov h4, v0.h[2]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[1], v1.h[0]
; CHECK-GI-NOFP16-NEXT:    fadd v1.4s, v2.4s, v3.4s
; CHECK-GI-NOFP16-NEXT:    mov v0.h[2], v4.h[0]
; CHECK-GI-NOFP16-NEXT:    fcvtn v1.4h, v1.4s
; CHECK-GI-NOFP16-NEXT:    mov v0.h[3], v5.h[0]
; CHECK-GI-NOFP16-NEXT:    mov h2, v1.h[1]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[4], v1.h[0]
; CHECK-GI-NOFP16-NEXT:    mov h1, v1.h[2]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[5], v2.h[0]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[6], v1.h[0]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[7], v0.h[0]
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fadd_v7f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fadd v0.8h, v0.8h, v1.8h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fadd <7 x half> %a, %b
  ret <7 x half> %c
}

define <4 x half> @fadd_v4f16(<4 x half> %a, <4 x half> %b) {
; CHECK-SD-NOFP16-LABEL: fadd_v4f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    fcvtl v1.4s, v1.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-SD-NOFP16-NEXT:    fadd v0.4s, v0.4s, v1.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fadd_v4f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fadd v0.4h, v0.4h, v1.4h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fadd_v4f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v1.4s, v1.4h
; CHECK-GI-NOFP16-NEXT:    fadd v0.4s, v0.4s, v1.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fadd_v4f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fadd v0.4h, v0.4h, v1.4h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fadd <4 x half> %a, %b
  ret <4 x half> %c
}

define <8 x half> @fadd_v8f16(<8 x half> %a, <8 x half> %b) {
; CHECK-SD-NOFP16-LABEL: fadd_v8f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    fcvtl v2.4s, v1.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl v3.4s, v0.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl2 v1.4s, v1.8h
; CHECK-SD-NOFP16-NEXT:    fcvtl2 v0.4s, v0.8h
; CHECK-SD-NOFP16-NEXT:    fadd v2.4s, v3.4s, v2.4s
; CHECK-SD-NOFP16-NEXT:    fadd v1.4s, v0.4s, v1.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn v0.4h, v2.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn2 v0.8h, v1.4s
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fadd_v8f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fadd v0.8h, v0.8h, v1.8h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fadd_v8f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    fcvtl v2.4s, v0.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v3.4s, v1.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v0.4s, v0.8h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v1.4s, v1.8h
; CHECK-GI-NOFP16-NEXT:    fadd v2.4s, v2.4s, v3.4s
; CHECK-GI-NOFP16-NEXT:    fadd v1.4s, v0.4s, v1.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn v0.4h, v2.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn2 v0.8h, v1.4s
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fadd_v8f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fadd v0.8h, v0.8h, v1.8h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fadd <8 x half> %a, %b
  ret <8 x half> %c
}

define <16 x half> @fadd_v16f16(<16 x half> %a, <16 x half> %b) {
; CHECK-SD-NOFP16-LABEL: fadd_v16f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    fcvtl v4.4s, v2.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl v5.4s, v0.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl v6.4s, v3.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl v7.4s, v1.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl2 v2.4s, v2.8h
; CHECK-SD-NOFP16-NEXT:    fcvtl2 v0.4s, v0.8h
; CHECK-SD-NOFP16-NEXT:    fcvtl2 v3.4s, v3.8h
; CHECK-SD-NOFP16-NEXT:    fcvtl2 v1.4s, v1.8h
; CHECK-SD-NOFP16-NEXT:    fadd v4.4s, v5.4s, v4.4s
; CHECK-SD-NOFP16-NEXT:    fadd v5.4s, v7.4s, v6.4s
; CHECK-SD-NOFP16-NEXT:    fadd v2.4s, v0.4s, v2.4s
; CHECK-SD-NOFP16-NEXT:    fadd v3.4s, v1.4s, v3.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn v0.4h, v4.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn v1.4h, v5.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn2 v0.8h, v2.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn2 v1.8h, v3.4s
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fadd_v16f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fadd v1.8h, v1.8h, v3.8h
; CHECK-SD-FP16-NEXT:    fadd v0.8h, v0.8h, v2.8h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fadd_v16f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    fcvtl v4.4s, v0.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v5.4s, v1.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v6.4s, v2.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v7.4s, v3.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v0.4s, v0.8h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v1.4s, v1.8h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v2.4s, v2.8h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v3.4s, v3.8h
; CHECK-GI-NOFP16-NEXT:    fadd v4.4s, v4.4s, v6.4s
; CHECK-GI-NOFP16-NEXT:    fadd v5.4s, v5.4s, v7.4s
; CHECK-GI-NOFP16-NEXT:    fadd v2.4s, v0.4s, v2.4s
; CHECK-GI-NOFP16-NEXT:    fadd v3.4s, v1.4s, v3.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn v0.4h, v4.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn v1.4h, v5.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn2 v0.8h, v2.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn2 v1.8h, v3.4s
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fadd_v16f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fadd v0.8h, v0.8h, v2.8h
; CHECK-GI-FP16-NEXT:    fadd v1.8h, v1.8h, v3.8h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fadd <16 x half> %a, %b
  ret <16 x half> %c
}

define double @fsub_f64(double %a, double %b) {
; CHECK-LABEL: fsub_f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fsub d0, d0, d1
; CHECK-NEXT:    ret
entry:
  %c = fsub double %a, %b
  ret double %c
}

define float @fsub_f32(float %a, float %b) {
; CHECK-LABEL: fsub_f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fsub s0, s0, s1
; CHECK-NEXT:    ret
entry:
  %c = fsub float %a, %b
  ret float %c
}

define half @fsub_f16(half %a, half %b) {
; CHECK-SD-NOFP16-LABEL: fsub_f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    fcvt s1, h1
; CHECK-SD-NOFP16-NEXT:    fcvt s0, h0
; CHECK-SD-NOFP16-NEXT:    fsub s0, s0, s1
; CHECK-SD-NOFP16-NEXT:    fcvt h0, s0
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fsub_f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fsub h0, h0, h1
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fsub_f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    fcvt s0, h0
; CHECK-GI-NOFP16-NEXT:    fcvt s1, h1
; CHECK-GI-NOFP16-NEXT:    fsub s0, s0, s1
; CHECK-GI-NOFP16-NEXT:    fcvt h0, s0
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fsub_f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fsub h0, h0, h1
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fsub half %a, %b
  ret half %c
}

define <2 x double> @fsub_v2f64(<2 x double> %a, <2 x double> %b) {
; CHECK-LABEL: fsub_v2f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fsub v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    ret
entry:
  %c = fsub <2 x double> %a, %b
  ret <2 x double> %c
}

define <3 x double> @fsub_v3f64(<3 x double> %a, <3 x double> %b) {
; CHECK-SD-LABEL: fsub_v3f64:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    // kill: def $d3 killed $d3 def $q3
; CHECK-SD-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-SD-NEXT:    // kill: def $d4 killed $d4 def $q4
; CHECK-SD-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-SD-NEXT:    // kill: def $d2 killed $d2 def $q2
; CHECK-SD-NEXT:    // kill: def $d5 killed $d5 def $q5
; CHECK-SD-NEXT:    mov v3.d[1], v4.d[0]
; CHECK-SD-NEXT:    mov v0.d[1], v1.d[0]
; CHECK-SD-NEXT:    fsub v2.2d, v2.2d, v5.2d
; CHECK-SD-NEXT:    // kill: def $d2 killed $d2 killed $q2
; CHECK-SD-NEXT:    fsub v0.2d, v0.2d, v3.2d
; CHECK-SD-NEXT:    ext v1.16b, v0.16b, v0.16b, #8
; CHECK-SD-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-SD-NEXT:    // kill: def $d1 killed $d1 killed $q1
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: fsub_v3f64:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-GI-NEXT:    // kill: def $d3 killed $d3 def $q3
; CHECK-GI-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-GI-NEXT:    // kill: def $d4 killed $d4 def $q4
; CHECK-GI-NEXT:    fsub d2, d2, d5
; CHECK-GI-NEXT:    mov v0.d[1], v1.d[0]
; CHECK-GI-NEXT:    mov v3.d[1], v4.d[0]
; CHECK-GI-NEXT:    fsub v0.2d, v0.2d, v3.2d
; CHECK-GI-NEXT:    mov d1, v0.d[1]
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
entry:
  %c = fsub <3 x double> %a, %b
  ret <3 x double> %c
}

define <4 x double> @fsub_v4f64(<4 x double> %a, <4 x double> %b) {
; CHECK-SD-LABEL: fsub_v4f64:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    fsub v1.2d, v1.2d, v3.2d
; CHECK-SD-NEXT:    fsub v0.2d, v0.2d, v2.2d
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: fsub_v4f64:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    fsub v0.2d, v0.2d, v2.2d
; CHECK-GI-NEXT:    fsub v1.2d, v1.2d, v3.2d
; CHECK-GI-NEXT:    ret
entry:
  %c = fsub <4 x double> %a, %b
  ret <4 x double> %c
}

define <2 x float> @fsub_v2f32(<2 x float> %a, <2 x float> %b) {
; CHECK-LABEL: fsub_v2f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fsub v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
entry:
  %c = fsub <2 x float> %a, %b
  ret <2 x float> %c
}

define <3 x float> @fsub_v3f32(<3 x float> %a, <3 x float> %b) {
; CHECK-LABEL: fsub_v3f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fsub v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
entry:
  %c = fsub <3 x float> %a, %b
  ret <3 x float> %c
}

define <4 x float> @fsub_v4f32(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: fsub_v4f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fsub v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
entry:
  %c = fsub <4 x float> %a, %b
  ret <4 x float> %c
}

define <8 x float> @fsub_v8f32(<8 x float> %a, <8 x float> %b) {
; CHECK-SD-LABEL: fsub_v8f32:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    fsub v1.4s, v1.4s, v3.4s
; CHECK-SD-NEXT:    fsub v0.4s, v0.4s, v2.4s
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: fsub_v8f32:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    fsub v0.4s, v0.4s, v2.4s
; CHECK-GI-NEXT:    fsub v1.4s, v1.4s, v3.4s
; CHECK-GI-NEXT:    ret
entry:
  %c = fsub <8 x float> %a, %b
  ret <8 x float> %c
}

define <7 x half> @fsub_v7f16(<7 x half> %a, <7 x half> %b) {
; CHECK-SD-NOFP16-LABEL: fsub_v7f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    fcvtl v2.4s, v1.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl v3.4s, v0.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl2 v1.4s, v1.8h
; CHECK-SD-NOFP16-NEXT:    fcvtl2 v0.4s, v0.8h
; CHECK-SD-NOFP16-NEXT:    fsub v2.4s, v3.4s, v2.4s
; CHECK-SD-NOFP16-NEXT:    fsub v1.4s, v0.4s, v1.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn v0.4h, v2.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn2 v0.8h, v1.4s
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fsub_v7f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fsub v0.8h, v0.8h, v1.8h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fsub_v7f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    mov h2, v0.h[4]
; CHECK-GI-NOFP16-NEXT:    mov h3, v0.h[5]
; CHECK-GI-NOFP16-NEXT:    mov h4, v1.h[4]
; CHECK-GI-NOFP16-NEXT:    mov h5, v1.h[5]
; CHECK-GI-NOFP16-NEXT:    fcvtl v6.4s, v0.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v7.4s, v1.4h
; CHECK-GI-NOFP16-NEXT:    mov h0, v0.h[6]
; CHECK-GI-NOFP16-NEXT:    mov h1, v1.h[6]
; CHECK-GI-NOFP16-NEXT:    mov v2.h[1], v3.h[0]
; CHECK-GI-NOFP16-NEXT:    mov v4.h[1], v5.h[0]
; CHECK-GI-NOFP16-NEXT:    fsub v3.4s, v6.4s, v7.4s
; CHECK-GI-NOFP16-NEXT:    mov v2.h[2], v0.h[0]
; CHECK-GI-NOFP16-NEXT:    mov v4.h[2], v1.h[0]
; CHECK-GI-NOFP16-NEXT:    fcvtn v0.4h, v3.4s
; CHECK-GI-NOFP16-NEXT:    mov v2.h[3], v0.h[0]
; CHECK-GI-NOFP16-NEXT:    mov v4.h[3], v0.h[0]
; CHECK-GI-NOFP16-NEXT:    mov h1, v0.h[1]
; CHECK-GI-NOFP16-NEXT:    mov h5, v0.h[3]
; CHECK-GI-NOFP16-NEXT:    fcvtl v2.4s, v2.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v3.4s, v4.4h
; CHECK-GI-NOFP16-NEXT:    mov h4, v0.h[2]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[1], v1.h[0]
; CHECK-GI-NOFP16-NEXT:    fsub v1.4s, v2.4s, v3.4s
; CHECK-GI-NOFP16-NEXT:    mov v0.h[2], v4.h[0]
; CHECK-GI-NOFP16-NEXT:    fcvtn v1.4h, v1.4s
; CHECK-GI-NOFP16-NEXT:    mov v0.h[3], v5.h[0]
; CHECK-GI-NOFP16-NEXT:    mov h2, v1.h[1]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[4], v1.h[0]
; CHECK-GI-NOFP16-NEXT:    mov h1, v1.h[2]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[5], v2.h[0]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[6], v1.h[0]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[7], v0.h[0]
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fsub_v7f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fsub v0.8h, v0.8h, v1.8h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fsub <7 x half> %a, %b
  ret <7 x half> %c
}

define <4 x half> @fsub_v4f16(<4 x half> %a, <4 x half> %b) {
; CHECK-SD-NOFP16-LABEL: fsub_v4f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    fcvtl v1.4s, v1.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-SD-NOFP16-NEXT:    fsub v0.4s, v0.4s, v1.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fsub_v4f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fsub v0.4h, v0.4h, v1.4h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fsub_v4f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v1.4s, v1.4h
; CHECK-GI-NOFP16-NEXT:    fsub v0.4s, v0.4s, v1.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fsub_v4f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fsub v0.4h, v0.4h, v1.4h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fsub <4 x half> %a, %b
  ret <4 x half> %c
}

define <8 x half> @fsub_v8f16(<8 x half> %a, <8 x half> %b) {
; CHECK-SD-NOFP16-LABEL: fsub_v8f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    fcvtl v2.4s, v1.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl v3.4s, v0.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl2 v1.4s, v1.8h
; CHECK-SD-NOFP16-NEXT:    fcvtl2 v0.4s, v0.8h
; CHECK-SD-NOFP16-NEXT:    fsub v2.4s, v3.4s, v2.4s
; CHECK-SD-NOFP16-NEXT:    fsub v1.4s, v0.4s, v1.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn v0.4h, v2.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn2 v0.8h, v1.4s
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fsub_v8f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fsub v0.8h, v0.8h, v1.8h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fsub_v8f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    fcvtl v2.4s, v0.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v3.4s, v1.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v0.4s, v0.8h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v1.4s, v1.8h
; CHECK-GI-NOFP16-NEXT:    fsub v2.4s, v2.4s, v3.4s
; CHECK-GI-NOFP16-NEXT:    fsub v1.4s, v0.4s, v1.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn v0.4h, v2.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn2 v0.8h, v1.4s
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fsub_v8f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fsub v0.8h, v0.8h, v1.8h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fsub <8 x half> %a, %b
  ret <8 x half> %c
}

define <16 x half> @fsub_v16f16(<16 x half> %a, <16 x half> %b) {
; CHECK-SD-NOFP16-LABEL: fsub_v16f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    fcvtl v4.4s, v2.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl v5.4s, v0.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl v6.4s, v3.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl v7.4s, v1.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl2 v2.4s, v2.8h
; CHECK-SD-NOFP16-NEXT:    fcvtl2 v0.4s, v0.8h
; CHECK-SD-NOFP16-NEXT:    fcvtl2 v3.4s, v3.8h
; CHECK-SD-NOFP16-NEXT:    fcvtl2 v1.4s, v1.8h
; CHECK-SD-NOFP16-NEXT:    fsub v4.4s, v5.4s, v4.4s
; CHECK-SD-NOFP16-NEXT:    fsub v5.4s, v7.4s, v6.4s
; CHECK-SD-NOFP16-NEXT:    fsub v2.4s, v0.4s, v2.4s
; CHECK-SD-NOFP16-NEXT:    fsub v3.4s, v1.4s, v3.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn v0.4h, v4.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn v1.4h, v5.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn2 v0.8h, v2.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn2 v1.8h, v3.4s
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fsub_v16f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fsub v1.8h, v1.8h, v3.8h
; CHECK-SD-FP16-NEXT:    fsub v0.8h, v0.8h, v2.8h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fsub_v16f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    fcvtl v4.4s, v0.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v5.4s, v1.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v6.4s, v2.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v7.4s, v3.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v0.4s, v0.8h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v1.4s, v1.8h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v2.4s, v2.8h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v3.4s, v3.8h
; CHECK-GI-NOFP16-NEXT:    fsub v4.4s, v4.4s, v6.4s
; CHECK-GI-NOFP16-NEXT:    fsub v5.4s, v5.4s, v7.4s
; CHECK-GI-NOFP16-NEXT:    fsub v2.4s, v0.4s, v2.4s
; CHECK-GI-NOFP16-NEXT:    fsub v3.4s, v1.4s, v3.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn v0.4h, v4.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn v1.4h, v5.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn2 v0.8h, v2.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn2 v1.8h, v3.4s
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fsub_v16f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fsub v0.8h, v0.8h, v2.8h
; CHECK-GI-FP16-NEXT:    fsub v1.8h, v1.8h, v3.8h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fsub <16 x half> %a, %b
  ret <16 x half> %c
}
