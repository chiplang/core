; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve %s -o - | FileCheck %s

define arm_aapcs_vfpcc <16 x i8> @add_ashr_v16i8(<16 x i8> %src1, <16 x i8> %src2) {
; CHECK-LABEL: add_ashr_v16i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.i8 q0, q0, q1
; CHECK-NEXT:    vshr.s8 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = add <16 x i8> %src1, %src2
  %1 = ashr <16 x i8> %0, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  ret <16 x i8> %1
}

define arm_aapcs_vfpcc <8 x i16> @add_ashr_v8i16(<8 x i16> %src1, <8 x i16> %src2) {
; CHECK-LABEL: add_ashr_v8i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.i16 q0, q0, q1
; CHECK-NEXT:    vshr.s16 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = add <8 x i16> %src1, %src2
  %1 = ashr <8 x i16> %0, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  ret <8 x i16> %1
}

define arm_aapcs_vfpcc <4 x i32> @add_ashr_v4i32(<4 x i32> %src1, <4 x i32> %src2) {
; CHECK-LABEL: add_ashr_v4i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vhadd.s32 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %0 = add nsw <4 x i32> %src1, %src2
  %1 = ashr <4 x i32> %0, <i32 1, i32 1, i32 1, i32 1>
  ret <4 x i32> %1
}

define arm_aapcs_vfpcc <16 x i8> @add_lshr_v16i8(<16 x i8> %src1, <16 x i8> %src2) {
; CHECK-LABEL: add_lshr_v16i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.i8 q0, q0, q1
; CHECK-NEXT:    vshr.u8 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = add <16 x i8> %src1, %src2
  %1 = lshr <16 x i8> %0, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  ret <16 x i8> %1
}

define arm_aapcs_vfpcc <8 x i16> @add_lshr_v8i16(<8 x i16> %src1, <8 x i16> %src2) {
; CHECK-LABEL: add_lshr_v8i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.i16 q0, q0, q1
; CHECK-NEXT:    vshr.u16 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = add <8 x i16> %src1, %src2
  %1 = lshr <8 x i16> %0, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  ret <8 x i16> %1
}

define arm_aapcs_vfpcc <4 x i32> @add_lshr_v4i32(<4 x i32> %src1, <4 x i32> %src2) {
; CHECK-LABEL: add_lshr_v4i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.i32 q0, q0, q1
; CHECK-NEXT:    vshr.u32 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = add nsw <4 x i32> %src1, %src2
  %1 = lshr <4 x i32> %0, <i32 1, i32 1, i32 1, i32 1>
  ret <4 x i32> %1
}

define arm_aapcs_vfpcc <16 x i8> @sub_ashr_v16i8(<16 x i8> %src1, <16 x i8> %src2) {
; CHECK-LABEL: sub_ashr_v16i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vsub.i8 q0, q0, q1
; CHECK-NEXT:    vshr.s8 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = sub <16 x i8> %src1, %src2
  %1 = ashr <16 x i8> %0, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  ret <16 x i8> %1
}

define arm_aapcs_vfpcc <8 x i16> @sub_ashr_v8i16(<8 x i16> %src1, <8 x i16> %src2) {
; CHECK-LABEL: sub_ashr_v8i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vsub.i16 q0, q0, q1
; CHECK-NEXT:    vshr.s16 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = sub <8 x i16> %src1, %src2
  %1 = ashr <8 x i16> %0, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  ret <8 x i16> %1
}

define arm_aapcs_vfpcc <4 x i32> @sub_ashr_v4i32(<4 x i32> %src1, <4 x i32> %src2) {
; CHECK-LABEL: sub_ashr_v4i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vhsub.s32 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %0 = sub nsw <4 x i32> %src1, %src2
  %1 = ashr <4 x i32> %0, <i32 1, i32 1, i32 1, i32 1>
  ret <4 x i32> %1
}

define arm_aapcs_vfpcc <16 x i8> @sub_lshr_v16i8(<16 x i8> %src1, <16 x i8> %src2) {
; CHECK-LABEL: sub_lshr_v16i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vsub.i8 q0, q0, q1
; CHECK-NEXT:    vshr.u8 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = sub <16 x i8> %src1, %src2
  %1 = lshr <16 x i8> %0, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  ret <16 x i8> %1
}

define arm_aapcs_vfpcc <8 x i16> @sub_lshr_v8i16(<8 x i16> %src1, <8 x i16> %src2) {
; CHECK-LABEL: sub_lshr_v8i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vsub.i16 q0, q0, q1
; CHECK-NEXT:    vshr.u16 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = sub <8 x i16> %src1, %src2
  %1 = lshr <8 x i16> %0, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  ret <8 x i16> %1
}

define arm_aapcs_vfpcc <4 x i32> @sub_lshr_v4i32(<4 x i32> %src1, <4 x i32> %src2) {
; CHECK-LABEL: sub_lshr_v4i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vsub.i32 q0, q0, q1
; CHECK-NEXT:    vshr.u32 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = sub nsw <4 x i32> %src1, %src2
  %1 = lshr <4 x i32> %0, <i32 1, i32 1, i32 1, i32 1>
  ret <4 x i32> %1
}



define arm_aapcs_vfpcc <16 x i8> @add_sdiv_v16i8(<16 x i8> %src1, <16 x i8> %src2) {
; CHECK-LABEL: add_sdiv_v16i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.i8 q0, q0, q1
; CHECK-NEXT:    vshr.u8 q1, q0, #7
; CHECK-NEXT:    vadd.i8 q0, q0, q1
; CHECK-NEXT:    vshr.s8 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = add <16 x i8> %src1, %src2
  %1 = sdiv <16 x i8> %0, <i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2>
  ret <16 x i8> %1
}

define arm_aapcs_vfpcc <8 x i16> @add_sdiv_v8i16(<8 x i16> %src1, <8 x i16> %src2) {
; CHECK-LABEL: add_sdiv_v8i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.i16 q0, q0, q1
; CHECK-NEXT:    vshr.u16 q1, q0, #15
; CHECK-NEXT:    vadd.i16 q0, q0, q1
; CHECK-NEXT:    vshr.s16 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = add <8 x i16> %src1, %src2
  %1 = sdiv <8 x i16> %0, <i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2>
  ret <8 x i16> %1
}

define arm_aapcs_vfpcc <4 x i32> @add_sdiv_v4i32(<4 x i32> %src1, <4 x i32> %src2) {
; CHECK-LABEL: add_sdiv_v4i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.i32 q0, q0, q1
; CHECK-NEXT:    vshr.u32 q1, q0, #31
; CHECK-NEXT:    vadd.i32 q0, q0, q1
; CHECK-NEXT:    vshr.s32 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = add nsw <4 x i32> %src1, %src2
  %1 = sdiv <4 x i32> %0, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %1
}

define arm_aapcs_vfpcc <16 x i8> @add_udiv_v16i8(<16 x i8> %src1, <16 x i8> %src2) {
; CHECK-LABEL: add_udiv_v16i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.i8 q0, q0, q1
; CHECK-NEXT:    vshr.u8 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = add <16 x i8> %src1, %src2
  %1 = udiv <16 x i8> %0, <i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2>
  ret <16 x i8> %1
}

define arm_aapcs_vfpcc <8 x i16> @add_udiv_v8i16(<8 x i16> %src1, <8 x i16> %src2) {
; CHECK-LABEL: add_udiv_v8i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.i16 q0, q0, q1
; CHECK-NEXT:    vshr.u16 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = add <8 x i16> %src1, %src2
  %1 = udiv <8 x i16> %0, <i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2>
  ret <8 x i16> %1
}

define arm_aapcs_vfpcc <4 x i32> @add_udiv_v4i32(<4 x i32> %src1, <4 x i32> %src2) {
; CHECK-LABEL: add_udiv_v4i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.i32 q0, q0, q1
; CHECK-NEXT:    vshr.u32 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = add nsw <4 x i32> %src1, %src2
  %1 = udiv <4 x i32> %0, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %1
}

define arm_aapcs_vfpcc <16 x i8> @sub_sdiv_v16i8(<16 x i8> %src1, <16 x i8> %src2) {
; CHECK-LABEL: sub_sdiv_v16i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vsub.i8 q0, q0, q1
; CHECK-NEXT:    vshr.u8 q1, q0, #7
; CHECK-NEXT:    vadd.i8 q0, q0, q1
; CHECK-NEXT:    vshr.s8 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = sub <16 x i8> %src1, %src2
  %1 = sdiv <16 x i8> %0, <i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2>
  ret <16 x i8> %1
}

define arm_aapcs_vfpcc <8 x i16> @sub_sdiv_v8i16(<8 x i16> %src1, <8 x i16> %src2) {
; CHECK-LABEL: sub_sdiv_v8i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vsub.i16 q0, q0, q1
; CHECK-NEXT:    vshr.u16 q1, q0, #15
; CHECK-NEXT:    vadd.i16 q0, q0, q1
; CHECK-NEXT:    vshr.s16 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = sub <8 x i16> %src1, %src2
  %1 = sdiv <8 x i16> %0, <i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2>
  ret <8 x i16> %1
}

define arm_aapcs_vfpcc <4 x i32> @sub_sdiv_v4i32(<4 x i32> %src1, <4 x i32> %src2) {
; CHECK-LABEL: sub_sdiv_v4i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vsub.i32 q0, q0, q1
; CHECK-NEXT:    vshr.u32 q1, q0, #31
; CHECK-NEXT:    vadd.i32 q0, q0, q1
; CHECK-NEXT:    vshr.s32 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = sub nsw <4 x i32> %src1, %src2
  %1 = sdiv <4 x i32> %0, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %1
}

define arm_aapcs_vfpcc <16 x i8> @sub_udiv_v16i8(<16 x i8> %src1, <16 x i8> %src2) {
; CHECK-LABEL: sub_udiv_v16i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vsub.i8 q0, q0, q1
; CHECK-NEXT:    vshr.u8 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = sub <16 x i8> %src1, %src2
  %1 = udiv <16 x i8> %0, <i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2>
  ret <16 x i8> %1
}

define arm_aapcs_vfpcc <8 x i16> @sub_udiv_v8i16(<8 x i16> %src1, <8 x i16> %src2) {
; CHECK-LABEL: sub_udiv_v8i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vsub.i16 q0, q0, q1
; CHECK-NEXT:    vshr.u16 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = sub <8 x i16> %src1, %src2
  %1 = udiv <8 x i16> %0, <i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2>
  ret <8 x i16> %1
}

define arm_aapcs_vfpcc <4 x i32> @sub_udiv_v4i32(<4 x i32> %src1, <4 x i32> %src2) {
; CHECK-LABEL: sub_udiv_v4i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vsub.i32 q0, q0, q1
; CHECK-NEXT:    vshr.u32 q0, q0, #1
; CHECK-NEXT:    bx lr
entry:
  %0 = sub nsw <4 x i32> %src1, %src2
  %1 = udiv <4 x i32> %0, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %1
}

