; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:     -mcpu=pwr10 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr < %s | \
; RUN:     FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu \
; RUN:     -mcpu=pwr10 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr < %s | \
; RUN:     FileCheck %s

; This test case tests spilling the CR EQ bit on Power10. On Power10, this is
; achieved by setb %reg, %CRREG (eq bit) -> stw %reg, $FI instead of:
; mfocrf %reg, %CRREG -> rlwinm %reg1, %reg, $SH, 0, 0 -> stw %reg1, $FI.

; Without fine-grained control over clobbering individual CR bits,
; it is difficult to produce a concise test case that will ensure a specific
; bit of any CR field is spilled. We need to test the spilling of a CR bit
; other than the LT bit. Hence this test case is rather complex.

%0 = type { i32, ptr, ptr, [1 x i8], ptr, ptr, ptr, ptr, i64, i32, [20 x i8] }
%1 = type { ptr, ptr, i32 }
%2 = type { [200 x i8], [200 x i8], ptr, ptr, ptr, ptr, ptr, ptr, ptr, i64 }
%3 = type { i64, i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i64, i32, i32 }
%4 = type { i32, i64, ptr, ptr, i16, ptr, ptr, i64, i64 }

define dso_local double @P10_Spill_CR_EQ(ptr %arg) local_unnamed_addr #0 {
; CHECK-LABEL: P10_Spill_CR_EQ:
; CHECK:       # %bb.0: # %bb
; CHECK-NEXT:    ld r3, 0(r3)
; CHECK-NEXT:    ld r4, 0(0)
; CHECK-NEXT:    cmpdi r3, 0
; CHECK-NEXT:    ld r5, 56(0)
; CHECK-NEXT:    cmpdi cr1, r4, 0
; CHECK-NEXT:    cmpdi cr5, r5, 0
; CHECK-NEXT:    cmpldi cr6, r3, 0
; CHECK-NEXT:    beq cr6, .LBB0_3
; CHECK-NEXT:  # %bb.1: # %bb10
; CHECK-NEXT:    lwz r3, 0(r3)
; CHECK-NEXT:    bc 12, 4*cr1+eq, .LBB0_4
; CHECK-NEXT:  .LBB0_2: # %bb14
; CHECK-NEXT:    lwz r5, 0(r3)
; CHECK-NEXT:    b .LBB0_5
; CHECK-NEXT:  .LBB0_3:
; CHECK-NEXT:    # implicit-def: $r3
; CHECK-NEXT:    bc 4, 4*cr1+eq, .LBB0_2
; CHECK-NEXT:  .LBB0_4:
; CHECK-NEXT:    # implicit-def: $r5
; CHECK-NEXT:  .LBB0_5: # %bb16
; CHECK-NEXT:    crnot 4*cr1+lt, eq
; CHECK-NEXT:    crnot 4*cr5+un, 4*cr5+eq
; CHECK-NEXT:    bc 12, 4*cr5+eq, .LBB0_7
; CHECK-NEXT:  # %bb.6: # %bb18
; CHECK-NEXT:    lwz r4, 0(r3)
; CHECK-NEXT:    b .LBB0_8
; CHECK-NEXT:  .LBB0_7:
; CHECK-NEXT:    # implicit-def: $r4
; CHECK-NEXT:  .LBB0_8: # %bb20
; CHECK-NEXT:    mfcr r12
; CHECK-NEXT:    cmpwi cr2, r3, -1
; CHECK-NEXT:    cmpwi cr3, r4, -1
; CHECK-NEXT:    stw r12, 8(r1)
; CHECK-NEXT:    cmpwi cr7, r3, 0
; CHECK-NEXT:    cmpwi cr6, r4, 0
; CHECK-NEXT:    crand 4*cr5+gt, 4*cr2+gt, 4*cr1+lt
; CHECK-NEXT:    crand 4*cr5+lt, 4*cr3+gt, 4*cr5+un
; CHECK-NEXT:    # implicit-def: $x3
; CHECK-NEXT:    bc 4, 4*cr5+gt, .LBB0_10
; CHECK-NEXT:  # %bb.9: # %bb34
; CHECK-NEXT:    ld r3, 0(r3)
; CHECK-NEXT:  .LBB0_10: # %bb36
; CHECK-NEXT:    cmpwi cr2, r5, 0
; CHECK-NEXT:    # implicit-def: $x4
; CHECK-NEXT:    bc 4, 4*cr5+lt, .LBB0_12
; CHECK-NEXT:  # %bb.11: # %bb38
; CHECK-NEXT:    ld r4, 0(r3)
; CHECK-NEXT:  .LBB0_12: # %bb40
; CHECK-NEXT:    crand 4*cr6+gt, 4*cr7+lt, 4*cr1+lt
; CHECK-NEXT:    crand 4*cr6+lt, 4*cr6+lt, 4*cr5+un
; CHECK-NEXT:    crnot 4*cr6+un, 4*cr1+eq
; CHECK-NEXT:    # implicit-def: $x6
; CHECK-NEXT:    bc 4, 4*cr6+lt, .LBB0_14
; CHECK-NEXT:  # %bb.13: # %bb48
; CHECK-NEXT:    ld r6, 0(r3)
; CHECK-NEXT:  .LBB0_14: # %bb50
; CHECK-NEXT:    cmpwi cr3, r5, -1
; CHECK-NEXT:    crand 4*cr7+lt, 4*cr2+lt, 4*cr6+un
; CHECK-NEXT:    # implicit-def: $r5
; CHECK-NEXT:    bc 4, 4*cr6+gt, .LBB0_16
; CHECK-NEXT:  # %bb.15: # %bb52
; CHECK-NEXT:    lwz r5, 0(r3)
; CHECK-NEXT:  .LBB0_16: # %bb54
; CHECK-NEXT:    mfocrf r7, 128
; CHECK-NEXT:    stw r7, -4(r1)
; CHECK-NEXT:    # implicit-def: $r7
; CHECK-NEXT:    bc 4, 4*cr7+lt, .LBB0_18
; CHECK-NEXT:  # %bb.17: # %bb56
; CHECK-NEXT:    lwz r7, 0(r3)
; CHECK-NEXT:  .LBB0_18: # %bb58
; CHECK-NEXT:    lwz r6, 92(r6)
; CHECK-NEXT:    crand 4*cr7+un, 4*cr3+gt, 4*cr6+un
; CHECK-NEXT:    cmpwi cr3, r5, 1
; CHECK-NEXT:    cmpwi cr4, r7, 1
; CHECK-NEXT:    crand 4*cr7+gt, 4*cr7+eq, 4*cr1+lt
; CHECK-NEXT:    # implicit-def: $x5
; CHECK-NEXT:    crand 4*cr6+un, 4*cr2+eq, 4*cr6+un
; CHECK-NEXT:    crand 4*cr5+un, 4*cr6+eq, 4*cr5+un
; CHECK-NEXT:    crand 4*cr6+gt, 4*cr3+lt, 4*cr6+gt
; CHECK-NEXT:    crand 4*cr7+lt, 4*cr4+lt, 4*cr7+lt
; CHECK-NEXT:    cmpwi r6, 1
; CHECK-NEXT:    crand 4*cr6+lt, lt, 4*cr6+lt
; CHECK-NEXT:    bc 4, 4*cr6+gt, .LBB0_20
; CHECK-NEXT:  # %bb.19: # %bb68
; CHECK-NEXT:    ld r5, 0(r3)
; CHECK-NEXT:  .LBB0_20: # %bb70
; CHECK-NEXT:    ld r6, 0(r3)
; CHECK-NEXT:    lwz r9, -4(r1)
; CHECK-NEXT:    crandc 4*cr5+gt, 4*cr5+gt, 4*cr7+eq
; CHECK-NEXT:    crandc 4*cr7+eq, 4*cr7+un, 4*cr2+eq
; CHECK-NEXT:    crandc 4*cr5+lt, 4*cr5+lt, 4*cr6+eq
; CHECK-NEXT:    setbc r7, 4*cr6+un
; CHECK-NEXT:    setbc r8, 4*cr5+un
; CHECK-NEXT:    lwz r12, 8(r1)
; CHECK-NEXT:    xxlxor f2, f2, f2
; CHECK-NEXT:    isel r3, r3, r5, 4*cr5+gt
; CHECK-NEXT:    setbc r5, 4*cr7+gt
; CHECK-NEXT:    crnor 4*cr5+gt, 4*cr6+gt, 4*cr5+gt
; CHECK-NEXT:    crnor 4*cr6+gt, 4*cr7+lt, 4*cr7+eq
; CHECK-NEXT:    crnor 4*cr5+lt, 4*cr6+lt, 4*cr5+lt
; CHECK-NEXT:    add r5, r7, r5
; CHECK-NEXT:    add r5, r8, r5
; CHECK-NEXT:    isel r3, 0, r3, 4*cr5+gt
; CHECK-NEXT:    isel r4, 0, r4, 4*cr5+lt
; CHECK-NEXT:    isel r6, 0, r6, 4*cr6+gt
; CHECK-NEXT:    mtocrf 128, r9
; CHECK-NEXT:    mtfprd f0, r5
; CHECK-NEXT:    isel r4, 0, r4, 4*cr5+eq
; CHECK-NEXT:    mtocrf 32, r12
; CHECK-NEXT:    mtocrf 16, r12
; CHECK-NEXT:    mtocrf 8, r12
; CHECK-NEXT:    iseleq r3, 0, r3
; CHECK-NEXT:    isel r6, 0, r6, 4*cr1+eq
; CHECK-NEXT:    xscvsxddp f0, f0
; CHECK-NEXT:    add r3, r6, r3
; CHECK-NEXT:    add r3, r4, r3
; CHECK-NEXT:    mtfprd f1, r3
; CHECK-NEXT:    xsmuldp f0, f0, f2
; CHECK-NEXT:    xscvsxddp f1, f1
; CHECK-NEXT:    xsadddp f1, f0, f1
; CHECK-NEXT:    blr
bb:
  %tmp = getelementptr inbounds %4, ptr null, i64 undef, i32 7
  %tmp1 = load i64, ptr undef, align 8
  %tmp2 = load i64, ptr null, align 8
  %tmp3 = load i64, ptr %tmp, align 8
  %tmp4 = icmp eq i64 %tmp1, 0
  %tmp5 = icmp eq i64 %tmp2, 0
  %tmp6 = icmp eq i64 %tmp3, 0
  %tmp7 = xor i1 %tmp4, true
  %tmp8 = xor i1 %tmp5, true
  %tmp9 = xor i1 %tmp6, true
  br i1 %tmp4, label %bb12, label %bb10

bb10:                                             ; preds = %bb
  %tmp11 = load i32, ptr undef, align 8
  br label %bb12

bb12:                                             ; preds = %bb10, %bb
  %tmp13 = phi i32 [ undef, %bb ], [ %tmp11, %bb10 ]
  br i1 %tmp5, label %bb16, label %bb14

bb14:                                             ; preds = %bb12
  %tmp15 = load i32, ptr undef, align 8
  br label %bb16

bb16:                                             ; preds = %bb14, %bb12
  %tmp17 = phi i32 [ undef, %bb12 ], [ %tmp15, %bb14 ]
  br i1 %tmp6, label %bb20, label %bb18

bb18:                                             ; preds = %bb16
  %tmp19 = load i32, ptr undef, align 8
  br label %bb20

bb20:                                             ; preds = %bb18, %bb16
  %tmp21 = phi i32 [ undef, %bb16 ], [ %tmp19, %bb18 ]
  %tmp22 = icmp slt i32 %tmp13, 0
  %tmp23 = icmp slt i32 %tmp17, 0
  %tmp24 = icmp slt i32 %tmp21, 0
  %tmp25 = icmp eq i32 %tmp13, 0
  %tmp26 = icmp eq i32 %tmp17, 0
  %tmp27 = icmp eq i32 %tmp21, 0
  %tmp28 = xor i1 %tmp22, true
  %tmp29 = xor i1 %tmp23, true
  %tmp30 = xor i1 %tmp24, true
  %tmp31 = and i1 %tmp28, %tmp7
  %tmp32 = and i1 %tmp29, %tmp8
  %tmp33 = and i1 %tmp30, %tmp9
  br i1 %tmp31, label %bb34, label %bb36

bb34:                                             ; preds = %bb20
  %tmp35 = load i64, ptr undef, align 8
  br label %bb36

bb36:                                             ; preds = %bb34, %bb20
  %tmp37 = phi i64 [ undef, %bb20 ], [ %tmp35, %bb34 ]
  br i1 %tmp33, label %bb38, label %bb40

bb38:                                             ; preds = %bb36
  %tmp39 = load i64, ptr undef, align 8
  br label %bb40

bb40:                                             ; preds = %bb38, %bb36
  %tmp41 = phi i64 [ undef, %bb36 ], [ %tmp39, %bb38 ]
  %tmp42 = and i1 %tmp25, %tmp7
  %tmp43 = and i1 %tmp26, %tmp8
  %tmp44 = and i1 %tmp27, %tmp9
  %tmp45 = and i1 %tmp22, %tmp7
  %tmp46 = and i1 %tmp23, %tmp8
  %tmp47 = and i1 %tmp24, %tmp9
  br i1 %tmp47, label %bb48, label %bb50

bb48:                                             ; preds = %bb40
  %tmp49 = load ptr, ptr undef, align 8
  br label %bb50

bb50:                                             ; preds = %bb48, %bb40
  %tmp51 = phi ptr [ undef, %bb40 ], [ %tmp49, %bb48 ]
  br i1 %tmp45, label %bb52, label %bb54

bb52:                                             ; preds = %bb50
  %tmp53 = load i32, ptr undef, align 8
  br label %bb54

bb54:                                             ; preds = %bb52, %bb50
  %tmp55 = phi i32 [ undef, %bb50 ], [ %tmp53, %bb52 ]
  br i1 %tmp46, label %bb56, label %bb58

bb56:                                             ; preds = %bb54
  %tmp57 = load i32, ptr undef, align 8
  br label %bb58

bb58:                                             ; preds = %bb56, %bb54
  %tmp59 = phi i32 [ undef, %bb54 ], [ %tmp57, %bb56 ]
  %tmp60 = getelementptr inbounds %3, ptr %tmp51, i64 0, i32 12
  %tmp61 = load i32, ptr %tmp60, align 8
  %tmp62 = icmp slt i32 %tmp55, 1
  %tmp63 = icmp slt i32 %tmp59, 1
  %tmp64 = icmp slt i32 %tmp61, 1
  %tmp65 = and i1 %tmp62, %tmp45
  %tmp66 = and i1 %tmp63, %tmp46
  %tmp67 = and i1 %tmp64, %tmp47
  br i1 %tmp65, label %bb68, label %bb70

bb68:                                             ; preds = %bb58
  %tmp69 = load i64, ptr undef, align 8
  br label %bb70

bb70:                                             ; preds = %bb68, %bb58
  %tmp71 = phi i64 [ undef, %bb58 ], [ %tmp69, %bb68 ]
  %tmp72 = load i64, ptr undef, align 8
  %tmp73 = xor i1 %tmp25, true
  %tmp74 = xor i1 %tmp26, true
  %tmp75 = xor i1 %tmp27, true
  %tmp76 = and i1 %tmp31, %tmp73
  %tmp77 = and i1 %tmp32, %tmp74
  %tmp78 = and i1 %tmp33, %tmp75
  %tmp79 = select i1 %tmp76, i64 %tmp37, i64 %tmp71
  %tmp80 = select i1 %tmp77, i64 undef, i64 %tmp72
  %tmp81 = select i1 %tmp78, i64 %tmp41, i64 undef
  %tmp82 = or i1 %tmp65, %tmp76
  %tmp83 = or i1 %tmp66, %tmp77
  %tmp84 = or i1 %tmp67, %tmp78
  %tmp85 = zext i1 %tmp42 to i64
  %tmp86 = add i64 0, %tmp85
  %tmp87 = zext i1 %tmp43 to i64
  %tmp88 = add i64 0, %tmp87
  %tmp89 = zext i1 %tmp44 to i64
  %tmp90 = add i64 0, %tmp89
  %tmp91 = select i1 %tmp82, i64 %tmp79, i64 0
  %tmp92 = add i64 0, %tmp91
  %tmp93 = select i1 %tmp83, i64 %tmp80, i64 0
  %tmp94 = add i64 0, %tmp93
  %tmp95 = select i1 %tmp84, i64 %tmp81, i64 0
  %tmp96 = add i64 0, %tmp95
  %tmp97 = select i1 %tmp42, i64 undef, i64 %tmp92
  %tmp98 = select i1 %tmp43, i64 undef, i64 %tmp94
  %tmp99 = select i1 %tmp44, i64 undef, i64 %tmp96
  %tmp100 = select i1 %tmp4, i64 0, i64 %tmp97
  %tmp101 = select i1 %tmp5, i64 0, i64 %tmp98
  %tmp102 = select i1 %tmp6, i64 0, i64 %tmp99
  %tmp103 = add i64 %tmp88, %tmp86
  %tmp104 = add i64 %tmp90, %tmp103
  %tmp105 = add i64 0, %tmp104
  %tmp106 = add i64 %tmp101, %tmp100
  %tmp107 = add i64 %tmp102, %tmp106
  %tmp108 = add i64 0, %tmp107
  %tmp109 = sitofp i64 %tmp105 to double
  %tmp110 = sitofp i64 %tmp108 to double
  %tmp111 = fmul double %tmp109, 0.000000e+00
  %tmp112 = fadd double %tmp111, %tmp110
  ret double %tmp112
}
