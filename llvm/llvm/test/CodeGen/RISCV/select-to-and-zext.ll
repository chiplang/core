; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV64I


define i32 @from_cmpeq(i32 %xx, i32 %y) {
; RV32I-LABEL: from_cmpeq:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, -9
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: from_cmpeq:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    addi a0, a0, -9
; RV64I-NEXT:    seqz a0, a0
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    ret
  %x = icmp eq i32 %xx, 9
  %masked = and i32 %y, 1

  %r = select i1 %x, i32 %masked, i32 0
  ret i32 %r
}

define i32 @from_cmpeq_fail_bad_andmask(i32 %xx, i32 %y) {
; RV32I-LABEL: from_cmpeq_fail_bad_andmask:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, -9
; RV32I-NEXT:    snez a0, a0
; RV32I-NEXT:    addi a0, a0, -1
; RV32I-NEXT:    and a0, a1, a0
; RV32I-NEXT:    andi a0, a0, 3
; RV32I-NEXT:    ret
;
; RV64I-LABEL: from_cmpeq_fail_bad_andmask:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    addi a0, a0, -9
; RV64I-NEXT:    snez a0, a0
; RV64I-NEXT:    addi a0, a0, -1
; RV64I-NEXT:    and a0, a1, a0
; RV64I-NEXT:    andi a0, a0, 3
; RV64I-NEXT:    ret
  %x = icmp eq i32 %xx, 9
  %masked = and i32 %y, 3
  %r = select i1 %x, i32 %masked, i32 0
  ret i32 %r
}

define i32 @from_i1(i1 %x, i32 %y) {
; RV32I-LABEL: from_i1:
; RV32I:       # %bb.0:
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    andi a0, a0, 1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: from_i1:
; RV64I:       # %bb.0:
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    andi a0, a0, 1
; RV64I-NEXT:    ret
  %masked = and i32 %y, 1
  %r = select i1 %x, i32 %masked, i32 0
  ret i32 %r
}

define i32 @from_trunc_i8(i8 %xx, i32 %y) {
; RV32I-LABEL: from_trunc_i8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    andi a0, a0, 1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: from_trunc_i8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    andi a0, a0, 1
; RV64I-NEXT:    ret
  %masked = and i32 %y, 1
  %x = trunc i8 %xx to i1
  %r = select i1 %x, i32 %masked, i32 0
  ret i32 %r
}

define i32 @from_trunc_i64(i64 %xx, i32 %y) {
; RV32I-LABEL: from_trunc_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    and a0, a0, a2
; RV32I-NEXT:    andi a0, a0, 1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: from_trunc_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    andi a0, a0, 1
; RV64I-NEXT:    ret
  %masked = and i32 %y, 1
  %x = trunc i64 %xx to i1
  %r = select i1 %x, i32 %masked, i32 0
  ret i32 %r
}

define i32 @from_i1_fail_bad_select0(i1 %x, i32 %y) {
; RV32I-LABEL: from_i1_fail_bad_select0:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a0, a0, 1
; RV32I-NEXT:    bnez a0, .LBB5_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    li a0, 1
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB5_2:
; RV32I-NEXT:    andi a0, a1, 1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: from_i1_fail_bad_select0:
; RV64I:       # %bb.0:
; RV64I-NEXT:    andi a0, a0, 1
; RV64I-NEXT:    bnez a0, .LBB5_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    li a0, 1
; RV64I-NEXT:    ret
; RV64I-NEXT:  .LBB5_2:
; RV64I-NEXT:    andi a0, a1, 1
; RV64I-NEXT:    ret
  %masked = and i32 %y, 1
  %r = select i1 %x, i32 %masked, i32 1
  ret i32 %r
}

define i32 @from_i1_fail_bad_select1(i1 %x, i32 %y) {
; RV32I-LABEL: from_i1_fail_bad_select1:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, -1
; RV32I-NEXT:    and a0, a1, a0
; RV32I-NEXT:    andi a0, a0, 1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: from_i1_fail_bad_select1:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi a0, a0, -1
; RV64I-NEXT:    and a0, a1, a0
; RV64I-NEXT:    andi a0, a0, 1
; RV64I-NEXT:    ret
  %masked = and i32 %y, 1
  %r = select i1 %x, i32 0, i32 %masked
  ret i32 %r
}
