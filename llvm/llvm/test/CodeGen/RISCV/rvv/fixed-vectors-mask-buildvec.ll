; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+v -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64
; Test with ELEN limited
; RUN: llc -mtriple=riscv32 -mattr=+f,+zve32f,+zvl128b -verify-machineinstrs < %s | FileCheck %s --check-prefixes=ZVE32F
; RUN: llc -mtriple=riscv64 -mattr=+f,+zve32f,+zvl128b -verify-machineinstrs < %s | FileCheck %s --check-prefixes=ZVE32F

define <1 x i1> @buildvec_mask_nonconst_v1i1(i1 %x) {
; CHECK-LABEL: buildvec_mask_nonconst_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_nonconst_v1i1:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    andi a0, a0, 1
; ZVE32F-NEXT:    vsetivli zero, 1, e8, mf4, ta, ma
; ZVE32F-NEXT:    vmv.s.x v8, a0
; ZVE32F-NEXT:    vmsne.vi v0, v8, 0
; ZVE32F-NEXT:    ret
  %1 = insertelement <1 x i1> poison, i1 %x, i32 0
  ret <1 x i1> %1
}

define <1 x i1> @buildvec_mask_optsize_nonconst_v1i1(i1 %x) optsize {
; CHECK-LABEL: buildvec_mask_optsize_nonconst_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.s.x v8, a0
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_optsize_nonconst_v1i1:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    andi a0, a0, 1
; ZVE32F-NEXT:    vsetivli zero, 1, e8, mf4, ta, ma
; ZVE32F-NEXT:    vmv.s.x v8, a0
; ZVE32F-NEXT:    vmsne.vi v0, v8, 0
; ZVE32F-NEXT:    ret
  %1 = insertelement <1 x i1> poison, i1 %x, i32 0
  ret <1 x i1> %1
}

define <2 x i1> @buildvec_mask_nonconst_v2i1(i1 %x, i1 %y) {
; CHECK-LABEL: buildvec_mask_nonconst_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    vslide1down.vx v8, v8, a1
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_nonconst_v2i1:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    vsetivli zero, 2, e8, mf4, ta, ma
; ZVE32F-NEXT:    vmv.v.x v8, a0
; ZVE32F-NEXT:    vslide1down.vx v8, v8, a1
; ZVE32F-NEXT:    vand.vi v8, v8, 1
; ZVE32F-NEXT:    vmsne.vi v0, v8, 0
; ZVE32F-NEXT:    ret
  %1 = insertelement <2 x i1> poison, i1 %x, i32 0
  %2 = insertelement <2 x i1> %1,  i1 %y, i32 1
  ret <2 x i1> %2
}

; FIXME: optsize isn't smaller than the code above
define <2 x i1> @buildvec_mask_optsize_nonconst_v2i1(i1 %x, i1 %y) optsize {
; CHECK-LABEL: buildvec_mask_optsize_nonconst_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    vslide1down.vx v8, v8, a1
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_optsize_nonconst_v2i1:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    vsetivli zero, 2, e8, mf4, ta, ma
; ZVE32F-NEXT:    vmv.v.x v8, a0
; ZVE32F-NEXT:    vslide1down.vx v8, v8, a1
; ZVE32F-NEXT:    vand.vi v8, v8, 1
; ZVE32F-NEXT:    vmsne.vi v0, v8, 0
; ZVE32F-NEXT:    ret
  %1 = insertelement <2 x i1> poison, i1 %x, i32 0
  %2 = insertelement <2 x i1> %1,  i1 %y, i32 1
  ret <2 x i1> %2
}

define <3 x i1> @buildvec_mask_v1i1() {
; CHECK-LABEL: buildvec_mask_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v0, 2
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_v1i1:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    vsetivli zero, 1, e8, mf4, ta, ma
; ZVE32F-NEXT:    vmv.v.i v0, 2
; ZVE32F-NEXT:    ret
  ret <3 x i1> <i1 0, i1 1, i1 0>
}

define <3 x i1> @buildvec_mask_optsize_v1i1() optsize {
; CHECK-LABEL: buildvec_mask_optsize_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v0, 2
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_optsize_v1i1:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    vsetivli zero, 1, e8, mf4, ta, ma
; ZVE32F-NEXT:    vmv.v.i v0, 2
; ZVE32F-NEXT:    ret
  ret <3 x i1> <i1 0, i1 1, i1 0>
}

define <4 x i1> @buildvec_mask_v4i1() {
; CHECK-LABEL: buildvec_mask_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v0, 6
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_v4i1:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    vsetivli zero, 1, e8, mf4, ta, ma
; ZVE32F-NEXT:    vmv.v.i v0, 6
; ZVE32F-NEXT:    ret
  ret <4 x i1> <i1 0, i1 1, i1 1, i1 0>
}

define <4 x i1> @buildvec_mask_nonconst_v4i1(i1 %x, i1 %y) {
; CHECK-LABEL: buildvec_mask_nonconst_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vmv.v.i v0, 3
; CHECK-NEXT:    vmv.v.x v8, a1
; CHECK-NEXT:    vmerge.vxm v8, v8, a0, v0
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_nonconst_v4i1:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; ZVE32F-NEXT:    vmv.v.i v0, 3
; ZVE32F-NEXT:    vmv.v.x v8, a1
; ZVE32F-NEXT:    vmerge.vxm v8, v8, a0, v0
; ZVE32F-NEXT:    vand.vi v8, v8, 1
; ZVE32F-NEXT:    vmsne.vi v0, v8, 0
; ZVE32F-NEXT:    ret
  %1 = insertelement <4 x i1> poison, i1 %x, i32 0
  %2 = insertelement <4 x i1> %1,  i1 %x, i32 1
  %3 = insertelement <4 x i1> %2,  i1 %y, i32 2
  %4 = insertelement <4 x i1> %3,  i1 %y, i32 3
  ret <4 x i1> %4
}

; FIXME: optsize isn't smaller than the code above
define <4 x i1> @buildvec_mask_optsize_nonconst_v4i1(i1 %x, i1 %y) optsize {
; CHECK-LABEL: buildvec_mask_optsize_nonconst_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    vslide1down.vx v8, v8, a1
; CHECK-NEXT:    vslide1down.vx v8, v8, a1
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_optsize_nonconst_v4i1:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; ZVE32F-NEXT:    vmv.v.x v8, a0
; ZVE32F-NEXT:    vslide1down.vx v8, v8, a0
; ZVE32F-NEXT:    vslide1down.vx v8, v8, a1
; ZVE32F-NEXT:    vslide1down.vx v8, v8, a1
; ZVE32F-NEXT:    vand.vi v8, v8, 1
; ZVE32F-NEXT:    vmsne.vi v0, v8, 0
; ZVE32F-NEXT:    ret
  %1 = insertelement <4 x i1> poison, i1 %x, i32 0
  %2 = insertelement <4 x i1> %1,  i1 %x, i32 1
  %3 = insertelement <4 x i1> %2,  i1 %y, i32 2
  %4 = insertelement <4 x i1> %3,  i1 %y, i32 3
  ret <4 x i1> %4
}

define <4 x i1> @buildvec_mask_nonconst_v4i1_2(i1 %x, i1 %y) {
; CHECK-LABEL: buildvec_mask_nonconst_v4i1_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    li a0, 1
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    vslide1down.vx v8, v8, a1
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_nonconst_v4i1_2:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; ZVE32F-NEXT:    vmv.v.i v8, 0
; ZVE32F-NEXT:    vslide1down.vx v8, v8, a0
; ZVE32F-NEXT:    li a0, 1
; ZVE32F-NEXT:    vslide1down.vx v8, v8, a0
; ZVE32F-NEXT:    vslide1down.vx v8, v8, a1
; ZVE32F-NEXT:    vand.vi v8, v8, 1
; ZVE32F-NEXT:    vmsne.vi v0, v8, 0
; ZVE32F-NEXT:    ret
  %1 = insertelement <4 x i1> poison, i1 0, i32 0
  %2 = insertelement <4 x i1> %1,  i1 %x, i32 1
  %3 = insertelement <4 x i1> %2,  i1  1, i32 2
  %4 = insertelement <4 x i1> %3,  i1 %y, i32 3
  ret <4 x i1> %4
}

define <8 x i1> @buildvec_mask_v8i1() {
; CHECK-LABEL: buildvec_mask_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 182
; CHECK-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_v8i1:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    li a0, 182
; ZVE32F-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; ZVE32F-NEXT:    vmv.s.x v0, a0
; ZVE32F-NEXT:    ret
  ret <8 x i1> <i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1>
}

define <8 x i1> @buildvec_mask_nonconst_v8i1(i1 %x, i1 %y) {
; CHECK-LABEL: buildvec_mask_nonconst_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    li a2, 19
; CHECK-NEXT:    vmv.s.x v0, a2
; CHECK-NEXT:    vmv.v.x v8, a1
; CHECK-NEXT:    vmerge.vxm v8, v8, a0, v0
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_nonconst_v8i1:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; ZVE32F-NEXT:    li a2, 19
; ZVE32F-NEXT:    vmv.s.x v0, a2
; ZVE32F-NEXT:    vmv.v.x v8, a1
; ZVE32F-NEXT:    vmerge.vxm v8, v8, a0, v0
; ZVE32F-NEXT:    vand.vi v8, v8, 1
; ZVE32F-NEXT:    vmsne.vi v0, v8, 0
; ZVE32F-NEXT:    ret
  %1 = insertelement <8 x i1> poison, i1 %x, i32 0
  %2 = insertelement <8 x i1> %1,  i1 %x, i32 1
  %3 = insertelement <8 x i1> %2,  i1 %y, i32 2
  %4 = insertelement <8 x i1> %3,  i1 %y, i32 3
  %5 = insertelement <8 x i1> %4,  i1 %x, i32 4
  %6 = insertelement <8 x i1> %5,  i1 %y, i32 5
  %7 = insertelement <8 x i1> %6,  i1 %y, i32 6
  %8 = insertelement <8 x i1> %7,  i1 %y, i32 7
  ret <8 x i1> %8
}

define <8 x i1> @buildvec_mask_nonconst_v8i1_2(i1 %x, i1 %y, i1 %z, i1 %w) {
; CHECK-LABEL: buildvec_mask_nonconst_v8i1_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    vslide1down.vx v9, v8, a0
; CHECK-NEXT:    li a0, 1
; CHECK-NEXT:    vslide1down.vx v9, v9, a0
; CHECK-NEXT:    vslide1down.vx v9, v9, a1
; CHECK-NEXT:    vslide1down.vx v8, v8, a3
; CHECK-NEXT:    vslide1down.vx v8, v8, zero
; CHECK-NEXT:    vmv.v.i v0, 15
; CHECK-NEXT:    vslide1down.vx v8, v8, a2
; CHECK-NEXT:    vslidedown.vi v8, v9, 4, v0.t
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_nonconst_v8i1_2:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; ZVE32F-NEXT:    vmv.v.x v8, a0
; ZVE32F-NEXT:    vslide1down.vx v9, v8, a0
; ZVE32F-NEXT:    li a0, 1
; ZVE32F-NEXT:    vslide1down.vx v9, v9, a0
; ZVE32F-NEXT:    vslide1down.vx v9, v9, a1
; ZVE32F-NEXT:    vslide1down.vx v8, v8, a3
; ZVE32F-NEXT:    vslide1down.vx v8, v8, zero
; ZVE32F-NEXT:    vmv.v.i v0, 15
; ZVE32F-NEXT:    vslide1down.vx v8, v8, a2
; ZVE32F-NEXT:    vslidedown.vi v8, v9, 4, v0.t
; ZVE32F-NEXT:    vand.vi v8, v8, 1
; ZVE32F-NEXT:    vmsne.vi v0, v8, 0
; ZVE32F-NEXT:    ret
  %1 = insertelement <8 x i1> poison, i1 %x, i32 0
  %2 = insertelement <8 x i1> %1,  i1 %x, i32 1
  %3 = insertelement <8 x i1> %2,  i1  1, i32 2
  %4 = insertelement <8 x i1> %3,  i1 %y, i32 3
  %5 = insertelement <8 x i1> %4,  i1 %x, i32 4
  %6 = insertelement <8 x i1> %5,  i1 %w, i32 5
  %7 = insertelement <8 x i1> %6,  i1  0, i32 6
  %8 = insertelement <8 x i1> %7,  i1 %z, i32 7
  ret <8 x i1> %8
}

define <8 x i1> @buildvec_mask_optsize_nonconst_v8i1_2(i1 %x, i1 %y, i1 %z, i1 %w) optsize {
; CHECK-LABEL: buildvec_mask_optsize_nonconst_v8i1_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    vslide1down.vx v9, v8, a0
; CHECK-NEXT:    li a0, 1
; CHECK-NEXT:    vslide1down.vx v9, v9, a0
; CHECK-NEXT:    vslide1down.vx v9, v9, a1
; CHECK-NEXT:    vslide1down.vx v8, v8, a3
; CHECK-NEXT:    vslide1down.vx v8, v8, zero
; CHECK-NEXT:    vmv.v.i v0, 15
; CHECK-NEXT:    vslide1down.vx v8, v8, a2
; CHECK-NEXT:    vslidedown.vi v8, v9, 4, v0.t
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_optsize_nonconst_v8i1_2:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; ZVE32F-NEXT:    vmv.v.x v8, a0
; ZVE32F-NEXT:    vslide1down.vx v9, v8, a0
; ZVE32F-NEXT:    li a0, 1
; ZVE32F-NEXT:    vslide1down.vx v9, v9, a0
; ZVE32F-NEXT:    vslide1down.vx v9, v9, a1
; ZVE32F-NEXT:    vslide1down.vx v8, v8, a3
; ZVE32F-NEXT:    vslide1down.vx v8, v8, zero
; ZVE32F-NEXT:    vmv.v.i v0, 15
; ZVE32F-NEXT:    vslide1down.vx v8, v8, a2
; ZVE32F-NEXT:    vslidedown.vi v8, v9, 4, v0.t
; ZVE32F-NEXT:    vand.vi v8, v8, 1
; ZVE32F-NEXT:    vmsne.vi v0, v8, 0
; ZVE32F-NEXT:    ret
  %1 = insertelement <8 x i1> poison, i1 %x, i32 0
  %2 = insertelement <8 x i1> %1,  i1 %x, i32 1
  %3 = insertelement <8 x i1> %2,  i1  1, i32 2
  %4 = insertelement <8 x i1> %3,  i1 %y, i32 3
  %5 = insertelement <8 x i1> %4,  i1 %x, i32 4
  %6 = insertelement <8 x i1> %5,  i1 %w, i32 5
  %7 = insertelement <8 x i1> %6,  i1  0, i32 6
  %8 = insertelement <8 x i1> %7,  i1 %z, i32 7
  ret <8 x i1> %8
}

define <8 x i1> @buildvec_mask_optsize_nonconst_v8i1(i1 %x, i1 %y) optsize {
; CHECK-LABEL: buildvec_mask_optsize_nonconst_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    vslide1down.vx v9, v8, a0
; CHECK-NEXT:    vslide1down.vx v9, v9, a1
; CHECK-NEXT:    vslide1down.vx v9, v9, a1
; CHECK-NEXT:    vslide1down.vx v8, v8, a1
; CHECK-NEXT:    vslide1down.vx v8, v8, a1
; CHECK-NEXT:    vmv.v.i v0, 15
; CHECK-NEXT:    vslide1down.vx v8, v8, a1
; CHECK-NEXT:    vslidedown.vi v8, v9, 4, v0.t
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_optsize_nonconst_v8i1:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; ZVE32F-NEXT:    vmv.v.x v8, a0
; ZVE32F-NEXT:    vslide1down.vx v9, v8, a0
; ZVE32F-NEXT:    vslide1down.vx v9, v9, a1
; ZVE32F-NEXT:    vslide1down.vx v9, v9, a1
; ZVE32F-NEXT:    vslide1down.vx v8, v8, a1
; ZVE32F-NEXT:    vslide1down.vx v8, v8, a1
; ZVE32F-NEXT:    vmv.v.i v0, 15
; ZVE32F-NEXT:    vslide1down.vx v8, v8, a1
; ZVE32F-NEXT:    vslidedown.vi v8, v9, 4, v0.t
; ZVE32F-NEXT:    vand.vi v8, v8, 1
; ZVE32F-NEXT:    vmsne.vi v0, v8, 0
; ZVE32F-NEXT:    ret
  %1 = insertelement <8 x i1> poison, i1 %x, i32 0
  %2 = insertelement <8 x i1> %1,  i1 %x, i32 1
  %3 = insertelement <8 x i1> %2,  i1 %y, i32 2
  %4 = insertelement <8 x i1> %3,  i1 %y, i32 3
  %5 = insertelement <8 x i1> %4,  i1 %x, i32 4
  %6 = insertelement <8 x i1> %5,  i1 %y, i32 5
  %7 = insertelement <8 x i1> %6,  i1 %y, i32 6
  %8 = insertelement <8 x i1> %7,  i1 %y, i32 7
  ret <8 x i1> %8
}

define <10 x i1> @buildvec_mask_v10i1() {
; CHECK-LABEL: buildvec_mask_v10i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 949
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_v10i1:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    li a0, 949
; ZVE32F-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; ZVE32F-NEXT:    vmv.s.x v0, a0
; ZVE32F-NEXT:    ret
  ret <10 x i1> <i1 1, i1 0, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 1>
}

define <16 x i1> @buildvec_mask_v16i1() {
; CHECK-LABEL: buildvec_mask_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 11
; CHECK-NEXT:    addi a0, a0, 1718
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_v16i1:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    lui a0, 11
; ZVE32F-NEXT:    addi a0, a0, 1718
; ZVE32F-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; ZVE32F-NEXT:    vmv.s.x v0, a0
; ZVE32F-NEXT:    ret
  ret <16 x i1> <i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1>
}

define <16 x i1> @buildvec_mask_v16i1_undefs() {
; CHECK-LABEL: buildvec_mask_v16i1_undefs:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 1722
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_v16i1_undefs:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    li a0, 1722
; ZVE32F-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; ZVE32F-NEXT:    vmv.s.x v0, a0
; ZVE32F-NEXT:    ret
  ret <16 x i1> <i1 undef, i1 1, i1 undef, i1 1, i1 1, i1 1, i1 0, i1 1, i1 0, i1 1, i1 1, i1 undef, i1 undef, i1 undef, i1 undef, i1 undef>
}

define <32 x i1> @buildvec_mask_v32i1() {
; CHECK-LABEL: buildvec_mask_v32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 748384
; CHECK-NEXT:    addi a0, a0, 1776
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_v32i1:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    lui a0, 748384
; ZVE32F-NEXT:    addi a0, a0, 1776
; ZVE32F-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; ZVE32F-NEXT:    vmv.s.x v0, a0
; ZVE32F-NEXT:    ret
  ret <32 x i1> <i1 0, i1 0, i1 0, i1 0, i1 1, i1 1, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 0, i1 0, i1 0, i1 0, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1>
}

define <64 x i1> @buildvec_mask_v64i1() {
; RV32-LABEL: buildvec_mask_v64i1:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, 748388
; RV32-NEXT:    addi a0, a0, -1793
; RV32-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; RV32-NEXT:    vmv.v.x v0, a0
; RV32-NEXT:    lui a0, 748384
; RV32-NEXT:    addi a0, a0, 1776
; RV32-NEXT:    vsetvli zero, zero, e32, mf2, tu, ma
; RV32-NEXT:    vmv.s.x v0, a0
; RV32-NEXT:    ret
;
; RV64-LABEL: buildvec_mask_v64i1:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a0, %hi(.LCPI19_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI19_0)
; RV64-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; RV64-NEXT:    vle64.v v0, (a0)
; RV64-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_v64i1:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    lui a0, 748388
; ZVE32F-NEXT:    addi a0, a0, -1793
; ZVE32F-NEXT:    vsetivli zero, 2, e32, m1, ta, ma
; ZVE32F-NEXT:    vmv.v.x v0, a0
; ZVE32F-NEXT:    lui a0, 748384
; ZVE32F-NEXT:    addi a0, a0, 1776
; ZVE32F-NEXT:    vsetvli zero, zero, e32, m1, tu, ma
; ZVE32F-NEXT:    vmv.s.x v0, a0
; ZVE32F-NEXT:    ret
  ret <64 x i1> <i1 0, i1 0, i1 0, i1 0, i1 1, i1 1, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 0, i1 0, i1 0, i1 0, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 0, i1 0, i1 0, i1 1, i1 1, i1 1, i1 0, i1 0, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1>
}

define <128 x i1> @buildvec_mask_v128i1() {
; RV32-LABEL: buildvec_mask_v128i1:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, %hi(.LCPI20_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI20_0)
; RV32-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; RV32-NEXT:    vle32.v v0, (a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: buildvec_mask_v128i1:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a0, %hi(.LCPI20_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI20_0)
; RV64-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV64-NEXT:    vlse64.v v0, (a0), zero
; RV64-NEXT:    lui a0, %hi(.LCPI20_1)
; RV64-NEXT:    ld a0, %lo(.LCPI20_1)(a0)
; RV64-NEXT:    vsetvli zero, zero, e64, m1, tu, ma
; RV64-NEXT:    vmv.s.x v0, a0
; RV64-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_v128i1:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    lui a0, %hi(.LCPI20_0)
; ZVE32F-NEXT:    addi a0, a0, %lo(.LCPI20_0)
; ZVE32F-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; ZVE32F-NEXT:    vle32.v v0, (a0)
; ZVE32F-NEXT:    ret
  ret <128 x i1> <i1 0, i1 0, i1 0, i1 0, i1 1, i1 1, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 0, i1 0, i1 0, i1 0, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 0, i1 0, i1 0, i1 1, i1 1, i1 1, i1 0, i1 0, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 0, i1 0, i1 0, i1 0, i1 1, i1 1, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 0, i1 0, i1 0, i1 0, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 0, i1 1, i1 1, i1 0, i1 0, i1 0, i1 0, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 0, i1 0, i1 0, i1 1, i1 1, i1 1, i1 0, i1 0, i1 0, i1 1, i1 0, i1 1, i1 1, i1 1, i1 0, i1 1, i1 0, i1 1, i1 1, i1 0, i1 0, i1 1, i1 1, i1 1>
}

define <128 x i1> @buildvec_mask_optsize_v128i1() optsize {
; CHECK-LABEL: buildvec_mask_optsize_v128i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI21_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI21_0)
; CHECK-NEXT:    li a1, 128
; CHECK-NEXT:    vsetvli zero, a1, e8, m8, ta, ma
; CHECK-NEXT:    vlm.v v0, (a0)
; CHECK-NEXT:    ret
;
; ZVE32F-LABEL: buildvec_mask_optsize_v128i1:
; ZVE32F:       # %bb.0:
; ZVE32F-NEXT:    lui a0, %hi(.LCPI21_0)
; ZVE32F-NEXT:    addi a0, a0, %lo(.LCPI21_0)
; ZVE32F-NEXT:    li a1, 128
; ZVE32F-NEXT:    vsetvli zero, a1, e8, m8, ta, ma
; ZVE32F-NEXT:    vlm.v v0, (a0)
; ZVE32F-NEXT:    ret
  ret <128 x i1> <i1 0, i1 0, i1 0, i1 0, i1 1, i1 1, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 0, i1 0, i1 0, i1 0, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 0, i1 0, i1 0, i1 1, i1 1, i1 1, i1 0, i1 0, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 0, i1 0, i1 0, i1 0, i1 1, i1 1, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 0, i1 0, i1 0, i1 0, i1 0, i1 1, i1 1, i1 0, i1 1, i1 1, i1 0, i1 1, i1 0, i1 1, i1 1, i1 0, i1 0, i1 0, i1 0, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 1, i1 0, i1 0, i1 0, i1 1, i1 1, i1 1, i1 0, i1 0, i1 0, i1 1, i1 0, i1 1, i1 1, i1 1, i1 0, i1 1, i1 0, i1 1, i1 1, i1 0, i1 0, i1 1, i1 1, i1 1>
}
