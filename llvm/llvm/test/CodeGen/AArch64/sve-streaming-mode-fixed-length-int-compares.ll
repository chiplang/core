; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mattr=+sve -force-streaming-compatible-sve  < %s | FileCheck %s
; RUN: llc -mattr=+sme -force-streaming-compatible-sve  < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

;
; ICMP EQ
;

define <8 x i8> @icmp_eq_v8i8(<8 x i8> %op1, <8 x i8> %op2) {
; CHECK-LABEL: icmp_eq_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl8
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    cmpeq p0.b, p0/z, z0.b, z1.b
; CHECK-NEXT:    mov z0.b, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %cmp = icmp eq <8 x i8> %op1, %op2
  %sext = sext <8 x i1> %cmp to <8 x i8>
  ret <8 x i8> %sext
}

define <16 x i8> @icmp_eq_v16i8(<16 x i8> %op1, <16 x i8> %op2) {
; CHECK-LABEL: icmp_eq_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    cmpeq p0.b, p0/z, z0.b, z1.b
; CHECK-NEXT:    mov z0.b, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %cmp = icmp eq <16 x i8> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i8>
  ret <16 x i8> %sext
}

define void @icmp_eq_v32i8(ptr %a, ptr %b) {
; CHECK-LABEL: icmp_eq_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    cmpeq p1.b, p0/z, z1.b, z0.b
; CHECK-NEXT:    cmpeq p0.b, p0/z, z2.b, z3.b
; CHECK-NEXT:    mov z0.b, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z1.b, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %op2 = load <32 x i8>, ptr %b
  %cmp = icmp eq <32 x i8> %op1, %op2
  %sext = sext <32 x i1> %cmp to <32 x i8>
  store <32 x i8> %sext, ptr %a
  ret void
}

define <4 x i16> @icmp_eq_v4i16(<4 x i16> %op1, <4 x i16> %op2) {
; CHECK-LABEL: icmp_eq_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    cmpeq p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    mov z0.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %cmp = icmp eq <4 x i16> %op1, %op2
  %sext = sext <4 x i1> %cmp to <4 x i16>
  ret <4 x i16> %sext
}

define <8 x i16> @icmp_eq_v8i16(<8 x i16> %op1, <8 x i16> %op2) {
; CHECK-LABEL: icmp_eq_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    cmpeq p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    mov z0.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %cmp = icmp eq <8 x i16> %op1, %op2
  %sext = sext <8 x i1> %cmp to <8 x i16>
  ret <8 x i16> %sext
}

define void @icmp_eq_v16i16(ptr %a, ptr %b) {
; CHECK-LABEL: icmp_eq_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    cmpeq p1.h, p0/z, z1.h, z0.h
; CHECK-NEXT:    cmpeq p0.h, p0/z, z2.h, z3.h
; CHECK-NEXT:    mov z0.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z1.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %op2 = load <16 x i16>, ptr %b
  %cmp = icmp eq <16 x i16> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %a
  ret void
}

define <2 x i32> @icmp_eq_v2i32(<2 x i32> %op1, <2 x i32> %op2) {
; CHECK-LABEL: icmp_eq_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    cmpeq p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT:    mov z0.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %cmp = icmp eq <2 x i32> %op1, %op2
  %sext = sext <2 x i1> %cmp to <2 x i32>
  ret <2 x i32> %sext
}

define <4 x i32> @icmp_eq_v4i32(<4 x i32> %op1, <4 x i32> %op2) {
; CHECK-LABEL: icmp_eq_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    cmpeq p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT:    mov z0.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %cmp = icmp eq <4 x i32> %op1, %op2
  %sext = sext <4 x i1> %cmp to <4 x i32>
  ret <4 x i32> %sext
}

define void @icmp_eq_v8i32(ptr %a, ptr %b) {
; CHECK-LABEL: icmp_eq_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    cmpeq p1.s, p0/z, z1.s, z0.s
; CHECK-NEXT:    cmpeq p0.s, p0/z, z2.s, z3.s
; CHECK-NEXT:    mov z0.s, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z1.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %op2 = load <8 x i32>, ptr %b
  %cmp = icmp eq <8 x i32> %op1, %op2
  %sext = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %sext, ptr %a
  ret void
}

define <1 x i64> @icmp_eq_v1i64(<1 x i64> %op1, <1 x i64> %op2) {
; CHECK-LABEL: icmp_eq_v1i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl1
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    cmpeq p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT:    mov z0.d, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %cmp = icmp eq <1 x i64> %op1, %op2
  %sext = sext <1 x i1> %cmp to <1 x i64>
  ret <1 x i64> %sext
}

define <2 x i64> @icmp_eq_v2i64(<2 x i64> %op1, <2 x i64> %op2) {
; CHECK-LABEL: icmp_eq_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    // kill: def $q1 killed $q1 def $z1
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    cmpeq p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT:    mov z0.d, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %cmp = icmp eq <2 x i64> %op1, %op2
  %sext = sext <2 x i1> %cmp to <2 x i64>
  ret <2 x i64> %sext
}

define void @icmp_eq_v4i64(ptr %a, ptr %b) {
; CHECK-LABEL: icmp_eq_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    cmpeq p1.d, p0/z, z1.d, z0.d
; CHECK-NEXT:    cmpeq p0.d, p0/z, z2.d, z3.d
; CHECK-NEXT:    mov z0.d, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z1.d, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i64>, ptr %a
  %op2 = load <4 x i64>, ptr %b
  %cmp = icmp eq <4 x i64> %op1, %op2
  %sext = sext <4 x i1> %cmp to <4 x i64>
  store <4 x i64> %sext, ptr %a
  ret void
}

;
; ICMP NE
;

define void @icmp_ne_v32i8(ptr %a, ptr %b) {
; CHECK-LABEL: icmp_ne_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    cmpne p1.b, p0/z, z1.b, z0.b
; CHECK-NEXT:    cmpne p0.b, p0/z, z2.b, z3.b
; CHECK-NEXT:    mov z0.b, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z1.b, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %op2 = load <32 x i8>, ptr %b
  %cmp = icmp ne <32 x i8> %op1, %op2
  %sext = sext <32 x i1> %cmp to <32 x i8>
  store <32 x i8> %sext, ptr %a
  ret void
}

;
; ICMP SGE
;

define void @icmp_sge_v8i16(ptr %a, ptr %b) {
; CHECK-LABEL: icmp_sge_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr q1, [x1]
; CHECK-NEXT:    cmpge p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    mov z0.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i16>, ptr %a
  %op2 = load <8 x i16>, ptr %b
  %cmp = icmp sge <8 x i16> %op1, %op2
  %sext = sext <8 x i1> %cmp to <8 x i16>
  store <8 x i16> %sext, ptr %a
  ret void
}

;
; ICMP SGT
;

define void @icmp_sgt_v16i16(ptr %a, ptr %b) {
; CHECK-LABEL: icmp_sgt_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    cmpgt p1.h, p0/z, z1.h, z0.h
; CHECK-NEXT:    cmpgt p0.h, p0/z, z2.h, z3.h
; CHECK-NEXT:    mov z0.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z1.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %op2 = load <16 x i16>, ptr %b
  %cmp = icmp sgt <16 x i16> %op1, %op2
  %sext = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %sext, ptr %a
  ret void
}

;
; ICMP SLE
;

define void @icmp_sle_v4i32(ptr %a, ptr %b) {
; CHECK-LABEL: icmp_sle_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr q1, [x1]
; CHECK-NEXT:    cmpge p0.s, p0/z, z1.s, z0.s
; CHECK-NEXT:    mov z0.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i32>, ptr %a
  %op2 = load <4 x i32>, ptr %b
  %cmp = icmp sle <4 x i32> %op1, %op2
  %sext = sext <4 x i1> %cmp to <4 x i32>
  store <4 x i32> %sext, ptr %a
  ret void
}

;
; ICMP SLT
;

define void @icmp_slt_v8i32(ptr %a, ptr %b) {
; CHECK-LABEL: icmp_slt_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    ldp q0, q3, [x1]
; CHECK-NEXT:    ldp q1, q2, [x0]
; CHECK-NEXT:    cmpgt p1.s, p0/z, z0.s, z1.s
; CHECK-NEXT:    cmpgt p0.s, p0/z, z3.s, z2.s
; CHECK-NEXT:    mov z0.s, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z1.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %op2 = load <8 x i32>, ptr %b
  %cmp = icmp slt <8 x i32> %op1, %op2
  %sext = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %sext, ptr %a
  ret void
}

;
; ICMP UGE
;

define void @icmp_uge_v2i64(ptr %a, ptr %b) {
; CHECK-LABEL: icmp_uge_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr q1, [x1]
; CHECK-NEXT:    cmphs p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT:    mov z0.d, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <2 x i64>, ptr %a
  %op2 = load <2 x i64>, ptr %b
  %cmp = icmp uge <2 x i64> %op1, %op2
  %sext = sext <2 x i1> %cmp to <2 x i64>
  store <2 x i64> %sext, ptr %a
  ret void
}

;
; ICMP UGT
;

define void @icmp_ugt_v2i64(ptr %a, ptr %b) {
; CHECK-LABEL: icmp_ugt_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr q1, [x1]
; CHECK-NEXT:    cmphi p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT:    mov z0.d, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <2 x i64>, ptr %a
  %op2 = load <2 x i64>, ptr %b
  %cmp = icmp ugt <2 x i64> %op1, %op2
  %sext = sext <2 x i1> %cmp to <2 x i64>
  store <2 x i64> %sext, ptr %a
  ret void
}

;
; ICMP ULE
;

define void @icmp_ule_v2i64(ptr %a, ptr %b) {
; CHECK-LABEL: icmp_ule_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr q1, [x1]
; CHECK-NEXT:    cmphs p0.d, p0/z, z1.d, z0.d
; CHECK-NEXT:    mov z0.d, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <2 x i64>, ptr %a
  %op2 = load <2 x i64>, ptr %b
  %cmp = icmp ule <2 x i64> %op1, %op2
  %sext = sext <2 x i1> %cmp to <2 x i64>
  store <2 x i64> %sext, ptr %a
  ret void
}

;
; ICMP ULT
;

define void @icmp_ult_v2i64(ptr %a, ptr %b) {
; CHECK-LABEL: icmp_ult_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr q1, [x1]
; CHECK-NEXT:    cmphi p0.d, p0/z, z1.d, z0.d
; CHECK-NEXT:    mov z0.d, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <2 x i64>, ptr %a
  %op2 = load <2 x i64>, ptr %b
  %cmp = icmp ult <2 x i64> %op1, %op2
  %sext = sext <2 x i1> %cmp to <2 x i64>
  store <2 x i64> %sext, ptr %a
  ret void
}
