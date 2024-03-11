; RUN: not llc --mtriple=loongarch64 --mattr=+lasx < %s 2>&1 | FileCheck %s

declare <32 x i8> @llvm.loongarch.lasx.xvmaxi.b(<32 x i8>, i32)

define <32 x i8> @lasx_xvmaxi_b(<32 x i8> %va, i32 %b) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <32 x i8> @llvm.loongarch.lasx.xvmaxi.b(<32 x i8> %va, i32 %b)
  ret <32 x i8> %res
}

declare <16 x i16> @llvm.loongarch.lasx.xvmaxi.h(<16 x i16>, i32)

define <16 x i16> @lasx_xvmaxi_h(<16 x i16> %va, i32 %b) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <16 x i16> @llvm.loongarch.lasx.xvmaxi.h(<16 x i16> %va, i32 %b)
  ret <16 x i16> %res
}

declare <8 x i32> @llvm.loongarch.lasx.xvmaxi.w(<8 x i32>, i32)

define <8 x i32> @lasx_xvmaxi_w(<8 x i32> %va, i32 %b) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <8 x i32> @llvm.loongarch.lasx.xvmaxi.w(<8 x i32> %va, i32 %b)
  ret <8 x i32> %res
}

declare <4 x i64> @llvm.loongarch.lasx.xvmaxi.d(<4 x i64>, i32)

define <4 x i64> @lasx_xvmaxi_d(<4 x i64> %va, i32 %b) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <4 x i64> @llvm.loongarch.lasx.xvmaxi.d(<4 x i64> %va, i32 %b)
  ret <4 x i64> %res
}

declare <32 x i8> @llvm.loongarch.lasx.xvmaxi.bu(<32 x i8>, i32)

define <32 x i8> @lasx_xvmaxi_bu(<32 x i8> %va, i32 %b) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <32 x i8> @llvm.loongarch.lasx.xvmaxi.bu(<32 x i8> %va, i32 %b)
  ret <32 x i8> %res
}

declare <16 x i16> @llvm.loongarch.lasx.xvmaxi.hu(<16 x i16>, i32)

define <16 x i16> @lasx_xvmaxi_hu(<16 x i16> %va, i32 %b) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <16 x i16> @llvm.loongarch.lasx.xvmaxi.hu(<16 x i16> %va, i32 %b)
  ret <16 x i16> %res
}

declare <8 x i32> @llvm.loongarch.lasx.xvmaxi.wu(<8 x i32>, i32)

define <8 x i32> @lasx_xvmaxi_wu(<8 x i32> %va, i32 %b) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <8 x i32> @llvm.loongarch.lasx.xvmaxi.wu(<8 x i32> %va, i32 %b)
  ret <8 x i32> %res
}

declare <4 x i64> @llvm.loongarch.lasx.xvmaxi.du(<4 x i64>, i32)

define <4 x i64> @lasx_xvmaxi_du(<4 x i64> %va, i32 %b) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <4 x i64> @llvm.loongarch.lasx.xvmaxi.du(<4 x i64> %va, i32 %b)
  ret <4 x i64> %res
}
