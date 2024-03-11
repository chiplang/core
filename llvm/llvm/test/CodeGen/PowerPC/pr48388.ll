; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le -ppc-asm-full-reg-names \
; RUN:   < %s | FileCheck %s

define i64 @julia_div_i64(i64 %0, i64 %1) local_unnamed_addr #0 {
; CHECK-LABEL: julia_div_i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    divd r5, r3, r4
; CHECK-NEXT:    lis r6, -1592
; CHECK-NEXT:    cmpdi r3, 0
; CHECK-NEXT:    ori r7, r6, 21321
; CHECK-NEXT:    ori r6, r6, 65519
; CHECK-NEXT:    rldic r7, r7, 4, 17
; CHECK-NEXT:    rldic r6, r6, 4, 17
; CHECK-NEXT:    iselgt r8, r6, r7
; CHECK-NEXT:    cmpdi r4, 0
; CHECK-NEXT:    iselgt r6, r6, r7
; CHECK-NEXT:    xor r6, r8, r6
; CHECK-NEXT:    cntlzd r6, r6
; CHECK-NEXT:    rldicl r6, r6, 58, 63
; CHECK-NEXT:    mulld r4, r5, r4
; CHECK-NEXT:    xor r3, r4, r3
; CHECK-NEXT:    addic r4, r3, -1
; CHECK-NEXT:    subfe r3, r4, r3
; CHECK-NEXT:    and r3, r6, r3
; CHECK-NEXT:    add r3, r5, r3
; CHECK-NEXT:    blr
entry:
  %2 = sdiv i64 %0, %1
  %3 = icmp sgt i64 %0, 0
  %4 = icmp sgt i64 %1, 0
  %5 = select i1 %3, i64 140735820070640, i64 140735819363472
  %6 = select i1 %4, i64 140735820070640, i64 140735819363472
  %7 = icmp eq i64 %5, %6
  %8 = mul i64 %2, %1
  %9 = icmp ne i64 %8, %0
  %10 = and i1 %7, %9
  %11 = zext i1 %10 to i64
  %12 = add i64 %2, %11
  ret i64 %12
}
