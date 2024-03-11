; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

define ptr @scalar_of_scalable_1(ptr %base) {
; CHECK-LABEL: scalar_of_scalable_1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rdvl x8, #4
; CHECK-NEXT:    add x0, x0, x8
; CHECK-NEXT:    ret
  %d = getelementptr <vscale x 2 x i64>, ptr %base, i64 4
  ret ptr %d
}

define ptr @scalar_of_scalable_2(ptr %base, i64 %offset) {
; CHECK-LABEL: scalar_of_scalable_2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rdvl x8, #1
; CHECK-NEXT:    madd x0, x1, x8, x0
; CHECK-NEXT:    ret
  %d = getelementptr <vscale x 2 x i64>, ptr %base, i64 %offset
  ret ptr %d
}

define ptr @scalar_of_scalable_3(ptr %base, i64 %offset) {
; CHECK-LABEL: scalar_of_scalable_3:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cnth x8
; CHECK-NEXT:    madd x0, x1, x8, x0
; CHECK-NEXT:    ret
  %d = getelementptr <vscale x 2 x i32>, ptr %base, i64 %offset
  ret ptr %d
}

define <2 x ptr> @fixed_of_scalable_1(ptr %base) {
; CHECK-LABEL: fixed_of_scalable_1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rdvl x8, #1
; CHECK-NEXT:    dup v1.2d, x0
; CHECK-NEXT:    dup v0.2d, x8
; CHECK-NEXT:    add v0.2d, v1.2d, v0.2d
; CHECK-NEXT:    ret
  %d = getelementptr <vscale x 2 x i64>, ptr %base, <2 x i64> <i64 1, i64 1>
  ret <2 x ptr> %d
}

define <2 x ptr> @fixed_of_scalable_2(<2 x ptr> %base) {
; CHECK-LABEL: fixed_of_scalable_2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rdvl x8, #1
; CHECK-NEXT:    dup v1.2d, x8
; CHECK-NEXT:    add v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    ret
  %d = getelementptr <vscale x 2 x i64>, <2 x ptr> %base, <2 x i64> <i64 1, i64 1>
  ret <2 x ptr> %d
}

define <vscale x 2 x ptr> @scalable_of_fixed_1(ptr %base) {
; CHECK-LABEL: scalable_of_fixed_1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add x8, x0, #1
; CHECK-NEXT:    mov z0.d, x8
; CHECK-NEXT:    ret
  %idx = shufflevector <vscale x 2 x i64> insertelement (<vscale x 2 x i64> undef, i64 1, i32 0), <vscale x 2 x i64> zeroinitializer, <vscale x 2 x i32> zeroinitializer
  %d = getelementptr i8, ptr %base, <vscale x 2 x i64> %idx
  ret <vscale x 2 x ptr> %d
}

define <vscale x 2 x ptr> @scalable_of_fixed_2(<vscale x 2 x ptr> %base) {
; CHECK-LABEL: scalable_of_fixed_2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add z0.d, z0.d, #1 // =0x1
; CHECK-NEXT:    ret
  %idx = shufflevector <vscale x 2 x i64> insertelement (<vscale x 2 x i64> undef, i64 1, i32 0), <vscale x 2 x i64> zeroinitializer, <vscale x 2 x i32> zeroinitializer
  %d = getelementptr i8, <vscale x 2 x ptr> %base, <vscale x 2 x i64> %idx
  ret <vscale x 2 x ptr> %d
}

define <vscale x 2 x ptr> @scalable_of_fixed_3_i8(ptr %base, <vscale x 2 x i64> %idx) {
; CHECK-LABEL: scalable_of_fixed_3_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.d, x0
; CHECK-NEXT:    add z0.d, z1.d, z0.d
; CHECK-NEXT:    ret
  %d = getelementptr i8, ptr %base, <vscale x 2 x i64> %idx
  ret <vscale x 2 x ptr> %d
}

define <vscale x 2 x ptr> @scalable_of_fixed_3_i16(ptr %base, <vscale x 2 x i64> %idx) {
; CHECK-LABEL: scalable_of_fixed_3_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.d, x0
; CHECK-NEXT:    adr z0.d, [z1.d, z0.d, lsl #1]
; CHECK-NEXT:    ret
  %d = getelementptr i16, ptr %base, <vscale x 2 x i64> %idx
  ret <vscale x 2 x ptr> %d
}

define <vscale x 2 x ptr> @scalable_of_fixed_3_i32(ptr %base, <vscale x 2 x i64> %idx) {
; CHECK-LABEL: scalable_of_fixed_3_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.d, x0
; CHECK-NEXT:    adr z0.d, [z1.d, z0.d, lsl #2]
; CHECK-NEXT:    ret
  %d = getelementptr i32, ptr %base, <vscale x 2 x i64> %idx
  ret <vscale x 2 x ptr> %d
}

define <vscale x 2 x ptr> @scalable_of_fixed_3_i64(ptr %base, <vscale x 2 x i64> %idx) {
; CHECK-LABEL: scalable_of_fixed_3_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.d, x0
; CHECK-NEXT:    adr z0.d, [z1.d, z0.d, lsl #3]
; CHECK-NEXT:    ret
  %d = getelementptr i64, ptr %base, <vscale x 2 x i64> %idx
  ret <vscale x 2 x ptr> %d
}

define <vscale x 2 x ptr> @scalable_of_fixed_4_i8(ptr %base, <vscale x 2 x i32> %idx) {
; CHECK-LABEL: scalable_of_fixed_4_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.d, x0
; CHECK-NEXT:    adr z0.d, [z1.d, z0.d, sxtw]
; CHECK-NEXT:    ret
  %d = getelementptr i8, ptr %base, <vscale x 2 x i32> %idx
  ret <vscale x 2 x ptr> %d
}

define <vscale x 2 x ptr> @scalable_of_fixed_4_i16(ptr %base, <vscale x 2 x i32> %idx) {
; CHECK-LABEL: scalable_of_fixed_4_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.d, x0
; CHECK-NEXT:    adr z0.d, [z1.d, z0.d, sxtw #1]
; CHECK-NEXT:    ret
  %d = getelementptr i16, ptr %base, <vscale x 2 x i32> %idx
  ret <vscale x 2 x ptr> %d
}

define <vscale x 2 x ptr> @scalable_of_fixed_4_i32(ptr %base, <vscale x 2 x i32> %idx) {
; CHECK-LABEL: scalable_of_fixed_4_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.d, x0
; CHECK-NEXT:    adr z0.d, [z1.d, z0.d, sxtw #2]
; CHECK-NEXT:    ret
  %d = getelementptr i32, ptr %base, <vscale x 2 x i32> %idx
  ret <vscale x 2 x ptr> %d
}

define <vscale x 2 x ptr> @scalable_of_fixed_4_i64(ptr %base, <vscale x 2 x i32> %idx) {
; CHECK-LABEL: scalable_of_fixed_4_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.d, x0
; CHECK-NEXT:    adr z0.d, [z1.d, z0.d, sxtw #3]
; CHECK-NEXT:    ret
  %d = getelementptr i64, ptr %base, <vscale x 2 x i32> %idx
  ret <vscale x 2 x ptr> %d
}

define <vscale x 2 x ptr> @scalable_of_fixed_5(ptr %base, <vscale x 2 x i32> %idx) {
; CHECK-LABEL: scalable_of_fixed_5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.d, x0
; CHECK-NEXT:    adr z0.d, [z1.d, z0.d, uxtw]
; CHECK-NEXT:    ret
  %idxZext = zext <vscale x 2 x i32> %idx to <vscale x 2 x i64>
  %d = getelementptr i8, ptr %base, <vscale x 2 x i64> %idxZext
  ret <vscale x 2 x ptr> %d
}

define <vscale x 2 x ptr> @scalable_of_fixed_5_i16(ptr %base, <vscale x 2 x i32> %idx) {
; CHECK-LABEL: scalable_of_fixed_5_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.d, x0
; CHECK-NEXT:    adr z0.d, [z1.d, z0.d, uxtw #1]
; CHECK-NEXT:    ret
  %idxZext = zext <vscale x 2 x i32> %idx to <vscale x 2 x i64>
  %d = getelementptr i16, ptr %base, <vscale x 2 x i64> %idxZext
  ret <vscale x 2 x ptr> %d
}

define <vscale x 2 x ptr> @scalable_of_fixed_5_i32(ptr %base, <vscale x 2 x i32> %idx) {
; CHECK-LABEL: scalable_of_fixed_5_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.d, x0
; CHECK-NEXT:    adr z0.d, [z1.d, z0.d, uxtw #2]
; CHECK-NEXT:    ret
  %idxZext = zext <vscale x 2 x i32> %idx to <vscale x 2 x i64>
  %d = getelementptr i32, ptr %base, <vscale x 2 x i64> %idxZext
  ret <vscale x 2 x ptr> %d
}


define <vscale x 2 x ptr> @scalable_of_fixed_5_i64(ptr %base, <vscale x 2 x i32> %idx) {
; CHECK-LABEL: scalable_of_fixed_5_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.d, x0
; CHECK-NEXT:    adr z0.d, [z1.d, z0.d, uxtw #3]
; CHECK-NEXT:    ret
  %idxZext = zext <vscale x 2 x i32> %idx to <vscale x 2 x i64>
  %d = getelementptr i64, ptr %base, <vscale x 2 x i64> %idxZext
  ret <vscale x 2 x ptr> %d
}

define <vscale x 2 x ptr> @scalable_of_scalable_1(ptr %base) {
; CHECK-LABEL: scalable_of_scalable_1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rdvl x8, #1
; CHECK-NEXT:    add x8, x0, x8
; CHECK-NEXT:    mov z0.d, x8
; CHECK-NEXT:    ret
  %idx = shufflevector <vscale x 2 x i64> insertelement (<vscale x 2 x i64> undef, i64 1, i32 0), <vscale x 2 x i64> zeroinitializer, <vscale x 2 x i32> zeroinitializer
  %d = getelementptr <vscale x 2 x i64>, ptr %base, <vscale x 2 x i64> %idx
  ret <vscale x 2 x ptr> %d
}

define <vscale x 2 x ptr> @scalable_of_scalable_2(<vscale x 2 x ptr> %base) {
; CHECK-LABEL: scalable_of_scalable_2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    incd z0.d, all, mul #8
; CHECK-NEXT:    ret
  %idx = shufflevector <vscale x 2 x i64> insertelement (<vscale x 2 x i64> undef, i64 1, i32 0), <vscale x 2 x i64> zeroinitializer, <vscale x 2 x i32> zeroinitializer
  %d = getelementptr <vscale x 2 x i64>, <vscale x 2 x ptr> %base, <vscale x 2 x i64> %idx
  ret <vscale x 2 x ptr> %d
}

define <vscale x 2 x ptr> @scalable_of_scalable_3(<vscale x 2 x ptr> %base, <vscale x 2 x i32> %idx) {
; CHECK-LABEL: scalable_of_scalable_3:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    rdvl x8, #1
; CHECK-NEXT:    mov z2.d, x8
; CHECK-NEXT:    sxtw z1.d, p0/m, z1.d
; CHECK-NEXT:    mla z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    ret
  %d = getelementptr <vscale x 2 x i64>, <vscale x 2 x ptr> %base, <vscale x 2 x i32> %idx
  ret <vscale x 2 x ptr> %d
}
