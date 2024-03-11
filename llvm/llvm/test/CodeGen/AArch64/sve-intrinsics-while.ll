; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sme < %s | FileCheck %s

;
; WHILELE
;

define <vscale x 16 x i1> @whilele_b_ww(i32 %a, i32 %b) {
; CHECK-LABEL: whilele_b_ww:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilele p0.b, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilele.nxv16i1.i32(i32 %a, i32 %b)
  ret <vscale x 16 x i1> %out
}

define <vscale x 16 x i1> @whilele_b_xx(i64 %a, i64 %b) {
; CHECK-LABEL: whilele_b_xx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilele p0.b, x0, x1
; CHECK-NEXT:    ret
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilele.nxv16i1.i64(i64 %a, i64 %b)
  ret <vscale x 16 x i1> %out
}

define <vscale x 8 x i1> @whilele_h_ww(i32 %a, i32 %b) {
; CHECK-LABEL: whilele_h_ww:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilele p0.h, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x i1> @llvm.aarch64.sve.whilele.nxv8i1.i32(i32 %a, i32 %b)
  ret <vscale x 8 x i1> %out
}

define <vscale x 8 x i1> @whilele_h_xx(i64 %a, i64 %b) {
; CHECK-LABEL: whilele_h_xx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilele p0.h, x0, x1
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x i1> @llvm.aarch64.sve.whilele.nxv8i1.i64(i64 %a, i64 %b)
  ret <vscale x 8 x i1> %out
}

define <vscale x 4 x i1> @whilele_s_ww(i32 %a, i32 %b) {
; CHECK-LABEL: whilele_s_ww:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilele p0.s, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x i1> @llvm.aarch64.sve.whilele.nxv4i1.i32(i32 %a, i32 %b)
  ret <vscale x 4 x i1> %out
}

define <vscale x 4 x i1> @whilele_s_xx(i64 %a, i64 %b) {
; CHECK-LABEL: whilele_s_xx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilele p0.s, x0, x1
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x i1> @llvm.aarch64.sve.whilele.nxv4i1.i64(i64 %a, i64 %b)
  ret <vscale x 4 x i1> %out
}

define <vscale x 2 x i1> @whilele_d_ww(i32 %a, i32 %b) {
; CHECK-LABEL: whilele_d_ww:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilele p0.d, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x i1> @llvm.aarch64.sve.whilele.nxv2i1.i32(i32 %a, i32 %b)
  ret <vscale x 2 x i1> %out
}

define <vscale x 2 x i1> @whilele_d_xx(i64 %a, i64 %b) {
; CHECK-LABEL: whilele_d_xx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilele p0.d, x0, x1
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x i1> @llvm.aarch64.sve.whilele.nxv2i1.i64(i64 %a, i64 %b)
  ret <vscale x 2 x i1> %out
}

define <vscale x 2 x i1> @whilele_d_ii_dont_fold_to_ptrue_larger_than_minvec() {
; CHECK-LABEL: whilele_d_ii_dont_fold_to_ptrue_larger_than_minvec:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #3
; CHECK-NEXT:    whilele p0.d, xzr, x8
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x i1> @llvm.aarch64.sve.whilele.nxv2i1.i64(i64 0, i64 3)
  ret <vscale x 2 x i1> %out
}

define <vscale x 16 x i1> @whilele_b_ii() {
; CHECK-LABEL: whilele_b_ii:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue p0.b, vl6
; CHECK-NEXT:    ret
entry:
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilele.nxv16i1.i64(i64 -2, i64 3)
  ret <vscale x 16 x i1> %out
}

define <vscale x 16 x i1> @whilele_b_ii_dont_fold_to_ptrue_nonexistent_vl9() {
; CHECK-LABEL: whilele_b_ii_dont_fold_to_ptrue_nonexistent_vl9:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, #9
; CHECK-NEXT:    whilele p0.b, xzr, x8
; CHECK-NEXT:    ret
entry:
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilele.nxv16i1.i64(i64 0, i64 9)
  ret <vscale x 16 x i1> %out
}

define <vscale x 16 x i1> @whilele_b_vl_maximum() vscale_range(16, 16) {
; CHECK-LABEL: whilele_b_vl_maximum:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl256
; CHECK-NEXT:    ret
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilele.nxv16i1.i64(i64 0, i64 255)
  ret <vscale x 16 x i1> %out
}

define <vscale x 16 x i1> @whilele_b_ii_dont_fold_to_ptrue_overflow() {
; CHECK-LABEL: whilele_b_ii_dont_fold_to_ptrue_overflow:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, #2
; CHECK-NEXT:    mov w9, #2147483647
; CHECK-NEXT:    movk w8, #32768, lsl #16
; CHECK-NEXT:    whilele p0.b, w9, w8
; CHECK-NEXT:    ret
entry:
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilele.nxv16i1.i32(i32 2147483647, i32 -2147483646)
  ret <vscale x 16 x i1> %out
}

define <vscale x 16 x i1> @whilele_b_ii_dont_fold_to_ptrue_increment_overflow() {
; CHECK-LABEL: whilele_b_ii_dont_fold_to_ptrue_increment_overflow:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, #2147483647
; CHECK-NEXT:    whilele p0.b, wzr, w8
; CHECK-NEXT:    ret
entry:
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilele.nxv16i1.i32(i32 0, i32 2147483647)
  ret <vscale x 16 x i1> %out
}

;
; WHILELO
;

define <vscale x 16 x i1> @whilelo_b_ww(i32 %a, i32 %b) {
; CHECK-LABEL: whilelo_b_ww:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.b, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilelo.nxv16i1.i32(i32 %a, i32 %b)
  ret <vscale x 16 x i1> %out
}

define <vscale x 16 x i1> @whilelo_b_xx(i64 %a, i64 %b) {
; CHECK-LABEL: whilelo_b_xx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.b, x0, x1
; CHECK-NEXT:    ret
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilelo.nxv16i1.i64(i64 %a, i64 %b)
  ret <vscale x 16 x i1> %out
}

define <vscale x 8 x i1> @whilelo_h_ww(i32 %a, i32 %b) {
; CHECK-LABEL: whilelo_h_ww:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.h, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x i1> @llvm.aarch64.sve.whilelo.nxv8i1.i32(i32 %a, i32 %b)
  ret <vscale x 8 x i1> %out
}

define <vscale x 8 x i1> @whilelo_h_xx(i64 %a, i64 %b) {
; CHECK-LABEL: whilelo_h_xx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.h, x0, x1
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x i1> @llvm.aarch64.sve.whilelo.nxv8i1.i64(i64 %a, i64 %b)
  ret <vscale x 8 x i1> %out
}

define <vscale x 4 x i1> @whilelo_s_ww(i32 %a, i32 %b) {
; CHECK-LABEL: whilelo_s_ww:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.s, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i32(i32 %a, i32 %b)
  ret <vscale x 4 x i1> %out
}

define <vscale x 4 x i1> @whilelo_s_xx(i64 %a, i64 %b) {
; CHECK-LABEL: whilelo_s_xx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.s, x0, x1
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i64(i64 %a, i64 %b)
  ret <vscale x 4 x i1> %out
}

define <vscale x 2 x i1> @whilelo_d_ww(i32 %a, i32 %b) {
; CHECK-LABEL: whilelo_d_ww:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.d, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x i1> @llvm.aarch64.sve.whilelo.nxv2i1.i32(i32 %a, i32 %b)
  ret <vscale x 2 x i1> %out
}

define <vscale x 2 x i1> @whilelo_d_xx(i64 %a, i64 %b) {
; CHECK-LABEL: whilelo_d_xx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.d, x0, x1
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x i1> @llvm.aarch64.sve.whilelo.nxv2i1.i64(i64 %a, i64 %b)
  ret <vscale x 2 x i1> %out
}

define <vscale x 2 x i1> @whilelo_d_ii_dont_fold_to_ptrue_larger_than_minvec() {
; CHECK-LABEL: whilelo_d_ii_dont_fold_to_ptrue_larger_than_minvec:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #3
; CHECK-NEXT:    whilelo p0.d, xzr, x8
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x i1> @llvm.aarch64.sve.whilelo.nxv2i1.i64(i64 0, i64 3)
  ret <vscale x 2 x i1> %out
}

define <vscale x 16 x i1> @whilelo_b_ii() {
; CHECK-LABEL: whilelo_b_ii:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue p0.b, vl6
; CHECK-NEXT:    ret
entry:
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilelo.nxv16i1.i64(i64 2, i64 8)
  ret <vscale x 16 x i1> %out
}

define <vscale x 16 x i1> @whilelo_b_ii_dont_fold_to_ptrue_nonexistent_vl9() {
; CHECK-LABEL: whilelo_b_ii_dont_fold_to_ptrue_nonexistent_vl9:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, #9
; CHECK-NEXT:    whilelo p0.b, xzr, x8
; CHECK-NEXT:    ret
entry:
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilelo.nxv16i1.i64(i64 0, i64 9)
  ret <vscale x 16 x i1> %out
}

define <vscale x 16 x i1> @whilelo_b_vl_maximum() vscale_range(16, 16) {
; CHECK-LABEL: whilelo_b_vl_maximum:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl256
; CHECK-NEXT:    ret
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilelo.nxv16i1.i64(i64 0, i64 256)
  ret <vscale x 16 x i1> %out
}

define <vscale x 16 x i1> @whilelo_b_ii_dont_fold_to_ptrue_overflow() {
; CHECK-LABEL: whilelo_b_ii_dont_fold_to_ptrue_overflow:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, #6
; CHECK-NEXT:    mov w9, #-1
; CHECK-NEXT:    whilelo p0.b, w9, w8
; CHECK-NEXT:    ret
entry:
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilelo.nxv16i1.i32(i32 4294967295, i32 6)
  ret <vscale x 16 x i1> %out
}

;
; WHILELS
;

define <vscale x 16 x i1> @whilels_b_ww(i32 %a, i32 %b) {
; CHECK-LABEL: whilels_b_ww:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilels p0.b, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilels.nxv16i1.i32(i32 %a, i32 %b)
  ret <vscale x 16 x i1> %out
}

define <vscale x 16 x i1> @whilels_b_xx(i64 %a, i64 %b) {
; CHECK-LABEL: whilels_b_xx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilels p0.b, x0, x1
; CHECK-NEXT:    ret
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilels.nxv16i1.i64(i64 %a, i64 %b)
  ret <vscale x 16 x i1> %out
}

define <vscale x 8 x i1> @whilels_h_ww(i32 %a, i32 %b) {
; CHECK-LABEL: whilels_h_ww:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilels p0.h, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x i1> @llvm.aarch64.sve.whilels.nxv8i1.i32(i32 %a, i32 %b)
  ret <vscale x 8 x i1> %out
}

define <vscale x 8 x i1> @whilels_h_xx(i64 %a, i64 %b) {
; CHECK-LABEL: whilels_h_xx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilels p0.h, x0, x1
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x i1> @llvm.aarch64.sve.whilels.nxv8i1.i64(i64 %a, i64 %b)
  ret <vscale x 8 x i1> %out
}

define <vscale x 4 x i1> @whilels_s_ww(i32 %a, i32 %b) {
; CHECK-LABEL: whilels_s_ww:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilels p0.s, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x i1> @llvm.aarch64.sve.whilels.nxv4i1.i32(i32 %a, i32 %b)
  ret <vscale x 4 x i1> %out
}

define <vscale x 4 x i1> @whilels_s_xx(i64 %a, i64 %b) {
; CHECK-LABEL: whilels_s_xx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilels p0.s, x0, x1
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x i1> @llvm.aarch64.sve.whilels.nxv4i1.i64(i64 %a, i64 %b)
  ret <vscale x 4 x i1> %out
}

define <vscale x 2 x i1> @whilels_d_ww(i32 %a, i32 %b) {
; CHECK-LABEL: whilels_d_ww:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilels p0.d, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x i1> @llvm.aarch64.sve.whilels.nxv2i1.i32(i32 %a, i32 %b)
  ret <vscale x 2 x i1> %out
}

define <vscale x 2 x i1> @whilels_d_xx(i64 %a, i64 %b) {
; CHECK-LABEL: whilels_d_xx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilels p0.d, x0, x1
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x i1> @llvm.aarch64.sve.whilels.nxv2i1.i64(i64 %a, i64 %b)
  ret <vscale x 2 x i1> %out
}

define <vscale x 2 x i1> @whilels_d_ii_dont_fold_to_ptrue_larger_than_minvec() {
; CHECK-LABEL: whilels_d_ii_dont_fold_to_ptrue_larger_than_minvec:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #3
; CHECK-NEXT:    whilels p0.d, xzr, x8
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x i1> @llvm.aarch64.sve.whilels.nxv2i1.i64(i64 0, i64 3)
  ret <vscale x 2 x i1> %out
}

define <vscale x 16 x i1> @whilels_b_ii() {
; CHECK-LABEL: whilels_b_ii:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue p0.b, vl7
; CHECK-NEXT:    ret
entry:
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilels.nxv16i1.i64(i64 2, i64 8)
  ret <vscale x 16 x i1> %out
}

define <vscale x 16 x i1> @whilels_b_ii_dont_fold_to_ptrue_nonexistent_vl9() {
; CHECK-LABEL: whilels_b_ii_dont_fold_to_ptrue_nonexistent_vl9:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, #9
; CHECK-NEXT:    whilels p0.b, xzr, x8
; CHECK-NEXT:    ret
entry:
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilels.nxv16i1.i64(i64 0, i64 9)
  ret <vscale x 16 x i1> %out
}

define <vscale x 16 x i1> @whilels_b_ii_vl_maximum() vscale_range(16, 16) {
; CHECK-LABEL: whilels_b_ii_vl_maximum:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl256
; CHECK-NEXT:    ret
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilels.nxv16i1.i64(i64 0, i64 255)
  ret <vscale x 16 x i1> %out
}

define <vscale x 16 x i1> @whilels_b_ii_dont_fold_to_ptrue_overflow() {
; CHECK-LABEL: whilels_b_ii_dont_fold_to_ptrue_overflow:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, #6
; CHECK-NEXT:    mov w9, #-1
; CHECK-NEXT:    whilels p0.b, w9, w8
; CHECK-NEXT:    ret
entry:
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilels.nxv16i1.i32(i32 4294967295, i32 6)
  ret <vscale x 16 x i1> %out
}

define <vscale x 16 x i1> @whilels_b_ii_dont_fold_to_ptrue_increment_overflow() {
; CHECK-LABEL: whilels_b_ii_dont_fold_to_ptrue_increment_overflow:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, #-1
; CHECK-NEXT:    whilels p0.b, wzr, w8
; CHECK-NEXT:    ret
entry:
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilels.nxv16i1.i32(i32 0, i32 4294967295)
  ret <vscale x 16 x i1> %out
}

;
; WHILELT
;

define <vscale x 16 x i1> @whilelt_b_ww(i32 %a, i32 %b) {
; CHECK-LABEL: whilelt_b_ww:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelt p0.b, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilelt.nxv16i1.i32(i32 %a, i32 %b)
  ret <vscale x 16 x i1> %out
}

define <vscale x 16 x i1> @whilelt_b_xx(i64 %a, i64 %b) {
; CHECK-LABEL: whilelt_b_xx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelt p0.b, x0, x1
; CHECK-NEXT:    ret
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilelt.nxv16i1.i64(i64 %a, i64 %b)
  ret <vscale x 16 x i1> %out
}

define <vscale x 8 x i1> @whilelt_h_ww(i32 %a, i32 %b) {
; CHECK-LABEL: whilelt_h_ww:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelt p0.h, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x i1> @llvm.aarch64.sve.whilelt.nxv8i1.i32(i32 %a, i32 %b)
  ret <vscale x 8 x i1> %out
}

define <vscale x 8 x i1> @whilelt_h_xx(i64 %a, i64 %b) {
; CHECK-LABEL: whilelt_h_xx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelt p0.h, x0, x1
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x i1> @llvm.aarch64.sve.whilelt.nxv8i1.i64(i64 %a, i64 %b)
  ret <vscale x 8 x i1> %out
}

define <vscale x 4 x i1> @whilelt_s_ww(i32 %a, i32 %b) {
; CHECK-LABEL: whilelt_s_ww:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelt p0.s, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x i1> @llvm.aarch64.sve.whilelt.nxv4i1.i32(i32 %a, i32 %b)
  ret <vscale x 4 x i1> %out
}

define <vscale x 4 x i1> @whilelt_s_xx(i64 %a, i64 %b) {
; CHECK-LABEL: whilelt_s_xx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelt p0.s, x0, x1
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x i1> @llvm.aarch64.sve.whilelt.nxv4i1.i64(i64 %a, i64 %b)
  ret <vscale x 4 x i1> %out
}

define <vscale x 2 x i1> @whilelt_d_ww(i32 %a, i32 %b) {
; CHECK-LABEL: whilelt_d_ww:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelt p0.d, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x i1> @llvm.aarch64.sve.whilelt.nxv2i1.i32(i32 %a, i32 %b)
  ret <vscale x 2 x i1> %out
}

define <vscale x 2 x i1> @whilelt_d_xx(i64 %a, i64 %b) {
; CHECK-LABEL: whilelt_d_xx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelt p0.d, x0, x1
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x i1> @llvm.aarch64.sve.whilelt.nxv2i1.i64(i64 %a, i64 %b)
  ret <vscale x 2 x i1> %out
}

define <vscale x 2 x i1> @whilelt_d_ii_dont_fold_to_ptrue_larger_than_minvec() {
; CHECK-LABEL: whilelt_d_ii_dont_fold_to_ptrue_larger_than_minvec:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #3
; CHECK-NEXT:    whilelt p0.d, xzr, x8
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x i1> @llvm.aarch64.sve.whilelt.nxv2i1.i64(i64 0, i64 3)
  ret <vscale x 2 x i1> %out
}

define <vscale x 16 x i1> @whilelt_b_ii() {
; CHECK-LABEL: whilelt_b_ii:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue p0.b, vl5
; CHECK-NEXT:    ret
entry:
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilelt.nxv16i1.i64(i64 -2, i64 3)
  ret <vscale x 16 x i1> %out
}

define <vscale x 16 x i1> @whilelt_b_ii_dont_fold_to_ptrue_nonexistent_vl9() {
; CHECK-LABEL: whilelt_b_ii_dont_fold_to_ptrue_nonexistent_vl9:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, #9
; CHECK-NEXT:    whilelt p0.b, xzr, x8
; CHECK-NEXT:    ret
entry:
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilelt.nxv16i1.i64(i64 0, i64 9)
  ret <vscale x 16 x i1> %out
}

define <vscale x 16 x i1> @whilelt_b_ii_vl_maximum() vscale_range(16, 16) {
; CHECK-LABEL: whilelt_b_ii_vl_maximum:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl256
; CHECK-NEXT:    ret
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilelt.nxv16i1.i64(i64 0, i64 256)
  ret <vscale x 16 x i1> %out
}

define <vscale x 16 x i1> @whilelt_b_ii_dont_fold_to_ptrue_overflow() {
; CHECK-LABEL: whilelt_b_ii_dont_fold_to_ptrue_overflow:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, #2
; CHECK-NEXT:    mov w9, #2147483647
; CHECK-NEXT:    movk w8, #32768, lsl #16
; CHECK-NEXT:    whilelt p0.b, w9, w8
; CHECK-NEXT:    ret
entry:
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.whilelt.nxv16i1.i32(i32 2147483647, i32 -2147483646)
  ret <vscale x 16 x i1> %out
}

declare <vscale x 16 x i1> @llvm.aarch64.sve.whilele.nxv16i1.i32(i32, i32)
declare <vscale x 16 x i1> @llvm.aarch64.sve.whilele.nxv16i1.i64(i64, i64)
declare <vscale x 8 x i1> @llvm.aarch64.sve.whilele.nxv8i1.i32(i32, i32)
declare <vscale x 8 x i1> @llvm.aarch64.sve.whilele.nxv8i1.i64(i64, i64)
declare <vscale x 4 x i1> @llvm.aarch64.sve.whilele.nxv4i1.i32(i32, i32)
declare <vscale x 4 x i1> @llvm.aarch64.sve.whilele.nxv4i1.i64(i64, i64)
declare <vscale x 2 x i1> @llvm.aarch64.sve.whilele.nxv2i1.i32(i32, i32)
declare <vscale x 2 x i1> @llvm.aarch64.sve.whilele.nxv2i1.i64(i64, i64)

declare <vscale x 16 x i1> @llvm.aarch64.sve.whilelo.nxv16i1.i32(i32, i32)
declare <vscale x 16 x i1> @llvm.aarch64.sve.whilelo.nxv16i1.i64(i64, i64)
declare <vscale x 8 x i1> @llvm.aarch64.sve.whilelo.nxv8i1.i32(i32, i32)
declare <vscale x 8 x i1> @llvm.aarch64.sve.whilelo.nxv8i1.i64(i64, i64)
declare <vscale x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i32(i32, i32)
declare <vscale x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i64(i64, i64)
declare <vscale x 2 x i1> @llvm.aarch64.sve.whilelo.nxv2i1.i32(i32, i32)
declare <vscale x 2 x i1> @llvm.aarch64.sve.whilelo.nxv2i1.i64(i64, i64)

declare <vscale x 16 x i1> @llvm.aarch64.sve.whilels.nxv16i1.i32(i32, i32)
declare <vscale x 16 x i1> @llvm.aarch64.sve.whilels.nxv16i1.i64(i64, i64)
declare <vscale x 8 x i1> @llvm.aarch64.sve.whilels.nxv8i1.i32(i32, i32)
declare <vscale x 8 x i1> @llvm.aarch64.sve.whilels.nxv8i1.i64(i64, i64)
declare <vscale x 4 x i1> @llvm.aarch64.sve.whilels.nxv4i1.i32(i32, i32)
declare <vscale x 4 x i1> @llvm.aarch64.sve.whilels.nxv4i1.i64(i64, i64)
declare <vscale x 2 x i1> @llvm.aarch64.sve.whilels.nxv2i1.i32(i32, i32)
declare <vscale x 2 x i1> @llvm.aarch64.sve.whilels.nxv2i1.i64(i64, i64)

declare <vscale x 16 x i1> @llvm.aarch64.sve.whilelt.nxv16i1.i32(i32, i32)
declare <vscale x 16 x i1> @llvm.aarch64.sve.whilelt.nxv16i1.i64(i64, i64)
declare <vscale x 8 x i1> @llvm.aarch64.sve.whilelt.nxv8i1.i32(i32, i32)
declare <vscale x 8 x i1> @llvm.aarch64.sve.whilelt.nxv8i1.i64(i64, i64)
declare <vscale x 4 x i1> @llvm.aarch64.sve.whilelt.nxv4i1.i32(i32, i32)
declare <vscale x 4 x i1> @llvm.aarch64.sve.whilelt.nxv4i1.i64(i64, i64)
declare <vscale x 2 x i1> @llvm.aarch64.sve.whilelt.nxv2i1.i32(i32, i32)
declare <vscale x 2 x i1> @llvm.aarch64.sve.whilelt.nxv2i1.i64(i64, i64)
