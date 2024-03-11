; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -passes="print<cost-model>" 2>&1 -disable-output -mtriple=thumbv8m.main-none-eabi | FileCheck %s

define void @get_lane_mask() {
; CHECK-LABEL: 'get_lane_mask'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 192 for instruction: %mask_v16i1_i64 = call <16 x i1> @llvm.get.active.lane.mask.v16i1.i64(i64 undef, i64 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 96 for instruction: %mask_v8i1_i64 = call <8 x i1> @llvm.get.active.lane.mask.v8i1.i64(i64 undef, i64 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %mask_v4i1_i64 = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i64(i64 undef, i64 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %mask_v2i1_i64 = call <2 x i1> @llvm.get.active.lane.mask.v2i1.i64(i64 undef, i64 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 112 for instruction: %mask_v16i1_i32 = call <16 x i1> @llvm.get.active.lane.mask.v16i1.i32(i32 undef, i32 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 56 for instruction: %mask_v8i1_i32 = call <8 x i1> @llvm.get.active.lane.mask.v8i1.i32(i32 undef, i32 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 28 for instruction: %mask_v4i1_i32 = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 undef, i32 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 14 for instruction: %mask_v2i1_i32 = call <2 x i1> @llvm.get.active.lane.mask.v2i1.i32(i32 undef, i32 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 112 for instruction: %mask_v16i1_i16 = call <16 x i1> @llvm.get.active.lane.mask.v16i1.i16(i16 undef, i16 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 56 for instruction: %mask_v8i1_i16 = call <8 x i1> @llvm.get.active.lane.mask.v8i1.i16(i16 undef, i16 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 28 for instruction: %mask_v4i1_i16 = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i16(i16 undef, i16 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 14 for instruction: %mask_v2i1_i16 = call <2 x i1> @llvm.get.active.lane.mask.v2i1.i16(i16 undef, i16 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %mask_v16i1_i64 = call <16 x i1> @llvm.get.active.lane.mask.v16i1.i64(i64 undef, i64 undef)
  %mask_v8i1_i64 = call <8 x i1> @llvm.get.active.lane.mask.v8i1.i64(i64 undef, i64 undef)
  %mask_v4i1_i64 = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i64(i64 undef, i64 undef)
  %mask_v2i1_i64 = call <2 x i1> @llvm.get.active.lane.mask.v2i1.i64(i64 undef, i64 undef)

  %mask_v16i1_i32 = call <16 x i1> @llvm.get.active.lane.mask.v16i1.i32(i32 undef, i32 undef)
  %mask_v8i1_i32 = call <8 x i1> @llvm.get.active.lane.mask.v8i1.i32(i32 undef, i32 undef)
  %mask_v4i1_i32 = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 undef, i32 undef)
  %mask_v2i1_i32 = call <2 x i1> @llvm.get.active.lane.mask.v2i1.i32(i32 undef, i32 undef)

  %mask_v16i1_i16 = call <16 x i1> @llvm.get.active.lane.mask.v16i1.i16(i16 undef, i16 undef)
  %mask_v8i1_i16 = call <8 x i1> @llvm.get.active.lane.mask.v8i1.i16(i16 undef, i16 undef)
  %mask_v4i1_i16 = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i16(i16 undef, i16 undef)
  %mask_v2i1_i16 = call <2 x i1> @llvm.get.active.lane.mask.v2i1.i16(i16 undef, i16 undef)

  ret void
}

declare <16 x i1> @llvm.get.active.lane.mask.v16i1.i64(i64, i64)
declare <8 x i1> @llvm.get.active.lane.mask.v8i1.i64(i64, i64)
declare <4 x i1> @llvm.get.active.lane.mask.v4i1.i64(i64, i64)
declare <2 x i1> @llvm.get.active.lane.mask.v2i1.i64(i64, i64)
declare <16 x i1> @llvm.get.active.lane.mask.v16i1.i32(i32, i32)
declare <8 x i1> @llvm.get.active.lane.mask.v8i1.i32(i32, i32)
declare <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32, i32)
declare <2 x i1> @llvm.get.active.lane.mask.v2i1.i32(i32, i32)
declare <16 x i1> @llvm.get.active.lane.mask.v16i1.i16(i16, i16)
declare <8 x i1> @llvm.get.active.lane.mask.v8i1.i16(i16, i16)
declare <4 x i1> @llvm.get.active.lane.mask.v4i1.i16(i16, i16)
declare <2 x i1> @llvm.get.active.lane.mask.v2i1.i16(i16, i16)
