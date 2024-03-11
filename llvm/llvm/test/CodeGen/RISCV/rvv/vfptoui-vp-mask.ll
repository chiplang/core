; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+v,+zfh,+zvfh < %s | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv64 -mattr=+m,+v,+zfh,+zvfh < %s | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv32 -mattr=+m,+v,+zfh,+zvfhmin < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN
; RUN: llc -mtriple=riscv64 -mattr=+m,+v,+zfh,+zvfhmin < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN

declare <vscale x 2 x i1> @llvm.vp.fptoui.nxv2i1.nxv2f16(<vscale x 2 x half>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i1> @vfptoui_nxv2i1_nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfptoui_nxv2i1_nxv2f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfcvt.rtz.xu.f.v v8, v8, v0.t
; ZVFH-NEXT:    vmsne.vi v0, v8, 0, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfptoui_nxv2i1_nxv2f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfcvt.rtz.xu.f.v v8, v9, v0.t
; ZVFHMIN-NEXT:    vmsne.vi v0, v8, 0, v0.t
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 2 x i1> @llvm.vp.fptoui.nxv2i1.nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i1> %v
}

define <vscale x 2 x i1> @vfptoui_nxv2i1_nxv2f16_unmasked(<vscale x 2 x half> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vfptoui_nxv2i1_nxv2f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfcvt.rtz.xu.f.v v8, v8
; ZVFH-NEXT:    vmsne.vi v0, v8, 0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfptoui_nxv2i1_nxv2f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfcvt.rtz.xu.f.v v8, v9
; ZVFHMIN-NEXT:    vmsne.vi v0, v8, 0
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 2 x i1> @llvm.vp.fptoui.nxv2i1.nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x i1> %v
}

declare <vscale x 2 x i1> @llvm.vp.fptoui.nxv2i1.nxv2f32(<vscale x 2 x float>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i1> @vfptoui_nxv2i1_nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfptoui_nxv2i1_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfcvt.rtz.xu.f.v v8, v8, v0.t
; CHECK-NEXT:    vmsne.vi v0, v8, 0, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i1> @llvm.vp.fptoui.nxv2i1.nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i1> %v
}

define <vscale x 2 x i1> @vfptoui_nxv2i1_nxv2f32_unmasked(<vscale x 2 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfptoui_nxv2i1_nxv2f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfcvt.rtz.xu.f.v v8, v8
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i1> @llvm.vp.fptoui.nxv2i1.nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x i1> %v
}

declare <vscale x 2 x i1> @llvm.vp.fptoui.nxv2i1.nxv2f64(<vscale x 2 x double>, <vscale x 2 x i1>, i32)

define <vscale x 2 x i1> @vfptoui_nxv2i1_nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfptoui_nxv2i1_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfcvt.rtz.xu.f.v v10, v8, v0.t
; CHECK-NEXT:    vmsne.vi v8, v10, 0, v0.t
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i1> @llvm.vp.fptoui.nxv2i1.nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i1> %v
}

define <vscale x 2 x i1> @vfptoui_nxv2i1_nxv2f64_unmasked(<vscale x 2 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfptoui_nxv2i1_nxv2f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfcvt.rtz.xu.f.v v8, v8
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i1> @llvm.vp.fptoui.nxv2i1.nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x i1> %v
}
