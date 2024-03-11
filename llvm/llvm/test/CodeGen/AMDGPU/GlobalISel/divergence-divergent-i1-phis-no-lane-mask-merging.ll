; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdpal -mcpu=gfx1010 -verify-machineinstrs < %s | FileCheck -check-prefix=GFX10 %s

; Divergent phis that don't require lowering using lane mask merging

; - divergent phi that has divergent incoming value (this makes it divergent)
;   but is reachable through only one path - branch instruction that chooses
;   path is uniform

; - divergent phi that is used only inside the loop and has incoming from
;   previous iteration. After phi-elimination (rewrite lane mask in phi def with
;   lane mask value from previous iteration), phi will hold lane mask valid for
;   current iteration which is fine since it is not used outside of the loop.

; And one more that is tricky (is branch divergent or not ?)
; "amdgpu-flat-work-group-size"="1,1" aka single lane execution does not stop
; shader from activating multiple lanes by using some intrinsic (entering wwm
; and using dpp instructions)
; - there are cases with single lane execution where branch instructions are not
;   lowered to si_if (or other intrinsic branches) - with intention to use
;   uniform branch after instruction selection?
;   PhiIncomingAnalysis does not recognize G_BRCOND as divergent branch and does
;   not perform lane mask merging



define amdgpu_ps void @divergent_i1_phi_uniform_branch(ptr addrspace(1) %out, i32 %tid, i32 inreg %cond, ptr addrspace(1) %dummyaddr) {
; GFX10-LABEL: divergent_i1_phi_uniform_branch:
; GFX10:       ; %bb.0: ; %A
; GFX10-NEXT:    s_cmp_lg_u32 s0, 0
; GFX10-NEXT:    s_cbranch_scc0 .LBB0_2
; GFX10-NEXT:  ; %bb.1:
; GFX10-NEXT:    v_cmp_le_u32_e64 s0, 6, v2
; GFX10-NEXT:    s_branch .LBB0_3
; GFX10-NEXT:  .LBB0_2: ; %dummy
; GFX10-NEXT:    v_mov_b32_e32 v5, 0x7b
; GFX10-NEXT:    v_cmp_gt_u32_e64 s0, 1, v2
; GFX10-NEXT:    global_store_dword v[3:4], v5, off
; GFX10-NEXT:  .LBB0_3: ; %exit
; GFX10-NEXT:    v_cndmask_b32_e64 v2, 0, -1, s0
; GFX10-NEXT:    v_add_nc_u32_e32 v2, 2, v2
; GFX10-NEXT:    global_store_dword v[0:1], v2, off
; GFX10-NEXT:    s_endpgm
A:
  %val_A = icmp uge i32 %tid, 6
  %cmp = icmp eq i32 %cond, 0
  br i1 %cmp, label %dummy, label %exit

dummy:
  store i32 123, ptr addrspace(1) %dummyaddr
  br label %B

B:
  %val_B = icmp ult i32 %tid, 1
  br label %exit

exit:
  %phi = phi i1 [ %val_A, %A ], [ %val_B, %B ]
  %sel = select i1 %phi, i32 1, i32 2
  store i32 %sel, ptr addrspace(1) %out
  ret void
}

; Fix me - there is no need to merge lane masks here
define amdgpu_ps void @divergent_i1_phi_uniform_branch_simple(ptr addrspace(1) %out, i32 %tid, i32 inreg %cond) {
; GFX10-LABEL: divergent_i1_phi_uniform_branch_simple:
; GFX10:       ; %bb.0: ; %A
; GFX10-NEXT:    v_cmp_le_u32_e64 s1, 6, v2
; GFX10-NEXT:    s_cmp_lg_u32 s0, 0
; GFX10-NEXT:    s_cbranch_scc1 .LBB1_2
; GFX10-NEXT:  ; %bb.1: ; %B
; GFX10-NEXT:    v_cmp_gt_u32_e32 vcc_lo, 1, v2
; GFX10-NEXT:    s_andn2_b32 s0, s1, exec_lo
; GFX10-NEXT:    s_and_b32 s1, exec_lo, vcc_lo
; GFX10-NEXT:    s_or_b32 s1, s0, s1
; GFX10-NEXT:  .LBB1_2: ; %exit
; GFX10-NEXT:    v_cndmask_b32_e64 v2, 0, -1, s1
; GFX10-NEXT:    v_add_nc_u32_e32 v2, 2, v2
; GFX10-NEXT:    global_store_dword v[0:1], v2, off
; GFX10-NEXT:    s_endpgm
A:
  %val_A = icmp uge i32 %tid, 6
  %cmp = icmp eq i32 %cond, 0
  br i1 %cmp, label %B, label %exit

B:
  %val_B = icmp ult i32 %tid, 1
  br label %exit

exit:
  %phi = phi i1 [ %val_A, %A ], [ %val_B, %B ]
  %sel = select i1 %phi, i32 1, i32 2
  store i32 %sel, ptr addrspace(1) %out
  ret void
}


; Divergent i1 phi that uses value from previous iteration.
; Used only inside the loop (variable name is bool_counter)
define void @divergent_i1_phi_used_inside_loop(float %val, ptr %addr) {
; GFX10-LABEL: divergent_i1_phi_used_inside_loop:
; GFX10:       ; %bb.0: ; %entry
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_mov_b32 s5, 0
; GFX10-NEXT:    v_mov_b32_e32 v3, 1
; GFX10-NEXT:    v_mov_b32_e32 v4, s5
; GFX10-NEXT:    ; implicit-def: $sgpr6
; GFX10-NEXT:  .LBB2_1: ; %loop
; GFX10-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX10-NEXT:    v_xor_b32_e32 v3, 1, v3
; GFX10-NEXT:    v_cvt_f32_u32_e32 v5, v4
; GFX10-NEXT:    v_add_nc_u32_e32 v4, 1, v4
; GFX10-NEXT:    v_and_b32_e32 v6, 1, v3
; GFX10-NEXT:    v_cmp_gt_f32_e32 vcc_lo, v5, v0
; GFX10-NEXT:    v_cmp_ne_u32_e64 s4, 0, v6
; GFX10-NEXT:    s_or_b32 s5, vcc_lo, s5
; GFX10-NEXT:    s_andn2_b32 s6, s6, exec_lo
; GFX10-NEXT:    s_and_b32 s4, exec_lo, s4
; GFX10-NEXT:    s_or_b32 s6, s6, s4
; GFX10-NEXT:    s_andn2_b32 exec_lo, exec_lo, s5
; GFX10-NEXT:    s_cbranch_execnz .LBB2_1
; GFX10-NEXT:  ; %bb.2: ; %exit
; GFX10-NEXT:    s_or_b32 exec_lo, exec_lo, s5
; GFX10-NEXT:    v_cndmask_b32_e64 v0, 0, 1.0, s6
; GFX10-NEXT:    flat_store_dword v[1:2], v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_setpc_b64 s[30:31]
entry:
  br label %loop

loop:
  %counter = phi i32 [ 0, %entry ], [ %counterPlus1, %loop ]
  %bool_counter = phi i1 [ true, %entry ], [ %neg_bool_counter, %loop ]
  %neg_bool_counter = xor i1 %bool_counter, true
  %fcounter = uitofp i32 %counter to float
  %cond = fcmp ogt float %fcounter, %val
  %counterPlus1 = add i32 %counter, 1
  br i1 %cond, label %exit, label %loop

exit:
  %select = select i1 %neg_bool_counter, float 1.000000e+00, float 0.000000e+00
  store float %select, ptr %addr
  ret void
}

define void @divergent_i1_phi_used_inside_loop_bigger_loop_body(float %val, float %pre_cond_val, ptr %addr, ptr %addr_if, ptr %addr_else) {
; GFX10-LABEL: divergent_i1_phi_used_inside_loop_bigger_loop_body:
; GFX10:       ; %bb.0: ; %entry
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_mov_b32 s4, 0
; GFX10-NEXT:    v_cmp_lt_f32_e64 s5, 1.0, v1
; GFX10-NEXT:    v_mov_b32_e32 v1, 0x3e8
; GFX10-NEXT:    v_mov_b32_e32 v8, s4
; GFX10-NEXT:    ; implicit-def: $sgpr6
; GFX10-NEXT:    s_branch .LBB3_2
; GFX10-NEXT:  .LBB3_1: ; %loop_body
; GFX10-NEXT:    ; in Loop: Header=BB3_2 Depth=1
; GFX10-NEXT:    v_cvt_f32_u32_e32 v9, v8
; GFX10-NEXT:    s_xor_b32 s5, s5, -1
; GFX10-NEXT:    v_add_nc_u32_e32 v8, 1, v8
; GFX10-NEXT:    v_cmp_gt_f32_e32 vcc_lo, v9, v0
; GFX10-NEXT:    s_or_b32 s4, vcc_lo, s4
; GFX10-NEXT:    s_andn2_b32 s6, s6, exec_lo
; GFX10-NEXT:    s_and_b32 s7, exec_lo, s5
; GFX10-NEXT:    s_or_b32 s6, s6, s7
; GFX10-NEXT:    s_andn2_b32 exec_lo, exec_lo, s4
; GFX10-NEXT:    s_cbranch_execz .LBB3_6
; GFX10-NEXT:  .LBB3_2: ; %loop_start
; GFX10-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX10-NEXT:    v_cmp_ge_i32_e32 vcc_lo, 0x3e8, v8
; GFX10-NEXT:    s_mov_b32 s7, 1
; GFX10-NEXT:    s_cbranch_vccz .LBB3_4
; GFX10-NEXT:  ; %bb.3: ; %else
; GFX10-NEXT:    ; in Loop: Header=BB3_2 Depth=1
; GFX10-NEXT:    s_mov_b32 s7, 0
; GFX10-NEXT:    flat_store_dword v[6:7], v1
; GFX10-NEXT:  .LBB3_4: ; %Flow
; GFX10-NEXT:    ; in Loop: Header=BB3_2 Depth=1
; GFX10-NEXT:    s_xor_b32 s7, s7, 1
; GFX10-NEXT:    s_and_b32 s7, s7, 1
; GFX10-NEXT:    s_cmp_lg_u32 s7, 0
; GFX10-NEXT:    s_cbranch_scc1 .LBB3_1
; GFX10-NEXT:  ; %bb.5: ; %if
; GFX10-NEXT:    ; in Loop: Header=BB3_2 Depth=1
; GFX10-NEXT:    flat_store_dword v[4:5], v1
; GFX10-NEXT:    s_branch .LBB3_1
; GFX10-NEXT:  .LBB3_6: ; %exit
; GFX10-NEXT:    s_or_b32 exec_lo, exec_lo, s4
; GFX10-NEXT:    v_cndmask_b32_e64 v0, 0, 1.0, s6
; GFX10-NEXT:    flat_store_dword v[2:3], v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_setpc_b64 s[30:31]
entry:
  %pre_cond = fcmp ogt float %pre_cond_val, 1.0
  br label %loop_start

loop_start:
  %counter = phi i32 [ 0, %entry ], [ %counterPlus1, %loop_body ]
  %bool_counter = phi i1 [ %pre_cond, %entry ], [ %neg_bool_counter, %loop_body ]
  %cond_break = icmp sgt i32 %counter, 1000
  br i1 %cond_break, label %if, label %else

if:
  store i32 1000, ptr %addr_if
  br label %loop_body

else:
  store i32 1000, ptr %addr_else
  br label %loop_body

loop_body:
  %neg_bool_counter = xor i1 %bool_counter, true
  %fcounter = uitofp i32 %counter to float
  %cond = fcmp ogt float %fcounter, %val
  %counterPlus1 = add i32 %counter, 1
  br i1 %cond, label %exit, label %loop_start

exit:
  %select = select i1 %neg_bool_counter, float 1.000000e+00, float 0.000000e+00
  store float %select, ptr %addr
  ret void
}

; There is a divergent, according to machine uniformity info, g_brcond branch
; here, not lowered to si_if because of "amdgpu-flat-work-group-size"="1,1".
define amdgpu_cs void @single_lane_execution_attribute(i32 inreg %.userdata0, <3 x i32> inreg %.WorkgroupId, <3 x i32> %.LocalInvocationId) #0 {
; GFX10-LABEL: single_lane_execution_attribute:
; GFX10:       ; %bb.0: ; %.entry
; GFX10-NEXT:    s_getpc_b64 s[4:5]
; GFX10-NEXT:    s_mov_b32 s12, 0
; GFX10-NEXT:    s_mov_b32 s13, -1
; GFX10-NEXT:    s_mov_b32 s2, s0
; GFX10-NEXT:    s_and_b64 s[4:5], s[4:5], s[12:13]
; GFX10-NEXT:    s_mov_b32 s3, s12
; GFX10-NEXT:    v_mbcnt_lo_u32_b32 v1, -1, 0
; GFX10-NEXT:    s_or_b64 s[2:3], s[4:5], s[2:3]
; GFX10-NEXT:    s_load_dwordx8 s[4:11], s[2:3], 0x0
; GFX10-NEXT:    v_mbcnt_hi_u32_b32 v1, -1, v1
; GFX10-NEXT:    v_lshlrev_b32_e32 v2, 2, v1
; GFX10-NEXT:    v_and_b32_e32 v3, 1, v1
; GFX10-NEXT:    v_xor_b32_e32 v3, 1, v3
; GFX10-NEXT:    v_and_b32_e32 v3, 1, v3
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    buffer_load_dword v2, v2, s[4:7], 0 offen
; GFX10-NEXT:    v_cmp_ne_u32_e32 vcc_lo, 0, v3
; GFX10-NEXT:    ; implicit-def: $vgpr3
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_cmp_eq_u32_e64 s0, 0, v2
; GFX10-NEXT:    s_cbranch_vccnz .LBB4_4
; GFX10-NEXT:  ; %bb.1: ; %.preheader.preheader
; GFX10-NEXT:    v_mov_b32_e32 v3, s12
; GFX10-NEXT:    v_mov_b32_e32 v4, s12
; GFX10-NEXT:  .LBB4_2: ; %.preheader
; GFX10-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX10-NEXT:    buffer_load_dword v5, v3, s[4:7], 0 offen
; GFX10-NEXT:    v_add_nc_u32_e32 v1, -1, v1
; GFX10-NEXT:    v_add_nc_u32_e32 v3, 4, v3
; GFX10-NEXT:    v_cmp_ne_u32_e32 vcc_lo, 0, v1
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_add_nc_u32_e32 v4, v5, v4
; GFX10-NEXT:    s_cbranch_vccnz .LBB4_2
; GFX10-NEXT:  ; %bb.3: ; %.preheader._crit_edge
; GFX10-NEXT:    v_cmp_eq_u32_e32 vcc_lo, v4, v2
; GFX10-NEXT:    s_mov_b32 s13, 0
; GFX10-NEXT:    s_or_b32 s2, s0, vcc_lo
; GFX10-NEXT:    v_cndmask_b32_e64 v3, 0, 1, s2
; GFX10-NEXT:  .LBB4_4: ; %Flow
; GFX10-NEXT:    s_and_b32 vcc_lo, exec_lo, s13
; GFX10-NEXT:    s_cbranch_vccz .LBB4_6
; GFX10-NEXT:  ; %bb.5: ; %.19
; GFX10-NEXT:    v_cndmask_b32_e64 v1, 0, 1, s0
; GFX10-NEXT:    v_or_b32_e32 v3, 2, v1
; GFX10-NEXT:  .LBB4_6: ; %.22
; GFX10-NEXT:    v_add_lshl_u32 v0, v0, s1, 2
; GFX10-NEXT:    buffer_store_dword v3, v0, s[8:11], 0 offen
; GFX10-NEXT:    s_endpgm
.entry:
  %.0 = call i64 @llvm.amdgcn.s.getpc()
  %.1 = and i64 %.0, -4294967296
  %.2 = zext i32 %.userdata0 to i64
  %.3 = or i64 %.1, %.2
  %.4 = inttoptr i64 %.3 to ptr addrspace(4)
  %.5 = getelementptr i8, ptr addrspace(4) %.4, i64 16
  %.6 = load <4 x i32>, ptr addrspace(4) %.5, align 16
  %.7 = load <4 x i32>, ptr addrspace(4) %.4, align 16
  %.8 = call i32 @llvm.amdgcn.mbcnt.lo(i32 -1, i32 0)
  %.9 = call i32 @llvm.amdgcn.mbcnt.hi(i32 -1, i32 %.8)
  %.fr11 = freeze i32 %.9
  %.idx = shl i32 %.fr11, 2
  %.10 = call i32 @llvm.amdgcn.raw.buffer.load.i32(<4 x i32> %.7, i32 %.idx, i32 0, i32 0)
  %.11 = icmp eq i32 %.10, 0
  %.12 = and i32 %.fr11, 1
  %.not = icmp eq i32 %.12, 0
  br i1 %.not, label %.19, label %.preheader

.preheader:                                       ; preds = %.entry, %.preheader
  %._96.02 = phi i32 [ %.15, %.preheader ], [ 0, %.entry ]
  %._50.01 = phi i32 [ %.14, %.preheader ], [ 0, %.entry ]
  %.idx5 = shl i32 %._96.02, 2
  %.13 = call i32 @llvm.amdgcn.raw.buffer.load.i32(<4 x i32> %.7, i32 %.idx5, i32 0, i32 0)
  %.14 = add i32 %.13, %._50.01
  %.15 = add nuw i32 %._96.02, 1
  %.exitcond.not = icmp eq i32 %.15, %.fr11
  br i1 %.exitcond.not, label %.preheader._crit_edge, label %.preheader

.preheader._crit_edge:                            ; preds = %.preheader
  %.16 = icmp eq i32 %.14, %.10
  %.17 = or i1 %.11, %.16
  %.18 = zext i1 %.17 to i32
  br label %.22

.19:                                               ; preds = %.entry
  %.20 = zext i1 %.11 to i32
  %.21 = or i32 %.20, 2
  br label %.22

.22:                                               ; preds = %.19, %.preheader._crit_edge
  %._51.0 = phi i32 [ %.18, %.preheader._crit_edge ], [ %.21, %.19 ]
  %.WorkgroupId.i0 = extractelement <3 x i32> %.WorkgroupId, i64 0
  %.LocalInvocationId.i0 = extractelement <3 x i32> %.LocalInvocationId, i64 0
  %.i0 = add i32 %.LocalInvocationId.i0, %.WorkgroupId.i0
  %.idx6 = shl i32 %.i0, 2
  call void @llvm.amdgcn.raw.buffer.store.i32(i32 %._51.0, <4 x i32> %.6, i32 %.idx6, i32 0, i32 0)
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i32 @llvm.amdgcn.mbcnt.lo(i32, i32)

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i32 @llvm.amdgcn.mbcnt.hi(i32, i32)

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.amdgcn.s.getpc()

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare i32 @llvm.amdgcn.raw.buffer.load.i32(<4 x i32>, i32, i32, i32 immarg)

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.amdgcn.raw.buffer.store.i32(i32, <4 x i32>, i32, i32, i32 immarg)

attributes #0 = { nounwind memory(readwrite) "amdgpu-flat-work-group-size"="1,1" }
