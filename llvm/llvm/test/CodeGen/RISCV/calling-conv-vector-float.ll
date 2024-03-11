; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+f -target-abi=lp64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64 %s
; RUN: llc -mtriple=riscv64 -mattr=+f -target-abi=lp64f -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64LP64F %s

define <2 x float> @callee_v2f32(<2 x float> %x, <2 x float> %y) {
; RV64-LABEL: callee_v2f32:
; RV64:       # %bb.0:
; RV64-NEXT:    fmv.w.x fa5, a2
; RV64-NEXT:    fmv.w.x fa4, a0
; RV64-NEXT:    fmv.w.x fa3, a3
; RV64-NEXT:    fmv.w.x fa2, a1
; RV64-NEXT:    fadd.s fa3, fa2, fa3
; RV64-NEXT:    fadd.s fa5, fa4, fa5
; RV64-NEXT:    fmv.x.w a0, fa5
; RV64-NEXT:    fmv.x.w a1, fa3
; RV64-NEXT:    ret
;
; RV64LP64F-LABEL: callee_v2f32:
; RV64LP64F:       # %bb.0:
; RV64LP64F-NEXT:    fadd.s fa0, fa0, fa2
; RV64LP64F-NEXT:    fadd.s fa1, fa1, fa3
; RV64LP64F-NEXT:    ret
  %z = fadd <2 x float> %x, %y
  ret <2 x float> %z
}

define <4 x float> @callee_v4f32(<4 x float> %x, <4 x float> %y) {
; RV64-LABEL: callee_v4f32:
; RV64:       # %bb.0:
; RV64-NEXT:    fmv.w.x fa5, a4
; RV64-NEXT:    fmv.w.x fa4, a7
; RV64-NEXT:    fmv.w.x fa3, a3
; RV64-NEXT:    fmv.w.x fa2, a6
; RV64-NEXT:    fmv.w.x fa1, a2
; RV64-NEXT:    fmv.w.x fa0, a5
; RV64-NEXT:    fmv.w.x ft0, a1
; RV64-NEXT:    flw ft1, 0(sp)
; RV64-NEXT:    fadd.s fa0, ft0, fa0
; RV64-NEXT:    fadd.s fa2, fa1, fa2
; RV64-NEXT:    fadd.s fa4, fa3, fa4
; RV64-NEXT:    fadd.s fa5, fa5, ft1
; RV64-NEXT:    fsw fa5, 12(a0)
; RV64-NEXT:    fsw fa4, 8(a0)
; RV64-NEXT:    fsw fa2, 4(a0)
; RV64-NEXT:    fsw fa0, 0(a0)
; RV64-NEXT:    ret
;
; RV64LP64F-LABEL: callee_v4f32:
; RV64LP64F:       # %bb.0:
; RV64LP64F-NEXT:    fadd.s fa4, fa0, fa4
; RV64LP64F-NEXT:    fadd.s fa5, fa1, fa5
; RV64LP64F-NEXT:    fadd.s fa2, fa2, fa6
; RV64LP64F-NEXT:    fadd.s fa3, fa3, fa7
; RV64LP64F-NEXT:    fsw fa3, 12(a0)
; RV64LP64F-NEXT:    fsw fa2, 8(a0)
; RV64LP64F-NEXT:    fsw fa5, 4(a0)
; RV64LP64F-NEXT:    fsw fa4, 0(a0)
; RV64LP64F-NEXT:    ret
  %z = fadd <4 x float> %x, %y
  ret <4 x float> %z
}
