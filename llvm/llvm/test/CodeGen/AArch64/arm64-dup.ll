; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=arm64-eabi -aarch64-neon-syntax=apple | FileCheck %s --check-prefixes=CHECK,CHECK-SD
; RUN: llc < %s -mtriple=arm64-eabi -aarch64-neon-syntax=apple -global-isel | FileCheck %s --check-prefixes=CHECK,CHECK-GI

define <8 x i8> @v_dup8(i8 %A) nounwind {
; CHECK-LABEL: v_dup8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup.8b v0, w0
; CHECK-NEXT:    ret
  %tmp1 = insertelement <8 x i8> zeroinitializer, i8 %A, i32 0
  %tmp2 = insertelement <8 x i8> %tmp1, i8 %A, i32 1
  %tmp3 = insertelement <8 x i8> %tmp2, i8 %A, i32 2
  %tmp4 = insertelement <8 x i8> %tmp3, i8 %A, i32 3
  %tmp5 = insertelement <8 x i8> %tmp4, i8 %A, i32 4
  %tmp6 = insertelement <8 x i8> %tmp5, i8 %A, i32 5
  %tmp7 = insertelement <8 x i8> %tmp6, i8 %A, i32 6
  %tmp8 = insertelement <8 x i8> %tmp7, i8 %A, i32 7
  ret <8 x i8> %tmp8
}

define <4 x i16> @v_dup16(i16 %A) nounwind {
; CHECK-LABEL: v_dup16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup.4h v0, w0
; CHECK-NEXT:    ret
  %tmp1 = insertelement <4 x i16> zeroinitializer, i16 %A, i32 0
  %tmp2 = insertelement <4 x i16> %tmp1, i16 %A, i32 1
  %tmp3 = insertelement <4 x i16> %tmp2, i16 %A, i32 2
  %tmp4 = insertelement <4 x i16> %tmp3, i16 %A, i32 3
  ret <4 x i16> %tmp4
}

define <2 x i32> @v_dup32(i32 %A) nounwind {
; CHECK-LABEL: v_dup32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup.2s v0, w0
; CHECK-NEXT:    ret
  %tmp1 = insertelement <2 x i32> zeroinitializer, i32 %A, i32 0
  %tmp2 = insertelement <2 x i32> %tmp1, i32 %A, i32 1
  ret <2 x i32> %tmp2
}

define <2 x float> @v_dupfloat(float %A) nounwind {
; CHECK-LABEL: v_dupfloat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $s0 killed $s0 def $q0
; CHECK-NEXT:    dup.2s v0, v0[0]
; CHECK-NEXT:    ret
  %tmp1 = insertelement <2 x float> zeroinitializer, float %A, i32 0
  %tmp2 = insertelement <2 x float> %tmp1, float %A, i32 1
  ret <2 x float> %tmp2
}

define <16 x i8> @v_dupQ8(i8 %A) nounwind {
; CHECK-LABEL: v_dupQ8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup.16b v0, w0
; CHECK-NEXT:    ret
  %tmp1 = insertelement <16 x i8> zeroinitializer, i8 %A, i32 0
  %tmp2 = insertelement <16 x i8> %tmp1, i8 %A, i32 1
  %tmp3 = insertelement <16 x i8> %tmp2, i8 %A, i32 2
  %tmp4 = insertelement <16 x i8> %tmp3, i8 %A, i32 3
  %tmp5 = insertelement <16 x i8> %tmp4, i8 %A, i32 4
  %tmp6 = insertelement <16 x i8> %tmp5, i8 %A, i32 5
  %tmp7 = insertelement <16 x i8> %tmp6, i8 %A, i32 6
  %tmp8 = insertelement <16 x i8> %tmp7, i8 %A, i32 7
  %tmp9 = insertelement <16 x i8> %tmp8, i8 %A, i32 8
  %tmp10 = insertelement <16 x i8> %tmp9, i8 %A, i32 9
  %tmp11 = insertelement <16 x i8> %tmp10, i8 %A, i32 10
  %tmp12 = insertelement <16 x i8> %tmp11, i8 %A, i32 11
  %tmp13 = insertelement <16 x i8> %tmp12, i8 %A, i32 12
  %tmp14 = insertelement <16 x i8> %tmp13, i8 %A, i32 13
  %tmp15 = insertelement <16 x i8> %tmp14, i8 %A, i32 14
  %tmp16 = insertelement <16 x i8> %tmp15, i8 %A, i32 15
  ret <16 x i8> %tmp16
}

define <8 x i16> @v_dupQ16(i16 %A) nounwind {
; CHECK-LABEL: v_dupQ16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup.8h v0, w0
; CHECK-NEXT:    ret
  %tmp1 = insertelement <8 x i16> zeroinitializer, i16 %A, i32 0
  %tmp2 = insertelement <8 x i16> %tmp1, i16 %A, i32 1
  %tmp3 = insertelement <8 x i16> %tmp2, i16 %A, i32 2
  %tmp4 = insertelement <8 x i16> %tmp3, i16 %A, i32 3
  %tmp5 = insertelement <8 x i16> %tmp4, i16 %A, i32 4
  %tmp6 = insertelement <8 x i16> %tmp5, i16 %A, i32 5
  %tmp7 = insertelement <8 x i16> %tmp6, i16 %A, i32 6
  %tmp8 = insertelement <8 x i16> %tmp7, i16 %A, i32 7
  ret <8 x i16> %tmp8
}

define <4 x i32> @v_dupQ32(i32 %A) nounwind {
; CHECK-LABEL: v_dupQ32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup.4s v0, w0
; CHECK-NEXT:    ret
  %tmp1 = insertelement <4 x i32> zeroinitializer, i32 %A, i32 0
  %tmp2 = insertelement <4 x i32> %tmp1, i32 %A, i32 1
  %tmp3 = insertelement <4 x i32> %tmp2, i32 %A, i32 2
  %tmp4 = insertelement <4 x i32> %tmp3, i32 %A, i32 3
  ret <4 x i32> %tmp4
}

define <4 x float> @v_dupQfloat(float %A) nounwind {
; CHECK-LABEL: v_dupQfloat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $s0 killed $s0 def $q0
; CHECK-NEXT:    dup.4s v0, v0[0]
; CHECK-NEXT:    ret
  %tmp1 = insertelement <4 x float> zeroinitializer, float %A, i32 0
  %tmp2 = insertelement <4 x float> %tmp1, float %A, i32 1
  %tmp3 = insertelement <4 x float> %tmp2, float %A, i32 2
  %tmp4 = insertelement <4 x float> %tmp3, float %A, i32 3
  ret <4 x float> %tmp4
}

; Check to make sure it works with shuffles, too.

define <8 x i8> @v_shuffledup8(i8 %A) nounwind {
; CHECK-LABEL: v_shuffledup8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup.8b v0, w0
; CHECK-NEXT:    ret
  %tmp1 = insertelement <8 x i8> undef, i8 %A, i32 0
  %tmp2 = shufflevector <8 x i8> %tmp1, <8 x i8> undef, <8 x i32> zeroinitializer
  ret <8 x i8> %tmp2
}

define <4 x i16> @v_shuffledup16(i16 %A) nounwind {
; CHECK-LABEL: v_shuffledup16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup.4h v0, w0
; CHECK-NEXT:    ret
  %tmp1 = insertelement <4 x i16> undef, i16 %A, i32 0
  %tmp2 = shufflevector <4 x i16> %tmp1, <4 x i16> undef, <4 x i32> zeroinitializer
  ret <4 x i16> %tmp2
}

define <2 x i32> @v_shuffledup32(i32 %A) nounwind {
; CHECK-LABEL: v_shuffledup32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup.2s v0, w0
; CHECK-NEXT:    ret
  %tmp1 = insertelement <2 x i32> undef, i32 %A, i32 0
  %tmp2 = shufflevector <2 x i32> %tmp1, <2 x i32> undef, <2 x i32> zeroinitializer
  ret <2 x i32> %tmp2
}

define <2 x float> @v_shuffledupfloat(float %A) nounwind {
; CHECK-LABEL: v_shuffledupfloat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $s0 killed $s0 def $q0
; CHECK-NEXT:    dup.2s v0, v0[0]
; CHECK-NEXT:    ret
  %tmp1 = insertelement <2 x float> undef, float %A, i32 0
  %tmp2 = shufflevector <2 x float> %tmp1, <2 x float> undef, <2 x i32> zeroinitializer
  ret <2 x float> %tmp2
}

define <16 x i8> @v_shuffledupQ8(i8 %A) nounwind {
; CHECK-LABEL: v_shuffledupQ8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup.16b v0, w0
; CHECK-NEXT:    ret
  %tmp1 = insertelement <16 x i8> undef, i8 %A, i32 0
  %tmp2 = shufflevector <16 x i8> %tmp1, <16 x i8> undef, <16 x i32> zeroinitializer
  ret <16 x i8> %tmp2
}

define <8 x i16> @v_shuffledupQ16(i16 %A) nounwind {
; CHECK-LABEL: v_shuffledupQ16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup.8h v0, w0
; CHECK-NEXT:    ret
  %tmp1 = insertelement <8 x i16> undef, i16 %A, i32 0
  %tmp2 = shufflevector <8 x i16> %tmp1, <8 x i16> undef, <8 x i32> zeroinitializer
  ret <8 x i16> %tmp2
}

define <4 x i32> @v_shuffledupQ32(i32 %A) nounwind {
; CHECK-LABEL: v_shuffledupQ32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup.4s v0, w0
; CHECK-NEXT:    ret
  %tmp1 = insertelement <4 x i32> undef, i32 %A, i32 0
  %tmp2 = shufflevector <4 x i32> %tmp1, <4 x i32> undef, <4 x i32> zeroinitializer
  ret <4 x i32> %tmp2
}

define <4 x float> @v_shuffledupQfloat(float %A) nounwind {
; CHECK-LABEL: v_shuffledupQfloat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $s0 killed $s0 def $q0
; CHECK-NEXT:    dup.4s v0, v0[0]
; CHECK-NEXT:    ret
  %tmp1 = insertelement <4 x float> undef, float %A, i32 0
  %tmp2 = shufflevector <4 x float> %tmp1, <4 x float> undef, <4 x i32> zeroinitializer
  ret <4 x float> %tmp2
}

define <8 x i8> @vduplane8(<8 x i8> %A) nounwind {
; CHECK-LABEL: vduplane8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    dup.8b v0, v0[1]
; CHECK-NEXT:    ret
  %tmp2 = shufflevector <8 x i8> %A, <8 x i8> undef, <8 x i32> < i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1 >
  ret <8 x i8> %tmp2
}

define <4 x i16> @vduplane16(<4 x i16> %A) nounwind {
; CHECK-LABEL: vduplane16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    dup.4h v0, v0[1]
; CHECK-NEXT:    ret
  %tmp2 = shufflevector <4 x i16> %A, <4 x i16> undef, <4 x i32> < i32 1, i32 1, i32 1, i32 1 >
  ret <4 x i16> %tmp2
}

define <2 x i32> @vduplane32(<2 x i32> %A) nounwind {
; CHECK-LABEL: vduplane32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    dup.2s v0, v0[1]
; CHECK-NEXT:    ret
  %tmp2 = shufflevector <2 x i32> %A, <2 x i32> undef, <2 x i32> < i32 1, i32 1 >
  ret <2 x i32> %tmp2
}

define <2 x float> @vduplanefloat(<2 x float> %A) nounwind {
; CHECK-LABEL: vduplanefloat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    dup.2s v0, v0[1]
; CHECK-NEXT:    ret
  %tmp2 = shufflevector <2 x float> %A, <2 x float> undef, <2 x i32> < i32 1, i32 1 >
  ret <2 x float> %tmp2
}

define <16 x i8> @vduplaneQ8(<8 x i8> %A) nounwind {
; CHECK-LABEL: vduplaneQ8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    dup.16b v0, v0[1]
; CHECK-NEXT:    ret
  %tmp2 = shufflevector <8 x i8> %A, <8 x i8> undef, <16 x i32> < i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1 >
  ret <16 x i8> %tmp2
}

define <8 x i16> @vduplaneQ16(<4 x i16> %A) nounwind {
; CHECK-LABEL: vduplaneQ16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    dup.8h v0, v0[1]
; CHECK-NEXT:    ret
  %tmp2 = shufflevector <4 x i16> %A, <4 x i16> undef, <8 x i32> < i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1 >
  ret <8 x i16> %tmp2
}

define <4 x i32> @vduplaneQ32(<2 x i32> %A) nounwind {
; CHECK-LABEL: vduplaneQ32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    dup.4s v0, v0[1]
; CHECK-NEXT:    ret
  %tmp2 = shufflevector <2 x i32> %A, <2 x i32> undef, <4 x i32> < i32 1, i32 1, i32 1, i32 1 >
  ret <4 x i32> %tmp2
}

define <4 x float> @vduplaneQfloat(<2 x float> %A) nounwind {
; CHECK-LABEL: vduplaneQfloat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    dup.4s v0, v0[1]
; CHECK-NEXT:    ret
  %tmp2 = shufflevector <2 x float> %A, <2 x float> undef, <4 x i32> < i32 1, i32 1, i32 1, i32 1 >
  ret <4 x float> %tmp2
}

define <2 x i64> @foo(<2 x i64> %arg0_int64x1_t) nounwind readnone {
; CHECK-LABEL: foo:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    dup.2d v0, v0[1]
; CHECK-NEXT:    ret
entry:
  %0 = shufflevector <2 x i64> %arg0_int64x1_t, <2 x i64> undef, <2 x i32> <i32 1, i32 1>
  ret <2 x i64> %0
}

define <2 x i64> @bar(<2 x i64> %arg0_int64x1_t) nounwind readnone {
; CHECK-LABEL: bar:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    dup.2d v0, v0[0]
; CHECK-NEXT:    ret
entry:
  %0 = shufflevector <2 x i64> %arg0_int64x1_t, <2 x i64> undef, <2 x i32> <i32 0, i32 0>
  ret <2 x i64> %0
}

define <2 x double> @baz(<2 x double> %arg0_int64x1_t) nounwind readnone {
; CHECK-LABEL: baz:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    dup.2d v0, v0[1]
; CHECK-NEXT:    ret
entry:
  %0 = shufflevector <2 x double> %arg0_int64x1_t, <2 x double> undef, <2 x i32> <i32 1, i32 1>
  ret <2 x double> %0
}

define <2 x double> @qux(<2 x double> %arg0_int64x1_t) nounwind readnone {
; CHECK-LABEL: qux:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    dup.2d v0, v0[0]
; CHECK-NEXT:    ret
entry:
  %0 = shufflevector <2 x double> %arg0_int64x1_t, <2 x double> undef, <2 x i32> <i32 0, i32 0>
  ret <2 x double> %0
}

define <2 x i32> @f(i32 %a, i32 %b) nounwind readnone  {
; CHECK-LABEL: f:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s0, w0
; CHECK-NEXT:    mov.s v0[1], w1
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-NEXT:    ret
  %vecinit = insertelement <2 x i32> undef, i32 %a, i32 0
  %vecinit1 = insertelement <2 x i32> %vecinit, i32 %b, i32 1
  ret <2 x i32> %vecinit1
}

define <4 x i32> @g(i32 %a, i32 %b) nounwind readnone  {
; CHECK-LABEL: g:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s0, w0
; CHECK-NEXT:    mov.s v0[1], w1
; CHECK-NEXT:    mov.s v0[2], w1
; CHECK-NEXT:    mov.s v0[3], w0
; CHECK-NEXT:    ret
  %vecinit = insertelement <4 x i32> undef, i32 %a, i32 0
  %vecinit1 = insertelement <4 x i32> %vecinit, i32 %b, i32 1
  %vecinit2 = insertelement <4 x i32> %vecinit1, i32 %b, i32 2
  %vecinit3 = insertelement <4 x i32> %vecinit2, i32 %a, i32 3
  ret <4 x i32> %vecinit3
}

define <2 x i64> @h(i64 %a, i64 %b) nounwind readnone  {
; CHECK-LABEL: h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov d0, x0
; CHECK-NEXT:    mov.d v0[1], x1
; CHECK-NEXT:    ret
  %vecinit = insertelement <2 x i64> undef, i64 %a, i32 0
  %vecinit1 = insertelement <2 x i64> %vecinit, i64 %b, i32 1
  ret <2 x i64> %vecinit1
}

; We used to spot this as a BUILD_VECTOR implementable by dup, but assume that
; the single value needed was of the same type as the vector. This is false if
; the scalar corresponding to the vector type is illegal (e.g. a <4 x i16>
; BUILD_VECTOR will have an i32 as its source). In that case, the operation is
; not a simple "dup vD.4h, vN.h[idx]" after all, and we crashed.
;
; *However*, it is a dup vD.4h, vN.h[2*idx].
define <4 x i16> @test_build_illegal(<4 x i32> %in) {
; CHECK-SD-LABEL: test_build_illegal:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    dup.4h v0, v0[6]
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test_build_illegal:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    mov.h v1[1], v0[0]
; CHECK-GI-NEXT:    mov s0, v0[3]
; CHECK-GI-NEXT:    mov.h v1[2], v0[0]
; CHECK-GI-NEXT:    mov.h v1[3], v0[0]
; CHECK-GI-NEXT:    fmov d0, d1
; CHECK-GI-NEXT:    ret
  %val = extractelement <4 x i32> %in, i32 3
  %smallval = trunc i32 %val to i16
  %vec = insertelement <4x i16> undef, i16 %smallval, i32 3

  ret <4 x i16> %vec
}

; We used to inherit an already extract_subvectored v4i16 from
; SelectionDAGBuilder here. We then added a DUPLANE on top of that, preventing
; the formation of an indexed-by-7 MLS.
define <4 x i16> @test_high_splat(<4 x i16> %a, <4 x i16> %b, <8 x i16> %v) #0 {
; CHECK-SD-LABEL: test_high_splat:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    mls.4h v0, v1, v2[7]
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test_high_splat:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    dup.8h v2, v2[7]
; CHECK-GI-NEXT:    mls.4h v0, v2, v1
; CHECK-GI-NEXT:    ret
entry:
  %shuffle = shufflevector <8 x i16> %v, <8 x i16> undef, <4 x i32> <i32 7, i32 7, i32 7, i32 7>
  %mul = mul <4 x i16> %shuffle, %b
  %sub = sub <4 x i16> %a, %mul
  ret <4 x i16> %sub
}

; Also test the DUP path in the PerfectShuffle generator.

define <4 x i16> @test_perfectshuffle_dupext_v4i16(<4 x i16> %a, <4 x i16> %b) nounwind {
; CHECK-SD-LABEL: test_perfectshuffle_dupext_v4i16:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    trn1.4h v0, v0, v0
; CHECK-SD-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-SD-NEXT:    mov.s v0[1], v1[0]
; CHECK-SD-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test_perfectshuffle_dupext_v4i16:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-GI-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-GI-NEXT:    adrp x8, .LCPI33_0
; CHECK-GI-NEXT:    mov.d v0[1], v1[0]
; CHECK-GI-NEXT:    ldr d1, [x8, :lo12:.LCPI33_0]
; CHECK-GI-NEXT:    tbl.16b v0, { v0 }, v1
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
  %r = shufflevector <4 x i16> %a, <4 x i16> %b, <4 x i32> <i32 0, i32 0, i32 4, i32 5>
  ret <4 x i16> %r
}

define <4 x half> @test_perfectshuffle_dupext_v4f16(<4 x half> %a, <4 x half> %b) nounwind {
; CHECK-SD-LABEL: test_perfectshuffle_dupext_v4f16:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    trn1.4h v0, v0, v0
; CHECK-SD-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-SD-NEXT:    mov.s v0[1], v1[0]
; CHECK-SD-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test_perfectshuffle_dupext_v4f16:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-GI-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-GI-NEXT:    adrp x8, .LCPI34_0
; CHECK-GI-NEXT:    mov.d v0[1], v1[0]
; CHECK-GI-NEXT:    ldr d1, [x8, :lo12:.LCPI34_0]
; CHECK-GI-NEXT:    tbl.16b v0, { v0 }, v1
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
  %r = shufflevector <4 x half> %a, <4 x half> %b, <4 x i32> <i32 0, i32 0, i32 4, i32 5>
  ret <4 x half> %r
}

define <4 x i32> @test_perfectshuffle_dupext_v4i32(<4 x i32> %a, <4 x i32> %b) nounwind {
; CHECK-SD-LABEL: test_perfectshuffle_dupext_v4i32:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    trn1.4s v0, v0, v0
; CHECK-SD-NEXT:    mov.d v0[1], v1[0]
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test_perfectshuffle_dupext_v4i32:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    adrp x8, .LCPI35_0
; CHECK-GI-NEXT:    // kill: def $q0 killed $q0 killed $q0_q1 def $q0_q1
; CHECK-GI-NEXT:    ldr q2, [x8, :lo12:.LCPI35_0]
; CHECK-GI-NEXT:    // kill: def $q1 killed $q1 killed $q0_q1 def $q0_q1
; CHECK-GI-NEXT:    tbl.16b v0, { v0, v1 }, v2
; CHECK-GI-NEXT:    ret
  %r = shufflevector <4 x i32> %a, <4 x i32> %b, <4 x i32> <i32 0, i32 0, i32 4, i32 5>
  ret <4 x i32> %r
}

define <4 x float> @test_perfectshuffle_dupext_v4f32(<4 x float> %a, <4 x float> %b) nounwind {
; CHECK-SD-LABEL: test_perfectshuffle_dupext_v4f32:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    trn1.4s v0, v0, v0
; CHECK-SD-NEXT:    mov.d v0[1], v1[0]
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test_perfectshuffle_dupext_v4f32:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    adrp x8, .LCPI36_0
; CHECK-GI-NEXT:    // kill: def $q0 killed $q0 killed $q0_q1 def $q0_q1
; CHECK-GI-NEXT:    ldr q2, [x8, :lo12:.LCPI36_0]
; CHECK-GI-NEXT:    // kill: def $q1 killed $q1 killed $q0_q1 def $q0_q1
; CHECK-GI-NEXT:    tbl.16b v0, { v0, v1 }, v2
; CHECK-GI-NEXT:    ret
  %r = shufflevector <4 x float> %a, <4 x float> %b, <4 x i32> <i32 0, i32 0, i32 4, i32 5>
  ret <4 x float> %r
}

define void @disguised_dup(<4 x float> %x, ptr %p1, ptr %p2) {
; CHECK-SD-LABEL: disguised_dup:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    ext.16b v1, v0, v0, #4
; CHECK-SD-NEXT:    mov.s v1[2], v0[0]
; CHECK-SD-NEXT:    dup.4s v0, v0[0]
; CHECK-SD-NEXT:    str q1, [x0]
; CHECK-SD-NEXT:    str q0, [x1]
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: disguised_dup:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    adrp x8, .LCPI37_1
; CHECK-GI-NEXT:    // kill: def $q0 killed $q0 def $q0_q1
; CHECK-GI-NEXT:    ldr q2, [x8, :lo12:.LCPI37_1]
; CHECK-GI-NEXT:    adrp x8, .LCPI37_0
; CHECK-GI-NEXT:    tbl.16b v0, { v0, v1 }, v2
; CHECK-GI-NEXT:    ldr q2, [x8, :lo12:.LCPI37_0]
; CHECK-GI-NEXT:    tbl.16b v2, { v0, v1 }, v2
; CHECK-GI-NEXT:    str q0, [x0]
; CHECK-GI-NEXT:    str q2, [x1]
; CHECK-GI-NEXT:    ret
  %shuf = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 1, i32 2, i32 0, i32 0>
  %dup = shufflevector <4 x float> %shuf, <4 x float> undef, <4 x i32> <i32 3, i32 2, i32 2, i32 3>
  store <4 x float> %shuf, ptr %p1, align 8
  store <4 x float> %dup, ptr %p2, align 8
  ret void
}

define <2 x i32> @dup_const2(<2 x i32> %A) nounwind {
; CHECK-SD-LABEL: dup_const2:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    mov w8, #32770 // =0x8002
; CHECK-SD-NEXT:    movk w8, #128, lsl #16
; CHECK-SD-NEXT:    dup.2s v1, w8
; CHECK-SD-NEXT:    add.2s v0, v0, v1
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: dup_const2:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    adrp x8, .LCPI38_0
; CHECK-GI-NEXT:    ldr d1, [x8, :lo12:.LCPI38_0]
; CHECK-GI-NEXT:    add.2s v0, v0, v1
; CHECK-GI-NEXT:    ret
  %tmp2 = add <2 x i32> %A, <i32 8421378, i32 8421378>
  ret <2 x i32> %tmp2
}

define <2 x i32> @dup_const4_ext(<4 x i32> %A) nounwind {
; CHECK-SD-LABEL: dup_const4_ext:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    mov w8, #32769 // =0x8001
; CHECK-SD-NEXT:    movk w8, #128, lsl #16
; CHECK-SD-NEXT:    dup.2s v1, w8
; CHECK-SD-NEXT:    add.2s v0, v0, v1
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: dup_const4_ext:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    adrp x8, .LCPI39_0
; CHECK-GI-NEXT:    ldr q1, [x8, :lo12:.LCPI39_0]
; CHECK-GI-NEXT:    add.4s v0, v0, v1
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
  %tmp1 = add <4 x i32> %A, <i32 8421377, i32 8421377, i32 8421377, i32 8421377>
  %tmp2 = shufflevector <4 x i32> %tmp1, <4 x i32> undef, <2 x i32> <i32 0, i32 1>
  ret <2 x i32> %tmp2
}

define <4 x i32> @dup_const24(<2 x i32> %A, <2 x i32> %B, <4 x i32> %C) nounwind {
; CHECK-SD-LABEL: dup_const24:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    mov w8, #32768 // =0x8000
; CHECK-SD-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-SD-NEXT:    movk w8, #128, lsl #16
; CHECK-SD-NEXT:    dup.4s v3, w8
; CHECK-SD-NEXT:    add.2s v0, v0, v3
; CHECK-SD-NEXT:    mov.d v0[1], v1[0]
; CHECK-SD-NEXT:    add.4s v1, v2, v3
; CHECK-SD-NEXT:    eor.16b v0, v1, v0
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: dup_const24:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    adrp x8, .LCPI40_1
; CHECK-GI-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-GI-NEXT:    ldr d3, [x8, :lo12:.LCPI40_1]
; CHECK-GI-NEXT:    adrp x8, .LCPI40_0
; CHECK-GI-NEXT:    add.2s v0, v0, v3
; CHECK-GI-NEXT:    ldr q3, [x8, :lo12:.LCPI40_0]
; CHECK-GI-NEXT:    mov.d v0[1], v1[0]
; CHECK-GI-NEXT:    add.4s v1, v2, v3
; CHECK-GI-NEXT:    eor.16b v0, v1, v0
; CHECK-GI-NEXT:    ret
  %tmp1 = add <2 x i32> %A, <i32 8421376, i32 8421376>
  %tmp4 = shufflevector <2 x i32> %tmp1, <2 x i32> %B, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %tmp3 = add <4 x i32> %C, <i32 8421376, i32 8421376, i32 8421376, i32 8421376>
  %tmp5 = xor <4 x i32> %tmp3, %tmp4
  ret <4 x i32> %tmp5
}

define <8 x i16> @bitcast_i64_v8i16(i64 %a) {
; CHECK-SD-LABEL: bitcast_i64_v8i16:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    dup.8h v0, w0
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: bitcast_i64_v8i16:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    fmov d0, x0
; CHECK-GI-NEXT:    dup.8h v0, v0[0]
; CHECK-GI-NEXT:    ret
  %b = bitcast i64 %a to <4 x i16>
  %r = shufflevector <4 x i16> %b, <4 x i16> poison, <8 x i32> zeroinitializer
  ret <8 x i16> %r
}

define <8 x i16> @bitcast_i64_v8i16_lane1(i64 %a) {
; CHECK-LABEL: bitcast_i64_v8i16_lane1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov d0, x0
; CHECK-NEXT:    dup.8h v0, v0[1]
; CHECK-NEXT:    ret
  %b = bitcast i64 %a to <4 x i16>
  %r = shufflevector <4 x i16> %b, <4 x i16> poison, <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  ret <8 x i16> %r
}

define <8 x i16> @bitcast_f64_v8i16(double %a) {
; CHECK-LABEL: bitcast_f64_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    dup.8h v0, v0[0]
; CHECK-NEXT:    ret
  %b = bitcast double %a to <4 x i16>
  %r = shufflevector <4 x i16> %b, <4 x i16> poison, <8 x i32> zeroinitializer
  ret <8 x i16> %r
}

define <8 x half> @bitcast_i64_v8f16(i64 %a) {
; CHECK-LABEL: bitcast_i64_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov d0, x0
; CHECK-NEXT:    dup.8h v0, v0[0]
; CHECK-NEXT:    ret
  %b = bitcast i64 %a to <4 x half>
  %r = shufflevector <4 x half> %b, <4 x half> poison, <8 x i32> zeroinitializer
  ret <8 x half> %r
}

define <2 x i64> @bitcast_i64_v2f64(i64 %a) {
; CHECK-SD-LABEL: bitcast_i64_v2f64:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    fmov d0, x0
; CHECK-SD-NEXT:    dup.2d v0, v0[0]
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: bitcast_i64_v2f64:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    dup.2d v0, x0
; CHECK-GI-NEXT:    ret
  %b = bitcast i64 %a to <1 x i64>
  %r = shufflevector <1 x i64> %b, <1 x i64> poison, <2 x i32> zeroinitializer
  ret <2 x i64> %r
}

define <2 x i64> @bitcast_v2f64_v2i64(<2 x double> %a) {
; CHECK-LABEL: bitcast_v2f64_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup.2d v0, v0[0]
; CHECK-NEXT:    ret
  %b = bitcast <2 x double> %a to <2 x i64>
  %r = shufflevector <2 x i64> %b, <2 x i64> poison, <2 x i32> zeroinitializer
  ret <2 x i64> %r
}

define <2 x i64> @bitcast_v8i16_v2i64(<8 x i16> %a) {
; CHECK-LABEL: bitcast_v8i16_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup.2d v0, v0[0]
; CHECK-NEXT:    ret
  %b = bitcast <8 x i16> %a to <2 x i64>
  %r = shufflevector <2 x i64> %b, <2 x i64> poison, <2 x i32> zeroinitializer
  ret <2 x i64> %r
}

define <8 x i16> @bitcast_v2f64_v8i16(<2 x i64> %a) {
; CHECK-LABEL: bitcast_v2f64_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup.8h v0, v0[0]
; CHECK-NEXT:    ret
  %b = bitcast <2 x i64> %a to <8 x i16>
  %r = shufflevector <8 x i16> %b, <8 x i16> poison, <8 x i32> zeroinitializer
  ret <8 x i16> %r
}

