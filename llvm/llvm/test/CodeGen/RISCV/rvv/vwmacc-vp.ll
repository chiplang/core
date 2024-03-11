; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -target-abi=ilp32 \
; RUN:     -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+v -target-abi=lp64 \
; RUN:     -verify-machineinstrs < %s | FileCheck %s

declare <vscale x 1 x i32> @llvm.vp.sext.nxv1i32.nxv1i16(<vscale x 1 x i16>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i32> @llvm.vp.mul.nxv1i32(<vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i32> @llvm.vp.add.nxv1i32(<vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i1>, i32)
declare <vscale x 1 x i32> @llvm.vp.merge.nxv1i32(<vscale x 1 x i1>, <vscale x 1 x i32>, <vscale x 1 x i32>, i32)

define <vscale x 1 x i32> @vwmacc_vv_nxv1i32_unmasked_tu(<vscale x 1 x i16> %a,
; CHECK-LABEL: vwmacc_vv_nxv1i32_unmasked_tu:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, tu, ma
; CHECK-NEXT:    vwmacc.vv v10, v8, v9
; CHECK-NEXT:    vmv1r.v v8, v10
; CHECK-NEXT:    ret
  <vscale x 1 x i16> %b, <vscale x 1 x i32> %c, i32 zeroext %evl) {
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i32 0
  %allones = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %aext = call <vscale x 1 x i32> @llvm.vp.sext.nxv1i32.nxv1i16(<vscale x 1 x i16> %a, <vscale x 1 x i1> %allones, i32 %evl)
  %bext = call <vscale x 1 x i32> @llvm.vp.sext.nxv1i32.nxv1i16(<vscale x 1 x i16> %b, <vscale x 1 x i1> %allones, i32 %evl)
  %abmul = call <vscale x 1 x i32> @llvm.vp.mul.nxv1i32(<vscale x 1 x i32> %aext, <vscale x 1 x i32> %bext, <vscale x 1 x i1> %allones, i32 %evl)
  %cadd = call <vscale x 1 x i32> @llvm.vp.add.nxv1i32(<vscale x 1 x i32> %abmul, <vscale x 1 x i32> %c, <vscale x 1 x i1>%allones, i32 %evl)
  %ret = call <vscale x 1 x i32> @llvm.vp.merge.nxv1i32(<vscale x 1 x i1> %allones, <vscale x 1 x i32> %cadd, <vscale x 1 x i32> %c, i32 %evl)
  ret <vscale x 1 x i32> %ret
}
