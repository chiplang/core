; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=amdgcn -mcpu=tonga -verify-machineinstrs | FileCheck -check-prefixes=PREGFX10-UNPACKED %s
; RUN: llc < %s -mtriple=amdgcn -mcpu=gfx810 -verify-machineinstrs | FileCheck -check-prefixes=PREGFX10-PACKED %s
; RUN: llc < %s -mtriple=amdgcn -mcpu=gfx900 -verify-machineinstrs | FileCheck -check-prefixes=PREGFX10-PACKED %s
; RUN: llc < %s -mtriple=amdgcn -mcpu=gfx1010 -verify-machineinstrs | FileCheck -check-prefixes=GFX10-PACKED %s
; RUN: llc < %s -mtriple=amdgcn -mcpu=gfx1100 -amdgpu-enable-vopd=0 -verify-machineinstrs | FileCheck -check-prefixes=GFX11-PACKED %s

define amdgpu_kernel void @tbuffer_store_d16_x(ptr addrspace(8) %rsrc, half %data) {
; PREGFX10-UNPACKED-LABEL: tbuffer_store_d16_x:
; PREGFX10-UNPACKED:       ; %bb.0: ; %main_body
; PREGFX10-UNPACKED-NEXT:    s_load_dword s4, s[0:1], 0x34
; PREGFX10-UNPACKED-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; PREGFX10-UNPACKED-NEXT:    s_waitcnt lgkmcnt(0)
; PREGFX10-UNPACKED-NEXT:    v_mov_b32_e32 v0, s4
; PREGFX10-UNPACKED-NEXT:    tbuffer_store_format_d16_x v0, off, s[0:3], 0 format:[BUF_NUM_FORMAT_USCALED]
; PREGFX10-UNPACKED-NEXT:    s_endpgm
;
; PREGFX10-PACKED-LABEL: tbuffer_store_d16_x:
; PREGFX10-PACKED:       ; %bb.0: ; %main_body
; PREGFX10-PACKED-NEXT:    s_load_dword s2, s[0:1], 0x34
; PREGFX10-PACKED-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; PREGFX10-PACKED-NEXT:    s_waitcnt lgkmcnt(0)
; PREGFX10-PACKED-NEXT:    v_mov_b32_e32 v0, s2
; PREGFX10-PACKED-NEXT:    tbuffer_store_format_d16_x v0, off, s[4:7], 0 format:[BUF_NUM_FORMAT_USCALED]
; PREGFX10-PACKED-NEXT:    s_endpgm
;
; GFX10-PACKED-LABEL: tbuffer_store_d16_x:
; GFX10-PACKED:       ; %bb.0: ; %main_body
; GFX10-PACKED-NEXT:    s_clause 0x1
; GFX10-PACKED-NEXT:    s_load_dword s2, s[0:1], 0x34
; GFX10-PACKED-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX10-PACKED-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-PACKED-NEXT:    v_mov_b32_e32 v0, s2
; GFX10-PACKED-NEXT:    tbuffer_store_format_d16_x v0, off, s[4:7], 0 format:[BUF_FMT_10_11_11_SSCALED]
; GFX10-PACKED-NEXT:    s_endpgm
;
; GFX11-PACKED-LABEL: tbuffer_store_d16_x:
; GFX11-PACKED:       ; %bb.0: ; %main_body
; GFX11-PACKED-NEXT:    s_clause 0x1
; GFX11-PACKED-NEXT:    s_load_b32 s4, s[0:1], 0x34
; GFX11-PACKED-NEXT:    s_load_b128 s[0:3], s[0:1], 0x24
; GFX11-PACKED-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-PACKED-NEXT:    v_mov_b32_e32 v0, s4
; GFX11-PACKED-NEXT:    tbuffer_store_d16_format_x v0, off, s[0:3], 0 format:[BUF_FMT_10_10_10_2_SNORM]
; GFX11-PACKED-NEXT:    s_nop 0
; GFX11-PACKED-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-PACKED-NEXT:    s_endpgm
main_body:
  call void @llvm.amdgcn.raw.ptr.tbuffer.store.f16(half %data, ptr addrspace(8) %rsrc, i32 0, i32 0, i32 33, i32 0)
  ret void
}

define amdgpu_kernel void @tbuffer_store_d16_xy(ptr addrspace(8) %rsrc, <2 x half> %data) {
; PREGFX10-UNPACKED-LABEL: tbuffer_store_d16_xy:
; PREGFX10-UNPACKED:       ; %bb.0: ; %main_body
; PREGFX10-UNPACKED-NEXT:    s_load_dword s4, s[0:1], 0x34
; PREGFX10-UNPACKED-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; PREGFX10-UNPACKED-NEXT:    s_waitcnt lgkmcnt(0)
; PREGFX10-UNPACKED-NEXT:    s_lshr_b32 s5, s4, 16
; PREGFX10-UNPACKED-NEXT:    s_and_b32 s4, s4, 0xffff
; PREGFX10-UNPACKED-NEXT:    v_mov_b32_e32 v0, s4
; PREGFX10-UNPACKED-NEXT:    v_mov_b32_e32 v1, s5
; PREGFX10-UNPACKED-NEXT:    tbuffer_store_format_d16_xy v[0:1], off, s[0:3], 0 format:[BUF_NUM_FORMAT_USCALED]
; PREGFX10-UNPACKED-NEXT:    s_endpgm
;
; PREGFX10-PACKED-LABEL: tbuffer_store_d16_xy:
; PREGFX10-PACKED:       ; %bb.0: ; %main_body
; PREGFX10-PACKED-NEXT:    s_load_dword s2, s[0:1], 0x34
; PREGFX10-PACKED-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; PREGFX10-PACKED-NEXT:    s_waitcnt lgkmcnt(0)
; PREGFX10-PACKED-NEXT:    v_mov_b32_e32 v0, s2
; PREGFX10-PACKED-NEXT:    tbuffer_store_format_d16_xy v0, off, s[4:7], 0 format:[BUF_NUM_FORMAT_USCALED]
; PREGFX10-PACKED-NEXT:    s_endpgm
;
; GFX10-PACKED-LABEL: tbuffer_store_d16_xy:
; GFX10-PACKED:       ; %bb.0: ; %main_body
; GFX10-PACKED-NEXT:    s_clause 0x1
; GFX10-PACKED-NEXT:    s_load_dword s2, s[0:1], 0x34
; GFX10-PACKED-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX10-PACKED-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-PACKED-NEXT:    v_mov_b32_e32 v0, s2
; GFX10-PACKED-NEXT:    tbuffer_store_format_d16_xy v0, off, s[4:7], 0 format:[BUF_FMT_10_11_11_SSCALED]
; GFX10-PACKED-NEXT:    s_endpgm
;
; GFX11-PACKED-LABEL: tbuffer_store_d16_xy:
; GFX11-PACKED:       ; %bb.0: ; %main_body
; GFX11-PACKED-NEXT:    s_clause 0x1
; GFX11-PACKED-NEXT:    s_load_b32 s4, s[0:1], 0x34
; GFX11-PACKED-NEXT:    s_load_b128 s[0:3], s[0:1], 0x24
; GFX11-PACKED-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-PACKED-NEXT:    v_mov_b32_e32 v0, s4
; GFX11-PACKED-NEXT:    tbuffer_store_d16_format_xy v0, off, s[0:3], 0 format:[BUF_FMT_10_10_10_2_SNORM]
; GFX11-PACKED-NEXT:    s_nop 0
; GFX11-PACKED-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-PACKED-NEXT:    s_endpgm
main_body:
  call void @llvm.amdgcn.raw.ptr.tbuffer.store.v2f16(<2 x half> %data, ptr addrspace(8) %rsrc, i32 0, i32 0, i32 33, i32 0)
  ret void
}

define amdgpu_kernel void @tbuffer_store_d16_xyz(ptr addrspace(8) %rsrc, <4 x half> %data) {
; PREGFX10-UNPACKED-LABEL: tbuffer_store_d16_xyz:
; PREGFX10-UNPACKED:       ; %bb.0: ; %main_body
; PREGFX10-UNPACKED-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x34
; PREGFX10-UNPACKED-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; PREGFX10-UNPACKED-NEXT:    s_waitcnt lgkmcnt(0)
; PREGFX10-UNPACKED-NEXT:    s_and_b32 s5, s5, 0xffff
; PREGFX10-UNPACKED-NEXT:    s_lshr_b32 s6, s4, 16
; PREGFX10-UNPACKED-NEXT:    s_and_b32 s4, s4, 0xffff
; PREGFX10-UNPACKED-NEXT:    v_mov_b32_e32 v0, s4
; PREGFX10-UNPACKED-NEXT:    v_mov_b32_e32 v1, s6
; PREGFX10-UNPACKED-NEXT:    v_mov_b32_e32 v2, s5
; PREGFX10-UNPACKED-NEXT:    tbuffer_store_format_d16_xyz v[0:2], off, s[0:3], 0 format:[BUF_NUM_FORMAT_USCALED]
; PREGFX10-UNPACKED-NEXT:    s_endpgm
;
; PREGFX10-PACKED-LABEL: tbuffer_store_d16_xyz:
; PREGFX10-PACKED:       ; %bb.0: ; %main_body
; PREGFX10-PACKED-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x34
; PREGFX10-PACKED-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; PREGFX10-PACKED-NEXT:    s_waitcnt lgkmcnt(0)
; PREGFX10-PACKED-NEXT:    s_and_b32 s0, s3, 0xffff
; PREGFX10-PACKED-NEXT:    v_mov_b32_e32 v0, s2
; PREGFX10-PACKED-NEXT:    v_mov_b32_e32 v1, s0
; PREGFX10-PACKED-NEXT:    tbuffer_store_format_d16_xyz v[0:1], off, s[4:7], 0 format:[BUF_NUM_FORMAT_USCALED]
; PREGFX10-PACKED-NEXT:    s_endpgm
;
; GFX10-PACKED-LABEL: tbuffer_store_d16_xyz:
; GFX10-PACKED:       ; %bb.0: ; %main_body
; GFX10-PACKED-NEXT:    s_clause 0x1
; GFX10-PACKED-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x34
; GFX10-PACKED-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX10-PACKED-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-PACKED-NEXT:    s_and_b32 s0, s3, 0xffff
; GFX10-PACKED-NEXT:    v_mov_b32_e32 v0, s2
; GFX10-PACKED-NEXT:    v_mov_b32_e32 v1, s0
; GFX10-PACKED-NEXT:    tbuffer_store_format_d16_xyz v[0:1], off, s[4:7], 0 format:[BUF_FMT_10_11_11_SSCALED]
; GFX10-PACKED-NEXT:    s_endpgm
;
; GFX11-PACKED-LABEL: tbuffer_store_d16_xyz:
; GFX11-PACKED:       ; %bb.0: ; %main_body
; GFX11-PACKED-NEXT:    s_clause 0x1
; GFX11-PACKED-NEXT:    s_load_b64 s[4:5], s[0:1], 0x34
; GFX11-PACKED-NEXT:    s_load_b128 s[0:3], s[0:1], 0x24
; GFX11-PACKED-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-PACKED-NEXT:    s_and_b32 s5, s5, 0xffff
; GFX11-PACKED-NEXT:    v_mov_b32_e32 v0, s4
; GFX11-PACKED-NEXT:    v_mov_b32_e32 v1, s5
; GFX11-PACKED-NEXT:    tbuffer_store_d16_format_xyz v[0:1], off, s[0:3], 0 format:[BUF_FMT_10_10_10_2_SNORM]
; GFX11-PACKED-NEXT:    s_nop 0
; GFX11-PACKED-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-PACKED-NEXT:    s_endpgm
main_body:
  %data_subvec = shufflevector <4 x half> %data, <4 x half> undef, <3 x i32> <i32 0, i32 1, i32 2>
  call void @llvm.amdgcn.raw.ptr.tbuffer.store.v3f16(<3 x half> %data_subvec, ptr addrspace(8) %rsrc, i32 0, i32 0, i32 33, i32 0)
  ret void
}

define amdgpu_kernel void @tbuffer_store_d16_xyzw(ptr addrspace(8) %rsrc, <4 x half> %data) {
; PREGFX10-UNPACKED-LABEL: tbuffer_store_d16_xyzw:
; PREGFX10-UNPACKED:       ; %bb.0: ; %main_body
; PREGFX10-UNPACKED-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x34
; PREGFX10-UNPACKED-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; PREGFX10-UNPACKED-NEXT:    s_waitcnt lgkmcnt(0)
; PREGFX10-UNPACKED-NEXT:    s_lshr_b32 s6, s5, 16
; PREGFX10-UNPACKED-NEXT:    s_and_b32 s5, s5, 0xffff
; PREGFX10-UNPACKED-NEXT:    s_lshr_b32 s7, s4, 16
; PREGFX10-UNPACKED-NEXT:    s_and_b32 s4, s4, 0xffff
; PREGFX10-UNPACKED-NEXT:    v_mov_b32_e32 v0, s4
; PREGFX10-UNPACKED-NEXT:    v_mov_b32_e32 v1, s7
; PREGFX10-UNPACKED-NEXT:    v_mov_b32_e32 v2, s5
; PREGFX10-UNPACKED-NEXT:    v_mov_b32_e32 v3, s6
; PREGFX10-UNPACKED-NEXT:    tbuffer_store_format_d16_xyzw v[0:3], off, s[0:3], 0 format:[BUF_NUM_FORMAT_USCALED]
; PREGFX10-UNPACKED-NEXT:    s_endpgm
;
; PREGFX10-PACKED-LABEL: tbuffer_store_d16_xyzw:
; PREGFX10-PACKED:       ; %bb.0: ; %main_body
; PREGFX10-PACKED-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x34
; PREGFX10-PACKED-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; PREGFX10-PACKED-NEXT:    s_waitcnt lgkmcnt(0)
; PREGFX10-PACKED-NEXT:    v_mov_b32_e32 v0, s2
; PREGFX10-PACKED-NEXT:    v_mov_b32_e32 v1, s3
; PREGFX10-PACKED-NEXT:    tbuffer_store_format_d16_xyzw v[0:1], off, s[4:7], 0 format:[BUF_NUM_FORMAT_USCALED]
; PREGFX10-PACKED-NEXT:    s_endpgm
;
; GFX10-PACKED-LABEL: tbuffer_store_d16_xyzw:
; GFX10-PACKED:       ; %bb.0: ; %main_body
; GFX10-PACKED-NEXT:    s_clause 0x1
; GFX10-PACKED-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x34
; GFX10-PACKED-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX10-PACKED-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-PACKED-NEXT:    v_mov_b32_e32 v0, s2
; GFX10-PACKED-NEXT:    v_mov_b32_e32 v1, s3
; GFX10-PACKED-NEXT:    tbuffer_store_format_d16_xyzw v[0:1], off, s[4:7], 0 format:[BUF_FMT_10_11_11_SSCALED]
; GFX10-PACKED-NEXT:    s_endpgm
;
; GFX11-PACKED-LABEL: tbuffer_store_d16_xyzw:
; GFX11-PACKED:       ; %bb.0: ; %main_body
; GFX11-PACKED-NEXT:    s_clause 0x1
; GFX11-PACKED-NEXT:    s_load_b64 s[4:5], s[0:1], 0x34
; GFX11-PACKED-NEXT:    s_load_b128 s[0:3], s[0:1], 0x24
; GFX11-PACKED-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-PACKED-NEXT:    v_mov_b32_e32 v0, s4
; GFX11-PACKED-NEXT:    v_mov_b32_e32 v1, s5
; GFX11-PACKED-NEXT:    tbuffer_store_d16_format_xyzw v[0:1], off, s[0:3], 0 format:[BUF_FMT_10_10_10_2_SNORM]
; GFX11-PACKED-NEXT:    s_nop 0
; GFX11-PACKED-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-PACKED-NEXT:    s_endpgm
main_body:
  call void @llvm.amdgcn.raw.ptr.tbuffer.store.v4f16(<4 x half> %data, ptr addrspace(8) %rsrc, i32 0, i32 0, i32 33, i32 0)
  ret void
}

declare void @llvm.amdgcn.raw.ptr.tbuffer.store.f16(half, ptr addrspace(8), i32, i32, i32, i32)
declare void @llvm.amdgcn.raw.ptr.tbuffer.store.v2f16(<2 x half>, ptr addrspace(8), i32, i32, i32, i32)
declare void @llvm.amdgcn.raw.ptr.tbuffer.store.v3f16(<3 x half>, ptr addrspace(8), i32, i32, i32, i32)
declare void @llvm.amdgcn.raw.ptr.tbuffer.store.v4f16(<4 x half>, ptr addrspace(8), i32, i32, i32, i32)
