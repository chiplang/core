; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-none-elf %s -o - | FileCheck %s

define i32 @neg_select_neg(i32 %a, i32 %b, i1 %bb) {
; CHECK-LABEL: neg_select_neg:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w2, #0x1
; CHECK-NEXT:    csel w0, w0, w1, ne
; CHECK-NEXT:    ret
  %nega = sub i32 0, %a
  %negb = sub i32 0, %b
  %sel = select i1 %bb, i32 %nega, i32 %negb
  %res = sub i32 0, %sel
  ret i32 %res
}

define i32 @negneg_select_nega(i32 %a, i32 %b, i1 %bb) {
; CHECK-LABEL: negneg_select_nega:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w2, #0x1
; CHECK-NEXT:    csneg w0, w1, w0, eq
; CHECK-NEXT:    ret
  %nega = sub i32 0, %a
  %sel = select i1 %bb, i32 %nega, i32 %b
  %nsel = sub i32 0, %sel
  %res = sub i32 0, %nsel
  ret i32 %res
}

define i32 @neg_select_nega(i32 %a, i32 %b, i1 %bb) {
; CHECK-LABEL: neg_select_nega:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w2, #0x1
; CHECK-NEXT:    csneg w0, w0, w1, ne
; CHECK-NEXT:    ret
  %nega = sub i32 0, %a
  %sel = select i1 %bb, i32 %nega, i32 %b
  %res = sub i32 0, %sel
  ret i32 %res
}

define i32 @neg_select_negb(i32 %a, i32 %b, i1 %bb) {
; CHECK-LABEL: neg_select_negb:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w2, #0x1
; CHECK-NEXT:    csneg w0, w1, w0, eq
; CHECK-NEXT:    ret
  %negb = sub i32 0, %b
  %sel = select i1 %bb, i32 %a, i32 %negb
  %res = sub i32 0, %sel
  ret i32 %res
}

define i32 @neg_select_ab(i32 %a, i32 %b, i1 %bb) {
; CHECK-LABEL: neg_select_ab:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w2, #0x1
; CHECK-NEXT:    csel w8, w0, w1, ne
; CHECK-NEXT:    neg w0, w8
; CHECK-NEXT:    ret
  %sel = select i1 %bb, i32 %a, i32 %b
  %res = sub i32 0, %sel
  ret i32 %res
}

define i32 @neg_select_nega_with_use(i32 %a, i32 %b, i1 %bb) {
; CHECK-LABEL: neg_select_nega_with_use:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w2, #0x1
; CHECK-NEXT:    neg w8, w0
; CHECK-NEXT:    csneg w9, w1, w0, eq
; CHECK-NEXT:    sub w0, w8, w9
; CHECK-NEXT:    ret
  %nega = sub i32 0, %a
  %sel = select i1 %bb, i32 %nega, i32 %b
  %nsel = sub i32 0, %sel
  %res = add i32 %nsel, %nega
  ret i32 %res
}
