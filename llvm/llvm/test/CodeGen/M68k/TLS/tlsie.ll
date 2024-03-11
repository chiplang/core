; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=m68k -o - %s | FileCheck %s

@myvar = external thread_local global i32, align 4

define dso_local ptr @get_addr() nounwind {
; CHECK-LABEL: get_addr:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    suba.l #4, %sp
; CHECK-NEXT:    jsr __m68k_read_tp@PLT
; CHECK-NEXT:    move.l %a0, %d0
; CHECK-NEXT:    lea (_GLOBAL_OFFSET_TABLE_@GOTPCREL,%pc), %a0
; CHECK-NEXT:    add.l (myvar@GOTTPOFF,%a0), %d0
; CHECK-NEXT:    move.l %d0, %a0
; CHECK-NEXT:    adda.l #4, %sp
; CHECK-NEXT:    rts

entry:
  %0 = call align 4 ptr @llvm.threadlocal.address.p0(ptr align 4 @myvar)
  ret ptr %0
}

declare nonnull ptr @llvm.threadlocal.address.p0(ptr nonnull)