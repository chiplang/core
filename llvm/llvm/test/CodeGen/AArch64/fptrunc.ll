; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc -mtriple=aarch64 -global-isel=0 -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-SD
; RUN: llc -mtriple=aarch64 -global-isel=1 -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-GI

define float @fptrunc_f64_f32(double %a) {
; CHECK-LABEL: fptrunc_f64_f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvt s0, d0
; CHECK-NEXT:    ret
entry:
  %c = fptrunc double %a to float
  ret float %c
}

define half @fptrunc_f64_f16(double %a) {
; CHECK-LABEL: fptrunc_f64_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvt h0, d0
; CHECK-NEXT:    ret
entry:
  %c = fptrunc double %a to half
  ret half %c
}

define half @fptrunc_f32_f16(float %a) {
; CHECK-LABEL: fptrunc_f32_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvt h0, s0
; CHECK-NEXT:    ret
entry:
  %c = fptrunc float %a to half
  ret half %c
}

define <2 x float> @fptrunc_v2f64_v2f32(<2 x double> %a) {
; CHECK-LABEL: fptrunc_v2f64_v2f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtn v0.2s, v0.2d
; CHECK-NEXT:    ret
entry:
  %c = fptrunc <2 x double> %a to <2 x float>
  ret <2 x float> %c
}

define <3 x float> @fptrunc_v3f64_v3f32(<3 x double> %a) {
; CHECK-SD-LABEL: fptrunc_v3f64_v3f32:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-SD-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-SD-NEXT:    // kill: def $d2 killed $d2 def $q2
; CHECK-SD-NEXT:    mov v0.d[1], v1.d[0]
; CHECK-SD-NEXT:    fcvtn v0.2s, v0.2d
; CHECK-SD-NEXT:    fcvtn2 v0.4s, v2.2d
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: fptrunc_v3f64_v3f32:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-GI-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-GI-NEXT:    fcvt s2, d2
; CHECK-GI-NEXT:    mov v0.d[1], v1.d[0]
; CHECK-GI-NEXT:    fcvtn v0.2s, v0.2d
; CHECK-GI-NEXT:    mov s1, v0.s[1]
; CHECK-GI-NEXT:    mov v0.s[1], v1.s[0]
; CHECK-GI-NEXT:    mov v0.s[2], v2.s[0]
; CHECK-GI-NEXT:    mov v0.s[3], v0.s[0]
; CHECK-GI-NEXT:    ret
entry:
  %c = fptrunc <3 x double> %a to <3 x float>
  ret <3 x float> %c
}

define <4 x float> @fptrunc_v4f64_v4f32(<4 x double> %a) {
; CHECK-LABEL: fptrunc_v4f64_v4f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtn v0.2s, v0.2d
; CHECK-NEXT:    fcvtn2 v0.4s, v1.2d
; CHECK-NEXT:    ret
entry:
  %c = fptrunc <4 x double> %a to <4 x float>
  ret <4 x float> %c
}

define <2 x half> @fptrunc_v2f64_v2f16(<2 x double> %a) {
; CHECK-SD-LABEL: fptrunc_v2f64_v2f16:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    fcvtxn v0.2s, v0.2d
; CHECK-SD-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: fptrunc_v2f64_v2f16:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    mov d1, v0.d[1]
; CHECK-GI-NEXT:    fcvt h0, d0
; CHECK-GI-NEXT:    fcvt h1, d1
; CHECK-GI-NEXT:    mov v0.h[1], v1.h[0]
; CHECK-GI-NEXT:    mov v0.h[2], v0.h[0]
; CHECK-GI-NEXT:    mov v0.h[3], v0.h[0]
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
entry:
  %c = fptrunc <2 x double> %a to <2 x half>
  ret <2 x half> %c
}

define <3 x half> @fptrunc_v3f64_v3f16(<3 x double> %a) {
; CHECK-SD-LABEL: fptrunc_v3f64_v3f16:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    fcvt h1, d1
; CHECK-SD-NEXT:    fcvt h0, d0
; CHECK-SD-NEXT:    mov v0.h[1], v1.h[0]
; CHECK-SD-NEXT:    fcvt h1, d2
; CHECK-SD-NEXT:    mov v0.h[2], v1.h[0]
; CHECK-SD-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: fptrunc_v3f64_v3f16:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    fcvt h0, d0
; CHECK-GI-NEXT:    fcvt h1, d1
; CHECK-GI-NEXT:    fcvt h2, d2
; CHECK-GI-NEXT:    mov v0.h[1], v1.h[0]
; CHECK-GI-NEXT:    mov v0.h[2], v2.h[0]
; CHECK-GI-NEXT:    mov v0.h[3], v0.h[0]
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
entry:
  %c = fptrunc <3 x double> %a to <3 x half>
  ret <3 x half> %c
}

define <4 x half> @fptrunc_v4f64_v4f16(<4 x double> %a) {
; CHECK-SD-LABEL: fptrunc_v4f64_v4f16:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    fcvtxn v0.2s, v0.2d
; CHECK-SD-NEXT:    fcvtxn2 v0.4s, v1.2d
; CHECK-SD-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: fptrunc_v4f64_v4f16:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    mov d2, v0.d[1]
; CHECK-GI-NEXT:    fcvt h0, d0
; CHECK-GI-NEXT:    mov d3, v1.d[1]
; CHECK-GI-NEXT:    fcvt h1, d1
; CHECK-GI-NEXT:    fcvt h2, d2
; CHECK-GI-NEXT:    mov v0.h[1], v2.h[0]
; CHECK-GI-NEXT:    fcvt h2, d3
; CHECK-GI-NEXT:    mov v0.h[2], v1.h[0]
; CHECK-GI-NEXT:    mov v0.h[3], v2.h[0]
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
entry:
  %c = fptrunc <4 x double> %a to <4 x half>
  ret <4 x half> %c
}

define <2 x half> @fptrunc_v2f32_v2f16(<2 x float> %a) {
; CHECK-SD-LABEL: fptrunc_v2f32_v2f16:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-SD-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: fptrunc_v2f32_v2f16:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-GI-NEXT:    mov s1, v0.s[1]
; CHECK-GI-NEXT:    mov v0.s[1], v1.s[0]
; CHECK-GI-NEXT:    mov v0.s[2], v0.s[0]
; CHECK-GI-NEXT:    mov v0.s[3], v0.s[0]
; CHECK-GI-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-GI-NEXT:    mov h1, v0.h[1]
; CHECK-GI-NEXT:    mov v0.h[1], v1.h[0]
; CHECK-GI-NEXT:    mov v0.h[2], v0.h[0]
; CHECK-GI-NEXT:    mov v0.h[3], v0.h[0]
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
entry:
  %c = fptrunc <2 x float> %a to <2 x half>
  ret <2 x half> %c
}

define <3 x half> @fptrunc_v3f32_v3f16(<3 x float> %a) {
; CHECK-LABEL: fptrunc_v3f32_v3f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-NEXT:    ret
entry:
  %c = fptrunc <3 x float> %a to <3 x half>
  ret <3 x half> %c
}

define <4 x half> @fptrunc_v4f32_v4f16(<4 x float> %a) {
; CHECK-LABEL: fptrunc_v4f32_v4f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-NEXT:    ret
entry:
  %c = fptrunc <4 x float> %a to <4 x half>
  ret <4 x half> %c
}

define <8 x half> @fptrunc_v8f32_v8f16(<8 x float> %a) {
; CHECK-LABEL: fptrunc_v8f32_v8f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-NEXT:    fcvtn2 v0.8h, v1.4s
; CHECK-NEXT:    ret
entry:
  %c = fptrunc <8 x float> %a to <8 x half>
  ret <8 x half> %c
}