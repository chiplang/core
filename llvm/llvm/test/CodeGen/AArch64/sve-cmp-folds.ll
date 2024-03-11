; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-unknown -mattr=+sve2 -o - < %s | FileCheck %s

define <vscale x 8 x i1> @not_icmp_sle_nxv8i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b) {
; CHECK-LABEL: not_icmp_sle_nxv8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    cmpgt p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    ret
  %icmp = icmp sle <vscale x 8 x i16> %a, %b
  %tmp = insertelement <vscale x 8 x i1> undef, i1 true, i32 0
  %ones = shufflevector <vscale x 8 x i1> %tmp, <vscale x 8 x i1> undef, <vscale x 8 x i32> zeroinitializer
  %not = xor <vscale x 8 x i1> %ones, %icmp
  ret <vscale x 8 x i1> %not
}

define <vscale x 4 x i1> @not_icmp_sgt_nxv4i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b) {
; CHECK-LABEL: not_icmp_sgt_nxv4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    cmpge p0.s, p0/z, z1.s, z0.s
; CHECK-NEXT:    ret
  %icmp = icmp sgt <vscale x 4 x i32> %a, %b
  %tmp = insertelement <vscale x 4 x i1> undef, i1 true, i32 0
  %ones = shufflevector <vscale x 4 x i1> %tmp, <vscale x 4 x i1> undef, <vscale x 4 x i32> zeroinitializer
  %not = xor <vscale x 4 x i1> %icmp, %ones
  ret <vscale x 4 x i1> %not
}

define <vscale x 2 x i1> @not_fcmp_une_nxv2f64(<vscale x 2 x double> %a, <vscale x 2 x double> %b) {
; CHECK-LABEL: not_fcmp_une_nxv2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fcmeq p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT:    ret
  %icmp = fcmp une <vscale x 2 x double> %a, %b
  %tmp = insertelement <vscale x 2 x i1> undef, i1 true, i32 0
  %ones = shufflevector <vscale x 2 x i1> %tmp, <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer
  %not = xor <vscale x 2 x i1> %icmp, %ones
  ret <vscale x 2 x i1> %not
}

define <vscale x 4 x i1> @not_fcmp_uge_nxv4f32(<vscale x 4 x float> %a, <vscale x 4 x float> %b) {
; CHECK-LABEL: not_fcmp_uge_nxv4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fcmgt p0.s, p0/z, z1.s, z0.s
; CHECK-NEXT:    ret
  %icmp = fcmp uge <vscale x 4 x float> %a, %b
  %tmp = insertelement <vscale x 4 x i1> undef, i1 true, i32 0
  %ones = shufflevector <vscale x 4 x i1> %tmp, <vscale x 4 x i1> undef, <vscale x 4 x i32> zeroinitializer
  %not = xor <vscale x 4 x i1> %icmp, %ones
  ret <vscale x 4 x i1> %not
}

define <vscale x 16 x i8> @icmp_cnot_nxv16i8(<vscale x 16 x i8> %a) {
; CHECK-LABEL: icmp_cnot_nxv16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    cnot z0.b, p0/m, z0.b
; CHECK-NEXT:    ret
  %mask = icmp eq <vscale x 16 x i8> %a, zeroinitializer
  %zext = zext <vscale x 16 x i1> %mask to <vscale x 16 x i8>
  ret <vscale x 16 x i8> %zext
}

define <vscale x 8 x i16> @icmp_cnot_nxv8i16(<vscale x 8 x i16> %a) {
; CHECK-LABEL: icmp_cnot_nxv8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    cnot z0.h, p0/m, z0.h
; CHECK-NEXT:    ret
  %mask = icmp eq <vscale x 8 x i16> %a, zeroinitializer
  %zext = zext <vscale x 8 x i1> %mask to <vscale x 8 x i16>
  ret <vscale x 8 x i16> %zext
}

define <vscale x 4 x i32> @icmp_cnot_nxv4i32(<vscale x 4 x i32> %a) {
; CHECK-LABEL: icmp_cnot_nxv4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    cnot z0.s, p0/m, z0.s
; CHECK-NEXT:    ret
  %mask = icmp eq <vscale x 4 x i32> %a, zeroinitializer
  %zext = zext <vscale x 4 x i1> %mask to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %zext
}

define <vscale x 2 x i64> @icmp_cnot_nxv2i64(<vscale x 2 x i64> %a) {
; CHECK-LABEL: icmp_cnot_nxv2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    cnot z0.d, p0/m, z0.d
; CHECK-NEXT:    ret
  %mask = icmp eq <vscale x 2 x i64> %a, zeroinitializer
  %zext = zext <vscale x 2 x i1> %mask to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %zext
}

define i1 @foo_first(<vscale x 4 x float> %a, <vscale x 4 x float> %b) {
; CHECK-LABEL: foo_first:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fcmeq p1.s, p0/z, z0.s, z1.s
; CHECK-NEXT:    ptest p0, p1.b
; CHECK-NEXT:    cset w0, mi
; CHECK-NEXT:    ret
  %vcond = fcmp oeq <vscale x 4 x float> %a, %b
  %bit = extractelement <vscale x 4 x i1> %vcond, i64 0
  ret i1 %bit
}

define i1 @foo_last(<vscale x 4 x float> %a, <vscale x 4 x float> %b) {
; CHECK-LABEL: foo_last:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mov x8, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    whilels p1.s, xzr, x8
; CHECK-NEXT:    fcmeq p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT:    mov z0.s, p0/z, #1 // =0x1
; CHECK-NEXT:    lastb w8, p1, z0.s
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
  %vcond = fcmp oeq <vscale x 4 x float> %a, %b
  %vscale = call i64 @llvm.vscale.i64()
  %shl2 = shl nuw nsw i64 %vscale, 2
  %idx = add nuw nsw i64 %shl2, -1
  %bit = extractelement <vscale x 4 x i1> %vcond, i64 %idx
  ret i1 %bit
}

define i1 @whilege_first(i64 %next, i64 %end) {
; CHECK-LABEL: whilege_first:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilege p0.s, x0, x1
; CHECK-NEXT:    cset w0, mi
; CHECK-NEXT:    ret
  %predicate = call <vscale x 4 x i1> @llvm.aarch64.sve.whilege.nxv4i1.i64(i64 %next, i64 %end)
  %bit = extractelement <vscale x 4 x i1> %predicate, i64 0
  ret i1 %bit
}

define i1 @whilegt_first(i64 %next, i64 %end) {
; CHECK-LABEL: whilegt_first:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilegt p0.s, x0, x1
; CHECK-NEXT:    cset w0, mi
; CHECK-NEXT:    ret
  %predicate = call <vscale x 4 x i1> @llvm.aarch64.sve.whilegt.nxv4i1.i64(i64 %next, i64 %end)
  %bit = extractelement <vscale x 4 x i1> %predicate, i64 0
  ret i1 %bit
}

define i1 @whilehi_first(i64 %next, i64 %end) {
; CHECK-LABEL: whilehi_first:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilehi p0.s, x0, x1
; CHECK-NEXT:    cset w0, mi
; CHECK-NEXT:    ret
  %predicate = call <vscale x 4 x i1> @llvm.aarch64.sve.whilehi.nxv4i1.i64(i64 %next, i64 %end)
  %bit = extractelement <vscale x 4 x i1> %predicate, i64 0
  ret i1 %bit
}

define i1 @whilehs_first(i64 %next, i64 %end) {
; CHECK-LABEL: whilehs_first:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilehs p0.s, x0, x1
; CHECK-NEXT:    cset w0, mi
; CHECK-NEXT:    ret
  %predicate = call <vscale x 4 x i1> @llvm.aarch64.sve.whilehs.nxv4i1.i64(i64 %next, i64 %end)
  %bit = extractelement <vscale x 4 x i1> %predicate, i64 0
  ret i1 %bit
}

define i1 @whilele_first(i64 %next, i64 %end) {
; CHECK-LABEL: whilele_first:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilele p0.s, x0, x1
; CHECK-NEXT:    cset w0, mi
; CHECK-NEXT:    ret
  %predicate = call <vscale x 4 x i1> @llvm.aarch64.sve.whilele.nxv4i1.i64(i64 %next, i64 %end)
  %bit = extractelement <vscale x 4 x i1> %predicate, i64 0
  ret i1 %bit
}

define i1 @whilelo_first(i64 %next, i64 %end) {
; CHECK-LABEL: whilelo_first:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.s, x0, x1
; CHECK-NEXT:    cset w0, mi
; CHECK-NEXT:    ret
  %predicate = call <vscale x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i64(i64 %next, i64 %end)
  %bit = extractelement <vscale x 4 x i1> %predicate, i64 0
  ret i1 %bit
}

define i1 @whilels_first(i64 %next, i64 %end) {
; CHECK-LABEL: whilels_first:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilels p0.s, x0, x1
; CHECK-NEXT:    cset w0, mi
; CHECK-NEXT:    ret
  %predicate = call <vscale x 4 x i1> @llvm.aarch64.sve.whilels.nxv4i1.i64(i64 %next, i64 %end)
  %bit = extractelement <vscale x 4 x i1> %predicate, i64 0
  ret i1 %bit
}

define i1 @whilelt_first(i64 %next, i64 %end) {
; CHECK-LABEL: whilelt_first:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelt p0.s, x0, x1
; CHECK-NEXT:    cset w0, mi
; CHECK-NEXT:    ret
  %predicate = call <vscale x 4 x i1> @llvm.aarch64.sve.whilelt.nxv4i1.i64(i64 %next, i64 %end)
  %bit = extractelement <vscale x 4 x i1> %predicate, i64 0
  ret i1 %bit
}

define i1 @lane_mask_first(i64 %next, i64 %end) {
; CHECK-LABEL: lane_mask_first:
; CHECK:       // %bb.0:
; CHECK-NEXT:    whilelo p0.s, x0, x1
; CHECK-NEXT:    cset w0, mi
; CHECK-NEXT:    ret
  %predicate = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 %next, i64 %end)
  %bit = extractelement <vscale x 4 x i1> %predicate, i64 0
  ret i1 %bit
}

declare i64 @llvm.vscale.i64()
declare <vscale x 4 x i1> @llvm.aarch64.sve.whilege.nxv4i1.i64(i64, i64)
declare <vscale x 4 x i1> @llvm.aarch64.sve.whilegt.nxv4i1.i64(i64, i64)
declare <vscale x 4 x i1> @llvm.aarch64.sve.whilehi.nxv4i1.i64(i64, i64)
declare <vscale x 4 x i1> @llvm.aarch64.sve.whilehs.nxv4i1.i64(i64, i64)
declare <vscale x 4 x i1> @llvm.aarch64.sve.whilele.nxv4i1.i64(i64, i64)
declare <vscale x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i64(i64, i64)
declare <vscale x 4 x i1> @llvm.aarch64.sve.whilels.nxv4i1.i64(i64, i64)
declare <vscale x 4 x i1> @llvm.aarch64.sve.whilelt.nxv4i1.i64(i64, i64)
declare <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64, i64)
