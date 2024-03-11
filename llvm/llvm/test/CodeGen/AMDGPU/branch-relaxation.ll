; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn -mcpu=tahiti -verify-machineinstrs -amdgpu-s-branch-bits=4 -simplifycfg-require-and-preserve-domtree=1 -amdgpu-long-branch-factor=0 < %s | FileCheck -enable-var-scope -check-prefix=GCN %s


; FIXME: We should use llvm-mc for this, but we can't even parse our own output.
;        See PR33579.
; RUN: llc -mtriple=amdgcn -verify-machineinstrs -amdgpu-s-branch-bits=4 -amdgpu-long-branch-factor=0 -o %t.o -filetype=obj -simplifycfg-require-and-preserve-domtree=1 %s
; RUN: llvm-readobj -r %t.o | FileCheck --check-prefix=OBJ %s

; OBJ:       Relocations [
; OBJ-NEXT: ]

; Restrict maximum branch to between +7 and -8 dwords

; Used to emit an always 4 byte instruction. Inline asm always assumes
; each instruction is the maximum size.
declare void @llvm.amdgcn.s.sleep(i32) #0

declare i32 @llvm.amdgcn.workitem.id.x() #1


define amdgpu_kernel void @uniform_conditional_max_short_forward_branch(ptr addrspace(1) %arg, i32 %cnd) #0 {
; GCN-LABEL: uniform_conditional_max_short_forward_branch:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_load_dword s2, s[0:1], 0xb
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_eq_u32 s2, 0
; GCN-NEXT:    s_cbranch_scc1 .LBB0_2
; GCN-NEXT:  ; %bb.1: ; %bb2
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    s_sleep 0
; GCN-NEXT:  .LBB0_2: ; %bb3
; GCN-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x9
; GCN-NEXT:    s_mov_b32 s7, 0xf000
; GCN-NEXT:    s_mov_b32 s6, -1
; GCN-NEXT:    v_mov_b32_e32 v0, s2
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    s_endpgm
bb:
  %cmp = icmp eq i32 %cnd, 0
  br i1 %cmp, label %bb3, label %bb2 ; +8 dword branch

bb2:
; 24 bytes
  call void asm sideeffect
  "v_nop_e64
  v_nop_e64
  v_nop_e64", ""() #0
  call void @llvm.amdgcn.s.sleep(i32 0)
  br label %bb3

bb3:
  store volatile i32 %cnd, ptr addrspace(1) %arg
  ret void
}

define amdgpu_kernel void @uniform_conditional_min_long_forward_branch(ptr addrspace(1) %arg, i32 %cnd) #0 {
; GCN-LABEL: uniform_conditional_min_long_forward_branch:
; GCN:       ; %bb.0: ; %bb0
; GCN-NEXT:    s_load_dword s2, s[0:1], 0xb
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_eq_u32 s2, 0
; GCN-NEXT:    s_cbranch_scc0 .LBB1_1
; GCN-NEXT:  ; %bb.3: ; %bb0
; GCN-NEXT:    s_getpc_b64 s[4:5]
; GCN-NEXT:  .Lpost_getpc0:
; GCN-NEXT:    s_add_u32 s4, s4, (.LBB1_2-.Lpost_getpc0)&4294967295
; GCN-NEXT:    s_addc_u32 s5, s5, (.LBB1_2-.Lpost_getpc0)>>32
; GCN-NEXT:    s_setpc_b64 s[4:5]
; GCN-NEXT:  .LBB1_1: ; %bb2
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:  .LBB1_2: ; %bb3
; GCN-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x9
; GCN-NEXT:    s_mov_b32 s7, 0xf000
; GCN-NEXT:    s_mov_b32 s6, -1
; GCN-NEXT:    v_mov_b32_e32 v0, s2
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    s_endpgm
bb0:
  %cmp = icmp eq i32 %cnd, 0
  br i1 %cmp, label %bb3, label %bb2 ; +9 dword branch

bb2:
; 32 bytes
  call void asm sideeffect
  "v_nop_e64
  v_nop_e64
  v_nop_e64
  v_nop_e64", ""() #0
  br label %bb3

bb3:
  store volatile i32 %cnd, ptr addrspace(1) %arg
  ret void
}

define amdgpu_kernel void @uniform_conditional_min_long_forward_vcnd_branch(ptr addrspace(1) %arg, float %cnd) #0 {
; GCN-LABEL: uniform_conditional_min_long_forward_vcnd_branch:
; GCN:       ; %bb.0: ; %bb0
; GCN-NEXT:    s_load_dword s2, s[0:1], 0xb
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_cmp_eq_f32_e64 s[4:5], s2, 0
; GCN-NEXT:    s_and_b64 vcc, exec, s[4:5]
; GCN-NEXT:    s_cbranch_vccz .LBB2_1
; GCN-NEXT:  ; %bb.3: ; %bb0
; GCN-NEXT:    s_getpc_b64 s[4:5]
; GCN-NEXT:  .Lpost_getpc1:
; GCN-NEXT:    s_add_u32 s4, s4, (.LBB2_2-.Lpost_getpc1)&4294967295
; GCN-NEXT:    s_addc_u32 s5, s5, (.LBB2_2-.Lpost_getpc1)>>32
; GCN-NEXT:    s_setpc_b64 s[4:5]
; GCN-NEXT:  .LBB2_1: ; %bb2
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:     ; 32 bytes
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:  .LBB2_2: ; %bb3
; GCN-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x9
; GCN-NEXT:    s_mov_b32 s7, 0xf000
; GCN-NEXT:    s_mov_b32 s6, -1
; GCN-NEXT:    v_mov_b32_e32 v0, s2
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    s_endpgm
bb0:
  %cmp = fcmp oeq float %cnd, 0.0
  br i1 %cmp, label %bb3, label %bb2 ; + 8 dword branch

bb2:
  call void asm sideeffect " ; 32 bytes
  v_nop_e64
  v_nop_e64
  v_nop_e64
  v_nop_e64", ""() #0
  br label %bb3

bb3:
  store volatile float %cnd, ptr addrspace(1) %arg
  ret void
}

define amdgpu_kernel void @min_long_forward_vbranch(ptr addrspace(1) %arg) #0 {
; GCN-LABEL: min_long_forward_vbranch:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x9
; GCN-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    s_mov_b32 s3, 0xf000
; GCN-NEXT:    s_mov_b32 s2, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v2, v[0:1], s[0:3], 0 addr64 glc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v1, s1
; GCN-NEXT:    v_add_i32_e32 v0, vcc, s0, v0
; GCN-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; GCN-NEXT:    v_cmp_ne_u32_e32 vcc, 0, v2
; GCN-NEXT:    s_and_saveexec_b64 s[0:1], vcc
; GCN-NEXT:    s_cbranch_execnz .LBB3_1
; GCN-NEXT:  ; %bb.3: ; %bb
; GCN-NEXT:    s_getpc_b64 s[4:5]
; GCN-NEXT:  .Lpost_getpc2:
; GCN-NEXT:    s_add_u32 s4, s4, (.LBB3_2-.Lpost_getpc2)&4294967295
; GCN-NEXT:    s_addc_u32 s5, s5, (.LBB3_2-.Lpost_getpc2)>>32
; GCN-NEXT:    s_setpc_b64 s[4:5]
; GCN-NEXT:  .LBB3_1: ; %bb2
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:     ; 32 bytes
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:  .LBB3_2: ; %bb3
; GCN-NEXT:    s_or_b64 exec, exec, s[0:1]
; GCN-NEXT:    s_mov_b32 s0, s2
; GCN-NEXT:    s_mov_b32 s1, s2
; GCN-NEXT:    buffer_store_dword v2, v[0:1], s[0:3], 0 addr64
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    s_endpgm
bb:
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = zext i32 %tid to i64
  %gep = getelementptr inbounds i32, ptr addrspace(1) %arg, i64 %tid.ext
  %load = load volatile i32, ptr addrspace(1) %gep
  %cmp = icmp eq i32 %load, 0
  br i1 %cmp, label %bb3, label %bb2 ; + 8 dword branch

bb2:
  call void asm sideeffect " ; 32 bytes
  v_nop_e64
  v_nop_e64
  v_nop_e64
  v_nop_e64", ""() #0
  br label %bb3

bb3:
  store volatile i32 %load, ptr addrspace(1) %gep
  ret void
}

define amdgpu_kernel void @long_backward_sbranch(ptr addrspace(1) %arg) #0 {
; GCN-LABEL: long_backward_sbranch:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_mov_b32 s0, 0
; GCN-NEXT:  .LBB4_1: ; %bb2
; GCN-NEXT:    ; =>This Inner Loop Header: Depth=1
; GCN-NEXT:    s_add_i32 s0, s0, 1
; GCN-NEXT:    s_cmp_lt_i32 s0, 10
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    s_cbranch_scc0 .LBB4_2
; GCN-NEXT:  ; %bb.3: ; %bb2
; GCN-NEXT:    ; in Loop: Header=BB4_1 Depth=1
; GCN-NEXT:    s_getpc_b64 s[2:3]
; GCN-NEXT:  .Lpost_getpc3:
; GCN-NEXT:    s_add_u32 s2, s2, (.LBB4_1-.Lpost_getpc3)&4294967295
; GCN-NEXT:    s_addc_u32 s3, s3, (.LBB4_1-.Lpost_getpc3)>>32
; GCN-NEXT:    s_setpc_b64 s[2:3]
; GCN-NEXT:  .LBB4_2: ; %bb3
; GCN-NEXT:    s_endpgm
bb:
  br label %bb2

bb2:
  %loop.idx = phi i32 [ 0, %bb ], [ %inc, %bb2 ]
  ; 24 bytes
  call void asm sideeffect
  "v_nop_e64
  v_nop_e64
  v_nop_e64", ""() #0
  %inc = add nsw i32 %loop.idx, 1 ; add cost 4
  %cmp = icmp slt i32 %inc, 10 ; condition cost = 8
  br i1 %cmp, label %bb2, label %bb3 ; -

bb3:
  ret void
}

; Requires expansion of unconditional branch from %bb2 to %bb4 (and
; expansion of conditional branch from %bb to %bb3.

define amdgpu_kernel void @uniform_unconditional_min_long_forward_branch(ptr addrspace(1) %arg, i32 %arg1) {
; GCN-LABEL: uniform_unconditional_min_long_forward_branch:
; GCN:       ; %bb.0: ; %bb0
; GCN-NEXT:    s_load_dword s2, s[0:1], 0xb
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_eq_u32 s2, 0
; GCN-NEXT:    s_mov_b64 s[2:3], -1
; GCN-NEXT:    s_cbranch_scc0 .LBB5_1
; GCN-NEXT:  ; %bb.7: ; %bb0
; GCN-NEXT:    s_getpc_b64 s[2:3]
; GCN-NEXT:  .Lpost_getpc5:
; GCN-NEXT:    s_add_u32 s2, s2, (.LBB5_4-.Lpost_getpc5)&4294967295
; GCN-NEXT:    s_addc_u32 s3, s3, (.LBB5_4-.Lpost_getpc5)>>32
; GCN-NEXT:    s_setpc_b64 s[2:3]
; GCN-NEXT:  .LBB5_1: ; %Flow
; GCN-NEXT:    s_andn2_b64 vcc, exec, s[2:3]
; GCN-NEXT:    s_cbranch_vccnz .LBB5_3
; GCN-NEXT:  .LBB5_2: ; %bb2
; GCN-NEXT:    s_mov_b32 s3, 0xf000
; GCN-NEXT:    s_mov_b32 s2, -1
; GCN-NEXT:    v_mov_b32_e32 v0, 17
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:  .LBB5_3: ; %bb4
; GCN-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x9
; GCN-NEXT:    s_mov_b32 s3, 0xf000
; GCN-NEXT:    s_mov_b32 s2, -1
; GCN-NEXT:    s_waitcnt expcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v0, 63
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    s_endpgm
; GCN-NEXT:  .LBB5_4: ; %bb3
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    s_cbranch_execnz .LBB5_5
; GCN-NEXT:  ; %bb.9: ; %bb3
; GCN-NEXT:    s_getpc_b64 s[2:3]
; GCN-NEXT:  .Lpost_getpc6:
; GCN-NEXT:    s_add_u32 s2, s2, (.LBB5_2-.Lpost_getpc6)&4294967295
; GCN-NEXT:    s_addc_u32 s3, s3, (.LBB5_2-.Lpost_getpc6)>>32
; GCN-NEXT:    s_setpc_b64 s[2:3]
; GCN-NEXT:  .LBB5_5: ; %bb3
; GCN-NEXT:    s_getpc_b64 s[2:3]
; GCN-NEXT:  .Lpost_getpc4:
; GCN-NEXT:    s_add_u32 s2, s2, (.LBB5_3-.Lpost_getpc4)&4294967295
; GCN-NEXT:    s_addc_u32 s3, s3, (.LBB5_3-.Lpost_getpc4)>>32
; GCN-NEXT:    s_setpc_b64 s[2:3]
bb0:
  %tmp = icmp ne i32 %arg1, 0
  br i1 %tmp, label %bb2, label %bb3

bb2:
  store volatile i32 17, ptr addrspace(1) undef
  br label %bb4

bb3:
  ; 32 byte asm
  call void asm sideeffect
  "v_nop_e64
  v_nop_e64
  v_nop_e64
  v_nop_e64", ""() #0
  br label %bb4

bb4:
  store volatile i32 63, ptr addrspace(1) %arg
  ret void
}

define amdgpu_kernel void @uniform_unconditional_min_long_backward_branch(ptr addrspace(1) %arg, i32 %arg1) {
; GCN-LABEL: uniform_unconditional_min_long_backward_branch:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    s_and_b64 vcc, exec, -1
; GCN-NEXT:  .LBB6_1: ; %loop
; GCN-NEXT:    ; =>This Inner Loop Header: Depth=1
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    s_mov_b64 vcc, vcc
; GCN-NEXT:    s_cbranch_vccz .LBB6_2
; GCN-NEXT:  ; %bb.3: ; %loop
; GCN-NEXT:    ; in Loop: Header=BB6_1 Depth=1
; GCN-NEXT:    s_getpc_b64 s[0:1]
; GCN-NEXT:  .Lpost_getpc7:
; GCN-NEXT:    s_add_u32 s0, s0, (.LBB6_1-.Lpost_getpc7)&4294967295
; GCN-NEXT:    s_addc_u32 s1, s1, (.LBB6_1-.Lpost_getpc7)>>32
; GCN-NEXT:    s_setpc_b64 s[0:1]
; GCN-NEXT:  .LBB6_2: ; %DummyReturnBlock
; GCN-NEXT:    s_endpgm
entry:
  br label %loop

loop:
  ; 32 byte asm
  call void asm sideeffect
  "v_nop_e64
  v_nop_e64
  v_nop_e64
  v_nop_e64", ""() #0
  br label %loop
}

; Expansion of branch from %bb1 to %bb3 introduces need to expand
; branch from %bb0 to %bb2

define amdgpu_kernel void @expand_requires_expand(i32 %cond0) #0 {
; GCN-LABEL: expand_requires_expand:
; GCN:       ; %bb.0: ; %bb0
; GCN-NEXT:    s_load_dword s0, s[0:1], 0x9
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_lt_i32 s0, 0
; GCN-NEXT:    s_cselect_b64 s[0:1], -1, 0
; GCN-NEXT:    s_and_b64 vcc, exec, s[0:1]
; GCN-NEXT:    s_cbranch_vccnz .LBB7_2
; GCN-NEXT:  ; %bb.1: ; %bb1
; GCN-NEXT:    s_load_dword s0, s[0:1], 0x0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_lg_u32 s0, 3
; GCN-NEXT:    s_cselect_b64 s[0:1], -1, 0
; GCN-NEXT:  .LBB7_2: ; %Flow
; GCN-NEXT:    s_andn2_b64 vcc, exec, s[0:1]
; GCN-NEXT:    s_cbranch_vccz .LBB7_3
; GCN-NEXT:  ; %bb.5: ; %Flow
; GCN-NEXT:    s_getpc_b64 s[0:1]
; GCN-NEXT:  .Lpost_getpc8:
; GCN-NEXT:    s_add_u32 s0, s0, (.LBB7_4-.Lpost_getpc8)&4294967295
; GCN-NEXT:    s_addc_u32 s1, s1, (.LBB7_4-.Lpost_getpc8)>>32
; GCN-NEXT:    s_setpc_b64 s[0:1]
; GCN-NEXT:  .LBB7_3: ; %bb2
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:  .LBB7_4: ; %bb3
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    s_endpgm
bb0:
  %tmp = tail call i32 @llvm.amdgcn.workitem.id.x() #0
  %cmp0 = icmp slt i32 %cond0, 0
  br i1 %cmp0, label %bb2, label %bb1

bb1:
  %val = load volatile i32, ptr addrspace(4) undef
  %cmp1 = icmp eq i32 %val, 3
  br i1 %cmp1, label %bb3, label %bb2

bb2:
  call void asm sideeffect
  "v_nop_e64
  v_nop_e64
  v_nop_e64
  v_nop_e64", ""() #0
  br label %bb3

bb3:
; These NOPs prevent tail-duplication-based outlining
; from firing, which defeats the need to expand the branches and this test.
  call void asm sideeffect
  "v_nop_e64", ""() #0
  call void asm sideeffect
  "v_nop_e64", ""() #0
  ret void
}

; Requires expanding of required skip branch.

define amdgpu_kernel void @uniform_inside_divergent(ptr addrspace(1) %out, i32 %cond) #0 {
; GCN-LABEL: uniform_inside_divergent:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 16, v0
; GCN-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GCN-NEXT:    s_cbranch_execnz .LBB8_1
; GCN-NEXT:  ; %bb.4: ; %entry
; GCN-NEXT:    s_getpc_b64 s[0:1]
; GCN-NEXT:  .Lpost_getpc9:
; GCN-NEXT:    s_add_u32 s0, s0, (.LBB8_3-.Lpost_getpc9)&4294967295
; GCN-NEXT:    s_addc_u32 s1, s1, (.LBB8_3-.Lpost_getpc9)>>32
; GCN-NEXT:    s_setpc_b64 s[0:1]
; GCN-NEXT:  .LBB8_1: ; %if
; GCN-NEXT:    s_load_dword s6, s[0:1], 0xb
; GCN-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x9
; GCN-NEXT:    s_mov_b32 s3, 0xf000
; GCN-NEXT:    s_mov_b32 s2, -1
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_lg_u32 s6, 0
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GCN-NEXT:    s_cbranch_scc1 .LBB8_3
; GCN-NEXT:  ; %bb.2: ; %if_uniform
; GCN-NEXT:    s_waitcnt expcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v0, 1
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GCN-NEXT:  .LBB8_3: ; %endif
; GCN-NEXT:    s_or_b64 exec, exec, s[4:5]
; GCN-NEXT:    s_sleep 5
; GCN-NEXT:    s_endpgm
entry:
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %d_cmp = icmp ult i32 %tid, 16
  br i1 %d_cmp, label %if, label %endif

if:
  store i32 0, ptr addrspace(1) %out
  %u_cmp = icmp eq i32 %cond, 0
  br i1 %u_cmp, label %if_uniform, label %endif

if_uniform:
  store i32 1, ptr addrspace(1) %out
  br label %endif

endif:
  ; layout can remove the split branch if it can copy the return block.
  ; This call makes the return block long enough that it doesn't get copied.
  call void @llvm.amdgcn.s.sleep(i32 5);
  ret void
}

; si_mask_branch

define amdgpu_kernel void @analyze_mask_branch() #0 {
; GCN-LABEL: analyze_mask_branch:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    v_mov_b32_e64 v0, 0
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    v_cmp_nlt_f32_e32 vcc, 0, v0
; GCN-NEXT:    s_and_saveexec_b64 s[0:1], vcc
; GCN-NEXT:    s_xor_b64 s[0:1], exec, s[0:1]
; GCN-NEXT:    s_cbranch_execz .LBB9_2
; GCN-NEXT:  ; %bb.1: ; %ret
; GCN-NEXT:    s_mov_b32 s3, 0xf000
; GCN-NEXT:    s_mov_b32 s2, -1
; GCN-NEXT:    v_mov_b32_e32 v0, 7
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:  .LBB9_2: ; %Flow1
; GCN-NEXT:    s_andn2_saveexec_b64 s[0:1], s[0:1]
; GCN-NEXT:    s_cbranch_execnz .LBB9_3
; GCN-NEXT:  ; %bb.6: ; %Flow1
; GCN-NEXT:    s_getpc_b64 s[0:1]
; GCN-NEXT:  .Lpost_getpc10:
; GCN-NEXT:    s_add_u32 s0, s0, (.LBB9_5-.Lpost_getpc10)&4294967295
; GCN-NEXT:    s_addc_u32 s1, s1, (.LBB9_5-.Lpost_getpc10)>>32
; GCN-NEXT:    s_setpc_b64 s[0:1]
; GCN-NEXT:  .LBB9_3: ; %loop.preheader
; GCN-NEXT:    s_and_b64 vcc, exec, 0
; GCN-NEXT:  .LBB9_4: ; %loop
; GCN-NEXT:    ; =>This Inner Loop Header: Depth=1
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    s_mov_b64 vcc, vcc
; GCN-NEXT:    s_cbranch_vccnz .LBB9_5
; GCN-NEXT:  ; %bb.8: ; %loop
; GCN-NEXT:    ; in Loop: Header=BB9_4 Depth=1
; GCN-NEXT:    s_getpc_b64 s[0:1]
; GCN-NEXT:  .Lpost_getpc11:
; GCN-NEXT:    s_add_u32 s0, s0, (.LBB9_4-.Lpost_getpc11)&4294967295
; GCN-NEXT:    s_addc_u32 s1, s1, (.LBB9_4-.Lpost_getpc11)>>32
; GCN-NEXT:    s_setpc_b64 s[0:1]
; GCN-NEXT:  .LBB9_5: ; %UnifiedReturnBlock
; GCN-NEXT:    s_endpgm
entry:
  %reg = call float asm sideeffect "v_mov_b32_e64 $0, 0", "=v"()
  %cmp0 = fcmp ogt float %reg, 0.000000e+00
  br i1 %cmp0, label %loop, label %ret

loop:
  %phi = phi float [ 0.000000e+00, %loop_body ], [ 1.000000e+00, %entry ]
  call void asm sideeffect
  "v_nop_e64
  v_nop_e64", ""() #0
  %cmp1 = fcmp olt float %phi, 8.0
  br i1 %cmp1, label %loop_body, label %ret

loop_body:
  call void asm sideeffect
  "v_nop_e64
  v_nop_e64
  v_nop_e64
  v_nop_e64", ""() #0
  br label %loop

ret:
  store volatile i32 7, ptr addrspace(1) undef
  ret void
}

define amdgpu_kernel void @long_branch_hang(ptr addrspace(1) nocapture %arg, i32 %arg1, i32 %arg2, i32 %arg3, i32 %arg4, i64 %arg5) #0 {
; GCN-LABEL: long_branch_hang:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0xb
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_eq_u32 s4, 0
; GCN-NEXT:    s_cselect_b64 s[2:3], -1, 0
; GCN-NEXT:    s_cmp_lg_u32 s4, 0
; GCN-NEXT:    s_cselect_b64 s[8:9], -1, 0
; GCN-NEXT:    s_cmp_lt_i32 s7, 6
; GCN-NEXT:    s_cbranch_scc1 .LBB10_1
; GCN-NEXT:  ; %bb.8: ; %bb
; GCN-NEXT:    s_getpc_b64 s[8:9]
; GCN-NEXT:  .Lpost_getpc12:
; GCN-NEXT:    s_add_u32 s8, s8, (.LBB10_2-.Lpost_getpc12)&4294967295
; GCN-NEXT:    s_addc_u32 s9, s9, (.LBB10_2-.Lpost_getpc12)>>32
; GCN-NEXT:    s_setpc_b64 s[8:9]
; GCN-NEXT:  .LBB10_1: ; %bb13
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    v_nop_e64
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    s_cbranch_execz .LBB10_3
; GCN-NEXT:    s_branch .LBB10_4
; GCN-NEXT:  .LBB10_2:
; GCN-NEXT:    s_mov_b64 s[8:9], 0
; GCN-NEXT:  .LBB10_3: ; %bb9
; GCN-NEXT:    s_cmp_lt_i32 s7, 11
; GCN-NEXT:    s_cselect_b64 s[8:9], -1, 0
; GCN-NEXT:    s_cmp_ge_i32 s6, s7
; GCN-NEXT:    s_cselect_b64 s[10:11], -1, 0
; GCN-NEXT:    s_and_b64 s[8:9], s[10:11], s[8:9]
; GCN-NEXT:  .LBB10_4: ; %Flow5
; GCN-NEXT:    s_andn2_b64 vcc, exec, s[8:9]
; GCN-NEXT:    s_cbranch_vccz .LBB10_5
; GCN-NEXT:  ; %bb.10: ; %Flow5
; GCN-NEXT:    s_getpc_b64 s[2:3]
; GCN-NEXT:  .Lpost_getpc13:
; GCN-NEXT:    s_add_u32 s2, s2, (.LBB10_6-.Lpost_getpc13)&4294967295
; GCN-NEXT:    s_addc_u32 s3, s3, (.LBB10_6-.Lpost_getpc13)>>32
; GCN-NEXT:    s_setpc_b64 s[2:3]
; GCN-NEXT:  .LBB10_5: ; %bb14
; GCN-NEXT:    s_cmp_lt_i32 s5, 9
; GCN-NEXT:    s_cselect_b64 s[4:5], -1, 0
; GCN-NEXT:    s_cmp_lt_i32 s6, s7
; GCN-NEXT:    s_cselect_b64 s[6:7], -1, 0
; GCN-NEXT:    s_or_b64 s[4:5], s[6:7], s[4:5]
; GCN-NEXT:    s_and_b64 s[2:3], s[2:3], s[4:5]
; GCN-NEXT:    v_cndmask_b32_e64 v0, 0, 1, s[2:3]
; GCN-NEXT:    s_branch .LBB10_7
; GCN-NEXT:  .LBB10_6:
; GCN-NEXT:    ; implicit-def: $vgpr0
; GCN-NEXT:  .LBB10_7: ; %bb19
; GCN-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0xf
; GCN-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x9
; GCN-NEXT:    s_mov_b32 s3, 0xf000
; GCN-NEXT:    s_mov_b32 s2, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_lshl_b64 s[4:5], s[4:5], 2
; GCN-NEXT:    v_mov_b32_e32 v1, s4
; GCN-NEXT:    v_mov_b32_e32 v2, s5
; GCN-NEXT:    buffer_store_dword v0, v[1:2], s[0:3], 0 addr64
; GCN-NEXT:    s_endpgm
bb:
  %tmp = icmp slt i32 %arg2, 9
  %tmp6 = icmp eq i32 %arg1, 0
  %tmp8 = icmp sgt i32 %arg4, 5
  br i1 %tmp8, label %bb9, label %bb13

bb9:                                              ; preds = %bb
  %tmp7 = icmp sgt i32 %arg4, 10                  ; avoid being optimized away through the domination
  %tmp11 = icmp slt i32 %arg3, %arg4
  %tmp12 = or i1 %tmp11, %tmp7
  br i1 %tmp12, label %bb19, label %bb14

bb13:                                             ; preds = %bb
  call void asm sideeffect
  "v_nop_e64
  v_nop_e64
  v_nop_e64
  v_nop_e64", ""() #0
  br i1 %tmp6, label %bb19, label %bb14

bb14:                                             ; preds = %bb13, %bb9
  %tmp15 = icmp slt i32 %arg3, %arg4
  %tmp16 = or i1 %tmp15, %tmp
  %tmp17 = and i1 %tmp6, %tmp16
  %tmp18 = zext i1 %tmp17 to i32
  br label %bb19

bb19:                                             ; preds = %bb14, %bb13, %bb9
  %tmp20 = phi i32 [ undef, %bb9 ], [ undef, %bb13 ], [ %tmp18, %bb14 ]
  %tmp21 = getelementptr inbounds i32, ptr addrspace(1) %arg, i64 %arg5
  store i32 %tmp20, ptr addrspace(1) %tmp21, align 4
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }
