; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=r600 -mcpu=redwood | FileCheck %s

; Test a selectcc with i32 LHS/RHS and float True/False

define amdgpu_kernel void @test(ptr addrspace(1) %out, ptr addrspace(1) %in) {
; CHECK-LABEL: test:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    ALU 0, @8, KC0[CB0:0-32], KC1[]
; CHECK-NEXT:    TEX 0 @6
; CHECK-NEXT:    ALU 3, @9, KC0[CB0:0-32], KC1[]
; CHECK-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.X, T1.X, 1
; CHECK-NEXT:    CF_END
; CHECK-NEXT:    PAD
; CHECK-NEXT:    Fetch clause starting at 6:
; CHECK-NEXT:     VTX_READ_32 T0.X, T0.X, 0, #1
; CHECK-NEXT:    ALU clause starting at 8:
; CHECK-NEXT:     MOV * T0.X, KC0[2].Z,
; CHECK-NEXT:    ALU clause starting at 9:
; CHECK-NEXT:     SETGT_INT * T0.W, 0.0, T0.X,
; CHECK-NEXT:     CNDE_INT T0.X, PV.W, literal.x, 0.0,
; CHECK-NEXT:     LSHR * T1.X, KC0[2].Y, literal.y,
; CHECK-NEXT:    1065353216(1.000000e+00), 2(2.802597e-45)
entry:
  %0 = load i32, ptr addrspace(1) %in
  %1 = icmp sge i32 %0, 0
  %2 = select i1 %1, float 1.0, float 0.0
  store float %2, ptr addrspace(1) %out
  ret void
}
