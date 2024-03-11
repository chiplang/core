; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=m68k-pc-linux -relocation-model=pic -verify-machineinstrs | FileCheck %s

;
; Pass first 4 arguments in registers %d0,%d1,%a0,%a1 the rest goes onto stack

define i32 @foo1() nounwind uwtable {
; CHECK-LABEL: foo1:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0: ; %entry
; CHECK-NEXT:    suba.l #4, %sp
; CHECK-NEXT:    .cfi_def_cfa_offset -8
; CHECK-NEXT:    move.l #5, (%sp)
; CHECK-NEXT:    move.l #1, %d0
; CHECK-NEXT:    move.l #2, %d1
; CHECK-NEXT:    move.l #3, %a0
; CHECK-NEXT:    move.l #4, %a1
; CHECK-NEXT:    jsr (bar1@PLT,%pc)
; CHECK-NEXT:    move.l #0, %d0
; CHECK-NEXT:    adda.l #4, %sp
; CHECK-NEXT:    rts
entry:
  call fastcc void @bar1(i32 1, i32 2, i32 3, i32 4, i32 5) nounwind
  ret i32 0
}

declare fastcc void @bar1(i32 %a, i32 %b, i32 %c, i32 %d, i32 %e);
;
; Pass pointers in %a registers if there are any free left
define i32 @foo2() nounwind uwtable {
; CHECK-LABEL: foo2:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0: ; %entry
; CHECK-NEXT:    suba.l #12, %sp
; CHECK-NEXT:    .cfi_def_cfa_offset -16
; CHECK-NEXT:    lea (8,%sp), %a0
; CHECK-NEXT:    move.l #2, %d0
; CHECK-NEXT:    lea (4,%sp), %a1
; CHECK-NEXT:    move.l #4, %d1
; CHECK-NEXT:    jsr (bar2@PLT,%pc)
; CHECK-NEXT:    move.l #0, %d0
; CHECK-NEXT:    adda.l #12, %sp
; CHECK-NEXT:    rts
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  call fastcc void @bar2(ptr %a, i32 2, ptr %b, i32 4) nounwind
  ret i32 0
}

declare fastcc void @bar2(ptr %a, i32 %b, ptr %c, i32 %d);
