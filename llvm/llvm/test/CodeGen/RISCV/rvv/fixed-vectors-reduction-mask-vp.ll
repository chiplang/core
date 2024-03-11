; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+v -verify-machineinstrs < %s | FileCheck %s

declare i1 @llvm.vp.reduce.and.v1i1(i1, <1 x i1>, <1 x i1>, i32)

define zeroext i1 @vpreduce_and_v1i1(i1 zeroext %s, <1 x i1> %v, <1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_and_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.and.v1i1(i1 %s, <1 x i1> %v, <1 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.or.v1i1(i1, <1 x i1>, <1 x i1>, i32)

define zeroext i1 @vpreduce_or_v1i1(i1 zeroext %s, <1 x i1> %v, <1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_or_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.or.v1i1(i1 %s, <1 x i1> %v, <1 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.xor.v1i1(i1, <1 x i1>, <1 x i1>, i32)

define zeroext i1 @vpreduce_xor_v1i1(i1 zeroext %s, <1 x i1> %v, <1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_xor_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    andi a1, a1, 1
; CHECK-NEXT:    xor a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.xor.v1i1(i1 %s, <1 x i1> %v, <1 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.and.v2i1(i1, <2 x i1>, <2 x i1>, i32)

define zeroext i1 @vpreduce_and_v2i1(i1 zeroext %s, <2 x i1> %v, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_and_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.and.v2i1(i1 %s, <2 x i1> %v, <2 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.or.v2i1(i1, <2 x i1>, <2 x i1>, i32)

define zeroext i1 @vpreduce_or_v2i1(i1 zeroext %s, <2 x i1> %v, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_or_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.or.v2i1(i1 %s, <2 x i1> %v, <2 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.xor.v2i1(i1, <2 x i1>, <2 x i1>, i32)

define zeroext i1 @vpreduce_xor_v2i1(i1 zeroext %s, <2 x i1> %v, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_xor_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    andi a1, a1, 1
; CHECK-NEXT:    xor a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.xor.v2i1(i1 %s, <2 x i1> %v, <2 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.and.v4i1(i1, <4 x i1>, <4 x i1>, i32)

define zeroext i1 @vpreduce_and_v4i1(i1 zeroext %s, <4 x i1> %v, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_and_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf4, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.and.v4i1(i1 %s, <4 x i1> %v, <4 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.or.v4i1(i1, <4 x i1>, <4 x i1>, i32)

define zeroext i1 @vpreduce_or_v4i1(i1 zeroext %s, <4 x i1> %v, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_or_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.or.v4i1(i1 %s, <4 x i1> %v, <4 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.xor.v4i1(i1, <4 x i1>, <4 x i1>, i32)

define zeroext i1 @vpreduce_xor_v4i1(i1 zeroext %s, <4 x i1> %v, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_xor_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    andi a1, a1, 1
; CHECK-NEXT:    xor a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.xor.v4i1(i1 %s, <4 x i1> %v, <4 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.and.v8i1(i1, <8 x i1>, <8 x i1>, i32)

define zeroext i1 @vpreduce_and_v8i1(i1 zeroext %s, <8 x i1> %v, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_and_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.and.v8i1(i1 %s, <8 x i1> %v, <8 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.or.v8i1(i1, <8 x i1>, <8 x i1>, i32)

define zeroext i1 @vpreduce_or_v8i1(i1 zeroext %s, <8 x i1> %v, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_or_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.or.v8i1(i1 %s, <8 x i1> %v, <8 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.xor.v8i1(i1, <8 x i1>, <8 x i1>, i32)

define zeroext i1 @vpreduce_xor_v8i1(i1 zeroext %s, <8 x i1> %v, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_xor_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    andi a1, a1, 1
; CHECK-NEXT:    xor a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.xor.v8i1(i1 %s, <8 x i1> %v, <8 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.and.v10i1(i1, <10 x i1>, <10 x i1>, i32)

define zeroext i1 @vpreduce_and_v10i1(i1 zeroext %s, <10 x i1> %v, <10 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_and_v10i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.and.v10i1(i1 %s, <10 x i1> %v, <10 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.and.v16i1(i1, <16 x i1>, <16 x i1>, i32)

define zeroext i1 @vpreduce_and_v16i1(i1 zeroext %s, <16 x i1> %v, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_and_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.and.v16i1(i1 %s, <16 x i1> %v, <16 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.and.v256i1(i1, <256 x i1>, <256 x i1>, i32)

define zeroext i1 @vpreduce_and_v256i1(i1 zeroext %s, <256 x i1> %v, <256 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_and_v256i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 128
; CHECK-NEXT:    mv a2, a1
; CHECK-NEXT:    bltu a1, a3, .LBB14_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    li a2, 128
; CHECK-NEXT:  .LBB14_2:
; CHECK-NEXT:    vsetvli zero, a2, e8, m8, ta, ma
; CHECK-NEXT:    vmnot.m v11, v0
; CHECK-NEXT:    vmv1r.v v0, v9
; CHECK-NEXT:    vcpop.m a2, v11, v0.t
; CHECK-NEXT:    seqz a2, a2
; CHECK-NEXT:    and a0, a2, a0
; CHECK-NEXT:    addi a2, a1, -128
; CHECK-NEXT:    sltu a1, a1, a2
; CHECK-NEXT:    addi a1, a1, -1
; CHECK-NEXT:    and a1, a1, a2
; CHECK-NEXT:    vsetvli zero, a1, e8, m8, ta, ma
; CHECK-NEXT:    vmnot.m v8, v8
; CHECK-NEXT:    vmv1r.v v0, v10
; CHECK-NEXT:    vcpop.m a1, v8, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.and.v256i1(i1 %s, <256 x i1> %v, <256 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.or.v16i1(i1, <16 x i1>, <16 x i1>, i32)

define zeroext i1 @vpreduce_or_v16i1(i1 zeroext %s, <16 x i1> %v, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_or_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.or.v16i1(i1 %s, <16 x i1> %v, <16 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.xor.v16i1(i1, <16 x i1>, <16 x i1>, i32)

define zeroext i1 @vpreduce_xor_v16i1(i1 zeroext %s, <16 x i1> %v, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_xor_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    andi a1, a1, 1
; CHECK-NEXT:    xor a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.xor.v16i1(i1 %s, <16 x i1> %v, <16 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.add.v1i1(i1, <1 x i1>, <1 x i1>, i32)

define zeroext i1 @vpreduce_add_v1i1(i1 zeroext %s, <1 x i1> %v, <1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_add_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    andi a1, a1, 1
; CHECK-NEXT:    xor a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.add.v1i1(i1 %s, <1 x i1> %v, <1 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.add.v2i1(i1, <2 x i1>, <2 x i1>, i32)

define zeroext i1 @vpreduce_add_v2i1(i1 zeroext %s, <2 x i1> %v, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_add_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    andi a1, a1, 1
; CHECK-NEXT:    xor a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.add.v2i1(i1 %s, <2 x i1> %v, <2 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.add.v4i1(i1, <4 x i1>, <4 x i1>, i32)

define zeroext i1 @vpreduce_add_v4i1(i1 zeroext %s, <4 x i1> %v, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_add_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    andi a1, a1, 1
; CHECK-NEXT:    xor a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.add.v4i1(i1 %s, <4 x i1> %v, <4 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.add.v8i1(i1, <8 x i1>, <8 x i1>, i32)

define zeroext i1 @vpreduce_add_v8i1(i1 zeroext %s, <8 x i1> %v, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_add_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    andi a1, a1, 1
; CHECK-NEXT:    xor a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.add.v8i1(i1 %s, <8 x i1> %v, <8 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.add.v16i1(i1, <16 x i1>, <16 x i1>, i32)

define zeroext i1 @vpreduce_add_v16i1(i1 zeroext %s, <16 x i1> %v, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_add_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    andi a1, a1, 1
; CHECK-NEXT:    xor a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.add.v16i1(i1 %s, <16 x i1> %v, <16 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.smax.v1i1(i1, <1 x i1>, <1 x i1>, i32)

define zeroext i1 @vpreduce_smax_v1i1(i1 zeroext %s, <1 x i1> %v, <1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_smax_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.smax.v1i1(i1 %s, <1 x i1> %v, <1 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.smax.v2i1(i1, <2 x i1>, <2 x i1>, i32)

define zeroext i1 @vpreduce_smax_v2i1(i1 zeroext %s, <2 x i1> %v, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_smax_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.smax.v2i1(i1 %s, <2 x i1> %v, <2 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.smax.v4i1(i1, <4 x i1>, <4 x i1>, i32)

define zeroext i1 @vpreduce_smax_v4i1(i1 zeroext %s, <4 x i1> %v, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_smax_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf4, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.smax.v4i1(i1 %s, <4 x i1> %v, <4 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.smax.v8i1(i1, <8 x i1>, <8 x i1>, i32)

define zeroext i1 @vpreduce_smax_v8i1(i1 zeroext %s, <8 x i1> %v, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_smax_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.smax.v8i1(i1 %s, <8 x i1> %v, <8 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.smax.v16i1(i1, <16 x i1>, <16 x i1>, i32)

define zeroext i1 @vpreduce_smax_v16i1(i1 zeroext %s, <16 x i1> %v, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_smax_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.smax.v16i1(i1 %s, <16 x i1> %v, <16 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.smax.v32i1(i1, <32 x i1>, <32 x i1>, i32)

define zeroext i1 @vpreduce_smax_v32i1(i1 zeroext %s, <32 x i1> %v, <32 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_smax_v32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m2, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.smax.v32i1(i1 %s, <32 x i1> %v, <32 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.smax.v64i1(i1, <64 x i1>, <64 x i1>, i32)

define zeroext i1 @vpreduce_smax_v64i1(i1 zeroext %s, <64 x i1> %v, <64 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_smax_v64i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m4, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.smax.v64i1(i1 %s, <64 x i1> %v, <64 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.smin.v1i1(i1, <1 x i1>, <1 x i1>, i32)

define zeroext i1 @vpreduce_smin_v1i1(i1 zeroext %s, <1 x i1> %v, <1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_smin_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.smin.v1i1(i1 %s, <1 x i1> %v, <1 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.smin.v2i1(i1, <2 x i1>, <2 x i1>, i32)

define zeroext i1 @vpreduce_smin_v2i1(i1 zeroext %s, <2 x i1> %v, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_smin_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.smin.v2i1(i1 %s, <2 x i1> %v, <2 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.smin.v4i1(i1, <4 x i1>, <4 x i1>, i32)

define zeroext i1 @vpreduce_smin_v4i1(i1 zeroext %s, <4 x i1> %v, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_smin_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.smin.v4i1(i1 %s, <4 x i1> %v, <4 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.smin.v8i1(i1, <8 x i1>, <8 x i1>, i32)

define zeroext i1 @vpreduce_smin_v8i1(i1 zeroext %s, <8 x i1> %v, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_smin_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.smin.v8i1(i1 %s, <8 x i1> %v, <8 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.smin.v16i1(i1, <16 x i1>, <16 x i1>, i32)

define zeroext i1 @vpreduce_smin_v16i1(i1 zeroext %s, <16 x i1> %v, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_smin_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.smin.v16i1(i1 %s, <16 x i1> %v, <16 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.smin.v32i1(i1, <32 x i1>, <32 x i1>, i32)

define zeroext i1 @vpreduce_smin_v32i1(i1 zeroext %s, <32 x i1> %v, <32 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_smin_v32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, m2, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.smin.v32i1(i1 %s, <32 x i1> %v, <32 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.smin.v64i1(i1, <64 x i1>, <64 x i1>, i32)

define zeroext i1 @vpreduce_smin_v64i1(i1 zeroext %s, <64 x i1> %v, <64 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_smin_v64i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, m4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.smin.v64i1(i1 %s, <64 x i1> %v, <64 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.umax.v1i1(i1, <1 x i1>, <1 x i1>, i32)

define zeroext i1 @vpreduce_umax_v1i1(i1 zeroext %s, <1 x i1> %v, <1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_umax_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.umax.v1i1(i1 %s, <1 x i1> %v, <1 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.umax.v2i1(i1, <2 x i1>, <2 x i1>, i32)

define zeroext i1 @vpreduce_umax_v2i1(i1 zeroext %s, <2 x i1> %v, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_umax_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.umax.v2i1(i1 %s, <2 x i1> %v, <2 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.umax.v4i1(i1, <4 x i1>, <4 x i1>, i32)

define zeroext i1 @vpreduce_umax_v4i1(i1 zeroext %s, <4 x i1> %v, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_umax_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.umax.v4i1(i1 %s, <4 x i1> %v, <4 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.umax.v8i1(i1, <8 x i1>, <8 x i1>, i32)

define zeroext i1 @vpreduce_umax_v8i1(i1 zeroext %s, <8 x i1> %v, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_umax_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.umax.v8i1(i1 %s, <8 x i1> %v, <8 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.umax.v16i1(i1, <16 x i1>, <16 x i1>, i32)

define zeroext i1 @vpreduce_umax_v16i1(i1 zeroext %s, <16 x i1> %v, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_umax_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.umax.v16i1(i1 %s, <16 x i1> %v, <16 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.umax.v32i1(i1, <32 x i1>, <32 x i1>, i32)

define zeroext i1 @vpreduce_umax_v32i1(i1 zeroext %s, <32 x i1> %v, <32 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_umax_v32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, m2, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.umax.v32i1(i1 %s, <32 x i1> %v, <32 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.umax.v64i1(i1, <64 x i1>, <64 x i1>, i32)

define zeroext i1 @vpreduce_umax_v64i1(i1 zeroext %s, <64 x i1> %v, <64 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_umax_v64i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, m4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.umax.v64i1(i1 %s, <64 x i1> %v, <64 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.umin.v1i1(i1, <1 x i1>, <1 x i1>, i32)

define zeroext i1 @vpreduce_umin_v1i1(i1 zeroext %s, <1 x i1> %v, <1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_umin_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.umin.v1i1(i1 %s, <1 x i1> %v, <1 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.umin.v2i1(i1, <2 x i1>, <2 x i1>, i32)

define zeroext i1 @vpreduce_umin_v2i1(i1 zeroext %s, <2 x i1> %v, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_umin_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.umin.v2i1(i1 %s, <2 x i1> %v, <2 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.umin.v4i1(i1, <4 x i1>, <4 x i1>, i32)

define zeroext i1 @vpreduce_umin_v4i1(i1 zeroext %s, <4 x i1> %v, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_umin_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf4, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.umin.v4i1(i1 %s, <4 x i1> %v, <4 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.umin.v8i1(i1, <8 x i1>, <8 x i1>, i32)

define zeroext i1 @vpreduce_umin_v8i1(i1 zeroext %s, <8 x i1> %v, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_umin_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.umin.v8i1(i1 %s, <8 x i1> %v, <8 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.umin.v16i1(i1, <16 x i1>, <16 x i1>, i32)

define zeroext i1 @vpreduce_umin_v16i1(i1 zeroext %s, <16 x i1> %v, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_umin_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.umin.v16i1(i1 %s, <16 x i1> %v, <16 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.umin.v32i1(i1, <32 x i1>, <32 x i1>, i32)

define zeroext i1 @vpreduce_umin_v32i1(i1 zeroext %s, <32 x i1> %v, <32 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_umin_v32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m2, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.umin.v32i1(i1 %s, <32 x i1> %v, <32 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.umin.v64i1(i1, <64 x i1>, <64 x i1>, i32)

define zeroext i1 @vpreduce_umin_v64i1(i1 zeroext %s, <64 x i1> %v, <64 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_umin_v64i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m4, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.umin.v64i1(i1 %s, <64 x i1> %v, <64 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.mul.v1i1(i1, <1 x i1>, <1 x i1>, i32)

define i1 @vpreduce_mul_v1i1(i1 %s, <1 x i1> %v, <1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_mul_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.mul.v1i1(i1 %s, <1 x i1> %v, <1 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.mul.v2i1(i1, <2 x i1>, <2 x i1>, i32)

define zeroext i1 @vpreduce_mul_v2i1(i1 zeroext %s, <2 x i1> %v, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_mul_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.mul.v2i1(i1 %s, <2 x i1> %v, <2 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.mul.v4i1(i1, <4 x i1>, <4 x i1>, i32)

define zeroext i1 @vpreduce_mul_v4i1(i1 zeroext %s, <4 x i1> %v, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_mul_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf4, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.mul.v4i1(i1 %s, <4 x i1> %v, <4 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.mul.v8i1(i1, <8 x i1>, <8 x i1>, i32)

define zeroext i1 @vpreduce_mul_v8i1(i1 zeroext %s, <8 x i1> %v, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_mul_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.mul.v8i1(i1 %s, <8 x i1> %v, <8 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.mul.v16i1(i1, <16 x i1>, <16 x i1>, i32)

define zeroext i1 @vpreduce_mul_v16i1(i1 zeroext %s, <16 x i1> %v, <16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_mul_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.mul.v16i1(i1 %s, <16 x i1> %v, <16 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.mul.v32i1(i1, <32 x i1>, <32 x i1>, i32)

define zeroext i1 @vpreduce_mul_v32i1(i1 zeroext %s, <32 x i1> %v, <32 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_mul_v32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m2, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.mul.v32i1(i1 %s, <32 x i1> %v, <32 x i1> %m, i32 %evl)
  ret i1 %r
}

declare i1 @llvm.vp.reduce.mul.v64i1(i1, <64 x i1>, <64 x i1>, i32)

define zeroext i1 @vpreduce_mul_v64i1(i1 zeroext %s, <64 x i1> %v, <64 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_mul_v64i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m4, ta, ma
; CHECK-NEXT:    vmnot.m v9, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vcpop.m a1, v9, v0.t
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
  %r = call i1 @llvm.vp.reduce.mul.v64i1(i1 %s, <64 x i1> %v, <64 x i1> %m, i32 %evl)
  ret i1 %r
}
