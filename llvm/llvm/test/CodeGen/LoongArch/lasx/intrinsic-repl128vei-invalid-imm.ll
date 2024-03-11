; RUN: not llc --mtriple=loongarch64 --mattr=+lasx < %s 2>&1 | FileCheck %s

declare <32 x i8> @llvm.loongarch.lasx.xvrepl128vei.b(<32 x i8>, i32)

define <32 x i8> @lasx_xvrepl128vei_b_lo(<32 x i8> %va) nounwind {
; CHECK: llvm.loongarch.lasx.xvrepl128vei.b: argument out of range
entry:
  %res = call <32 x i8> @llvm.loongarch.lasx.xvrepl128vei.b(<32 x i8> %va, i32 -1)
  ret <32 x i8> %res
}

define <32 x i8> @lasx_xvrepl128vei_b_hi(<32 x i8> %va) nounwind {
; CHECK: llvm.loongarch.lasx.xvrepl128vei.b: argument out of range
entry:
  %res = call <32 x i8> @llvm.loongarch.lasx.xvrepl128vei.b(<32 x i8> %va, i32 16)
  ret <32 x i8> %res
}

declare <16 x i16> @llvm.loongarch.lasx.xvrepl128vei.h(<16 x i16>, i32)

define <16 x i16> @lasx_xvrepl128vei_h_lo(<16 x i16> %va) nounwind {
; CHECK: llvm.loongarch.lasx.xvrepl128vei.h: argument out of range
entry:
  %res = call <16 x i16> @llvm.loongarch.lasx.xvrepl128vei.h(<16 x i16> %va, i32 -1)
  ret <16 x i16> %res
}

define <16 x i16> @lasx_xvrepl128vei_h_hi(<16 x i16> %va) nounwind {
; CHECK: llvm.loongarch.lasx.xvrepl128vei.h: argument out of range
entry:
  %res = call <16 x i16> @llvm.loongarch.lasx.xvrepl128vei.h(<16 x i16> %va, i32 8)
  ret <16 x i16> %res
}

declare <8 x i32> @llvm.loongarch.lasx.xvrepl128vei.w(<8 x i32>, i32)

define <8 x i32> @lasx_xvrepl128vei_w_lo(<8 x i32> %va) nounwind {
; CHECK: llvm.loongarch.lasx.xvrepl128vei.w: argument out of range
entry:
  %res = call <8 x i32> @llvm.loongarch.lasx.xvrepl128vei.w(<8 x i32> %va, i32 -1)
  ret <8 x i32> %res
}

define <8 x i32> @lasx_xvrepl128vei_w_hi(<8 x i32> %va) nounwind {
; CHECK: llvm.loongarch.lasx.xvrepl128vei.w: argument out of range
entry:
  %res = call <8 x i32> @llvm.loongarch.lasx.xvrepl128vei.w(<8 x i32> %va, i32 4)
  ret <8 x i32> %res
}

declare <4 x i64> @llvm.loongarch.lasx.xvrepl128vei.d(<4 x i64>, i32)

define <4 x i64> @lasx_xvrepl128vei_d_lo(<4 x i64> %va) nounwind {
; CHECK: llvm.loongarch.lasx.xvrepl128vei.d: argument out of range
entry:
  %res = call <4 x i64> @llvm.loongarch.lasx.xvrepl128vei.d(<4 x i64> %va, i32 -1)
  ret <4 x i64> %res
}

define <4 x i64> @lasx_xvrepl128vei_d_hi(<4 x i64> %va) nounwind {
; CHECK: llvm.loongarch.lasx.xvrepl128vei.d: argument out of range
entry:
  %res = call <4 x i64> @llvm.loongarch.lasx.xvrepl128vei.d(<4 x i64> %va, i32 2)
  ret <4 x i64> %res
}
