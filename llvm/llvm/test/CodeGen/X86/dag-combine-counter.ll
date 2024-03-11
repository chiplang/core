; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=x86_64-- -debug-counter=dagcombine-count=6 < %s | FileCheck %s

; REQUIRES: asserts

define i32 @test(i32 %x) {
; CHECK-LABEL: test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    retq
  %y = add i32 %x, 1
  %z = sub i32 %y, 1
  ret i32 %z
}

define i32 @test2(i32 %x) {
; CHECK-LABEL: test2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    leal 1(%rdi), %eax
; CHECK-NEXT:    subl $1, %eax
; CHECK-NEXT:    retq
  %y = add i32 %x, 1
  %z = sub i32 %y, 1
  ret i32 %z
}
