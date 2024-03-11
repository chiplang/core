; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn -mcpu=gfx1010 -verify-machineinstrs -o - %s | FileCheck --check-prefix=GCN %s
;
; This test shows a typical case that a PHI(%c2) in join block was treated as uniform
; as it has one unique uniform incoming value plus one additional undef incoming
; value. This case might suffer from correctness issue if %c2 was assigned a scalar
; register but meanwhile dead in %if. The problem is solved by replacing the %undef
; with %c (thus replacing %c2 with %c in this example).


define amdgpu_ps float @uniform_phi_with_undef(float inreg %c, float %v, i32 %x, i32 %y) #0 {
; GCN-LABEL: uniform_phi_with_undef:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    v_cmp_lt_i32_e64 s2, v2, v1
; GCN-NEXT:    s_mov_b32 s1, exec_lo
; GCN-NEXT:    s_and_b32 s2, s1, s2
; GCN-NEXT:    s_mov_b32 exec_lo, s2
; GCN-NEXT:    s_cbranch_execz .LBB0_2
; GCN-NEXT:  ; %bb.1: ; %if
; GCN-NEXT:    s_mov_b32 s2, 2.0
; GCN-NEXT:    v_div_scale_f32 v1, s3, s2, s2, v0
; GCN-NEXT:    v_rcp_f32_e64 v2, v1
; GCN-NEXT:    s_mov_b32 s3, 1.0
; GCN-NEXT:    v_fma_f32 v3, -v1, v2, s3
; GCN-NEXT:    v_fmac_f32_e64 v2, v3, v2
; GCN-NEXT:    v_div_scale_f32 v3, vcc_lo, v0, s2, v0
; GCN-NEXT:    v_mul_f32_e64 v4, v3, v2
; GCN-NEXT:    v_fma_f32 v5, -v1, v4, v3
; GCN-NEXT:    v_fmac_f32_e64 v4, v5, v2
; GCN-NEXT:    v_fma_f32 v1, -v1, v4, v3
; GCN-NEXT:    v_div_fmas_f32 v1, v1, v2, v4
; GCN-NEXT:    v_div_fixup_f32 v0, v1, s2, v0
; GCN-NEXT:  .LBB0_2: ; %end
; GCN-NEXT:    s_or_b32 exec_lo, exec_lo, s1
; GCN-NEXT:    v_add_f32_e64 v0, v0, s0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %cc = icmp slt i32 %y, %x
  br i1 %cc, label %if, label %end

if:
  %v.if = fdiv float %v, 2.0
  br label %end

end:
  %v2 = phi float [ %v.if, %if ], [ %v, %entry ]
  %c2 = phi float [ undef, %if ], [ %c, %entry ]
  %r = fadd float %v2, %c2
  ret float %r
}

attributes #0 = { nounwind optnone noinline }
