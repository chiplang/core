; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel=0 -mtriple=amdgcn-amd-amdhsa -mcpu=fiji -o - -amdgpu-enable-lower-module-lds=false %s 2> %t | FileCheck -check-prefixes=GFX8,GFX8-SDAG %s
; RUN: FileCheck -check-prefix=ERR %s < %t

; RUN: llc -global-isel=1 -mtriple=amdgcn-amd-amdhsa -mcpu=fiji -o - -amdgpu-enable-lower-module-lds=false %s 2> %t | FileCheck -check-prefixes=GFX8,GFX8-GISEL %s
; RUN: FileCheck -check-prefix=ERR %s < %t

; RUN: llc -global-isel=0 -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -o - -amdgpu-enable-lower-module-lds=false %s 2> %t | FileCheck -check-prefixes=GFX9,GFX9-SDAG %s
; RUN: FileCheck -check-prefix=ERR %s < %t

; RUN: llc -global-isel=1 -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -o - -amdgpu-enable-lower-module-lds=false %s 2> %t | FileCheck -check-prefixes=GFX9,GFX9-GISEL %s
; RUN: FileCheck -check-prefix=ERR %s < %t

; Test there's no verifier error if a function directly uses LDS and
; we emit a trap. The s_endpgm needs to be emitted in a terminator
; position.

; RUN: llc -global-isel=0 -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx900 -verify-machineinstrs < %s 2> %t | FileCheck -check-prefixes=CHECK,SDAG %s
; RUN: FileCheck -check-prefix=ERR %s < %t

; RUN: llc -global-isel=1 -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx900 -verify-machineinstrs < %s 2> %t | FileCheck -check-prefixes=CHECK,GISEL %s
; RUN: FileCheck -check-prefix=ERR %s < %t


@lds = internal addrspace(3) global float poison, align 4

; FIXME: The DAG should probably move the trap before the access.

; ERR: warning: <unknown>:0:0: in function func_use_lds_global void (): local memory global used by non-kernel function
define void @func_use_lds_global() {
; GFX8-SDAG-LABEL: func_use_lds_global:
; GFX8-SDAG:       ; %bb.0:
; GFX8-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-SDAG-NEXT:    v_mov_b32_e32 v0, 0
; GFX8-SDAG-NEXT:    s_mov_b32 m0, -1
; GFX8-SDAG-NEXT:    s_mov_b64 s[4:5], 0
; GFX8-SDAG-NEXT:    ds_write_b32 v0, v0
; GFX8-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX8-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-SDAG-NEXT:    s_trap 2
; GFX8-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-GISEL-LABEL: func_use_lds_global:
; GFX8-GISEL:       ; %bb.0:
; GFX8-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-GISEL-NEXT:    s_mov_b64 s[4:5], 0xc8
; GFX8-GISEL-NEXT:    v_mov_b32_e32 v0, 0
; GFX8-GISEL-NEXT:    s_mov_b32 m0, -1
; GFX8-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX8-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-GISEL-NEXT:    s_trap 2
; GFX8-GISEL-NEXT:    ds_write_b32 v0, v0
; GFX8-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-SDAG-LABEL: func_use_lds_global:
; GFX9-SDAG:       ; %bb.0:
; GFX9-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-SDAG-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-SDAG-NEXT:    ds_write_b32 v0, v0
; GFX9-SDAG-NEXT:    s_trap 2
; GFX9-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-GISEL-LABEL: func_use_lds_global:
; GFX9-GISEL:       ; %bb.0:
; GFX9-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-GISEL-NEXT:    s_trap 2
; GFX9-GISEL-NEXT:    ds_write_b32 v0, v0
; GFX9-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; SDAG-LABEL: func_use_lds_global:
; SDAG:       ; %bb.0:
; SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    ds_write_b32 v0, v0
; SDAG-NEXT:    s_cbranch_execnz .LBB0_2
; SDAG-NEXT:  ; %bb.1:
; SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; SDAG-NEXT:    s_setpc_b64 s[30:31]
; SDAG-NEXT:  .LBB0_2:
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: func_use_lds_global:
; GISEL:       ; %bb.0:
; GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GISEL-NEXT:    s_cbranch_execnz .LBB0_2
; GISEL-NEXT:  ; %bb.1:
; GISEL-NEXT:    v_mov_b32_e32 v0, 0
; GISEL-NEXT:    ds_write_b32 v0, v0
; GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GISEL-NEXT:    s_setpc_b64 s[30:31]
; GISEL-NEXT:  .LBB0_2:
; GISEL-NEXT:    s_endpgm
  store volatile float 0.0, ptr addrspace(3) @lds, align 4
  ret void
}

; ERR: warning: <unknown>:0:0: in function func_use_lds_global_constexpr_cast void (): local memory global used by non-kernel function
define void @func_use_lds_global_constexpr_cast() {
; GFX8-SDAG-LABEL: func_use_lds_global_constexpr_cast:
; GFX8-SDAG:       ; %bb.0:
; GFX8-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-SDAG-NEXT:    s_mov_b64 s[4:5], 0
; GFX8-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX8-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-SDAG-NEXT:    s_trap 2
; GFX8-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-GISEL-LABEL: func_use_lds_global_constexpr_cast:
; GFX8-GISEL:       ; %bb.0:
; GFX8-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-GISEL-NEXT:    s_mov_b64 s[4:5], 0xc8
; GFX8-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX8-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-GISEL-NEXT:    s_trap 2
; GFX8-GISEL-NEXT:    flat_store_dword v[0:1], v0
; GFX8-GISEL-NEXT:    s_waitcnt vmcnt(0)
; GFX8-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-SDAG-LABEL: func_use_lds_global_constexpr_cast:
; GFX9-SDAG:       ; %bb.0:
; GFX9-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-SDAG-NEXT:    s_trap 2
; GFX9-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-GISEL-LABEL: func_use_lds_global_constexpr_cast:
; GFX9-GISEL:       ; %bb.0:
; GFX9-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-GISEL-NEXT:    s_trap 2
; GFX9-GISEL-NEXT:    global_store_dword v[0:1], v0, off
; GFX9-GISEL-NEXT:    s_waitcnt vmcnt(0)
; GFX9-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; SDAG-LABEL: func_use_lds_global_constexpr_cast:
; SDAG:       ; %bb.0:
; SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; SDAG-NEXT:    s_cbranch_execnz .LBB1_2
; SDAG-NEXT:  ; %bb.1:
; SDAG-NEXT:    s_setpc_b64 s[30:31]
; SDAG-NEXT:  .LBB1_2:
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: func_use_lds_global_constexpr_cast:
; GISEL:       ; %bb.0:
; GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GISEL-NEXT:    s_cbranch_execnz .LBB1_2
; GISEL-NEXT:  ; %bb.1:
; GISEL-NEXT:    global_store_dword v[0:1], v0, off
; GISEL-NEXT:    s_waitcnt vmcnt(0)
; GISEL-NEXT:    s_setpc_b64 s[30:31]
; GISEL-NEXT:  .LBB1_2:
; GISEL-NEXT:    s_endpgm
  store volatile i32 ptrtoint (ptr addrspace(3) @lds to i32), ptr addrspace(1) poison, align 4
  ret void
}

; ERR: warning: <unknown>:0:0: in function func_uses_lds_multi void (i1): local memory global used by non-kernel function
define void @func_uses_lds_multi(i1 %cond) {
; GFX8-SDAG-LABEL: func_uses_lds_multi:
; GFX8-SDAG:       ; %bb.0: ; %entry
; GFX8-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-SDAG-NEXT:    v_and_b32_e32 v0, 1, v0
; GFX8-SDAG-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GFX8-SDAG-NEXT:    s_xor_b64 s[4:5], vcc, -1
; GFX8-SDAG-NEXT:    s_mov_b32 m0, -1
; GFX8-SDAG-NEXT:    s_and_saveexec_b64 s[6:7], s[4:5]
; GFX8-SDAG-NEXT:    s_xor_b64 s[4:5], exec, s[6:7]
; GFX8-SDAG-NEXT:    s_cbranch_execz .LBB2_2
; GFX8-SDAG-NEXT:  ; %bb.1: ; %bb1
; GFX8-SDAG-NEXT:    v_mov_b32_e32 v0, 1
; GFX8-SDAG-NEXT:    s_mov_b64 s[6:7], 0
; GFX8-SDAG-NEXT:    ds_write_b32 v0, v0
; GFX8-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; GFX8-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-SDAG-NEXT:    s_trap 2
; GFX8-SDAG-NEXT:  .LBB2_2: ; %Flow
; GFX8-SDAG-NEXT:    s_andn2_saveexec_b64 s[4:5], s[4:5]
; GFX8-SDAG-NEXT:    s_cbranch_execz .LBB2_4
; GFX8-SDAG-NEXT:  ; %bb.3: ; %bb0
; GFX8-SDAG-NEXT:    v_mov_b32_e32 v0, 0
; GFX8-SDAG-NEXT:    s_mov_b64 s[6:7], 0
; GFX8-SDAG-NEXT:    ds_write_b32 v0, v0
; GFX8-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; GFX8-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-SDAG-NEXT:    s_trap 2
; GFX8-SDAG-NEXT:  .LBB2_4: ; %ret
; GFX8-SDAG-NEXT:    s_or_b64 exec, exec, s[4:5]
; GFX8-SDAG-NEXT:    v_mov_b32_e32 v0, 2
; GFX8-SDAG-NEXT:    s_mov_b64 s[4:5], 0
; GFX8-SDAG-NEXT:    ds_write_b32 v0, v0
; GFX8-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX8-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-SDAG-NEXT:    s_trap 2
; GFX8-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-GISEL-LABEL: func_uses_lds_multi:
; GFX8-GISEL:       ; %bb.0: ; %entry
; GFX8-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-GISEL-NEXT:    v_and_b32_e32 v0, 1, v0
; GFX8-GISEL-NEXT:    v_cmp_ne_u32_e32 vcc, 0, v0
; GFX8-GISEL-NEXT:    s_xor_b64 s[4:5], vcc, -1
; GFX8-GISEL-NEXT:    s_and_saveexec_b64 s[6:7], s[4:5]
; GFX8-GISEL-NEXT:    s_xor_b64 s[4:5], exec, s[6:7]
; GFX8-GISEL-NEXT:    s_cbranch_execz .LBB2_2
; GFX8-GISEL-NEXT:  ; %bb.1: ; %bb1
; GFX8-GISEL-NEXT:    s_mov_b64 s[6:7], 0xc8
; GFX8-GISEL-NEXT:    v_mov_b32_e32 v0, 1
; GFX8-GISEL-NEXT:    s_mov_b32 m0, -1
; GFX8-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; GFX8-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-GISEL-NEXT:    s_trap 2
; GFX8-GISEL-NEXT:    ds_write_b32 v0, v0
; GFX8-GISEL-NEXT:  .LBB2_2: ; %Flow
; GFX8-GISEL-NEXT:    s_andn2_saveexec_b64 s[4:5], s[4:5]
; GFX8-GISEL-NEXT:    s_cbranch_execz .LBB2_4
; GFX8-GISEL-NEXT:  ; %bb.3: ; %bb0
; GFX8-GISEL-NEXT:    s_mov_b64 s[6:7], 0xc8
; GFX8-GISEL-NEXT:    v_mov_b32_e32 v0, 0
; GFX8-GISEL-NEXT:    s_mov_b32 m0, -1
; GFX8-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; GFX8-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-GISEL-NEXT:    s_trap 2
; GFX8-GISEL-NEXT:    ds_write_b32 v0, v0
; GFX8-GISEL-NEXT:  .LBB2_4: ; %ret
; GFX8-GISEL-NEXT:    s_or_b64 exec, exec, s[4:5]
; GFX8-GISEL-NEXT:    s_mov_b64 s[4:5], 0xc8
; GFX8-GISEL-NEXT:    v_mov_b32_e32 v0, 2
; GFX8-GISEL-NEXT:    s_mov_b32 m0, -1
; GFX8-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX8-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-GISEL-NEXT:    s_trap 2
; GFX8-GISEL-NEXT:    ds_write_b32 v0, v0
; GFX8-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-SDAG-LABEL: func_uses_lds_multi:
; GFX9-SDAG:       ; %bb.0: ; %entry
; GFX9-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-SDAG-NEXT:    v_and_b32_e32 v0, 1, v0
; GFX9-SDAG-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GFX9-SDAG-NEXT:    s_xor_b64 s[4:5], vcc, -1
; GFX9-SDAG-NEXT:    s_and_saveexec_b64 s[6:7], s[4:5]
; GFX9-SDAG-NEXT:    s_xor_b64 s[4:5], exec, s[6:7]
; GFX9-SDAG-NEXT:    s_cbranch_execz .LBB2_2
; GFX9-SDAG-NEXT:  ; %bb.1: ; %bb1
; GFX9-SDAG-NEXT:    v_mov_b32_e32 v0, 1
; GFX9-SDAG-NEXT:    ds_write_b32 v0, v0
; GFX9-SDAG-NEXT:    s_trap 2
; GFX9-SDAG-NEXT:  .LBB2_2: ; %Flow
; GFX9-SDAG-NEXT:    s_andn2_saveexec_b64 s[4:5], s[4:5]
; GFX9-SDAG-NEXT:    s_cbranch_execz .LBB2_4
; GFX9-SDAG-NEXT:  ; %bb.3: ; %bb0
; GFX9-SDAG-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-SDAG-NEXT:    ds_write_b32 v0, v0
; GFX9-SDAG-NEXT:    s_trap 2
; GFX9-SDAG-NEXT:  .LBB2_4: ; %ret
; GFX9-SDAG-NEXT:    s_or_b64 exec, exec, s[4:5]
; GFX9-SDAG-NEXT:    v_mov_b32_e32 v0, 2
; GFX9-SDAG-NEXT:    ds_write_b32 v0, v0
; GFX9-SDAG-NEXT:    s_trap 2
; GFX9-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-GISEL-LABEL: func_uses_lds_multi:
; GFX9-GISEL:       ; %bb.0: ; %entry
; GFX9-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-GISEL-NEXT:    v_and_b32_e32 v0, 1, v0
; GFX9-GISEL-NEXT:    v_cmp_ne_u32_e32 vcc, 0, v0
; GFX9-GISEL-NEXT:    s_xor_b64 s[4:5], vcc, -1
; GFX9-GISEL-NEXT:    s_and_saveexec_b64 s[6:7], s[4:5]
; GFX9-GISEL-NEXT:    s_xor_b64 s[4:5], exec, s[6:7]
; GFX9-GISEL-NEXT:    s_cbranch_execz .LBB2_2
; GFX9-GISEL-NEXT:  ; %bb.1: ; %bb1
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v0, 1
; GFX9-GISEL-NEXT:    s_trap 2
; GFX9-GISEL-NEXT:    ds_write_b32 v0, v0
; GFX9-GISEL-NEXT:  .LBB2_2: ; %Flow
; GFX9-GISEL-NEXT:    s_andn2_saveexec_b64 s[4:5], s[4:5]
; GFX9-GISEL-NEXT:    s_cbranch_execz .LBB2_4
; GFX9-GISEL-NEXT:  ; %bb.3: ; %bb0
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-GISEL-NEXT:    s_trap 2
; GFX9-GISEL-NEXT:    ds_write_b32 v0, v0
; GFX9-GISEL-NEXT:  .LBB2_4: ; %ret
; GFX9-GISEL-NEXT:    s_or_b64 exec, exec, s[4:5]
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v0, 2
; GFX9-GISEL-NEXT:    s_trap 2
; GFX9-GISEL-NEXT:    ds_write_b32 v0, v0
; GFX9-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; SDAG-LABEL: func_uses_lds_multi:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; SDAG-NEXT:    v_and_b32_e32 v0, 1, v0
; SDAG-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; SDAG-NEXT:    s_xor_b64 s[4:5], vcc, -1
; SDAG-NEXT:    s_and_saveexec_b64 s[6:7], s[4:5]
; SDAG-NEXT:    s_xor_b64 s[4:5], exec, s[6:7]
; SDAG-NEXT:    s_cbranch_execz .LBB2_2
; SDAG-NEXT:  ; %bb.1: ; %bb1
; SDAG-NEXT:    v_mov_b32_e32 v0, 1
; SDAG-NEXT:    ds_write_b32 v0, v0
; SDAG-NEXT:    s_cbranch_execnz .LBB2_6
; SDAG-NEXT:  .LBB2_2: ; %Flow
; SDAG-NEXT:    s_andn2_saveexec_b64 s[4:5], s[4:5]
; SDAG-NEXT:    s_cbranch_execz .LBB2_4
; SDAG-NEXT:  ; %bb.3: ; %bb0
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    ds_write_b32 v0, v0
; SDAG-NEXT:    s_cbranch_execnz .LBB2_6
; SDAG-NEXT:  .LBB2_4: ; %ret
; SDAG-NEXT:    s_or_b64 exec, exec, s[4:5]
; SDAG-NEXT:    v_mov_b32_e32 v0, 2
; SDAG-NEXT:    ds_write_b32 v0, v0
; SDAG-NEXT:    s_cbranch_execnz .LBB2_6
; SDAG-NEXT:  ; %bb.5: ; %ret
; SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; SDAG-NEXT:    s_setpc_b64 s[30:31]
; SDAG-NEXT:  .LBB2_6:
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: func_uses_lds_multi:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GISEL-NEXT:    v_and_b32_e32 v0, 1, v0
; GISEL-NEXT:    v_cmp_ne_u32_e32 vcc, 0, v0
; GISEL-NEXT:    s_xor_b64 s[4:5], vcc, -1
; GISEL-NEXT:    s_and_saveexec_b64 s[6:7], s[4:5]
; GISEL-NEXT:    s_xor_b64 s[4:5], exec, s[6:7]
; GISEL-NEXT:    s_cbranch_execz .LBB2_3
; GISEL-NEXT:  ; %bb.1: ; %bb1
; GISEL-NEXT:    s_cbranch_execnz .LBB2_8
; GISEL-NEXT:  ; %bb.2: ; %bb1
; GISEL-NEXT:    v_mov_b32_e32 v0, 1
; GISEL-NEXT:    ds_write_b32 v0, v0
; GISEL-NEXT:  .LBB2_3: ; %Flow
; GISEL-NEXT:    s_andn2_saveexec_b64 s[4:5], s[4:5]
; GISEL-NEXT:    s_cbranch_execz .LBB2_6
; GISEL-NEXT:  ; %bb.4: ; %bb0
; GISEL-NEXT:    s_cbranch_execnz .LBB2_8
; GISEL-NEXT:  ; %bb.5: ; %bb0
; GISEL-NEXT:    v_mov_b32_e32 v0, 0
; GISEL-NEXT:    ds_write_b32 v0, v0
; GISEL-NEXT:  .LBB2_6: ; %ret
; GISEL-NEXT:    s_or_b64 exec, exec, s[4:5]
; GISEL-NEXT:    s_cbranch_execnz .LBB2_8
; GISEL-NEXT:  ; %bb.7: ; %ret
; GISEL-NEXT:    v_mov_b32_e32 v0, 2
; GISEL-NEXT:    ds_write_b32 v0, v0
; GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GISEL-NEXT:    s_setpc_b64 s[30:31]
; GISEL-NEXT:  .LBB2_8:
; GISEL-NEXT:    s_endpgm
entry:
  br i1 %cond, label %bb0, label %bb1

bb0:
  store volatile i32 0, ptr addrspace(3) @lds, align 4
  br label %ret

bb1:
  store volatile i32 1, ptr addrspace(3) @lds, align 4
  br label %ret

ret:
  store volatile i32 2, ptr addrspace(3) @lds, align 4
  ret void
}

; ERR: warning: <unknown>:0:0: in function func_uses_lds_code_after void (ptr addrspace(1)): local memory global used by non-kernel function
define void @func_uses_lds_code_after(ptr addrspace(1) %ptr) {
; GFX8-SDAG-LABEL: func_uses_lds_code_after:
; GFX8-SDAG:       ; %bb.0:
; GFX8-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-SDAG-NEXT:    v_mov_b32_e32 v2, 0
; GFX8-SDAG-NEXT:    s_mov_b32 m0, -1
; GFX8-SDAG-NEXT:    ds_write_b32 v0, v2
; GFX8-SDAG-NEXT:    s_mov_b64 s[4:5], 0
; GFX8-SDAG-NEXT:    v_mov_b32_e32 v2, 1
; GFX8-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX8-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-SDAG-NEXT:    s_trap 2
; GFX8-SDAG-NEXT:    flat_store_dword v[0:1], v2
; GFX8-SDAG-NEXT:    s_waitcnt vmcnt(0)
; GFX8-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-GISEL-LABEL: func_uses_lds_code_after:
; GFX8-GISEL:       ; %bb.0:
; GFX8-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-GISEL-NEXT:    s_mov_b64 s[4:5], 0xc8
; GFX8-GISEL-NEXT:    v_mov_b32_e32 v2, 0
; GFX8-GISEL-NEXT:    s_mov_b32 m0, -1
; GFX8-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX8-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-GISEL-NEXT:    s_trap 2
; GFX8-GISEL-NEXT:    ds_write_b32 v0, v2
; GFX8-GISEL-NEXT:    v_mov_b32_e32 v2, 1
; GFX8-GISEL-NEXT:    flat_store_dword v[0:1], v2
; GFX8-GISEL-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX8-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-SDAG-LABEL: func_uses_lds_code_after:
; GFX9-SDAG:       ; %bb.0:
; GFX9-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-SDAG-NEXT:    v_mov_b32_e32 v2, 0
; GFX9-SDAG-NEXT:    ds_write_b32 v0, v2
; GFX9-SDAG-NEXT:    v_mov_b32_e32 v2, 1
; GFX9-SDAG-NEXT:    s_trap 2
; GFX9-SDAG-NEXT:    global_store_dword v[0:1], v2, off
; GFX9-SDAG-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX9-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-GISEL-LABEL: func_uses_lds_code_after:
; GFX9-GISEL:       ; %bb.0:
; GFX9-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v2, 0
; GFX9-GISEL-NEXT:    s_trap 2
; GFX9-GISEL-NEXT:    ds_write_b32 v0, v2
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v2, 1
; GFX9-GISEL-NEXT:    global_store_dword v[0:1], v2, off
; GFX9-GISEL-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX9-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; SDAG-LABEL: func_uses_lds_code_after:
; SDAG:       ; %bb.0:
; SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; SDAG-NEXT:    v_mov_b32_e32 v2, 0
; SDAG-NEXT:    ds_write_b32 v0, v2
; SDAG-NEXT:    s_cbranch_execnz .LBB3_2
; SDAG-NEXT:  ; %bb.1:
; SDAG-NEXT:    v_mov_b32_e32 v2, 1
; SDAG-NEXT:    global_store_dword v[0:1], v2, off
; SDAG-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; SDAG-NEXT:    s_setpc_b64 s[30:31]
; SDAG-NEXT:  .LBB3_2:
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: func_uses_lds_code_after:
; GISEL:       ; %bb.0:
; GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GISEL-NEXT:    s_cbranch_execnz .LBB3_2
; GISEL-NEXT:  ; %bb.1:
; GISEL-NEXT:    v_mov_b32_e32 v2, 0
; GISEL-NEXT:    ds_write_b32 v0, v2
; GISEL-NEXT:    v_mov_b32_e32 v2, 1
; GISEL-NEXT:    global_store_dword v[0:1], v2, off
; GISEL-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GISEL-NEXT:    s_setpc_b64 s[30:31]
; GISEL-NEXT:  .LBB3_2:
; GISEL-NEXT:    s_endpgm
  store volatile i32 0, ptr addrspace(3) @lds, align 4
  store volatile i32 1, ptr addrspace(1) %ptr, align 4
  ret void
}

; ERR: warning: <unknown>:0:0: in function func_uses_lds_phi_after i32 (i1, ptr addrspace(1)): local memory global used by non-kernel function
define i32 @func_uses_lds_phi_after(i1 %cond, ptr addrspace(1) %ptr) {
; GFX8-SDAG-LABEL: func_uses_lds_phi_after:
; GFX8-SDAG:       ; %bb.0: ; %entry
; GFX8-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-SDAG-NEXT:    v_mov_b32_e32 v3, v0
; GFX8-SDAG-NEXT:    flat_load_dword v0, v[1:2] glc
; GFX8-SDAG-NEXT:    s_waitcnt vmcnt(0)
; GFX8-SDAG-NEXT:    v_and_b32_e32 v3, 1, v3
; GFX8-SDAG-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v3
; GFX8-SDAG-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GFX8-SDAG-NEXT:    s_cbranch_execz .LBB4_2
; GFX8-SDAG-NEXT:  ; %bb.1: ; %use.bb
; GFX8-SDAG-NEXT:    v_mov_b32_e32 v0, 0
; GFX8-SDAG-NEXT:    s_mov_b32 m0, -1
; GFX8-SDAG-NEXT:    s_mov_b64 s[6:7], 0
; GFX8-SDAG-NEXT:    ds_write_b32 v0, v0
; GFX8-SDAG-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; GFX8-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-SDAG-NEXT:    s_trap 2
; GFX8-SDAG-NEXT:    flat_load_dword v0, v[1:2] glc
; GFX8-SDAG-NEXT:    s_waitcnt vmcnt(0)
; GFX8-SDAG-NEXT:  .LBB4_2: ; %ret
; GFX8-SDAG-NEXT:    s_or_b64 exec, exec, s[4:5]
; GFX8-SDAG-NEXT:    s_waitcnt vmcnt(0)
; GFX8-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-GISEL-LABEL: func_uses_lds_phi_after:
; GFX8-GISEL:       ; %bb.0: ; %entry
; GFX8-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-GISEL-NEXT:    v_mov_b32_e32 v3, v0
; GFX8-GISEL-NEXT:    flat_load_dword v0, v[1:2] glc
; GFX8-GISEL-NEXT:    s_waitcnt vmcnt(0)
; GFX8-GISEL-NEXT:    v_and_b32_e32 v3, 1, v3
; GFX8-GISEL-NEXT:    v_cmp_ne_u32_e32 vcc, 0, v3
; GFX8-GISEL-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GFX8-GISEL-NEXT:    s_cbranch_execz .LBB4_2
; GFX8-GISEL-NEXT:  ; %bb.1: ; %use.bb
; GFX8-GISEL-NEXT:    s_mov_b64 s[6:7], 0xc8
; GFX8-GISEL-NEXT:    v_mov_b32_e32 v0, 0
; GFX8-GISEL-NEXT:    s_mov_b32 m0, -1
; GFX8-GISEL-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; GFX8-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-GISEL-NEXT:    s_trap 2
; GFX8-GISEL-NEXT:    ds_write_b32 v0, v0
; GFX8-GISEL-NEXT:    flat_load_dword v0, v[1:2] glc
; GFX8-GISEL-NEXT:    s_waitcnt vmcnt(0)
; GFX8-GISEL-NEXT:  .LBB4_2: ; %ret
; GFX8-GISEL-NEXT:    s_or_b64 exec, exec, s[4:5]
; GFX8-GISEL-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX8-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-SDAG-LABEL: func_uses_lds_phi_after:
; GFX9-SDAG:       ; %bb.0: ; %entry
; GFX9-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-SDAG-NEXT:    v_mov_b32_e32 v3, v0
; GFX9-SDAG-NEXT:    global_load_dword v0, v[1:2], off glc
; GFX9-SDAG-NEXT:    s_waitcnt vmcnt(0)
; GFX9-SDAG-NEXT:    v_and_b32_e32 v3, 1, v3
; GFX9-SDAG-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v3
; GFX9-SDAG-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GFX9-SDAG-NEXT:    s_cbranch_execz .LBB4_2
; GFX9-SDAG-NEXT:  ; %bb.1: ; %use.bb
; GFX9-SDAG-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-SDAG-NEXT:    ds_write_b32 v0, v0
; GFX9-SDAG-NEXT:    s_trap 2
; GFX9-SDAG-NEXT:    global_load_dword v0, v[1:2], off glc
; GFX9-SDAG-NEXT:    s_waitcnt vmcnt(0)
; GFX9-SDAG-NEXT:  .LBB4_2: ; %ret
; GFX9-SDAG-NEXT:    s_or_b64 exec, exec, s[4:5]
; GFX9-SDAG-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX9-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-GISEL-LABEL: func_uses_lds_phi_after:
; GFX9-GISEL:       ; %bb.0: ; %entry
; GFX9-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v3, v0
; GFX9-GISEL-NEXT:    global_load_dword v0, v[1:2], off glc
; GFX9-GISEL-NEXT:    s_waitcnt vmcnt(0)
; GFX9-GISEL-NEXT:    v_and_b32_e32 v3, 1, v3
; GFX9-GISEL-NEXT:    v_cmp_ne_u32_e32 vcc, 0, v3
; GFX9-GISEL-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GFX9-GISEL-NEXT:    s_cbranch_execz .LBB4_2
; GFX9-GISEL-NEXT:  ; %bb.1: ; %use.bb
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-GISEL-NEXT:    s_trap 2
; GFX9-GISEL-NEXT:    ds_write_b32 v0, v0
; GFX9-GISEL-NEXT:    global_load_dword v0, v[1:2], off glc
; GFX9-GISEL-NEXT:    s_waitcnt vmcnt(0)
; GFX9-GISEL-NEXT:  .LBB4_2: ; %ret
; GFX9-GISEL-NEXT:    s_or_b64 exec, exec, s[4:5]
; GFX9-GISEL-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX9-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; SDAG-LABEL: func_uses_lds_phi_after:
; SDAG:       ; %bb.0: ; %entry
; SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; SDAG-NEXT:    v_mov_b32_e32 v3, v0
; SDAG-NEXT:    global_load_dword v0, v[1:2], off glc
; SDAG-NEXT:    s_waitcnt vmcnt(0)
; SDAG-NEXT:    v_and_b32_e32 v3, 1, v3
; SDAG-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v3
; SDAG-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; SDAG-NEXT:    s_cbranch_execz .LBB4_3
; SDAG-NEXT:  ; %bb.1: ; %use.bb
; SDAG-NEXT:    v_mov_b32_e32 v0, 0
; SDAG-NEXT:    ds_write_b32 v0, v0
; SDAG-NEXT:    s_cbranch_execnz .LBB4_4
; SDAG-NEXT:  ; %bb.2: ; %use.bb
; SDAG-NEXT:    global_load_dword v0, v[1:2], off glc
; SDAG-NEXT:    s_waitcnt vmcnt(0)
; SDAG-NEXT:  .LBB4_3: ; %ret
; SDAG-NEXT:    s_or_b64 exec, exec, s[4:5]
; SDAG-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; SDAG-NEXT:    s_setpc_b64 s[30:31]
; SDAG-NEXT:  .LBB4_4:
; SDAG-NEXT:    s_endpgm
;
; GISEL-LABEL: func_uses_lds_phi_after:
; GISEL:       ; %bb.0: ; %entry
; GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GISEL-NEXT:    v_mov_b32_e32 v3, v0
; GISEL-NEXT:    global_load_dword v0, v[1:2], off glc
; GISEL-NEXT:    s_waitcnt vmcnt(0)
; GISEL-NEXT:    v_and_b32_e32 v3, 1, v3
; GISEL-NEXT:    v_cmp_ne_u32_e32 vcc, 0, v3
; GISEL-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GISEL-NEXT:    s_cbranch_execz .LBB4_3
; GISEL-NEXT:  ; %bb.1: ; %use.bb
; GISEL-NEXT:    s_cbranch_execnz .LBB4_4
; GISEL-NEXT:  ; %bb.2: ; %use.bb
; GISEL-NEXT:    v_mov_b32_e32 v0, 0
; GISEL-NEXT:    ds_write_b32 v0, v0
; GISEL-NEXT:    global_load_dword v0, v[1:2], off glc
; GISEL-NEXT:    s_waitcnt vmcnt(0)
; GISEL-NEXT:  .LBB4_3: ; %ret
; GISEL-NEXT:    s_or_b64 exec, exec, s[4:5]
; GISEL-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GISEL-NEXT:    s_setpc_b64 s[30:31]
; GISEL-NEXT:  .LBB4_4:
; GISEL-NEXT:    s_endpgm
entry:
  %entry.load = load volatile i32, ptr addrspace(1) %ptr
  br i1 %cond, label %use.bb, label %ret

use.bb:
  store volatile i32 0, ptr addrspace(3) @lds, align 4
  %use.bb.load = load volatile i32, ptr addrspace(1) %ptr
  br label %ret

ret:
  %phi = phi i32 [ %entry.load, %entry ], [ %use.bb.load, %use.bb ]
  ret i32 %phi
}

;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK: {{.*}}
; GFX8: {{.*}}
; GFX9: {{.*}}

!llvm.module.flags = !{!0}
!0 = !{i32 1, !"amdhsa_code_object_version", i32 500}
