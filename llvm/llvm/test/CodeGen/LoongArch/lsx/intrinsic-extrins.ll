; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lsx < %s | FileCheck %s

declare <16 x i8> @llvm.loongarch.lsx.vextrins.b(<16 x i8>, <16 x i8>, i32)

define <16 x i8> @lsx_vextrins_b(<16 x i8> %va, <16 x i8> %vb) nounwind {
; CHECK-LABEL: lsx_vextrins_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vextrins.b $vr0, $vr1, 255
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i8> @llvm.loongarch.lsx.vextrins.b(<16 x i8> %va, <16 x i8> %vb, i32 255)
  ret <16 x i8> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vextrins.h(<8 x i16>, <8 x i16>, i32)

define <8 x i16> @lsx_vextrins_h(<8 x i16> %va, <8 x i16> %vb) nounwind {
; CHECK-LABEL: lsx_vextrins_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vextrins.h $vr0, $vr1, 255
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vextrins.h(<8 x i16> %va, <8 x i16> %vb, i32 255)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vextrins.w(<4 x i32>, <4 x i32>, i32)

define <4 x i32> @lsx_vextrins_w(<4 x i32> %va, <4 x i32> %vb) nounwind {
; CHECK-LABEL: lsx_vextrins_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vextrins.w $vr0, $vr1, 255
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vextrins.w(<4 x i32> %va, <4 x i32> %vb, i32 255)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vextrins.d(<2 x i64>, <2 x i64>, i32)

define <2 x i64> @lsx_vextrins_d(<2 x i64> %va, <2 x i64> %vb) nounwind {
; CHECK-LABEL: lsx_vextrins_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vextrins.d $vr0, $vr1, 255
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vextrins.d(<2 x i64> %va, <2 x i64> %vb, i32 255)
  ret <2 x i64> %res
}
