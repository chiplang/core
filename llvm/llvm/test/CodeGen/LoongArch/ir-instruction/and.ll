; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch32 < %s | FileCheck %s --check-prefix=LA32
; RUN: llc --mtriple=loongarch64 < %s | FileCheck %s --check-prefix=LA64

;; Exercise the 'and' LLVM IR: https://llvm.org/docs/LangRef.html#and-instruction

define i1 @and_i1(i1 %a, i1 %b) {
; LA32-LABEL: and_i1:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    and $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i1:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    and $a0, $a0, $a1
; LA64-NEXT:    ret
entry:
  %r = and i1 %a, %b
  ret i1 %r
}

define i8 @and_i8(i8 %a, i8 %b) {
; LA32-LABEL: and_i8:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    and $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i8:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    and $a0, $a0, $a1
; LA64-NEXT:    ret
entry:
  %r = and i8 %a, %b
  ret i8 %r
}

define i16 @and_i16(i16 %a, i16 %b) {
; LA32-LABEL: and_i16:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    and $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i16:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    and $a0, $a0, $a1
; LA64-NEXT:    ret
entry:
  %r = and i16 %a, %b
  ret i16 %r
}

define i32 @and_i32(i32 %a, i32 %b) {
; LA32-LABEL: and_i32:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    and $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i32:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    and $a0, $a0, $a1
; LA64-NEXT:    ret
entry:
  %r = and i32 %a, %b
  ret i32 %r
}

define i64 @and_i64(i64 %a, i64 %b) {
; LA32-LABEL: and_i64:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    and $a0, $a0, $a2
; LA32-NEXT:    and $a1, $a1, $a3
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i64:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    and $a0, $a0, $a1
; LA64-NEXT:    ret
entry:
  %r = and i64 %a, %b
  ret i64 %r
}

define i1 @and_i1_0(i1 %b) {
; LA32-LABEL: and_i1_0:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    move $a0, $zero
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i1_0:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    move $a0, $zero
; LA64-NEXT:    ret
entry:
  %r = and i1 4, %b
  ret i1 %r
}

define i1 @and_i1_5(i1 %b) {
; LA32-LABEL: and_i1_5:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i1_5:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    ret
entry:
  %r = and i1 5, %b
  ret i1 %r
}

define i8 @and_i8_5(i8 %b) {
; LA32-LABEL: and_i8_5:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    andi $a0, $a0, 5
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i8_5:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    andi $a0, $a0, 5
; LA64-NEXT:    ret
entry:
  %r = and i8 5, %b
  ret i8 %r
}

define i8 @and_i8_257(i8 %b) {
; LA32-LABEL: and_i8_257:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    andi $a0, $a0, 1
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i8_257:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    andi $a0, $a0, 1
; LA64-NEXT:    ret
entry:
  %r = and i8 257, %b
  ret i8 %r
}

define i16 @and_i16_5(i16 %b) {
; LA32-LABEL: and_i16_5:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    andi $a0, $a0, 5
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i16_5:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    andi $a0, $a0, 5
; LA64-NEXT:    ret
entry:
  %r = and i16 5, %b
  ret i16 %r
}

define i16 @and_i16_0x1000(i16 %b) {
; LA32-LABEL: and_i16_0x1000:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    lu12i.w $a1, 1
; LA32-NEXT:    and $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i16_0x1000:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    lu12i.w $a1, 1
; LA64-NEXT:    and $a0, $a0, $a1
; LA64-NEXT:    ret
entry:
  %r = and i16 4096, %b
  ret i16 %r
}

define i16 @and_i16_0x10001(i16 %b) {
; LA32-LABEL: and_i16_0x10001:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    andi $a0, $a0, 1
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i16_0x10001:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    andi $a0, $a0, 1
; LA64-NEXT:    ret
entry:
  %r = and i16 65537, %b
  ret i16 %r
}

define i32 @and_i32_5(i32 %b) {
; LA32-LABEL: and_i32_5:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    andi $a0, $a0, 5
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i32_5:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    andi $a0, $a0, 5
; LA64-NEXT:    ret
entry:
  %r = and i32 5, %b
  ret i32 %r
}

define i32 @and_i32_0x1000(i32 %b) {
; LA32-LABEL: and_i32_0x1000:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    lu12i.w $a1, 1
; LA32-NEXT:    and $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i32_0x1000:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    lu12i.w $a1, 1
; LA64-NEXT:    and $a0, $a0, $a1
; LA64-NEXT:    ret
entry:
  %r = and i32 4096, %b
  ret i32 %r
}

define i32 @and_i32_0x100000001(i32 %b) {
; LA32-LABEL: and_i32_0x100000001:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    andi $a0, $a0, 1
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i32_0x100000001:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    andi $a0, $a0, 1
; LA64-NEXT:    ret
entry:
  %r = and i32 4294967297, %b
  ret i32 %r
}

define i64 @and_i64_5(i64 %b) {
; LA32-LABEL: and_i64_5:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    andi $a0, $a0, 5
; LA32-NEXT:    move $a1, $zero
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i64_5:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    andi $a0, $a0, 5
; LA64-NEXT:    ret
entry:
  %r = and i64 5, %b
  ret i64 %r
}

define i64 @and_i64_0x1000(i64 %b) {
; LA32-LABEL: and_i64_0x1000:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    lu12i.w $a1, 1
; LA32-NEXT:    and $a0, $a0, $a1
; LA32-NEXT:    move $a1, $zero
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i64_0x1000:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    lu12i.w $a1, 1
; LA64-NEXT:    and $a0, $a0, $a1
; LA64-NEXT:    ret
entry:
  %r = and i64 4096, %b
  ret i64 %r
}

define signext i32 @and_i32_0xfff0(i32 %a) {
; LA32-LABEL: and_i32_0xfff0:
; LA32:       # %bb.0:
; LA32-NEXT:    bstrpick.w $a0, $a0, 15, 4
; LA32-NEXT:    slli.w $a0, $a0, 4
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i32_0xfff0:
; LA64:       # %bb.0:
; LA64-NEXT:    bstrpick.d $a0, $a0, 15, 4
; LA64-NEXT:    slli.d $a0, $a0, 4
; LA64-NEXT:    ret
  %b = and i32 %a, 65520
  ret i32 %b
}

define signext i32 @and_i32_0xfff0_twice(i32 %a, i32 %b) {
; LA32-LABEL: and_i32_0xfff0_twice:
; LA32:       # %bb.0:
; LA32-NEXT:    bstrpick.w $a0, $a0, 15, 4
; LA32-NEXT:    slli.w $a0, $a0, 4
; LA32-NEXT:    bstrpick.w $a1, $a1, 15, 4
; LA32-NEXT:    slli.w $a1, $a1, 4
; LA32-NEXT:    sub.w $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i32_0xfff0_twice:
; LA64:       # %bb.0:
; LA64-NEXT:    bstrpick.d $a0, $a0, 15, 4
; LA64-NEXT:    slli.d $a0, $a0, 4
; LA64-NEXT:    bstrpick.d $a1, $a1, 15, 4
; LA64-NEXT:    slli.d $a1, $a1, 4
; LA64-NEXT:    sub.d $a0, $a0, $a1
; LA64-NEXT:    ret
  %c = and i32 %a, 65520
  %d = and i32 %b, 65520
  %e = sub i32 %c, %d
  ret i32 %e
}

define i64 @and_i64_0xfff0(i64 %a) {
; LA32-LABEL: and_i64_0xfff0:
; LA32:       # %bb.0:
; LA32-NEXT:    bstrpick.w $a0, $a0, 15, 4
; LA32-NEXT:    slli.w $a0, $a0, 4
; LA32-NEXT:    move $a1, $zero
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i64_0xfff0:
; LA64:       # %bb.0:
; LA64-NEXT:    bstrpick.d $a0, $a0, 15, 4
; LA64-NEXT:    slli.d $a0, $a0, 4
; LA64-NEXT:    ret
  %b = and i64 %a, 65520
  ret i64 %b
}

define i64 @and_i64_0xfff0_twice(i64 %a, i64 %b) {
; LA32-LABEL: and_i64_0xfff0_twice:
; LA32:       # %bb.0:
; LA32-NEXT:    bstrpick.w $a0, $a0, 15, 4
; LA32-NEXT:    slli.w $a1, $a0, 4
; LA32-NEXT:    bstrpick.w $a0, $a2, 15, 4
; LA32-NEXT:    slli.w $a2, $a0, 4
; LA32-NEXT:    sub.w $a0, $a1, $a2
; LA32-NEXT:    sltu $a1, $a1, $a2
; LA32-NEXT:    sub.w $a1, $zero, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i64_0xfff0_twice:
; LA64:       # %bb.0:
; LA64-NEXT:    bstrpick.d $a0, $a0, 15, 4
; LA64-NEXT:    slli.d $a0, $a0, 4
; LA64-NEXT:    bstrpick.d $a1, $a1, 15, 4
; LA64-NEXT:    slli.d $a1, $a1, 4
; LA64-NEXT:    sub.d $a0, $a0, $a1
; LA64-NEXT:    ret
  %c = and i64 %a, 65520
  %d = and i64 %b, 65520
  %e = sub i64 %c, %d
  ret i64 %e
}

;; This case is not optimized to `bstrpick + slli`,
;; since the immediate 1044480 can be composed via
;; a single `lu12i.w $rx, 255`.
define i64 @and_i64_0xff000(i64 %a) {
; LA32-LABEL: and_i64_0xff000:
; LA32:       # %bb.0:
; LA32-NEXT:    lu12i.w $a1, 255
; LA32-NEXT:    and $a0, $a0, $a1
; LA32-NEXT:    move $a1, $zero
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i64_0xff000:
; LA64:       # %bb.0:
; LA64-NEXT:    lu12i.w $a1, 255
; LA64-NEXT:    and $a0, $a0, $a1
; LA64-NEXT:    ret
  %b = and i64 %a, 1044480
  ret i64 %b
}

define i64 @and_i64_minus_2048(i64 %a) {
; LA32-LABEL: and_i64_minus_2048:
; LA32:       # %bb.0:
; LA32-NEXT:    bstrins.w $a0, $zero, 10, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i64_minus_2048:
; LA64:       # %bb.0:
; LA64-NEXT:    bstrins.d $a0, $zero, 10, 0
; LA64-NEXT:    ret
  %b = and i64 %a, -2048
  ret i64 %b
}

;; This case is not optimized to `bstrpick + slli`,
;; since the immediate 0xfff0 has more than 2 uses.
define i64 @and_i64_0xfff0_multiple_times(i64 %a, i64 %b, i64 %c) {
; LA32-LABEL: and_i64_0xfff0_multiple_times:
; LA32:       # %bb.0:
; LA32-NEXT:    lu12i.w $a1, 15
; LA32-NEXT:    ori $a1, $a1, 4080
; LA32-NEXT:    and $a0, $a0, $a1
; LA32-NEXT:    and $a2, $a2, $a1
; LA32-NEXT:    and $a3, $a4, $a1
; LA32-NEXT:    sltu $a1, $a0, $a2
; LA32-NEXT:    sub.w $a1, $zero, $a1
; LA32-NEXT:    sub.w $a0, $a0, $a2
; LA32-NEXT:    mul.w $a2, $a2, $a3
; LA32-NEXT:    xor $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i64_0xfff0_multiple_times:
; LA64:       # %bb.0:
; LA64-NEXT:    lu12i.w $a3, 15
; LA64-NEXT:    ori $a3, $a3, 4080
; LA64-NEXT:    and $a0, $a0, $a3
; LA64-NEXT:    and $a1, $a1, $a3
; LA64-NEXT:    and $a2, $a2, $a3
; LA64-NEXT:    sub.d $a0, $a0, $a1
; LA64-NEXT:    mul.d $a1, $a1, $a2
; LA64-NEXT:    xor $a0, $a0, $a1
; LA64-NEXT:    ret
  %d = and i64 %a, 65520
  %e = and i64 %b, 65520
  %f = and i64 %c, 65520
  %g = sub i64 %d, %e
  %h = mul i64 %e, %f
  %i = xor i64 %g, %h
  ret i64 %i
}

define i64 @and_i64_0xffffffffff00ffff(i64 %a) {
; LA32-LABEL: and_i64_0xffffffffff00ffff:
; LA32:       # %bb.0:
; LA32-NEXT:    bstrins.w $a0, $zero, 23, 16
; LA32-NEXT:    ret
;
; LA64-LABEL: and_i64_0xffffffffff00ffff:
; LA64:       # %bb.0:
; LA64-NEXT:    bstrins.d $a0, $zero, 23, 16
; LA64-NEXT:    ret
  %b = and i64 %a, 18446744073692839935
  ret i64 %b
}

define i32 @and_add_lsr(i32 %x, i32 %y) {
; LA32-LABEL: and_add_lsr:
; LA32:       # %bb.0:
; LA32-NEXT:    addi.w $a0, $a0, -1
; LA32-NEXT:    srli.w $a1, $a1, 20
; LA32-NEXT:    and $a0, $a1, $a0
; LA32-NEXT:    ret
;
; LA64-LABEL: and_add_lsr:
; LA64:       # %bb.0:
; LA64-NEXT:    addi.d $a0, $a0, -1
; LA64-NEXT:    bstrpick.d $a1, $a1, 31, 20
; LA64-NEXT:    and $a0, $a1, $a0
; LA64-NEXT:    ret
  %1 = add i32 %x, 4095
  %2 = lshr i32 %y, 20
  %r = and i32 %2, %1
  ret i32 %r
}