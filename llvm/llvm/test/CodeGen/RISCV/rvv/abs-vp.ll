; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v,+m -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v,+m -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK

declare <vscale x 1 x i8> @llvm.vp.abs.nxv1i8(<vscale x 1 x i8>, i1 immarg, <vscale x 1 x i1>, i32)

define <vscale x 1 x i8> @vp_abs_nxv1i8(<vscale x 1 x i8> %va, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv1i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf8, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i8> @llvm.vp.abs.nxv1i8(<vscale x 1 x i8> %va, i1 false, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i8> %v
}

define <vscale x 1 x i8> @vp_abs_nxv1i8_unmasked(<vscale x 1 x i8> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv1i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf8, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 1 x i1> %head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %v = call <vscale x 1 x i8> @llvm.vp.abs.nxv1i8(<vscale x 1 x i8> %va, i1 false, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i8> %v
}

declare <vscale x 2 x i8> @llvm.vp.abs.nxv2i8(<vscale x 2 x i8>, i1 immarg, <vscale x 2 x i1>, i32)

define <vscale x 2 x i8> @vp_abs_nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i8> @llvm.vp.abs.nxv2i8(<vscale x 2 x i8> %va, i1 false, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i8> %v
}

define <vscale x 2 x i8> @vp_abs_nxv2i8_unmasked(<vscale x 2 x i8> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv2i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 2 x i1> %head, <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer
  %v = call <vscale x 2 x i8> @llvm.vp.abs.nxv2i8(<vscale x 2 x i8> %va, i1 false, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i8> %v
}

declare <vscale x 4 x i8> @llvm.vp.abs.nxv4i8(<vscale x 4 x i8>, i1 immarg, <vscale x 4 x i1>, i32)

define <vscale x 4 x i8> @vp_abs_nxv4i8(<vscale x 4 x i8> %va, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i8> @llvm.vp.abs.nxv4i8(<vscale x 4 x i8> %va, i1 false, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x i8> %v
}

define <vscale x 4 x i8> @vp_abs_nxv4i8_unmasked(<vscale x 4 x i8> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv4i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 4 x i1> %head, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %v = call <vscale x 4 x i8> @llvm.vp.abs.nxv4i8(<vscale x 4 x i8> %va, i1 false, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x i8> %v
}

declare <vscale x 8 x i8> @llvm.vp.abs.nxv8i8(<vscale x 8 x i8>, i1 immarg, <vscale x 8 x i1>, i32)

define <vscale x 8 x i8> @vp_abs_nxv8i8(<vscale x 8 x i8> %va, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i8> @llvm.vp.abs.nxv8i8(<vscale x 8 x i8> %va, i1 false, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i8> %v
}

define <vscale x 8 x i8> @vp_abs_nxv8i8_unmasked(<vscale x 8 x i8> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv8i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 8 x i1> %head, <vscale x 8 x i1> poison, <vscale x 8 x i32> zeroinitializer
  %v = call <vscale x 8 x i8> @llvm.vp.abs.nxv8i8(<vscale x 8 x i8> %va, i1 false, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i8> %v
}

declare <vscale x 16 x i8> @llvm.vp.abs.nxv16i8(<vscale x 16 x i8>, i1 immarg, <vscale x 16 x i1>, i32)

define <vscale x 16 x i8> @vp_abs_nxv16i8(<vscale x 16 x i8> %va, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m2, ta, ma
; CHECK-NEXT:    vrsub.vi v10, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v10, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i8> @llvm.vp.abs.nxv16i8(<vscale x 16 x i8> %va, i1 false, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x i8> %v
}

define <vscale x 16 x i8> @vp_abs_nxv16i8_unmasked(<vscale x 16 x i8> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv16i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m2, ta, ma
; CHECK-NEXT:    vrsub.vi v10, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v10
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 16 x i1> %head, <vscale x 16 x i1> poison, <vscale x 16 x i32> zeroinitializer
  %v = call <vscale x 16 x i8> @llvm.vp.abs.nxv16i8(<vscale x 16 x i8> %va, i1 false, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x i8> %v
}

declare <vscale x 32 x i8> @llvm.vp.abs.nxv32i8(<vscale x 32 x i8>, i1 immarg, <vscale x 32 x i1>, i32)

define <vscale x 32 x i8> @vp_abs_nxv32i8(<vscale x 32 x i8> %va, <vscale x 32 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m4, ta, ma
; CHECK-NEXT:    vrsub.vi v12, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v12, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x i8> @llvm.vp.abs.nxv32i8(<vscale x 32 x i8> %va, i1 false, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x i8> %v
}

define <vscale x 32 x i8> @vp_abs_nxv32i8_unmasked(<vscale x 32 x i8> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv32i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m4, ta, ma
; CHECK-NEXT:    vrsub.vi v12, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v12
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 32 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 32 x i1> %head, <vscale x 32 x i1> poison, <vscale x 32 x i32> zeroinitializer
  %v = call <vscale x 32 x i8> @llvm.vp.abs.nxv32i8(<vscale x 32 x i8> %va, i1 false, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x i8> %v
}

declare <vscale x 64 x i8> @llvm.vp.abs.nxv64i8(<vscale x 64 x i8>, i1 immarg, <vscale x 64 x i1>, i32)

define <vscale x 64 x i8> @vp_abs_nxv64i8(<vscale x 64 x i8> %va, <vscale x 64 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m8, ta, ma
; CHECK-NEXT:    vrsub.vi v16, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v16, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 64 x i8> @llvm.vp.abs.nxv64i8(<vscale x 64 x i8> %va, i1 false, <vscale x 64 x i1> %m, i32 %evl)
  ret <vscale x 64 x i8> %v
}

define <vscale x 64 x i8> @vp_abs_nxv64i8_unmasked(<vscale x 64 x i8> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv64i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m8, ta, ma
; CHECK-NEXT:    vrsub.vi v16, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v16
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 64 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 64 x i1> %head, <vscale x 64 x i1> poison, <vscale x 64 x i32> zeroinitializer
  %v = call <vscale x 64 x i8> @llvm.vp.abs.nxv64i8(<vscale x 64 x i8> %va, i1 false, <vscale x 64 x i1> %m, i32 %evl)
  ret <vscale x 64 x i8> %v
}

declare <vscale x 1 x i16> @llvm.vp.abs.nxv1i16(<vscale x 1 x i16>, i1 immarg, <vscale x 1 x i1>, i32)

define <vscale x 1 x i16> @vp_abs_nxv1i16(<vscale x 1 x i16> %va, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv1i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i16> @llvm.vp.abs.nxv1i16(<vscale x 1 x i16> %va, i1 false, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i16> %v
}

define <vscale x 1 x i16> @vp_abs_nxv1i16_unmasked(<vscale x 1 x i16> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv1i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 1 x i1> %head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %v = call <vscale x 1 x i16> @llvm.vp.abs.nxv1i16(<vscale x 1 x i16> %va, i1 false, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i16> %v
}

declare <vscale x 2 x i16> @llvm.vp.abs.nxv2i16(<vscale x 2 x i16>, i1 immarg, <vscale x 2 x i1>, i32)

define <vscale x 2 x i16> @vp_abs_nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i16> @llvm.vp.abs.nxv2i16(<vscale x 2 x i16> %va, i1 false, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i16> %v
}

define <vscale x 2 x i16> @vp_abs_nxv2i16_unmasked(<vscale x 2 x i16> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv2i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 2 x i1> %head, <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer
  %v = call <vscale x 2 x i16> @llvm.vp.abs.nxv2i16(<vscale x 2 x i16> %va, i1 false, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i16> %v
}

declare <vscale x 4 x i16> @llvm.vp.abs.nxv4i16(<vscale x 4 x i16>, i1 immarg, <vscale x 4 x i1>, i32)

define <vscale x 4 x i16> @vp_abs_nxv4i16(<vscale x 4 x i16> %va, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i16> @llvm.vp.abs.nxv4i16(<vscale x 4 x i16> %va, i1 false, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x i16> %v
}

define <vscale x 4 x i16> @vp_abs_nxv4i16_unmasked(<vscale x 4 x i16> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv4i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 4 x i1> %head, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %v = call <vscale x 4 x i16> @llvm.vp.abs.nxv4i16(<vscale x 4 x i16> %va, i1 false, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x i16> %v
}

declare <vscale x 8 x i16> @llvm.vp.abs.nxv8i16(<vscale x 8 x i16>, i1 immarg, <vscale x 8 x i1>, i32)

define <vscale x 8 x i16> @vp_abs_nxv8i16(<vscale x 8 x i16> %va, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; CHECK-NEXT:    vrsub.vi v10, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v10, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i16> @llvm.vp.abs.nxv8i16(<vscale x 8 x i16> %va, i1 false, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i16> %v
}

define <vscale x 8 x i16> @vp_abs_nxv8i16_unmasked(<vscale x 8 x i16> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv8i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; CHECK-NEXT:    vrsub.vi v10, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v10
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 8 x i1> %head, <vscale x 8 x i1> poison, <vscale x 8 x i32> zeroinitializer
  %v = call <vscale x 8 x i16> @llvm.vp.abs.nxv8i16(<vscale x 8 x i16> %va, i1 false, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i16> %v
}

declare <vscale x 16 x i16> @llvm.vp.abs.nxv16i16(<vscale x 16 x i16>, i1 immarg, <vscale x 16 x i1>, i32)

define <vscale x 16 x i16> @vp_abs_nxv16i16(<vscale x 16 x i16> %va, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; CHECK-NEXT:    vrsub.vi v12, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v12, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i16> @llvm.vp.abs.nxv16i16(<vscale x 16 x i16> %va, i1 false, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x i16> %v
}

define <vscale x 16 x i16> @vp_abs_nxv16i16_unmasked(<vscale x 16 x i16> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv16i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; CHECK-NEXT:    vrsub.vi v12, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v12
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 16 x i1> %head, <vscale x 16 x i1> poison, <vscale x 16 x i32> zeroinitializer
  %v = call <vscale x 16 x i16> @llvm.vp.abs.nxv16i16(<vscale x 16 x i16> %va, i1 false, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x i16> %v
}

declare <vscale x 32 x i16> @llvm.vp.abs.nxv32i16(<vscale x 32 x i16>, i1 immarg, <vscale x 32 x i1>, i32)

define <vscale x 32 x i16> @vp_abs_nxv32i16(<vscale x 32 x i16> %va, <vscale x 32 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv32i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; CHECK-NEXT:    vrsub.vi v16, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v16, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x i16> @llvm.vp.abs.nxv32i16(<vscale x 32 x i16> %va, i1 false, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x i16> %v
}

define <vscale x 32 x i16> @vp_abs_nxv32i16_unmasked(<vscale x 32 x i16> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv32i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; CHECK-NEXT:    vrsub.vi v16, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v16
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 32 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 32 x i1> %head, <vscale x 32 x i1> poison, <vscale x 32 x i32> zeroinitializer
  %v = call <vscale x 32 x i16> @llvm.vp.abs.nxv32i16(<vscale x 32 x i16> %va, i1 false, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x i16> %v
}

declare <vscale x 1 x i32> @llvm.vp.abs.nxv1i32(<vscale x 1 x i32>, i1 immarg, <vscale x 1 x i1>, i32)

define <vscale x 1 x i32> @vp_abs_nxv1i32(<vscale x 1 x i32> %va, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv1i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i32> @llvm.vp.abs.nxv1i32(<vscale x 1 x i32> %va, i1 false, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i32> %v
}

define <vscale x 1 x i32> @vp_abs_nxv1i32_unmasked(<vscale x 1 x i32> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv1i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 1 x i1> %head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %v = call <vscale x 1 x i32> @llvm.vp.abs.nxv1i32(<vscale x 1 x i32> %va, i1 false, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i32> %v
}

declare <vscale x 2 x i32> @llvm.vp.abs.nxv2i32(<vscale x 2 x i32>, i1 immarg, <vscale x 2 x i1>, i32)

define <vscale x 2 x i32> @vp_abs_nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i32> @llvm.vp.abs.nxv2i32(<vscale x 2 x i32> %va, i1 false, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i32> %v
}

define <vscale x 2 x i32> @vp_abs_nxv2i32_unmasked(<vscale x 2 x i32> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv2i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 2 x i1> %head, <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer
  %v = call <vscale x 2 x i32> @llvm.vp.abs.nxv2i32(<vscale x 2 x i32> %va, i1 false, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i32> %v
}

declare <vscale x 4 x i32> @llvm.vp.abs.nxv4i32(<vscale x 4 x i32>, i1 immarg, <vscale x 4 x i1>, i32)

define <vscale x 4 x i32> @vp_abs_nxv4i32(<vscale x 4 x i32> %va, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vrsub.vi v10, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v10, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i32> @llvm.vp.abs.nxv4i32(<vscale x 4 x i32> %va, i1 false, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x i32> %v
}

define <vscale x 4 x i32> @vp_abs_nxv4i32_unmasked(<vscale x 4 x i32> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv4i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vrsub.vi v10, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v10
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 4 x i1> %head, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %v = call <vscale x 4 x i32> @llvm.vp.abs.nxv4i32(<vscale x 4 x i32> %va, i1 false, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x i32> %v
}

declare <vscale x 8 x i32> @llvm.vp.abs.nxv8i32(<vscale x 8 x i32>, i1 immarg, <vscale x 8 x i1>, i32)

define <vscale x 8 x i32> @vp_abs_nxv8i32(<vscale x 8 x i32> %va, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vrsub.vi v12, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v12, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i32> @llvm.vp.abs.nxv8i32(<vscale x 8 x i32> %va, i1 false, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i32> %v
}

define <vscale x 8 x i32> @vp_abs_nxv8i32_unmasked(<vscale x 8 x i32> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv8i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vrsub.vi v12, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v12
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 8 x i1> %head, <vscale x 8 x i1> poison, <vscale x 8 x i32> zeroinitializer
  %v = call <vscale x 8 x i32> @llvm.vp.abs.nxv8i32(<vscale x 8 x i32> %va, i1 false, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i32> %v
}

declare <vscale x 16 x i32> @llvm.vp.abs.nxv16i32(<vscale x 16 x i32>, i1 immarg, <vscale x 16 x i1>, i32)

define <vscale x 16 x i32> @vp_abs_nxv16i32(<vscale x 16 x i32> %va, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vrsub.vi v16, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v16, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.vp.abs.nxv16i32(<vscale x 16 x i32> %va, i1 false, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @vp_abs_nxv16i32_unmasked(<vscale x 16 x i32> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv16i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vrsub.vi v16, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v16
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 16 x i1> %head, <vscale x 16 x i1> poison, <vscale x 16 x i32> zeroinitializer
  %v = call <vscale x 16 x i32> @llvm.vp.abs.nxv16i32(<vscale x 16 x i32> %va, i1 false, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x i32> %v
}

declare <vscale x 1 x i64> @llvm.vp.abs.nxv1i64(<vscale x 1 x i64>, i1 immarg, <vscale x 1 x i1>, i32)

define <vscale x 1 x i64> @vp_abs_nxv1i64(<vscale x 1 x i64> %va, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv1i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i64> @llvm.vp.abs.nxv1i64(<vscale x 1 x i64> %va, i1 false, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i64> %v
}

define <vscale x 1 x i64> @vp_abs_nxv1i64_unmasked(<vscale x 1 x i64> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv1i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vrsub.vi v9, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 1 x i1> %head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %v = call <vscale x 1 x i64> @llvm.vp.abs.nxv1i64(<vscale x 1 x i64> %va, i1 false, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i64> %v
}

declare <vscale x 2 x i64> @llvm.vp.abs.nxv2i64(<vscale x 2 x i64>, i1 immarg, <vscale x 2 x i1>, i32)

define <vscale x 2 x i64> @vp_abs_nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vrsub.vi v10, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v10, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i64> @llvm.vp.abs.nxv2i64(<vscale x 2 x i64> %va, i1 false, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i64> %v
}

define <vscale x 2 x i64> @vp_abs_nxv2i64_unmasked(<vscale x 2 x i64> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv2i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vrsub.vi v10, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v10
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 2 x i1> %head, <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer
  %v = call <vscale x 2 x i64> @llvm.vp.abs.nxv2i64(<vscale x 2 x i64> %va, i1 false, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i64> %v
}

declare <vscale x 4 x i64> @llvm.vp.abs.nxv4i64(<vscale x 4 x i64>, i1 immarg, <vscale x 4 x i1>, i32)

define <vscale x 4 x i64> @vp_abs_nxv4i64(<vscale x 4 x i64> %va, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vrsub.vi v12, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v12, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i64> @llvm.vp.abs.nxv4i64(<vscale x 4 x i64> %va, i1 false, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x i64> %v
}

define <vscale x 4 x i64> @vp_abs_nxv4i64_unmasked(<vscale x 4 x i64> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv4i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vrsub.vi v12, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v12
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 4 x i1> %head, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %v = call <vscale x 4 x i64> @llvm.vp.abs.nxv4i64(<vscale x 4 x i64> %va, i1 false, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x i64> %v
}

declare <vscale x 7 x i64> @llvm.vp.abs.nxv7i64(<vscale x 7 x i64>, i1 immarg, <vscale x 7 x i1>, i32)

define <vscale x 7 x i64> @vp_abs_nxv7i64(<vscale x 7 x i64> %va, <vscale x 7 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv7i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vrsub.vi v16, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v16, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 7 x i64> @llvm.vp.abs.nxv7i64(<vscale x 7 x i64> %va, i1 false, <vscale x 7 x i1> %m, i32 %evl)
  ret <vscale x 7 x i64> %v
}

define <vscale x 7 x i64> @vp_abs_nxv7i64_unmasked(<vscale x 7 x i64> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv7i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vrsub.vi v16, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v16
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 7 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 7 x i1> %head, <vscale x 7 x i1> poison, <vscale x 7 x i32> zeroinitializer
  %v = call <vscale x 7 x i64> @llvm.vp.abs.nxv7i64(<vscale x 7 x i64> %va, i1 false, <vscale x 7 x i1> %m, i32 %evl)
  ret <vscale x 7 x i64> %v
}

declare <vscale x 8 x i64> @llvm.vp.abs.nxv8i64(<vscale x 8 x i64>, i1 immarg, <vscale x 8 x i1>, i32)

define <vscale x 8 x i64> @vp_abs_nxv8i64(<vscale x 8 x i64> %va, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vrsub.vi v16, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v16, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i64> @llvm.vp.abs.nxv8i64(<vscale x 8 x i64> %va, i1 false, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i64> %v
}

define <vscale x 8 x i64> @vp_abs_nxv8i64_unmasked(<vscale x 8 x i64> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv8i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vrsub.vi v16, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v16
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 8 x i1> %head, <vscale x 8 x i1> poison, <vscale x 8 x i32> zeroinitializer
  %v = call <vscale x 8 x i64> @llvm.vp.abs.nxv8i64(<vscale x 8 x i64> %va, i1 false, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i64> %v
}

declare <vscale x 16 x i64> @llvm.vp.abs.nxv16i64(<vscale x 16 x i64>, i1 immarg, <vscale x 16 x i1>, i32)

define <vscale x 16 x i64> @vp_abs_nxv16i64(<vscale x 16 x i64> %va, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv16i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 4
; CHECK-NEXT:    sub sp, sp, a1
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 16 * vlenb
; CHECK-NEXT:    vmv1r.v v24, v0
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vs8r.v v8, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    srli a2, a1, 3
; CHECK-NEXT:    vsetvli a3, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v0, a2
; CHECK-NEXT:    sub a2, a0, a1
; CHECK-NEXT:    sltu a3, a0, a2
; CHECK-NEXT:    addi a3, a3, -1
; CHECK-NEXT:    and a2, a3, a2
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, ta, ma
; CHECK-NEXT:    vrsub.vi v8, v16, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v16, v8, v0.t
; CHECK-NEXT:    addi a2, sp, 16
; CHECK-NEXT:    vs8r.v v8, (a2) # Unknown-size Folded Spill
; CHECK-NEXT:    bltu a0, a1, .LBB46_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB46_2:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v8, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vrsub.vi v16, v8, 0, v0.t
; CHECK-NEXT:    vmax.vv v8, v8, v16, v0.t
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i64> @llvm.vp.abs.nxv16i64(<vscale x 16 x i64> %va, i1 false, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x i64> %v
}

define <vscale x 16 x i64> @vp_abs_nxv16i64_unmasked(<vscale x 16 x i64> %va, i32 zeroext %evl) {
; CHECK-LABEL: vp_abs_nxv16i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    sub a2, a0, a1
; CHECK-NEXT:    sltu a3, a0, a2
; CHECK-NEXT:    addi a3, a3, -1
; CHECK-NEXT:    and a2, a3, a2
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, ta, ma
; CHECK-NEXT:    vrsub.vi v24, v16, 0
; CHECK-NEXT:    vmax.vv v16, v16, v24
; CHECK-NEXT:    bltu a0, a1, .LBB47_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB47_2:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vrsub.vi v24, v8, 0
; CHECK-NEXT:    vmax.vv v8, v8, v24
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 16 x i1> %head, <vscale x 16 x i1> poison, <vscale x 16 x i32> zeroinitializer
  %v = call <vscale x 16 x i64> @llvm.vp.abs.nxv16i64(<vscale x 16 x i64> %va, i1 false, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x i64> %v
}
