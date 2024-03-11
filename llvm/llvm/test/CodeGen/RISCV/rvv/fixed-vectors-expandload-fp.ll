; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=riscv32 -mattr=+m,+v,+f,+d,+zfh,+zvfh -verify-machineinstrs < %s | FileCheck %s --check-prefixes=RV32
; RUN: llc -mtriple=riscv64 -mattr=+m,+v,+f,+d,+zfh,+zvfh -verify-machineinstrs < %s | FileCheck %s --check-prefixes=RV64

declare <1 x half> @llvm.masked.expandload.v1f16(ptr, <1 x i1>, <1 x half>)
define <1 x half> @expandload_v1f16(ptr %base, <1 x half> %src0, <1 x i1> %mask) {
; RV32-LABEL: expandload_v1f16:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetvli a1, zero, e8, mf8, ta, ma
; RV32-NEXT:    vfirst.m a1, v0
; RV32-NEXT:    bnez a1, .LBB0_2
; RV32-NEXT:  # %bb.1: # %cond.load
; RV32-NEXT:    vsetivli zero, 1, e16, mf4, ta, ma
; RV32-NEXT:    vle16.v v8, (a0)
; RV32-NEXT:  .LBB0_2: # %else
; RV32-NEXT:    ret
;
; RV64-LABEL: expandload_v1f16:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli a1, zero, e8, mf8, ta, ma
; RV64-NEXT:    vfirst.m a1, v0
; RV64-NEXT:    bnez a1, .LBB0_2
; RV64-NEXT:  # %bb.1: # %cond.load
; RV64-NEXT:    vsetivli zero, 1, e16, mf4, ta, ma
; RV64-NEXT:    vle16.v v8, (a0)
; RV64-NEXT:  .LBB0_2: # %else
; RV64-NEXT:    ret
  %res = call <1 x half> @llvm.masked.expandload.v1f16(ptr align 2 %base, <1 x i1> %mask, <1 x half> %src0)
  ret <1 x half>%res
}

declare <2 x half> @llvm.masked.expandload.v2f16(ptr, <2 x i1>, <2 x half>)
define <2 x half> @expandload_v2f16(ptr %base, <2 x half> %src0, <2 x i1> %mask) {
; RV32-LABEL: expandload_v2f16:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; RV32-NEXT:    vmv.x.s a1, v0
; RV32-NEXT:    andi a2, a1, 1
; RV32-NEXT:    bnez a2, .LBB1_3
; RV32-NEXT:  # %bb.1: # %else
; RV32-NEXT:    andi a1, a1, 2
; RV32-NEXT:    bnez a1, .LBB1_4
; RV32-NEXT:  .LBB1_2: # %else2
; RV32-NEXT:    ret
; RV32-NEXT:  .LBB1_3: # %cond.load
; RV32-NEXT:    flh fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 2, e16, m2, tu, ma
; RV32-NEXT:    vfmv.s.f v8, fa5
; RV32-NEXT:    addi a0, a0, 2
; RV32-NEXT:    andi a1, a1, 2
; RV32-NEXT:    beqz a1, .LBB1_2
; RV32-NEXT:  .LBB1_4: # %cond.load1
; RV32-NEXT:    flh fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; RV32-NEXT:    vfmv.s.f v9, fa5
; RV32-NEXT:    vslideup.vi v8, v9, 1
; RV32-NEXT:    ret
;
; RV64-LABEL: expandload_v2f16:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; RV64-NEXT:    vmv.x.s a1, v0
; RV64-NEXT:    andi a2, a1, 1
; RV64-NEXT:    bnez a2, .LBB1_3
; RV64-NEXT:  # %bb.1: # %else
; RV64-NEXT:    andi a1, a1, 2
; RV64-NEXT:    bnez a1, .LBB1_4
; RV64-NEXT:  .LBB1_2: # %else2
; RV64-NEXT:    ret
; RV64-NEXT:  .LBB1_3: # %cond.load
; RV64-NEXT:    flh fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 2, e16, m2, tu, ma
; RV64-NEXT:    vfmv.s.f v8, fa5
; RV64-NEXT:    addi a0, a0, 2
; RV64-NEXT:    andi a1, a1, 2
; RV64-NEXT:    beqz a1, .LBB1_2
; RV64-NEXT:  .LBB1_4: # %cond.load1
; RV64-NEXT:    flh fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; RV64-NEXT:    vfmv.s.f v9, fa5
; RV64-NEXT:    vslideup.vi v8, v9, 1
; RV64-NEXT:    ret
  %res = call <2 x half> @llvm.masked.expandload.v2f16(ptr align 2 %base, <2 x i1> %mask, <2 x half> %src0)
  ret <2 x half>%res
}

declare <4 x half> @llvm.masked.expandload.v4f16(ptr, <4 x i1>, <4 x half>)
define <4 x half> @expandload_v4f16(ptr %base, <4 x half> %src0, <4 x i1> %mask) {
; RV32-LABEL: expandload_v4f16:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; RV32-NEXT:    vmv.x.s a1, v0
; RV32-NEXT:    andi a2, a1, 1
; RV32-NEXT:    bnez a2, .LBB2_5
; RV32-NEXT:  # %bb.1: # %else
; RV32-NEXT:    andi a2, a1, 2
; RV32-NEXT:    bnez a2, .LBB2_6
; RV32-NEXT:  .LBB2_2: # %else2
; RV32-NEXT:    andi a2, a1, 4
; RV32-NEXT:    bnez a2, .LBB2_7
; RV32-NEXT:  .LBB2_3: # %else6
; RV32-NEXT:    andi a1, a1, 8
; RV32-NEXT:    bnez a1, .LBB2_8
; RV32-NEXT:  .LBB2_4: # %else10
; RV32-NEXT:    ret
; RV32-NEXT:  .LBB2_5: # %cond.load
; RV32-NEXT:    flh fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 4, e16, m2, tu, ma
; RV32-NEXT:    vfmv.s.f v8, fa5
; RV32-NEXT:    addi a0, a0, 2
; RV32-NEXT:    andi a2, a1, 2
; RV32-NEXT:    beqz a2, .LBB2_2
; RV32-NEXT:  .LBB2_6: # %cond.load1
; RV32-NEXT:    flh fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 2, e16, mf2, tu, ma
; RV32-NEXT:    vfmv.s.f v9, fa5
; RV32-NEXT:    vslideup.vi v8, v9, 1
; RV32-NEXT:    addi a0, a0, 2
; RV32-NEXT:    andi a2, a1, 4
; RV32-NEXT:    beqz a2, .LBB2_3
; RV32-NEXT:  .LBB2_7: # %cond.load5
; RV32-NEXT:    flh fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 3, e16, mf2, tu, ma
; RV32-NEXT:    vfmv.s.f v9, fa5
; RV32-NEXT:    vslideup.vi v8, v9, 2
; RV32-NEXT:    addi a0, a0, 2
; RV32-NEXT:    andi a1, a1, 8
; RV32-NEXT:    beqz a1, .LBB2_4
; RV32-NEXT:  .LBB2_8: # %cond.load9
; RV32-NEXT:    flh fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; RV32-NEXT:    vfmv.s.f v9, fa5
; RV32-NEXT:    vslideup.vi v8, v9, 3
; RV32-NEXT:    ret
;
; RV64-LABEL: expandload_v4f16:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; RV64-NEXT:    vmv.x.s a1, v0
; RV64-NEXT:    andi a2, a1, 1
; RV64-NEXT:    bnez a2, .LBB2_5
; RV64-NEXT:  # %bb.1: # %else
; RV64-NEXT:    andi a2, a1, 2
; RV64-NEXT:    bnez a2, .LBB2_6
; RV64-NEXT:  .LBB2_2: # %else2
; RV64-NEXT:    andi a2, a1, 4
; RV64-NEXT:    bnez a2, .LBB2_7
; RV64-NEXT:  .LBB2_3: # %else6
; RV64-NEXT:    andi a1, a1, 8
; RV64-NEXT:    bnez a1, .LBB2_8
; RV64-NEXT:  .LBB2_4: # %else10
; RV64-NEXT:    ret
; RV64-NEXT:  .LBB2_5: # %cond.load
; RV64-NEXT:    flh fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 4, e16, m2, tu, ma
; RV64-NEXT:    vfmv.s.f v8, fa5
; RV64-NEXT:    addi a0, a0, 2
; RV64-NEXT:    andi a2, a1, 2
; RV64-NEXT:    beqz a2, .LBB2_2
; RV64-NEXT:  .LBB2_6: # %cond.load1
; RV64-NEXT:    flh fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 2, e16, mf2, tu, ma
; RV64-NEXT:    vfmv.s.f v9, fa5
; RV64-NEXT:    vslideup.vi v8, v9, 1
; RV64-NEXT:    addi a0, a0, 2
; RV64-NEXT:    andi a2, a1, 4
; RV64-NEXT:    beqz a2, .LBB2_3
; RV64-NEXT:  .LBB2_7: # %cond.load5
; RV64-NEXT:    flh fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 3, e16, mf2, tu, ma
; RV64-NEXT:    vfmv.s.f v9, fa5
; RV64-NEXT:    vslideup.vi v8, v9, 2
; RV64-NEXT:    addi a0, a0, 2
; RV64-NEXT:    andi a1, a1, 8
; RV64-NEXT:    beqz a1, .LBB2_4
; RV64-NEXT:  .LBB2_8: # %cond.load9
; RV64-NEXT:    flh fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; RV64-NEXT:    vfmv.s.f v9, fa5
; RV64-NEXT:    vslideup.vi v8, v9, 3
; RV64-NEXT:    ret
  %res = call <4 x half> @llvm.masked.expandload.v4f16(ptr align 2 %base, <4 x i1> %mask, <4 x half> %src0)
  ret <4 x half>%res
}

declare <8 x half> @llvm.masked.expandload.v8f16(ptr, <8 x i1>, <8 x half>)
define <8 x half> @expandload_v8f16(ptr %base, <8 x half> %src0, <8 x i1> %mask) {
; RV32-LABEL: expandload_v8f16:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; RV32-NEXT:    vmv.x.s a1, v0
; RV32-NEXT:    andi a2, a1, 1
; RV32-NEXT:    bnez a2, .LBB3_9
; RV32-NEXT:  # %bb.1: # %else
; RV32-NEXT:    andi a2, a1, 2
; RV32-NEXT:    bnez a2, .LBB3_10
; RV32-NEXT:  .LBB3_2: # %else2
; RV32-NEXT:    andi a2, a1, 4
; RV32-NEXT:    bnez a2, .LBB3_11
; RV32-NEXT:  .LBB3_3: # %else6
; RV32-NEXT:    andi a2, a1, 8
; RV32-NEXT:    bnez a2, .LBB3_12
; RV32-NEXT:  .LBB3_4: # %else10
; RV32-NEXT:    andi a2, a1, 16
; RV32-NEXT:    bnez a2, .LBB3_13
; RV32-NEXT:  .LBB3_5: # %else14
; RV32-NEXT:    andi a2, a1, 32
; RV32-NEXT:    bnez a2, .LBB3_14
; RV32-NEXT:  .LBB3_6: # %else18
; RV32-NEXT:    andi a2, a1, 64
; RV32-NEXT:    bnez a2, .LBB3_15
; RV32-NEXT:  .LBB3_7: # %else22
; RV32-NEXT:    andi a1, a1, -128
; RV32-NEXT:    bnez a1, .LBB3_16
; RV32-NEXT:  .LBB3_8: # %else26
; RV32-NEXT:    ret
; RV32-NEXT:  .LBB3_9: # %cond.load
; RV32-NEXT:    flh fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 8, e16, m2, tu, ma
; RV32-NEXT:    vfmv.s.f v8, fa5
; RV32-NEXT:    addi a0, a0, 2
; RV32-NEXT:    andi a2, a1, 2
; RV32-NEXT:    beqz a2, .LBB3_2
; RV32-NEXT:  .LBB3_10: # %cond.load1
; RV32-NEXT:    flh fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 2, e16, m1, tu, ma
; RV32-NEXT:    vfmv.s.f v9, fa5
; RV32-NEXT:    vslideup.vi v8, v9, 1
; RV32-NEXT:    addi a0, a0, 2
; RV32-NEXT:    andi a2, a1, 4
; RV32-NEXT:    beqz a2, .LBB3_3
; RV32-NEXT:  .LBB3_11: # %cond.load5
; RV32-NEXT:    flh fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 3, e16, m1, tu, ma
; RV32-NEXT:    vfmv.s.f v9, fa5
; RV32-NEXT:    vslideup.vi v8, v9, 2
; RV32-NEXT:    addi a0, a0, 2
; RV32-NEXT:    andi a2, a1, 8
; RV32-NEXT:    beqz a2, .LBB3_4
; RV32-NEXT:  .LBB3_12: # %cond.load9
; RV32-NEXT:    flh fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 4, e16, m1, tu, ma
; RV32-NEXT:    vfmv.s.f v9, fa5
; RV32-NEXT:    vslideup.vi v8, v9, 3
; RV32-NEXT:    addi a0, a0, 2
; RV32-NEXT:    andi a2, a1, 16
; RV32-NEXT:    beqz a2, .LBB3_5
; RV32-NEXT:  .LBB3_13: # %cond.load13
; RV32-NEXT:    flh fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 5, e16, m1, tu, ma
; RV32-NEXT:    vfmv.s.f v9, fa5
; RV32-NEXT:    vslideup.vi v8, v9, 4
; RV32-NEXT:    addi a0, a0, 2
; RV32-NEXT:    andi a2, a1, 32
; RV32-NEXT:    beqz a2, .LBB3_6
; RV32-NEXT:  .LBB3_14: # %cond.load17
; RV32-NEXT:    flh fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 6, e16, m1, tu, ma
; RV32-NEXT:    vfmv.s.f v9, fa5
; RV32-NEXT:    vslideup.vi v8, v9, 5
; RV32-NEXT:    addi a0, a0, 2
; RV32-NEXT:    andi a2, a1, 64
; RV32-NEXT:    beqz a2, .LBB3_7
; RV32-NEXT:  .LBB3_15: # %cond.load21
; RV32-NEXT:    flh fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 7, e16, m1, tu, ma
; RV32-NEXT:    vfmv.s.f v9, fa5
; RV32-NEXT:    vslideup.vi v8, v9, 6
; RV32-NEXT:    addi a0, a0, 2
; RV32-NEXT:    andi a1, a1, -128
; RV32-NEXT:    beqz a1, .LBB3_8
; RV32-NEXT:  .LBB3_16: # %cond.load25
; RV32-NEXT:    flh fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; RV32-NEXT:    vfmv.s.f v9, fa5
; RV32-NEXT:    vslideup.vi v8, v9, 7
; RV32-NEXT:    ret
;
; RV64-LABEL: expandload_v8f16:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; RV64-NEXT:    vmv.x.s a1, v0
; RV64-NEXT:    andi a2, a1, 1
; RV64-NEXT:    bnez a2, .LBB3_9
; RV64-NEXT:  # %bb.1: # %else
; RV64-NEXT:    andi a2, a1, 2
; RV64-NEXT:    bnez a2, .LBB3_10
; RV64-NEXT:  .LBB3_2: # %else2
; RV64-NEXT:    andi a2, a1, 4
; RV64-NEXT:    bnez a2, .LBB3_11
; RV64-NEXT:  .LBB3_3: # %else6
; RV64-NEXT:    andi a2, a1, 8
; RV64-NEXT:    bnez a2, .LBB3_12
; RV64-NEXT:  .LBB3_4: # %else10
; RV64-NEXT:    andi a2, a1, 16
; RV64-NEXT:    bnez a2, .LBB3_13
; RV64-NEXT:  .LBB3_5: # %else14
; RV64-NEXT:    andi a2, a1, 32
; RV64-NEXT:    bnez a2, .LBB3_14
; RV64-NEXT:  .LBB3_6: # %else18
; RV64-NEXT:    andi a2, a1, 64
; RV64-NEXT:    bnez a2, .LBB3_15
; RV64-NEXT:  .LBB3_7: # %else22
; RV64-NEXT:    andi a1, a1, -128
; RV64-NEXT:    bnez a1, .LBB3_16
; RV64-NEXT:  .LBB3_8: # %else26
; RV64-NEXT:    ret
; RV64-NEXT:  .LBB3_9: # %cond.load
; RV64-NEXT:    flh fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 8, e16, m2, tu, ma
; RV64-NEXT:    vfmv.s.f v8, fa5
; RV64-NEXT:    addi a0, a0, 2
; RV64-NEXT:    andi a2, a1, 2
; RV64-NEXT:    beqz a2, .LBB3_2
; RV64-NEXT:  .LBB3_10: # %cond.load1
; RV64-NEXT:    flh fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 2, e16, m1, tu, ma
; RV64-NEXT:    vfmv.s.f v9, fa5
; RV64-NEXT:    vslideup.vi v8, v9, 1
; RV64-NEXT:    addi a0, a0, 2
; RV64-NEXT:    andi a2, a1, 4
; RV64-NEXT:    beqz a2, .LBB3_3
; RV64-NEXT:  .LBB3_11: # %cond.load5
; RV64-NEXT:    flh fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 3, e16, m1, tu, ma
; RV64-NEXT:    vfmv.s.f v9, fa5
; RV64-NEXT:    vslideup.vi v8, v9, 2
; RV64-NEXT:    addi a0, a0, 2
; RV64-NEXT:    andi a2, a1, 8
; RV64-NEXT:    beqz a2, .LBB3_4
; RV64-NEXT:  .LBB3_12: # %cond.load9
; RV64-NEXT:    flh fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 4, e16, m1, tu, ma
; RV64-NEXT:    vfmv.s.f v9, fa5
; RV64-NEXT:    vslideup.vi v8, v9, 3
; RV64-NEXT:    addi a0, a0, 2
; RV64-NEXT:    andi a2, a1, 16
; RV64-NEXT:    beqz a2, .LBB3_5
; RV64-NEXT:  .LBB3_13: # %cond.load13
; RV64-NEXT:    flh fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 5, e16, m1, tu, ma
; RV64-NEXT:    vfmv.s.f v9, fa5
; RV64-NEXT:    vslideup.vi v8, v9, 4
; RV64-NEXT:    addi a0, a0, 2
; RV64-NEXT:    andi a2, a1, 32
; RV64-NEXT:    beqz a2, .LBB3_6
; RV64-NEXT:  .LBB3_14: # %cond.load17
; RV64-NEXT:    flh fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 6, e16, m1, tu, ma
; RV64-NEXT:    vfmv.s.f v9, fa5
; RV64-NEXT:    vslideup.vi v8, v9, 5
; RV64-NEXT:    addi a0, a0, 2
; RV64-NEXT:    andi a2, a1, 64
; RV64-NEXT:    beqz a2, .LBB3_7
; RV64-NEXT:  .LBB3_15: # %cond.load21
; RV64-NEXT:    flh fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 7, e16, m1, tu, ma
; RV64-NEXT:    vfmv.s.f v9, fa5
; RV64-NEXT:    vslideup.vi v8, v9, 6
; RV64-NEXT:    addi a0, a0, 2
; RV64-NEXT:    andi a1, a1, -128
; RV64-NEXT:    beqz a1, .LBB3_8
; RV64-NEXT:  .LBB3_16: # %cond.load25
; RV64-NEXT:    flh fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; RV64-NEXT:    vfmv.s.f v9, fa5
; RV64-NEXT:    vslideup.vi v8, v9, 7
; RV64-NEXT:    ret
  %res = call <8 x half> @llvm.masked.expandload.v8f16(ptr align 2 %base, <8 x i1> %mask, <8 x half> %src0)
  ret <8 x half>%res
}

declare <1 x float> @llvm.masked.expandload.v1f32(ptr, <1 x i1>, <1 x float>)
define <1 x float> @expandload_v1f32(ptr %base, <1 x float> %src0, <1 x i1> %mask) {
; RV32-LABEL: expandload_v1f32:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetvli a1, zero, e8, mf8, ta, ma
; RV32-NEXT:    vfirst.m a1, v0
; RV32-NEXT:    bnez a1, .LBB4_2
; RV32-NEXT:  # %bb.1: # %cond.load
; RV32-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; RV32-NEXT:    vle32.v v8, (a0)
; RV32-NEXT:  .LBB4_2: # %else
; RV32-NEXT:    ret
;
; RV64-LABEL: expandload_v1f32:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli a1, zero, e8, mf8, ta, ma
; RV64-NEXT:    vfirst.m a1, v0
; RV64-NEXT:    bnez a1, .LBB4_2
; RV64-NEXT:  # %bb.1: # %cond.load
; RV64-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; RV64-NEXT:    vle32.v v8, (a0)
; RV64-NEXT:  .LBB4_2: # %else
; RV64-NEXT:    ret
  %res = call <1 x float> @llvm.masked.expandload.v1f32(ptr align 4 %base, <1 x i1> %mask, <1 x float> %src0)
  ret <1 x float>%res
}

declare <2 x float> @llvm.masked.expandload.v2f32(ptr, <2 x i1>, <2 x float>)
define <2 x float> @expandload_v2f32(ptr %base, <2 x float> %src0, <2 x i1> %mask) {
; RV32-LABEL: expandload_v2f32:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; RV32-NEXT:    vmv.x.s a1, v0
; RV32-NEXT:    andi a2, a1, 1
; RV32-NEXT:    bnez a2, .LBB5_3
; RV32-NEXT:  # %bb.1: # %else
; RV32-NEXT:    andi a1, a1, 2
; RV32-NEXT:    bnez a1, .LBB5_4
; RV32-NEXT:  .LBB5_2: # %else2
; RV32-NEXT:    ret
; RV32-NEXT:  .LBB5_3: # %cond.load
; RV32-NEXT:    flw fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 2, e32, m4, tu, ma
; RV32-NEXT:    vfmv.s.f v8, fa5
; RV32-NEXT:    addi a0, a0, 4
; RV32-NEXT:    andi a1, a1, 2
; RV32-NEXT:    beqz a1, .LBB5_2
; RV32-NEXT:  .LBB5_4: # %cond.load1
; RV32-NEXT:    flw fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; RV32-NEXT:    vfmv.s.f v9, fa5
; RV32-NEXT:    vslideup.vi v8, v9, 1
; RV32-NEXT:    ret
;
; RV64-LABEL: expandload_v2f32:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; RV64-NEXT:    vmv.x.s a1, v0
; RV64-NEXT:    andi a2, a1, 1
; RV64-NEXT:    bnez a2, .LBB5_3
; RV64-NEXT:  # %bb.1: # %else
; RV64-NEXT:    andi a1, a1, 2
; RV64-NEXT:    bnez a1, .LBB5_4
; RV64-NEXT:  .LBB5_2: # %else2
; RV64-NEXT:    ret
; RV64-NEXT:  .LBB5_3: # %cond.load
; RV64-NEXT:    flw fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 2, e32, m4, tu, ma
; RV64-NEXT:    vfmv.s.f v8, fa5
; RV64-NEXT:    addi a0, a0, 4
; RV64-NEXT:    andi a1, a1, 2
; RV64-NEXT:    beqz a1, .LBB5_2
; RV64-NEXT:  .LBB5_4: # %cond.load1
; RV64-NEXT:    flw fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; RV64-NEXT:    vfmv.s.f v9, fa5
; RV64-NEXT:    vslideup.vi v8, v9, 1
; RV64-NEXT:    ret
  %res = call <2 x float> @llvm.masked.expandload.v2f32(ptr align 4 %base, <2 x i1> %mask, <2 x float> %src0)
  ret <2 x float>%res
}

declare <4 x float> @llvm.masked.expandload.v4f32(ptr, <4 x i1>, <4 x float>)
define <4 x float> @expandload_v4f32(ptr %base, <4 x float> %src0, <4 x i1> %mask) {
; RV32-LABEL: expandload_v4f32:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; RV32-NEXT:    vmv.x.s a1, v0
; RV32-NEXT:    andi a2, a1, 1
; RV32-NEXT:    bnez a2, .LBB6_5
; RV32-NEXT:  # %bb.1: # %else
; RV32-NEXT:    andi a2, a1, 2
; RV32-NEXT:    bnez a2, .LBB6_6
; RV32-NEXT:  .LBB6_2: # %else2
; RV32-NEXT:    andi a2, a1, 4
; RV32-NEXT:    bnez a2, .LBB6_7
; RV32-NEXT:  .LBB6_3: # %else6
; RV32-NEXT:    andi a1, a1, 8
; RV32-NEXT:    bnez a1, .LBB6_8
; RV32-NEXT:  .LBB6_4: # %else10
; RV32-NEXT:    ret
; RV32-NEXT:  .LBB6_5: # %cond.load
; RV32-NEXT:    flw fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 4, e32, m4, tu, ma
; RV32-NEXT:    vfmv.s.f v8, fa5
; RV32-NEXT:    addi a0, a0, 4
; RV32-NEXT:    andi a2, a1, 2
; RV32-NEXT:    beqz a2, .LBB6_2
; RV32-NEXT:  .LBB6_6: # %cond.load1
; RV32-NEXT:    flw fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; RV32-NEXT:    vfmv.s.f v9, fa5
; RV32-NEXT:    vslideup.vi v8, v9, 1
; RV32-NEXT:    addi a0, a0, 4
; RV32-NEXT:    andi a2, a1, 4
; RV32-NEXT:    beqz a2, .LBB6_3
; RV32-NEXT:  .LBB6_7: # %cond.load5
; RV32-NEXT:    flw fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 3, e32, m1, tu, ma
; RV32-NEXT:    vfmv.s.f v9, fa5
; RV32-NEXT:    vslideup.vi v8, v9, 2
; RV32-NEXT:    addi a0, a0, 4
; RV32-NEXT:    andi a1, a1, 8
; RV32-NEXT:    beqz a1, .LBB6_4
; RV32-NEXT:  .LBB6_8: # %cond.load9
; RV32-NEXT:    flw fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; RV32-NEXT:    vfmv.s.f v9, fa5
; RV32-NEXT:    vslideup.vi v8, v9, 3
; RV32-NEXT:    ret
;
; RV64-LABEL: expandload_v4f32:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; RV64-NEXT:    vmv.x.s a1, v0
; RV64-NEXT:    andi a2, a1, 1
; RV64-NEXT:    bnez a2, .LBB6_5
; RV64-NEXT:  # %bb.1: # %else
; RV64-NEXT:    andi a2, a1, 2
; RV64-NEXT:    bnez a2, .LBB6_6
; RV64-NEXT:  .LBB6_2: # %else2
; RV64-NEXT:    andi a2, a1, 4
; RV64-NEXT:    bnez a2, .LBB6_7
; RV64-NEXT:  .LBB6_3: # %else6
; RV64-NEXT:    andi a1, a1, 8
; RV64-NEXT:    bnez a1, .LBB6_8
; RV64-NEXT:  .LBB6_4: # %else10
; RV64-NEXT:    ret
; RV64-NEXT:  .LBB6_5: # %cond.load
; RV64-NEXT:    flw fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 4, e32, m4, tu, ma
; RV64-NEXT:    vfmv.s.f v8, fa5
; RV64-NEXT:    addi a0, a0, 4
; RV64-NEXT:    andi a2, a1, 2
; RV64-NEXT:    beqz a2, .LBB6_2
; RV64-NEXT:  .LBB6_6: # %cond.load1
; RV64-NEXT:    flw fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; RV64-NEXT:    vfmv.s.f v9, fa5
; RV64-NEXT:    vslideup.vi v8, v9, 1
; RV64-NEXT:    addi a0, a0, 4
; RV64-NEXT:    andi a2, a1, 4
; RV64-NEXT:    beqz a2, .LBB6_3
; RV64-NEXT:  .LBB6_7: # %cond.load5
; RV64-NEXT:    flw fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 3, e32, m1, tu, ma
; RV64-NEXT:    vfmv.s.f v9, fa5
; RV64-NEXT:    vslideup.vi v8, v9, 2
; RV64-NEXT:    addi a0, a0, 4
; RV64-NEXT:    andi a1, a1, 8
; RV64-NEXT:    beqz a1, .LBB6_4
; RV64-NEXT:  .LBB6_8: # %cond.load9
; RV64-NEXT:    flw fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; RV64-NEXT:    vfmv.s.f v9, fa5
; RV64-NEXT:    vslideup.vi v8, v9, 3
; RV64-NEXT:    ret
  %res = call <4 x float> @llvm.masked.expandload.v4f32(ptr align 4 %base, <4 x i1> %mask, <4 x float> %src0)
  ret <4 x float>%res
}

declare <8 x float> @llvm.masked.expandload.v8f32(ptr, <8 x i1>, <8 x float>)
define <8 x float> @expandload_v8f32(ptr %base, <8 x float> %src0, <8 x i1> %mask) {
; RV32-LABEL: expandload_v8f32:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; RV32-NEXT:    vmv.x.s a1, v0
; RV32-NEXT:    andi a2, a1, 1
; RV32-NEXT:    bnez a2, .LBB7_9
; RV32-NEXT:  # %bb.1: # %else
; RV32-NEXT:    andi a2, a1, 2
; RV32-NEXT:    bnez a2, .LBB7_10
; RV32-NEXT:  .LBB7_2: # %else2
; RV32-NEXT:    andi a2, a1, 4
; RV32-NEXT:    bnez a2, .LBB7_11
; RV32-NEXT:  .LBB7_3: # %else6
; RV32-NEXT:    andi a2, a1, 8
; RV32-NEXT:    bnez a2, .LBB7_12
; RV32-NEXT:  .LBB7_4: # %else10
; RV32-NEXT:    andi a2, a1, 16
; RV32-NEXT:    bnez a2, .LBB7_13
; RV32-NEXT:  .LBB7_5: # %else14
; RV32-NEXT:    andi a2, a1, 32
; RV32-NEXT:    bnez a2, .LBB7_14
; RV32-NEXT:  .LBB7_6: # %else18
; RV32-NEXT:    andi a2, a1, 64
; RV32-NEXT:    bnez a2, .LBB7_15
; RV32-NEXT:  .LBB7_7: # %else22
; RV32-NEXT:    andi a1, a1, -128
; RV32-NEXT:    bnez a1, .LBB7_16
; RV32-NEXT:  .LBB7_8: # %else26
; RV32-NEXT:    ret
; RV32-NEXT:  .LBB7_9: # %cond.load
; RV32-NEXT:    flw fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 8, e32, m4, tu, ma
; RV32-NEXT:    vfmv.s.f v8, fa5
; RV32-NEXT:    addi a0, a0, 4
; RV32-NEXT:    andi a2, a1, 2
; RV32-NEXT:    beqz a2, .LBB7_2
; RV32-NEXT:  .LBB7_10: # %cond.load1
; RV32-NEXT:    flw fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; RV32-NEXT:    vfmv.s.f v10, fa5
; RV32-NEXT:    vslideup.vi v8, v10, 1
; RV32-NEXT:    addi a0, a0, 4
; RV32-NEXT:    andi a2, a1, 4
; RV32-NEXT:    beqz a2, .LBB7_3
; RV32-NEXT:  .LBB7_11: # %cond.load5
; RV32-NEXT:    flw fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 3, e32, m1, tu, ma
; RV32-NEXT:    vfmv.s.f v10, fa5
; RV32-NEXT:    vslideup.vi v8, v10, 2
; RV32-NEXT:    addi a0, a0, 4
; RV32-NEXT:    andi a2, a1, 8
; RV32-NEXT:    beqz a2, .LBB7_4
; RV32-NEXT:  .LBB7_12: # %cond.load9
; RV32-NEXT:    flw fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 4, e32, m1, tu, ma
; RV32-NEXT:    vfmv.s.f v10, fa5
; RV32-NEXT:    vslideup.vi v8, v10, 3
; RV32-NEXT:    addi a0, a0, 4
; RV32-NEXT:    andi a2, a1, 16
; RV32-NEXT:    beqz a2, .LBB7_5
; RV32-NEXT:  .LBB7_13: # %cond.load13
; RV32-NEXT:    flw fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 5, e32, m2, tu, ma
; RV32-NEXT:    vfmv.s.f v10, fa5
; RV32-NEXT:    vslideup.vi v8, v10, 4
; RV32-NEXT:    addi a0, a0, 4
; RV32-NEXT:    andi a2, a1, 32
; RV32-NEXT:    beqz a2, .LBB7_6
; RV32-NEXT:  .LBB7_14: # %cond.load17
; RV32-NEXT:    flw fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 6, e32, m2, tu, ma
; RV32-NEXT:    vfmv.s.f v10, fa5
; RV32-NEXT:    vslideup.vi v8, v10, 5
; RV32-NEXT:    addi a0, a0, 4
; RV32-NEXT:    andi a2, a1, 64
; RV32-NEXT:    beqz a2, .LBB7_7
; RV32-NEXT:  .LBB7_15: # %cond.load21
; RV32-NEXT:    flw fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 7, e32, m2, tu, ma
; RV32-NEXT:    vfmv.s.f v10, fa5
; RV32-NEXT:    vslideup.vi v8, v10, 6
; RV32-NEXT:    addi a0, a0, 4
; RV32-NEXT:    andi a1, a1, -128
; RV32-NEXT:    beqz a1, .LBB7_8
; RV32-NEXT:  .LBB7_16: # %cond.load25
; RV32-NEXT:    flw fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; RV32-NEXT:    vfmv.s.f v10, fa5
; RV32-NEXT:    vslideup.vi v8, v10, 7
; RV32-NEXT:    ret
;
; RV64-LABEL: expandload_v8f32:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; RV64-NEXT:    vmv.x.s a1, v0
; RV64-NEXT:    andi a2, a1, 1
; RV64-NEXT:    bnez a2, .LBB7_9
; RV64-NEXT:  # %bb.1: # %else
; RV64-NEXT:    andi a2, a1, 2
; RV64-NEXT:    bnez a2, .LBB7_10
; RV64-NEXT:  .LBB7_2: # %else2
; RV64-NEXT:    andi a2, a1, 4
; RV64-NEXT:    bnez a2, .LBB7_11
; RV64-NEXT:  .LBB7_3: # %else6
; RV64-NEXT:    andi a2, a1, 8
; RV64-NEXT:    bnez a2, .LBB7_12
; RV64-NEXT:  .LBB7_4: # %else10
; RV64-NEXT:    andi a2, a1, 16
; RV64-NEXT:    bnez a2, .LBB7_13
; RV64-NEXT:  .LBB7_5: # %else14
; RV64-NEXT:    andi a2, a1, 32
; RV64-NEXT:    bnez a2, .LBB7_14
; RV64-NEXT:  .LBB7_6: # %else18
; RV64-NEXT:    andi a2, a1, 64
; RV64-NEXT:    bnez a2, .LBB7_15
; RV64-NEXT:  .LBB7_7: # %else22
; RV64-NEXT:    andi a1, a1, -128
; RV64-NEXT:    bnez a1, .LBB7_16
; RV64-NEXT:  .LBB7_8: # %else26
; RV64-NEXT:    ret
; RV64-NEXT:  .LBB7_9: # %cond.load
; RV64-NEXT:    flw fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 8, e32, m4, tu, ma
; RV64-NEXT:    vfmv.s.f v8, fa5
; RV64-NEXT:    addi a0, a0, 4
; RV64-NEXT:    andi a2, a1, 2
; RV64-NEXT:    beqz a2, .LBB7_2
; RV64-NEXT:  .LBB7_10: # %cond.load1
; RV64-NEXT:    flw fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; RV64-NEXT:    vfmv.s.f v10, fa5
; RV64-NEXT:    vslideup.vi v8, v10, 1
; RV64-NEXT:    addi a0, a0, 4
; RV64-NEXT:    andi a2, a1, 4
; RV64-NEXT:    beqz a2, .LBB7_3
; RV64-NEXT:  .LBB7_11: # %cond.load5
; RV64-NEXT:    flw fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 3, e32, m1, tu, ma
; RV64-NEXT:    vfmv.s.f v10, fa5
; RV64-NEXT:    vslideup.vi v8, v10, 2
; RV64-NEXT:    addi a0, a0, 4
; RV64-NEXT:    andi a2, a1, 8
; RV64-NEXT:    beqz a2, .LBB7_4
; RV64-NEXT:  .LBB7_12: # %cond.load9
; RV64-NEXT:    flw fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 4, e32, m1, tu, ma
; RV64-NEXT:    vfmv.s.f v10, fa5
; RV64-NEXT:    vslideup.vi v8, v10, 3
; RV64-NEXT:    addi a0, a0, 4
; RV64-NEXT:    andi a2, a1, 16
; RV64-NEXT:    beqz a2, .LBB7_5
; RV64-NEXT:  .LBB7_13: # %cond.load13
; RV64-NEXT:    flw fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 5, e32, m2, tu, ma
; RV64-NEXT:    vfmv.s.f v10, fa5
; RV64-NEXT:    vslideup.vi v8, v10, 4
; RV64-NEXT:    addi a0, a0, 4
; RV64-NEXT:    andi a2, a1, 32
; RV64-NEXT:    beqz a2, .LBB7_6
; RV64-NEXT:  .LBB7_14: # %cond.load17
; RV64-NEXT:    flw fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 6, e32, m2, tu, ma
; RV64-NEXT:    vfmv.s.f v10, fa5
; RV64-NEXT:    vslideup.vi v8, v10, 5
; RV64-NEXT:    addi a0, a0, 4
; RV64-NEXT:    andi a2, a1, 64
; RV64-NEXT:    beqz a2, .LBB7_7
; RV64-NEXT:  .LBB7_15: # %cond.load21
; RV64-NEXT:    flw fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 7, e32, m2, tu, ma
; RV64-NEXT:    vfmv.s.f v10, fa5
; RV64-NEXT:    vslideup.vi v8, v10, 6
; RV64-NEXT:    addi a0, a0, 4
; RV64-NEXT:    andi a1, a1, -128
; RV64-NEXT:    beqz a1, .LBB7_8
; RV64-NEXT:  .LBB7_16: # %cond.load25
; RV64-NEXT:    flw fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; RV64-NEXT:    vfmv.s.f v10, fa5
; RV64-NEXT:    vslideup.vi v8, v10, 7
; RV64-NEXT:    ret
  %res = call <8 x float> @llvm.masked.expandload.v8f32(ptr align 4 %base, <8 x i1> %mask, <8 x float> %src0)
  ret <8 x float>%res
}

declare <1 x double> @llvm.masked.expandload.v1f64(ptr, <1 x i1>, <1 x double>)
define <1 x double> @expandload_v1f64(ptr %base, <1 x double> %src0, <1 x i1> %mask) {
; RV32-LABEL: expandload_v1f64:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetvli a1, zero, e8, mf8, ta, ma
; RV32-NEXT:    vfirst.m a1, v0
; RV32-NEXT:    bnez a1, .LBB8_2
; RV32-NEXT:  # %bb.1: # %cond.load
; RV32-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; RV32-NEXT:    vle64.v v8, (a0)
; RV32-NEXT:  .LBB8_2: # %else
; RV32-NEXT:    ret
;
; RV64-LABEL: expandload_v1f64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli a1, zero, e8, mf8, ta, ma
; RV64-NEXT:    vfirst.m a1, v0
; RV64-NEXT:    bnez a1, .LBB8_2
; RV64-NEXT:  # %bb.1: # %cond.load
; RV64-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; RV64-NEXT:    vle64.v v8, (a0)
; RV64-NEXT:  .LBB8_2: # %else
; RV64-NEXT:    ret
  %res = call <1 x double> @llvm.masked.expandload.v1f64(ptr align 8 %base, <1 x i1> %mask, <1 x double> %src0)
  ret <1 x double>%res
}

declare <2 x double> @llvm.masked.expandload.v2f64(ptr, <2 x i1>, <2 x double>)
define <2 x double> @expandload_v2f64(ptr %base, <2 x double> %src0, <2 x i1> %mask) {
; RV32-LABEL: expandload_v2f64:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; RV32-NEXT:    vmv.x.s a1, v0
; RV32-NEXT:    andi a2, a1, 1
; RV32-NEXT:    bnez a2, .LBB9_3
; RV32-NEXT:  # %bb.1: # %else
; RV32-NEXT:    andi a1, a1, 2
; RV32-NEXT:    bnez a1, .LBB9_4
; RV32-NEXT:  .LBB9_2: # %else2
; RV32-NEXT:    ret
; RV32-NEXT:  .LBB9_3: # %cond.load
; RV32-NEXT:    fld fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 2, e64, m8, tu, ma
; RV32-NEXT:    vfmv.s.f v8, fa5
; RV32-NEXT:    addi a0, a0, 8
; RV32-NEXT:    andi a1, a1, 2
; RV32-NEXT:    beqz a1, .LBB9_2
; RV32-NEXT:  .LBB9_4: # %cond.load1
; RV32-NEXT:    fld fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV32-NEXT:    vfmv.s.f v9, fa5
; RV32-NEXT:    vslideup.vi v8, v9, 1
; RV32-NEXT:    ret
;
; RV64-LABEL: expandload_v2f64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; RV64-NEXT:    vmv.x.s a1, v0
; RV64-NEXT:    andi a2, a1, 1
; RV64-NEXT:    bnez a2, .LBB9_3
; RV64-NEXT:  # %bb.1: # %else
; RV64-NEXT:    andi a1, a1, 2
; RV64-NEXT:    bnez a1, .LBB9_4
; RV64-NEXT:  .LBB9_2: # %else2
; RV64-NEXT:    ret
; RV64-NEXT:  .LBB9_3: # %cond.load
; RV64-NEXT:    fld fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 2, e64, m8, tu, ma
; RV64-NEXT:    vfmv.s.f v8, fa5
; RV64-NEXT:    addi a0, a0, 8
; RV64-NEXT:    andi a1, a1, 2
; RV64-NEXT:    beqz a1, .LBB9_2
; RV64-NEXT:  .LBB9_4: # %cond.load1
; RV64-NEXT:    fld fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV64-NEXT:    vfmv.s.f v9, fa5
; RV64-NEXT:    vslideup.vi v8, v9, 1
; RV64-NEXT:    ret
  %res = call <2 x double> @llvm.masked.expandload.v2f64(ptr align 8 %base, <2 x i1> %mask, <2 x double> %src0)
  ret <2 x double>%res
}

declare <4 x double> @llvm.masked.expandload.v4f64(ptr, <4 x i1>, <4 x double>)
define <4 x double> @expandload_v4f64(ptr %base, <4 x double> %src0, <4 x i1> %mask) {
; RV32-LABEL: expandload_v4f64:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; RV32-NEXT:    vmv.x.s a1, v0
; RV32-NEXT:    andi a2, a1, 1
; RV32-NEXT:    bnez a2, .LBB10_5
; RV32-NEXT:  # %bb.1: # %else
; RV32-NEXT:    andi a2, a1, 2
; RV32-NEXT:    bnez a2, .LBB10_6
; RV32-NEXT:  .LBB10_2: # %else2
; RV32-NEXT:    andi a2, a1, 4
; RV32-NEXT:    bnez a2, .LBB10_7
; RV32-NEXT:  .LBB10_3: # %else6
; RV32-NEXT:    andi a1, a1, 8
; RV32-NEXT:    bnez a1, .LBB10_8
; RV32-NEXT:  .LBB10_4: # %else10
; RV32-NEXT:    ret
; RV32-NEXT:  .LBB10_5: # %cond.load
; RV32-NEXT:    fld fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 4, e64, m8, tu, ma
; RV32-NEXT:    vfmv.s.f v8, fa5
; RV32-NEXT:    addi a0, a0, 8
; RV32-NEXT:    andi a2, a1, 2
; RV32-NEXT:    beqz a2, .LBB10_2
; RV32-NEXT:  .LBB10_6: # %cond.load1
; RV32-NEXT:    fld fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 2, e64, m1, tu, ma
; RV32-NEXT:    vfmv.s.f v10, fa5
; RV32-NEXT:    vslideup.vi v8, v10, 1
; RV32-NEXT:    addi a0, a0, 8
; RV32-NEXT:    andi a2, a1, 4
; RV32-NEXT:    beqz a2, .LBB10_3
; RV32-NEXT:  .LBB10_7: # %cond.load5
; RV32-NEXT:    fld fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 3, e64, m2, tu, ma
; RV32-NEXT:    vfmv.s.f v10, fa5
; RV32-NEXT:    vslideup.vi v8, v10, 2
; RV32-NEXT:    addi a0, a0, 8
; RV32-NEXT:    andi a1, a1, 8
; RV32-NEXT:    beqz a1, .LBB10_4
; RV32-NEXT:  .LBB10_8: # %cond.load9
; RV32-NEXT:    fld fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; RV32-NEXT:    vfmv.s.f v10, fa5
; RV32-NEXT:    vslideup.vi v8, v10, 3
; RV32-NEXT:    ret
;
; RV64-LABEL: expandload_v4f64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; RV64-NEXT:    vmv.x.s a1, v0
; RV64-NEXT:    andi a2, a1, 1
; RV64-NEXT:    bnez a2, .LBB10_5
; RV64-NEXT:  # %bb.1: # %else
; RV64-NEXT:    andi a2, a1, 2
; RV64-NEXT:    bnez a2, .LBB10_6
; RV64-NEXT:  .LBB10_2: # %else2
; RV64-NEXT:    andi a2, a1, 4
; RV64-NEXT:    bnez a2, .LBB10_7
; RV64-NEXT:  .LBB10_3: # %else6
; RV64-NEXT:    andi a1, a1, 8
; RV64-NEXT:    bnez a1, .LBB10_8
; RV64-NEXT:  .LBB10_4: # %else10
; RV64-NEXT:    ret
; RV64-NEXT:  .LBB10_5: # %cond.load
; RV64-NEXT:    fld fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 4, e64, m8, tu, ma
; RV64-NEXT:    vfmv.s.f v8, fa5
; RV64-NEXT:    addi a0, a0, 8
; RV64-NEXT:    andi a2, a1, 2
; RV64-NEXT:    beqz a2, .LBB10_2
; RV64-NEXT:  .LBB10_6: # %cond.load1
; RV64-NEXT:    fld fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 2, e64, m1, tu, ma
; RV64-NEXT:    vfmv.s.f v10, fa5
; RV64-NEXT:    vslideup.vi v8, v10, 1
; RV64-NEXT:    addi a0, a0, 8
; RV64-NEXT:    andi a2, a1, 4
; RV64-NEXT:    beqz a2, .LBB10_3
; RV64-NEXT:  .LBB10_7: # %cond.load5
; RV64-NEXT:    fld fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 3, e64, m2, tu, ma
; RV64-NEXT:    vfmv.s.f v10, fa5
; RV64-NEXT:    vslideup.vi v8, v10, 2
; RV64-NEXT:    addi a0, a0, 8
; RV64-NEXT:    andi a1, a1, 8
; RV64-NEXT:    beqz a1, .LBB10_4
; RV64-NEXT:  .LBB10_8: # %cond.load9
; RV64-NEXT:    fld fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; RV64-NEXT:    vfmv.s.f v10, fa5
; RV64-NEXT:    vslideup.vi v8, v10, 3
; RV64-NEXT:    ret
  %res = call <4 x double> @llvm.masked.expandload.v4f64(ptr align 8 %base, <4 x i1> %mask, <4 x double> %src0)
  ret <4 x double>%res
}

declare <8 x double> @llvm.masked.expandload.v8f64(ptr, <8 x i1>, <8 x double>)
define <8 x double> @expandload_v8f64(ptr %base, <8 x double> %src0, <8 x i1> %mask) {
; RV32-LABEL: expandload_v8f64:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; RV32-NEXT:    vmv.x.s a1, v0
; RV32-NEXT:    andi a2, a1, 1
; RV32-NEXT:    bnez a2, .LBB11_9
; RV32-NEXT:  # %bb.1: # %else
; RV32-NEXT:    andi a2, a1, 2
; RV32-NEXT:    bnez a2, .LBB11_10
; RV32-NEXT:  .LBB11_2: # %else2
; RV32-NEXT:    andi a2, a1, 4
; RV32-NEXT:    bnez a2, .LBB11_11
; RV32-NEXT:  .LBB11_3: # %else6
; RV32-NEXT:    andi a2, a1, 8
; RV32-NEXT:    bnez a2, .LBB11_12
; RV32-NEXT:  .LBB11_4: # %else10
; RV32-NEXT:    andi a2, a1, 16
; RV32-NEXT:    bnez a2, .LBB11_13
; RV32-NEXT:  .LBB11_5: # %else14
; RV32-NEXT:    andi a2, a1, 32
; RV32-NEXT:    bnez a2, .LBB11_14
; RV32-NEXT:  .LBB11_6: # %else18
; RV32-NEXT:    andi a2, a1, 64
; RV32-NEXT:    bnez a2, .LBB11_15
; RV32-NEXT:  .LBB11_7: # %else22
; RV32-NEXT:    andi a1, a1, -128
; RV32-NEXT:    bnez a1, .LBB11_16
; RV32-NEXT:  .LBB11_8: # %else26
; RV32-NEXT:    ret
; RV32-NEXT:  .LBB11_9: # %cond.load
; RV32-NEXT:    fld fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 8, e64, m8, tu, ma
; RV32-NEXT:    vfmv.s.f v8, fa5
; RV32-NEXT:    addi a0, a0, 8
; RV32-NEXT:    andi a2, a1, 2
; RV32-NEXT:    beqz a2, .LBB11_2
; RV32-NEXT:  .LBB11_10: # %cond.load1
; RV32-NEXT:    fld fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 2, e64, m1, tu, ma
; RV32-NEXT:    vfmv.s.f v12, fa5
; RV32-NEXT:    vslideup.vi v8, v12, 1
; RV32-NEXT:    addi a0, a0, 8
; RV32-NEXT:    andi a2, a1, 4
; RV32-NEXT:    beqz a2, .LBB11_3
; RV32-NEXT:  .LBB11_11: # %cond.load5
; RV32-NEXT:    fld fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 3, e64, m2, tu, ma
; RV32-NEXT:    vfmv.s.f v12, fa5
; RV32-NEXT:    vslideup.vi v8, v12, 2
; RV32-NEXT:    addi a0, a0, 8
; RV32-NEXT:    andi a2, a1, 8
; RV32-NEXT:    beqz a2, .LBB11_4
; RV32-NEXT:  .LBB11_12: # %cond.load9
; RV32-NEXT:    fld fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 4, e64, m2, tu, ma
; RV32-NEXT:    vfmv.s.f v12, fa5
; RV32-NEXT:    vslideup.vi v8, v12, 3
; RV32-NEXT:    addi a0, a0, 8
; RV32-NEXT:    andi a2, a1, 16
; RV32-NEXT:    beqz a2, .LBB11_5
; RV32-NEXT:  .LBB11_13: # %cond.load13
; RV32-NEXT:    fld fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 5, e64, m4, tu, ma
; RV32-NEXT:    vfmv.s.f v12, fa5
; RV32-NEXT:    vslideup.vi v8, v12, 4
; RV32-NEXT:    addi a0, a0, 8
; RV32-NEXT:    andi a2, a1, 32
; RV32-NEXT:    beqz a2, .LBB11_6
; RV32-NEXT:  .LBB11_14: # %cond.load17
; RV32-NEXT:    fld fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 6, e64, m4, tu, ma
; RV32-NEXT:    vfmv.s.f v12, fa5
; RV32-NEXT:    vslideup.vi v8, v12, 5
; RV32-NEXT:    addi a0, a0, 8
; RV32-NEXT:    andi a2, a1, 64
; RV32-NEXT:    beqz a2, .LBB11_7
; RV32-NEXT:  .LBB11_15: # %cond.load21
; RV32-NEXT:    fld fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 7, e64, m4, tu, ma
; RV32-NEXT:    vfmv.s.f v12, fa5
; RV32-NEXT:    vslideup.vi v8, v12, 6
; RV32-NEXT:    addi a0, a0, 8
; RV32-NEXT:    andi a1, a1, -128
; RV32-NEXT:    beqz a1, .LBB11_8
; RV32-NEXT:  .LBB11_16: # %cond.load25
; RV32-NEXT:    fld fa5, 0(a0)
; RV32-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV32-NEXT:    vfmv.s.f v12, fa5
; RV32-NEXT:    vslideup.vi v8, v12, 7
; RV32-NEXT:    ret
;
; RV64-LABEL: expandload_v8f64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; RV64-NEXT:    vmv.x.s a1, v0
; RV64-NEXT:    andi a2, a1, 1
; RV64-NEXT:    bnez a2, .LBB11_9
; RV64-NEXT:  # %bb.1: # %else
; RV64-NEXT:    andi a2, a1, 2
; RV64-NEXT:    bnez a2, .LBB11_10
; RV64-NEXT:  .LBB11_2: # %else2
; RV64-NEXT:    andi a2, a1, 4
; RV64-NEXT:    bnez a2, .LBB11_11
; RV64-NEXT:  .LBB11_3: # %else6
; RV64-NEXT:    andi a2, a1, 8
; RV64-NEXT:    bnez a2, .LBB11_12
; RV64-NEXT:  .LBB11_4: # %else10
; RV64-NEXT:    andi a2, a1, 16
; RV64-NEXT:    bnez a2, .LBB11_13
; RV64-NEXT:  .LBB11_5: # %else14
; RV64-NEXT:    andi a2, a1, 32
; RV64-NEXT:    bnez a2, .LBB11_14
; RV64-NEXT:  .LBB11_6: # %else18
; RV64-NEXT:    andi a2, a1, 64
; RV64-NEXT:    bnez a2, .LBB11_15
; RV64-NEXT:  .LBB11_7: # %else22
; RV64-NEXT:    andi a1, a1, -128
; RV64-NEXT:    bnez a1, .LBB11_16
; RV64-NEXT:  .LBB11_8: # %else26
; RV64-NEXT:    ret
; RV64-NEXT:  .LBB11_9: # %cond.load
; RV64-NEXT:    fld fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 8, e64, m8, tu, ma
; RV64-NEXT:    vfmv.s.f v8, fa5
; RV64-NEXT:    addi a0, a0, 8
; RV64-NEXT:    andi a2, a1, 2
; RV64-NEXT:    beqz a2, .LBB11_2
; RV64-NEXT:  .LBB11_10: # %cond.load1
; RV64-NEXT:    fld fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 2, e64, m1, tu, ma
; RV64-NEXT:    vfmv.s.f v12, fa5
; RV64-NEXT:    vslideup.vi v8, v12, 1
; RV64-NEXT:    addi a0, a0, 8
; RV64-NEXT:    andi a2, a1, 4
; RV64-NEXT:    beqz a2, .LBB11_3
; RV64-NEXT:  .LBB11_11: # %cond.load5
; RV64-NEXT:    fld fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 3, e64, m2, tu, ma
; RV64-NEXT:    vfmv.s.f v12, fa5
; RV64-NEXT:    vslideup.vi v8, v12, 2
; RV64-NEXT:    addi a0, a0, 8
; RV64-NEXT:    andi a2, a1, 8
; RV64-NEXT:    beqz a2, .LBB11_4
; RV64-NEXT:  .LBB11_12: # %cond.load9
; RV64-NEXT:    fld fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 4, e64, m2, tu, ma
; RV64-NEXT:    vfmv.s.f v12, fa5
; RV64-NEXT:    vslideup.vi v8, v12, 3
; RV64-NEXT:    addi a0, a0, 8
; RV64-NEXT:    andi a2, a1, 16
; RV64-NEXT:    beqz a2, .LBB11_5
; RV64-NEXT:  .LBB11_13: # %cond.load13
; RV64-NEXT:    fld fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 5, e64, m4, tu, ma
; RV64-NEXT:    vfmv.s.f v12, fa5
; RV64-NEXT:    vslideup.vi v8, v12, 4
; RV64-NEXT:    addi a0, a0, 8
; RV64-NEXT:    andi a2, a1, 32
; RV64-NEXT:    beqz a2, .LBB11_6
; RV64-NEXT:  .LBB11_14: # %cond.load17
; RV64-NEXT:    fld fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 6, e64, m4, tu, ma
; RV64-NEXT:    vfmv.s.f v12, fa5
; RV64-NEXT:    vslideup.vi v8, v12, 5
; RV64-NEXT:    addi a0, a0, 8
; RV64-NEXT:    andi a2, a1, 64
; RV64-NEXT:    beqz a2, .LBB11_7
; RV64-NEXT:  .LBB11_15: # %cond.load21
; RV64-NEXT:    fld fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 7, e64, m4, tu, ma
; RV64-NEXT:    vfmv.s.f v12, fa5
; RV64-NEXT:    vslideup.vi v8, v12, 6
; RV64-NEXT:    addi a0, a0, 8
; RV64-NEXT:    andi a1, a1, -128
; RV64-NEXT:    beqz a1, .LBB11_8
; RV64-NEXT:  .LBB11_16: # %cond.load25
; RV64-NEXT:    fld fa5, 0(a0)
; RV64-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV64-NEXT:    vfmv.s.f v12, fa5
; RV64-NEXT:    vslideup.vi v8, v12, 7
; RV64-NEXT:    ret
  %res = call <8 x double> @llvm.masked.expandload.v8f64(ptr align 8 %base, <8 x i1> %mask, <8 x double> %src0)
  ret <8 x double>%res
}
