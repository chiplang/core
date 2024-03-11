; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn -mcpu=gfx1200 -mattr=-wavefrontsize32,+wavefrontsize64 -verify-machineinstrs < %s | FileCheck %s --check-prefix=GFX12

define amdgpu_ps void @test_wmma_i32_16x16x16_iu8_zext_src0(i32 %A, i32 %B, <4 x i32> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_i32_16x16x16_iu8_zext_src0:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_i32_16x16x16_iu8 v[2:5], v0, v1, v[2:5] neg_lo:[1,0,0]
; GFX12-NEXT:    global_store_b128 v[6:7], v[2:5], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <4 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu8.v4i32.i32.i32.v4i32(i1 1, i32 %A, i1 0, i32 %B, <4 x i32> %C, i1 0)
  store <4 x i32> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_iu8_zext_src1(i32 %A, i32 %B, <4 x i32> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_i32_16x16x16_iu8_zext_src1:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_i32_16x16x16_iu8 v[2:5], v0, v1, v[2:5] neg_lo:[0,1,0]
; GFX12-NEXT:    global_store_b128 v[6:7], v[2:5], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <4 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu8.v4i32.i32.i32.v4i32(i1 0, i32 %A, i1 1, i32 %B, <4 x i32> %C, i1 0)
  store <4 x i32> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_iu8_clamp(i32 %A, i32 %B, <4 x i32> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_i32_16x16x16_iu8_clamp:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_i32_16x16x16_iu8 v[2:5], v0, v1, v[2:5] clamp
; GFX12-NEXT:    global_store_b128 v[6:7], v[2:5], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <4 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu8.v4i32.i32.i32.v4i32(i1 0, i32 %A, i1 0, i32 %B, <4 x i32> %C, i1 1)
  store <4 x i32> %res, ptr addrspace(1) %out
  ret void
}



define amdgpu_ps void @test_wmma_i32_16x16x16_iu4_zext_src0(i32 %A, i32 %B, <4 x i32> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_i32_16x16x16_iu4_zext_src0:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_i32_16x16x16_iu4 v[2:5], v0, v1, v[2:5] neg_lo:[1,0,0]
; GFX12-NEXT:    global_store_b128 v[6:7], v[2:5], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <4 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu4.v4i32.i32.i32.v4i32(i1 1, i32 %A, i1 0, i32 %B, <4 x i32> %C, i1 0)
  store <4 x i32> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_iu4_zext_src1(i32 %A, i32 %B, <4 x i32> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_i32_16x16x16_iu4_zext_src1:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_i32_16x16x16_iu4 v[2:5], v0, v1, v[2:5] neg_lo:[0,1,0]
; GFX12-NEXT:    global_store_b128 v[6:7], v[2:5], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <4 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu4.v4i32.i32.i32.v4i32(i1 0, i32 %A, i1 1, i32 %B, <4 x i32> %C, i1 0)
  store <4 x i32> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_iu4_clamp(i32 %A, i32 %B, <4 x i32> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_i32_16x16x16_iu4_clamp:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_i32_16x16x16_iu4 v[2:5], v0, v1, v[2:5] clamp
; GFX12-NEXT:    global_store_b128 v[6:7], v[2:5], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <4 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu4.v4i32.i32.i32.v4i32(i1 0, i32 %A, i1 0, i32 %B, <4 x i32> %C, i1 1)
  store <4 x i32> %res, ptr addrspace(1) %out
  ret void
}



define amdgpu_ps void @test_wmma_i32_16x16x32_iu4_zext_src0(i32 %A, i32 %B, <4 x i32> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_i32_16x16x32_iu4_zext_src0:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_i32_16x16x32_iu4 v[2:5], v0, v1, v[2:5] neg_lo:[1,0,0]
; GFX12-NEXT:    global_store_b128 v[6:7], v[2:5], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <4 x i32> @llvm.amdgcn.wmma.i32.16x16x32.iu4.v4i32.i32.i32.v4i32(i1 1, i32 %A, i1 0, i32 %B, <4 x i32> %C, i1 0)
  store <4 x i32> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x32_iu4_zext_src1(i32 %A, i32 %B, <4 x i32> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_i32_16x16x32_iu4_zext_src1:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_i32_16x16x32_iu4 v[2:5], v0, v1, v[2:5] neg_lo:[0,1,0]
; GFX12-NEXT:    global_store_b128 v[6:7], v[2:5], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <4 x i32> @llvm.amdgcn.wmma.i32.16x16x32.iu4.v4i32.i32.i32.v4i32(i1 0, i32 %A, i1 1, i32 %B, <4 x i32> %C, i1 0)
  store <4 x i32> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x32_iu4_clamp(i32 %A, i32 %B, <4 x i32> %C, ptr addrspace(1) %out) {
; GFX12-LABEL: test_wmma_i32_16x16x32_iu4_clamp:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_wmma_i32_16x16x32_iu4 v[2:5], v0, v1, v[2:5] clamp
; GFX12-NEXT:    global_store_b128 v[6:7], v[2:5], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <4 x i32> @llvm.amdgcn.wmma.i32.16x16x32.iu4.v4i32.i32.i32.v4i32(i1 0, i32 %A, i1 0, i32 %B, <4 x i32> %C, i1 1)
  store <4 x i32> %res, ptr addrspace(1) %out
  ret void
}






define amdgpu_ps void @test_swmmac_i32_16x16x32_iu8_zext_src0(i32 %A, <2 x i32> %B, <4 x i32> %C, i8 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_i32_16x16x32_iu8_zext_src0:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_i32_16x16x32_iu8 v[3:6], v0, v[1:2], v7 neg_lo:[1,0,0]
; GFX12-NEXT:    global_store_b128 v[8:9], v[3:6], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu8.v4i32.i32.v2i32.v4i32.i8(i1 1, i32 %A, i1 0, <2 x i32> %B, <4 x i32> %C, i8 %Index, i1 0)
  store <4 x i32> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_i32_16x16x32_iu8_zext_src1(i32 %A, <2 x i32> %B, <4 x i32> %C, i8 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_i32_16x16x32_iu8_zext_src1:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_i32_16x16x32_iu8 v[3:6], v0, v[1:2], v7 neg_lo:[0,1,0]
; GFX12-NEXT:    global_store_b128 v[8:9], v[3:6], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu8.v4i32.i32.v2i32.v4i32.i8(i1 0, i32 %A, i1 1, <2 x i32> %B, <4 x i32> %C, i8 %Index, i1 0)
  store <4 x i32> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_i32_16x16x32_iu8_clamp(i32 %A, <2 x i32> %B, <4 x i32> %C, i8 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_i32_16x16x32_iu8_clamp:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_i32_16x16x32_iu8 v[3:6], v0, v[1:2], v7 clamp
; GFX12-NEXT:    global_store_b128 v[8:9], v[3:6], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu8.v4i32.i32.v2i32.v4i32.i8(i1 0, i32 %A, i1 0, <2 x i32> %B, <4 x i32> %C, i8 %Index, i1 1)
  store <4 x i32> %res, ptr addrspace(1) %out
  ret void
}



define amdgpu_ps void @test_swmmac_i32_16x16x32_iu4_zext_src0(i32 %A, i32 %B, <4 x i32> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_i32_16x16x32_iu4_zext_src0:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_i32_16x16x32_iu4 v[2:5], v0, v1, v6 neg_lo:[1,0,0]
; GFX12-NEXT:    global_store_b128 v[7:8], v[2:5], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu4.v4i32.i32.i32.v4i32.i16(i1 1, i32 %A, i1 0, i32 %B, <4 x i32> %C, i16 %Index, i1 0)
  store <4 x i32> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_i32_16x16x32_iu4_zext_src1(i32 %A, i32 %B, <4 x i32> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_i32_16x16x32_iu4_zext_src1:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_i32_16x16x32_iu4 v[2:5], v0, v1, v6 neg_lo:[0,1,0]
; GFX12-NEXT:    global_store_b128 v[7:8], v[2:5], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu4.v4i32.i32.i32.v4i32.i16(i1 0, i32 %A, i1 1, i32 %B, <4 x i32> %C, i16 %Index, i1 0)
  store <4 x i32> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_i32_16x16x32_iu4_clamp(i32 %A, i32 %B, <4 x i32> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_i32_16x16x32_iu4_clamp:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_i32_16x16x32_iu4 v[2:5], v0, v1, v6 clamp
; GFX12-NEXT:    global_store_b128 v[7:8], v[2:5], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu4.v4i32.i32.i32.v4i32.i16(i1 0, i32 %A, i1 0, i32 %B, <4 x i32> %C, i16 %Index, i1 1)
  store <4 x i32> %res, ptr addrspace(1) %out
  ret void
}



define amdgpu_ps void @test_swmmac_i32_16x16x64_iu4_zext_src0(i32 %A, <2 x i32> %B, <4 x i32> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_i32_16x16x64_iu4_zext_src0:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_i32_16x16x64_iu4 v[3:6], v0, v[1:2], v7 neg_lo:[1,0,0]
; GFX12-NEXT:    global_store_b128 v[8:9], v[3:6], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x64.iu4.v4i32.i32.v2i32.v4i32.i16(i1 1, i32 %A, i1 0, <2 x i32> %B, <4 x i32> %C, i16 %Index, i1 0)
  store <4 x i32> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_i32_16x16x64_iu4_zext_src1(i32 %A, <2 x i32> %B, <4 x i32> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_i32_16x16x64_iu4_zext_src1:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_i32_16x16x64_iu4 v[3:6], v0, v[1:2], v7 neg_lo:[0,1,0]
; GFX12-NEXT:    global_store_b128 v[8:9], v[3:6], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x64.iu4.v4i32.i32.v2i32.v4i32.i16(i1 0, i32 %A, i1 1, <2 x i32> %B, <4 x i32> %C, i16 %Index, i1 0)
  store <4 x i32> %res, ptr addrspace(1) %out
  ret void
}

define amdgpu_ps void @test_swmmac_i32_16x16x64_iu4_clamp(i32 %A, <2 x i32> %B, <4 x i32> %C, i16 %Index, ptr addrspace(1) %out) {
; GFX12-LABEL: test_swmmac_i32_16x16x64_iu4_clamp:
; GFX12:       ; %bb.0: ; %bb
; GFX12-NEXT:    v_swmmac_i32_16x16x64_iu4 v[3:6], v0, v[1:2], v7 clamp
; GFX12-NEXT:    global_store_b128 v[8:9], v[3:6], off
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
bb:
  %res = call <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x64.iu4.v4i32.i32.v2i32.v4i32.i16(i1 0, i32 %A, i1 0, <2 x i32> %B, <4 x i32> %C, i16 %Index, i1 1)
  store <4 x i32> %res, ptr addrspace(1) %out
  ret void
}

declare <4 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu8.v4i32.i32.i32.v4i32(i1 immarg, i32, i1 immarg, i32, <4 x i32>, i1 immarg)
declare <4 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu4.v4i32.i32.i32.v4i32(i1 immarg, i32, i1 immarg, i32, <4 x i32>, i1 immarg)
declare <4 x i32> @llvm.amdgcn.wmma.i32.16x16x32.iu4.v4i32.i32.i32.v4i32(i1 immarg, i32, i1 immarg, i32, <4 x i32>, i1 immarg)
declare <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu8.v4i32.i32.v2i32.v4i32.i8(i1 immarg, i32, i1 immarg, <2 x i32>, <4 x i32>, i8 %Index, i1 immarg)
declare <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x32.iu4.v4i32.i32.i32.v4i32.i16(i1 immarg, i32, i1 immarg, i32, <4 x i32>, i16 %Index, i1 immarg)
declare <4 x i32> @llvm.amdgcn.swmmac.i32.16x16x64.iu4.v4i32.i32.v2i32.v4i32.i16(i1 immarg, i32, i1 immarg, <2 x i32>, <4 x i32>, i16 %Index, i1 immarg)
