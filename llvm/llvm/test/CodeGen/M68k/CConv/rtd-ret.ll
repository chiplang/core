; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=m68k < %s | FileCheck %s

define dso_local m68k_rtdcc i32 @ret(i32 noundef %a, i32 noundef %b, i32 noundef %c) nounwind {
; CHECK-LABEL: ret:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    move.l (8,%sp), %d0
; CHECK-NEXT:    add.l (4,%sp), %d0
; CHECK-NEXT:    add.l (12,%sp), %d0
; CHECK-NEXT:    move.l (%sp), %a1
; CHECK-NEXT:    adda.l #12, %sp
; CHECK-NEXT:    move.l %a1, (%sp)
; CHECK-NEXT:    rts
entry:
  %add = add nsw i32 %b, %a
  %add1 = add nsw i32 %add, %c
  ret i32 %add1
}

define dso_local m68k_rtdcc i32 @va_ret(i32 noundef %a, i32 noundef %b, i32 noundef %c, ...) nounwind {
; CHECK-LABEL: va_ret:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    move.l (8,%sp), %d0
; CHECK-NEXT:    add.l (4,%sp), %d0
; CHECK-NEXT:    add.l (12,%sp), %d0
; CHECK-NEXT:    rts
entry:
  %add = add nsw i32 %b, %a
  %add1 = add nsw i32 %add, %c
  ret i32 %add1
}
