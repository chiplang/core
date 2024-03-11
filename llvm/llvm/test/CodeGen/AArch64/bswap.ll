; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=aarch64 %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-SD
; RUN: llc -mtriple=aarch64 -global-isel -global-isel-abort=2 %s -o - 2>&1 | FileCheck %s --check-prefixes=CHECK,CHECK-GI

; CHECK-GI:         warning: Instruction selection used fallback path for bswap_v2i16

; ====== Scalar Tests =====
define i16 @bswap_i16(i16 %a){
; CHECK-LABEL: bswap_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev w8, w0
; CHECK-NEXT:    lsr w0, w8, #16
; CHECK-NEXT:    ret
    %3 = call i16 @llvm.bswap.i16(i16 %a)
    ret i16 %3
}
declare i16 @llvm.bswap.i16(i16)

define i32 @bswap_i32(i32 %a){
; CHECK-LABEL: bswap_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev w0, w0
; CHECK-NEXT:    ret
    %3 = call i32 @llvm.bswap.i32(i32 %a)
    ret i32 %3
}
declare i32 @llvm.bswap.i32(i32)

define i64 @bswap_i64(i64 %a){
; CHECK-LABEL: bswap_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev x0, x0
; CHECK-NEXT:    ret
    %3 = call i64 @llvm.bswap.i64(i64 %a)
    ret i64 %3
}
declare i64 @llvm.bswap.i64(i64)

define i128 @bswap_i128(i128 %a){
; CHECK-LABEL: bswap_i128:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev x8, x1
; CHECK-NEXT:    rev x1, x0
; CHECK-NEXT:    mov x0, x8
; CHECK-NEXT:    ret
    %3 = call i128 @llvm.bswap.i128(i128 %a)
    ret i128 %3
}
declare i128 @llvm.bswap.i128(i128)

; ===== Legal Vector Type Tests =====

define <4 x i16> @bswap_v4i16(<4 x i16> %a){
; CHECK-LABEL: bswap_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev16 v0.8b, v0.8b
; CHECK-NEXT:    ret
    %3 = call <4 x i16> @llvm.bswap.v4i16(<4 x i16> %a)
    ret <4 x i16> %3
}
declare <4 x i16> @llvm.bswap.v4i16(<4 x i16>)

define <8 x i16> @bswap_v8i16(<8 x i16> %a){
; CHECK-LABEL: bswap_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev16 v0.16b, v0.16b
; CHECK-NEXT:    ret
    %3 = call <8 x i16> @llvm.bswap.v8i16(<8 x i16> %a)
    ret <8 x i16> %3
}
declare <8 x i16> @llvm.bswap.v8i16(<8 x i16>)

define <2 x i32> @bswap_v2i32(<2 x i32> %a){
; CHECK-LABEL: bswap_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev32 v0.8b, v0.8b
; CHECK-NEXT:    ret
    %3 = call <2 x i32> @llvm.bswap.v2i32(<2 x i32> %a)
    ret <2 x i32> %3
}
declare <2 x i32> @llvm.bswap.v2i32(<2 x i32>)

define <4 x i32> @bswap_v4i32(<4 x i32> %a){
; CHECK-LABEL: bswap_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev32 v0.16b, v0.16b
; CHECK-NEXT:    ret
    %3 = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> %a)
    ret <4 x i32> %3
}
declare <4 x i32> @llvm.bswap.v4i32(<4 x i32>)

define <2 x i64> @bswap_v2i64(<2 x i64> %a){
; CHECK-LABEL: bswap_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev64 v0.16b, v0.16b
; CHECK-NEXT:    ret
    %3 = call <2 x i64> @llvm.bswap.v2i64(<2 x i64> %a)
    ret <2 x i64> %3
}
declare <2 x i64> @llvm.bswap.v2i64(<2 x i64>)

; ===== Smaller/Larger Width Vectors with Legal Element Sizes =====

define <2 x i16> @bswap_v2i16(<2 x i16> %a){
; CHECK-LABEL: bswap_v2i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    rev32 v0.8b, v0.8b
; CHECK-NEXT:    ushr v0.2s, v0.2s, #16
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i16> @llvm.bswap.v2i16(<2 x i16> %a)
  ret <2 x i16> %res
}
declare <2 x i16> @llvm.bswap.v2i16(<2 x i16>)

define <16 x i16> @bswap_v16i16(<16 x i16> %a){
; CHECK-LABEL: bswap_v16i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    rev16 v0.16b, v0.16b
; CHECK-NEXT:    rev16 v1.16b, v1.16b
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i16> @llvm.bswap.v16i16(<16 x i16> %a)
  ret <16 x i16> %res
}
declare <16 x i16> @llvm.bswap.v16i16(<16 x i16>)

define <1 x i32> @bswap_v1i32(<1 x i32> %a){
; CHECK-SD-LABEL: bswap_v1i32:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    rev32 v0.8b, v0.8b
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: bswap_v1i32:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    fmov w8, s0
; CHECK-GI-NEXT:    rev w8, w8
; CHECK-GI-NEXT:    fmov s0, w8
; CHECK-GI-NEXT:    mov v0.s[1], w8
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
entry:
  %res = call <1 x i32> @llvm.bswap.v1i32(<1 x i32> %a)
  ret <1 x i32> %res
}
declare <1 x i32> @llvm.bswap.v1i32(<1 x i32>)

define <8 x i32> @bswap_v8i32(<8 x i32> %a){
; CHECK-LABEL: bswap_v8i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    rev32 v0.16b, v0.16b
; CHECK-NEXT:    rev32 v1.16b, v1.16b
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i32> @llvm.bswap.v8i32(<8 x i32> %a)
  ret <8 x i32> %res
}
declare <8 x i32> @llvm.bswap.v8i32(<8 x i32>)

define <4 x i64> @bswap_v4i64(<4 x i64> %a){
; CHECK-LABEL: bswap_v4i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    rev64 v0.16b, v0.16b
; CHECK-NEXT:    rev64 v1.16b, v1.16b
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i64> @llvm.bswap.v4i64(<4 x i64> %a)
  ret <4 x i64> %res
}
declare <4 x i64> @llvm.bswap.v4i64(<4 x i64>)

; ===== Vectors with Non-Pow 2 Widths =====

define <3 x i16> @bswap_v3i16(<3 x i16> %a){
; CHECK-LABEL: bswap_v3i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    rev16 v0.8b, v0.8b
; CHECK-NEXT:    ret
entry:
  %res = call <3 x i16> @llvm.bswap.v3i16(<3 x i16> %a)
  ret <3 x i16> %res
}
declare <3 x i16> @llvm.bswap.v3i16(<3 x i16>)

define <7 x i16> @bswap_v7i16(<7 x i16> %a){
; CHECK-LABEL: bswap_v7i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    rev16 v0.16b, v0.16b
; CHECK-NEXT:    ret
entry:
  %res = call <7 x i16> @llvm.bswap.v7i16(<7 x i16> %a)
  ret <7 x i16> %res
}
declare <7 x i16> @llvm.bswap.v7i16(<7 x i16>)

define <3 x i32> @bswap_v3i32(<3 x i32> %a){
; CHECK-LABEL: bswap_v3i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    rev32 v0.16b, v0.16b
; CHECK-NEXT:    ret
entry:
  %res = call <3 x i32> @llvm.bswap.v3i32(<3 x i32> %a)
  ret <3 x i32> %res
}
declare <3 x i32> @llvm.bswap.v3i32(<3 x i32>)
