; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -verify-machineinstrs -mattr=+sme < %s | FileCheck %s

; This file tests the following combinations related to streaming-enabled functions:
; [ ] N  ->  SC    (Normal -> Streaming-compatible)
; [ ] SC  ->  N    (Streaming-compatible -> Normal)
; [ ] SC  ->  S    (Streaming-compatible -> Streaming)
; [ ] SC  ->  SC   (Streaming-compatible -> Streaming-compatible)
;
; The following combination is tested in sme-streaming-interface.ll
; [ ] S  ->  SC    (Streaming -> Streaming-compatible)

declare void @normal_callee();
declare void @streaming_callee() "aarch64_pstate_sm_enabled";
declare void @streaming_compatible_callee() "aarch64_pstate_sm_compatible";

; [x] N   ->  SC   (Normal -> Streaming-compatible)
; [ ] SC  ->  N    (Streaming-compatible -> Normal)
; [ ] SC  ->  S    (Streaming-compatible -> Streaming)
; [ ] SC  ->  SC   (Streaming-compatible -> Streaming-compatible)
define void @normal_caller_streaming_compatible_callee() nounwind {
; CHECK-LABEL: normal_caller_streaming_compatible_callee:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    bl streaming_compatible_callee
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  call void @streaming_compatible_callee();
  ret void;
}

; [ ] N   ->  SC   (Normal -> Streaming-compatible)
; [x] SC  ->  N    (Streaming-compatible -> Normal)
; [ ] SC  ->  S    (Streaming-compatible -> Streaming)
; [ ] SC  ->  SC   (Streaming-compatible -> Streaming-compatible)
define void @streaming_compatible_caller_normal_callee() "aarch64_pstate_sm_compatible" nounwind {
; CHECK-LABEL: streaming_compatible_caller_normal_callee:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp d15, d14, [sp, #-80]! // 16-byte Folded Spill
; CHECK-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-NEXT:    stp x30, x19, [sp, #64] // 16-byte Folded Spill
; CHECK-NEXT:    bl __arm_sme_state
; CHECK-NEXT:    and x19, x0, #0x1
; CHECK-NEXT:    tbz w19, #0, .LBB1_2
; CHECK-NEXT:  // %bb.1:
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:  .LBB1_2:
; CHECK-NEXT:    bl normal_callee
; CHECK-NEXT:    tbz w19, #0, .LBB1_4
; CHECK-NEXT:  // %bb.3:
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:  .LBB1_4:
; CHECK-NEXT:    ldp x30, x19, [sp, #64] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d15, d14, [sp], #80 // 16-byte Folded Reload
; CHECK-NEXT:    ret

  call void @normal_callee();
  ret void;
}

; Streaming Compatible Caller, Streaming Callee

; [ ] N   ->  SC   (Normal -> Streaming-compatible)
; [ ] SC  ->  N    (Streaming-compatible -> Normal)
; [x] SC  ->  S    (Streaming-compatible -> Streaming)
; [ ] SC  ->  SC   (Streaming-compatible -> Streaming-compatible)
define void @streaming_compatible_caller_streaming_callee() "aarch64_pstate_sm_compatible" nounwind {
; CHECK-LABEL: streaming_compatible_caller_streaming_callee:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp d15, d14, [sp, #-80]! // 16-byte Folded Spill
; CHECK-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-NEXT:    stp x30, x19, [sp, #64] // 16-byte Folded Spill
; CHECK-NEXT:    bl __arm_sme_state
; CHECK-NEXT:    and x19, x0, #0x1
; CHECK-NEXT:    tbnz w19, #0, .LBB2_2
; CHECK-NEXT:  // %bb.1:
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:  .LBB2_2:
; CHECK-NEXT:    bl streaming_callee
; CHECK-NEXT:    tbnz w19, #0, .LBB2_4
; CHECK-NEXT:  // %bb.3:
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:  .LBB2_4:
; CHECK-NEXT:    ldp x30, x19, [sp, #64] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d15, d14, [sp], #80 // 16-byte Folded Reload
; CHECK-NEXT:    ret

  call void @streaming_callee();
  ret void;
}

; [ ] N  ->  SC    (Normal -> Streaming-compatible)
; [ ] SC  ->  N    (Streaming-compatible -> Normal)
; [ ] SC  ->  S    (Streaming-compatible -> Streaming)
; [x] SC  ->  SC   (Streaming-compatible -> Streaming-compatible)
define void @streaming_compatible_caller_and_callee() "aarch64_pstate_sm_compatible" nounwind {
; CHECK-LABEL: streaming_compatible_caller_and_callee:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    bl streaming_compatible_callee
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret

  call void @streaming_compatible_callee();
  ret void;
}


;
; Handle special cases here.
;

define <2 x double> @streaming_compatible_with_neon_vectors(<2 x double> %arg) "aarch64_pstate_sm_compatible" nounwind {
; CHECK-LABEL: streaming_compatible_with_neon_vectors:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp d15, d14, [sp, #-96]! // 16-byte Folded Spill
; CHECK-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-NEXT:    str x29, [sp, #64] // 8-byte Folded Spill
; CHECK-NEXT:    stp x30, x19, [sp, #80] // 16-byte Folded Spill
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    add x8, sp, #16
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    str z0, [x8] // 16-byte Folded Spill
; CHECK-NEXT:    bl __arm_sme_state
; CHECK-NEXT:    add x8, sp, #16
; CHECK-NEXT:    and x19, x0, #0x1
; CHECK-NEXT:    ldr z0, [x8] // 16-byte Folded Reload
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    str q0, [sp] // 16-byte Folded Spill
; CHECK-NEXT:    tbz w19, #0, .LBB4_2
; CHECK-NEXT:  // %bb.1:
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:  .LBB4_2:
; CHECK-NEXT:    ldr q0, [sp] // 16-byte Folded Reload
; CHECK-NEXT:    bl normal_callee_vec_arg
; CHECK-NEXT:    str q0, [sp] // 16-byte Folded Spill
; CHECK-NEXT:    tbz w19, #0, .LBB4_4
; CHECK-NEXT:  // %bb.3:
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:  .LBB4_4:
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    add x8, sp, #16
; CHECK-NEXT:    ldr q0, [sp] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z1, [x8] // 16-byte Folded Reload
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    fadd z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    ldp x30, x19, [sp, #80] // 16-byte Folded Reload
; CHECK-NEXT:    ldr x29, [sp, #64] // 8-byte Folded Reload
; CHECK-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d15, d14, [sp], #96 // 16-byte Folded Reload
; CHECK-NEXT:    ret
  %res = call <2 x double> @normal_callee_vec_arg(<2 x double> %arg)
  %fadd = fadd <2 x double> %res, %arg
  ret <2 x double> %fadd
}
declare <2 x double> @normal_callee_vec_arg(<2 x double>)

define <vscale x 2 x double> @streaming_compatible_with_scalable_vectors(<vscale x 2 x double> %arg) "aarch64_pstate_sm_compatible" nounwind {
; CHECK-LABEL: streaming_compatible_with_scalable_vectors:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-32]! // 8-byte Folded Spill
; CHECK-NEXT:    stp x30, x19, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-18
; CHECK-NEXT:    str p15, [sp, #4, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p14, [sp, #5, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p13, [sp, #6, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p12, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p11, [sp, #8, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p10, [sp, #9, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p9, [sp, #10, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p8, [sp, #11, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p7, [sp, #12, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p6, [sp, #13, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p5, [sp, #14, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p4, [sp, #15, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str z23, [sp, #2, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z22, [sp, #3, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z21, [sp, #4, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z20, [sp, #5, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z19, [sp, #6, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z18, [sp, #7, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z17, [sp, #8, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z16, [sp, #9, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z15, [sp, #10, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z14, [sp, #11, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z13, [sp, #12, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z12, [sp, #13, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z11, [sp, #14, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z10, [sp, #15, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z9, [sp, #16, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z8, [sp, #17, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-2
; CHECK-NEXT:    str z0, [sp, #1, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    bl __arm_sme_state
; CHECK-NEXT:    and x19, x0, #0x1
; CHECK-NEXT:    tbz w19, #0, .LBB5_2
; CHECK-NEXT:  // %bb.1:
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:  .LBB5_2:
; CHECK-NEXT:    ldr z0, [sp, #1, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    bl normal_callee_scalable_vec_arg
; CHECK-NEXT:    str z0, [sp] // 16-byte Folded Spill
; CHECK-NEXT:    tbz w19, #0, .LBB5_4
; CHECK-NEXT:  // %bb.3:
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:  .LBB5_4:
; CHECK-NEXT:    ldr z0, [sp, #1, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z1, [sp] // 16-byte Folded Reload
; CHECK-NEXT:    fadd z0.d, z1.d, z0.d
; CHECK-NEXT:    addvl sp, sp, #2
; CHECK-NEXT:    ldr z23, [sp, #2, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z22, [sp, #3, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z21, [sp, #4, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z20, [sp, #5, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z19, [sp, #6, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z18, [sp, #7, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z17, [sp, #8, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z16, [sp, #9, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z15, [sp, #10, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z14, [sp, #11, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z13, [sp, #12, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z12, [sp, #13, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z11, [sp, #14, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z10, [sp, #15, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z9, [sp, #16, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z8, [sp, #17, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr p15, [sp, #4, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p14, [sp, #5, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p13, [sp, #6, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p12, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p11, [sp, #8, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p10, [sp, #9, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p9, [sp, #10, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p8, [sp, #11, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p7, [sp, #12, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p6, [sp, #13, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p5, [sp, #14, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p4, [sp, #15, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #18
; CHECK-NEXT:    ldp x30, x19, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldr x29, [sp], #32 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %res = call <vscale x 2 x double> @normal_callee_scalable_vec_arg(<vscale x 2 x double> %arg)
  %fadd = fadd <vscale x 2 x double> %res, %arg
  ret <vscale x 2 x double> %fadd
}

declare <vscale x 2 x double> @normal_callee_scalable_vec_arg(<vscale x 2 x double>)

define <vscale x 2 x i1> @streaming_compatible_with_predicate_vectors(<vscale x 2 x i1> %arg) "aarch64_pstate_sm_compatible" nounwind {
; CHECK-LABEL: streaming_compatible_with_predicate_vectors:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-32]! // 8-byte Folded Spill
; CHECK-NEXT:    stp x30, x19, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-18
; CHECK-NEXT:    str p15, [sp, #4, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p14, [sp, #5, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p13, [sp, #6, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p12, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p11, [sp, #8, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p10, [sp, #9, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p9, [sp, #10, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p8, [sp, #11, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p7, [sp, #12, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p6, [sp, #13, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p5, [sp, #14, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p4, [sp, #15, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str z23, [sp, #2, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z22, [sp, #3, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z21, [sp, #4, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z20, [sp, #5, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z19, [sp, #6, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z18, [sp, #7, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z17, [sp, #8, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z16, [sp, #9, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z15, [sp, #10, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z14, [sp, #11, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z13, [sp, #12, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z12, [sp, #13, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z11, [sp, #14, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z10, [sp, #15, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z9, [sp, #16, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z8, [sp, #17, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    str p0, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    bl __arm_sme_state
; CHECK-NEXT:    and x19, x0, #0x1
; CHECK-NEXT:    tbz w19, #0, .LBB6_2
; CHECK-NEXT:  // %bb.1:
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:  .LBB6_2:
; CHECK-NEXT:    ldr p0, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    bl normal_callee_predicate_vec_arg
; CHECK-NEXT:    str p0, [sp, #6, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    tbz w19, #0, .LBB6_4
; CHECK-NEXT:  // %bb.3:
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:  .LBB6_4:
; CHECK-NEXT:    ldr p0, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p1, [sp, #6, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    and p0.b, p1/z, p1.b, p0.b
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr z23, [sp, #2, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z22, [sp, #3, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z21, [sp, #4, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z20, [sp, #5, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z19, [sp, #6, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z18, [sp, #7, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z17, [sp, #8, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z16, [sp, #9, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z15, [sp, #10, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z14, [sp, #11, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z13, [sp, #12, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z12, [sp, #13, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z11, [sp, #14, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z10, [sp, #15, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z9, [sp, #16, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z8, [sp, #17, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr p15, [sp, #4, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p14, [sp, #5, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p13, [sp, #6, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p12, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p11, [sp, #8, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p10, [sp, #9, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p9, [sp, #10, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p8, [sp, #11, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p7, [sp, #12, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p6, [sp, #13, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p5, [sp, #14, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p4, [sp, #15, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #18
; CHECK-NEXT:    ldp x30, x19, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldr x29, [sp], #32 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %res = call <vscale x 2 x i1> @normal_callee_predicate_vec_arg(<vscale x 2 x i1> %arg)
  %and = and <vscale x 2 x i1> %res, %arg
  ret <vscale x 2 x i1> %and
}

declare <vscale x 2 x i1> @normal_callee_predicate_vec_arg(<vscale x 2 x i1>)

define i32 @conditional_smstart_unreachable_block() "aarch64_pstate_sm_compatible" nounwind {
; CHECK-LABEL: conditional_smstart_unreachable_block:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp d15, d14, [sp, #-80]! // 16-byte Folded Spill
; CHECK-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-NEXT:    stp x30, x19, [sp, #64] // 16-byte Folded Spill
; CHECK-NEXT:    bl __arm_sme_state
; CHECK-NEXT:    and x19, x0, #0x1
; CHECK-NEXT:    tbnz w19, #0, .LBB7_2
; CHECK-NEXT:  // %bb.1:
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:  .LBB7_2:
; CHECK-NEXT:    bl streaming_callee
  call void @streaming_callee()
  unreachable
}

define void @conditional_smstart_no_successor_block(i1 %p) "aarch64_pstate_sm_compatible" nounwind {
; CHECK-LABEL: conditional_smstart_no_successor_block:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tbz w0, #0, .LBB8_6
; CHECK-NEXT:  // %bb.1: // %if.then
; CHECK-NEXT:    stp d15, d14, [sp, #-80]! // 16-byte Folded Spill
; CHECK-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-NEXT:    stp x30, x19, [sp, #64] // 16-byte Folded Spill
; CHECK-NEXT:    bl __arm_sme_state
; CHECK-NEXT:    and x19, x0, #0x1
; CHECK-NEXT:    tbnz w19, #0, .LBB8_3
; CHECK-NEXT:  // %bb.2: // %if.then
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:  .LBB8_3: // %if.then
; CHECK-NEXT:    bl streaming_callee
; CHECK-NEXT:    tbnz w19, #0, .LBB8_5
; CHECK-NEXT:  // %bb.4: // %if.then
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:  .LBB8_5: // %if.then
; CHECK-NEXT:    ldp x30, x19, [sp, #64] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d15, d14, [sp], #80 // 16-byte Folded Reload
; CHECK-NEXT:  .LBB8_6: // %exit
; CHECK-NEXT:    ret
  br i1 %p, label %if.then, label %exit

if.then:
  call void @streaming_callee()
  br label %exit

exit:
  ret void
}

define void @disable_tailcallopt() "aarch64_pstate_sm_compatible" nounwind {
; CHECK-LABEL: disable_tailcallopt:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp d15, d14, [sp, #-80]! // 16-byte Folded Spill
; CHECK-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-NEXT:    stp x30, x19, [sp, #64] // 16-byte Folded Spill
; CHECK-NEXT:    bl __arm_sme_state
; CHECK-NEXT:    and x19, x0, #0x1
; CHECK-NEXT:    tbz w19, #0, .LBB9_2
; CHECK-NEXT:  // %bb.1:
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:  .LBB9_2:
; CHECK-NEXT:    bl normal_callee
; CHECK-NEXT:    tbz w19, #0, .LBB9_4
; CHECK-NEXT:  // %bb.3:
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:  .LBB9_4:
; CHECK-NEXT:    ldp x30, x19, [sp, #64] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d15, d14, [sp], #80 // 16-byte Folded Reload
; CHECK-NEXT:    ret

  tail call void @normal_callee();
  ret void;
}

define void @call_to_non_streaming_pass_args(ptr nocapture noundef readnone %ptr, i64 %long1, i64 %long2, i32 %int1, i32 %int2, float %float1, float %float2, double %double1, double %double2) "aarch64_pstate_sm_compatible" {
; CHECK-LABEL: call_to_non_streaming_pass_args:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub sp, sp, #112
; CHECK-NEXT:    stp d15, d14, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    stp d13, d12, [sp, #48] // 16-byte Folded Spill
; CHECK-NEXT:    stp d11, d10, [sp, #64] // 16-byte Folded Spill
; CHECK-NEXT:    stp d9, d8, [sp, #80] // 16-byte Folded Spill
; CHECK-NEXT:    stp x30, x19, [sp, #96] // 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 112
; CHECK-NEXT:    .cfi_offset w19, -8
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    .cfi_offset b8, -24
; CHECK-NEXT:    .cfi_offset b9, -32
; CHECK-NEXT:    .cfi_offset b10, -40
; CHECK-NEXT:    .cfi_offset b11, -48
; CHECK-NEXT:    .cfi_offset b12, -56
; CHECK-NEXT:    .cfi_offset b13, -64
; CHECK-NEXT:    .cfi_offset b14, -72
; CHECK-NEXT:    .cfi_offset b15, -80
; CHECK-NEXT:    stp d2, d3, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    mov x8, x1
; CHECK-NEXT:    mov x9, x0
; CHECK-NEXT:    stp s0, s1, [sp, #8] // 8-byte Folded Spill
; CHECK-NEXT:    bl __arm_sme_state
; CHECK-NEXT:    ldp s4, s0, [sp, #8] // 8-byte Folded Reload
; CHECK-NEXT:    and x19, x0, #0x1
; CHECK-NEXT:    stp s4, s0, [sp, #8] // 8-byte Folded Spill
; CHECK-NEXT:    ldp d4, d0, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    stp d4, d0, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    tbz w19, #0, .LBB10_2
; CHECK-NEXT:  // %bb.1: // %entry
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:  .LBB10_2: // %entry
; CHECK-NEXT:    ldp s0, s1, [sp, #8] // 8-byte Folded Reload
; CHECK-NEXT:    mov x0, x9
; CHECK-NEXT:    ldp d2, d3, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    mov x1, x8
; CHECK-NEXT:    bl bar
; CHECK-NEXT:    tbz w19, #0, .LBB10_4
; CHECK-NEXT:  // %bb.3: // %entry
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:  .LBB10_4: // %entry
; CHECK-NEXT:    ldp x30, x19, [sp, #96] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d9, d8, [sp, #80] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d11, d10, [sp, #64] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d13, d12, [sp, #48] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d15, d14, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #112
; CHECK-NEXT:    ret
entry:
  call void @bar(ptr noundef nonnull %ptr, i64 %long1, i64 %long2, i32 %int1, i32 %int2, float %float1, float %float2, double %double1, double %double2)
  ret void
}

declare void @bar(ptr noundef, i64 noundef, i64 noundef, i32 noundef, i32 noundef, float noundef, float noundef, double noundef, double noundef)
