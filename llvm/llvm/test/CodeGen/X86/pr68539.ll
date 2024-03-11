; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc < %s -mtriple=x86_64-- | FileCheck %s

define i32 @main(i1 %arg) {
; CHECK-LABEL: main:
; CHECK:       # %bb.0: # %bb
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB0_1: # %bb1
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    jmp .LBB0_1
bb:
  br label %bb1

bb1:
  %i = phi i64 [ 0, %bb ], [ %i8, %bb1 ]
  %i2 = add i32 1, 1
  %i3 = icmp eq i32 %i2, 0
  %i4 = add i32 0, 1
  %i5 = icmp eq i32 %i4, 0
  %i6 = select i1 %arg, i1 %i5, i1 %i3
  %i7 = and i64 %i, 0
  %i8 = select i1 %i6, i64 0, i64 %i
  br label %bb1
}
