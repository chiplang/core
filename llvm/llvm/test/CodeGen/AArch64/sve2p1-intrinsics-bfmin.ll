; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve2p1 -mattr=+b16b16 -mattr=+use-experimental-zeroing-pseudos -verify-machineinstrs < %s \
; RUN: | FileCheck %s

define <vscale x 8 x bfloat> @bfmin_pred(<vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %b){
; CHECK-LABEL: bfmin_pred:
; CHECK:       // %bb.0:
; CHECK-NEXT:    bfmin z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x bfloat> @llvm.aarch64.sve.fmin.nxv8bf16(<vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %b)
  ret <vscale x 8 x bfloat> %res
}

define <vscale x 8 x bfloat> @bfmin(<vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %b){
; CHECK-LABEL: bfmin:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    bfmin z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT:    ret
  %elt = call <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 31)
  %res = call <vscale x 8 x bfloat> @llvm.aarch64.sve.fmin.nxv8bf16(<vscale x 8 x i1> %elt, <vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %b)
  ret <vscale x 8 x bfloat> %res
}

define <vscale x 8 x bfloat> @bfmin_zeroing(<vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %b) {
; CHECK-LABEL: bfmin_zeroing:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movprfx z0.h, p0/z, z0.h
; CHECK-NEXT:    bfmin z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT:    ret
  %a_z = select <vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> zeroinitializer
  %out = call <vscale x 8 x bfloat> @llvm.aarch64.sve.fmin.nxv8bf16(<vscale x 8 x i1> %pg,
                                                            <vscale x 8 x bfloat> %a_z,
                                                            <vscale x 8 x bfloat> %b)
  ret <vscale x 8 x bfloat> %out
}

define <vscale x 8 x bfloat> @bfmin_u_pred(<vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %b){
; CHECK-LABEL: bfmin_u_pred:
; CHECK:       // %bb.0:
; CHECK-NEXT:    bfmin z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x bfloat> @llvm.aarch64.sve.fmin.u.nxv8bf16(<vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %b)
  ret <vscale x 8 x bfloat> %res
}

define <vscale x 8 x bfloat> @bfmin_u(<vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %b){
; CHECK-LABEL: bfmin_u:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    bfmin z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT:    ret
  %elt = call <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 31)
  %res = call <vscale x 8 x bfloat> @llvm.aarch64.sve.fmin.u.nxv8bf16(<vscale x 8 x i1> %elt, <vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %b)
  ret <vscale x 8 x bfloat> %res
}

define <vscale x 8 x bfloat> @bfmin_u_zeroing(<vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> %b) {
; CHECK-LABEL: bfmin_u_zeroing:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z2.h, #0 // =0x0
; CHECK-NEXT:    sel z0.h, p0, z0.h, z2.h
; CHECK-NEXT:    bfmin z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT:    ret
  %a_z = select <vscale x 8 x i1> %pg, <vscale x 8 x bfloat> %a, <vscale x 8 x bfloat> zeroinitializer
  %out = call <vscale x 8 x bfloat> @llvm.aarch64.sve.fmin.u.nxv8bf16(<vscale x 8 x i1> %pg,
                                                            <vscale x 8 x bfloat> %a_z,
                                                            <vscale x 8 x bfloat> %b)
  ret <vscale x 8 x bfloat> %out
}

declare <vscale x 8 x bfloat> @llvm.aarch64.sve.fmin.nxv8bf16(<vscale x 8 x i1>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>)
declare <vscale x 8 x bfloat> @llvm.aarch64.sve.fmin.u.nxv8bf16(<vscale x 8 x i1>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>)
declare <vscale x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 immarg)
