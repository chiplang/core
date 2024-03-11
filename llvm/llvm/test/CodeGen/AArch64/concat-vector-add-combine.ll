; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=aarch64 < %s | FileCheck %s

define i16 @combine_add_16xi16(i16 %a, i16 %b, i16 %c, i16 %d, i16 %e, i16 %f, i16 %g, i16 %h, i16 %i, i16 %j, i16 %k, i16 %l, i16 %m, i16 %n, i16 %o, i16 %p) {
; CHECK-LABEL: combine_add_16xi16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s0, w0
; CHECK-NEXT:    ldr h1, [sp]
; CHECK-NEXT:    add x8, sp, #8
; CHECK-NEXT:    ld1 { v1.h }[1], [x8]
; CHECK-NEXT:    add x8, sp, #16
; CHECK-NEXT:    mov v0.h[1], w1
; CHECK-NEXT:    ld1 { v1.h }[2], [x8]
; CHECK-NEXT:    add x8, sp, #24
; CHECK-NEXT:    mov v0.h[2], w2
; CHECK-NEXT:    ld1 { v1.h }[3], [x8]
; CHECK-NEXT:    add x8, sp, #32
; CHECK-NEXT:    mov v0.h[3], w3
; CHECK-NEXT:    ld1 { v1.h }[4], [x8]
; CHECK-NEXT:    add x8, sp, #40
; CHECK-NEXT:    ld1 { v1.h }[5], [x8]
; CHECK-NEXT:    add x8, sp, #48
; CHECK-NEXT:    mov v0.h[4], w4
; CHECK-NEXT:    ld1 { v1.h }[6], [x8]
; CHECK-NEXT:    add x8, sp, #56
; CHECK-NEXT:    mov v0.h[5], w5
; CHECK-NEXT:    ld1 { v1.h }[7], [x8]
; CHECK-NEXT:    mov v0.h[6], w6
; CHECK-NEXT:    mov v0.h[7], w7
; CHECK-NEXT:    uzp2 v2.16b, v0.16b, v1.16b
; CHECK-NEXT:    uzp1 v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    uhadd v0.16b, v0.16b, v2.16b
; CHECK-NEXT:    uaddlv h0, v0.16b
; CHECK-NEXT:    umov w0, v0.h[0]
; CHECK-NEXT:    ret
  %a1 = insertelement <16 x i16> poison, i16 %a, i16 0
  %b1 = insertelement <16 x i16> %a1, i16 %b, i16 1
  %c1 = insertelement <16 x i16> %b1, i16 %c, i16 2
  %d1 = insertelement <16 x i16> %c1, i16 %d, i16 3
  %e1 = insertelement <16 x i16> %d1, i16 %e, i16 4
  %f1 = insertelement <16 x i16> %e1, i16 %f, i16 5
  %g1 = insertelement <16 x i16> %f1, i16 %g, i16 6
  %h1 = insertelement <16 x i16> %g1, i16 %h, i16 7
  %i1 = insertelement <16 x i16> %h1, i16 %i, i16 8
  %j1 = insertelement <16 x i16> %i1, i16 %j, i16 9
  %k1 = insertelement <16 x i16> %j1, i16 %k, i16 10
  %l1 = insertelement <16 x i16> %k1, i16 %l, i16 11
  %m1 = insertelement <16 x i16> %l1, i16 %m, i16 12
  %n1 = insertelement <16 x i16> %m1, i16 %n, i16 13
  %o1 = insertelement <16 x i16> %n1, i16 %o, i16 14
  %p1 = insertelement <16 x i16> %o1, i16 %p, i16 15
  %x = and <16 x i16> %p1, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  %sh1 = lshr <16 x i16> %p1, <i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8>
  %s = add nuw nsw <16 x i16> %x, %sh1
  %sh2 = lshr <16 x i16> %s, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %res = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> %sh2)
  ret i16 %res
}

define i32 @combine_add_8xi32(i32 %a, i32 %b, i32 %c, i32 %d, i32 %e, i32 %f, i32 %g, i32 %h) local_unnamed_addr #0 {
; CHECK-LABEL: combine_add_8xi32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s0, w4
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    mov v0.s[1], w5
; CHECK-NEXT:    mov v1.s[1], w1
; CHECK-NEXT:    mov v0.s[2], w6
; CHECK-NEXT:    mov v1.s[2], w2
; CHECK-NEXT:    mov v0.s[3], w7
; CHECK-NEXT:    mov v1.s[3], w3
; CHECK-NEXT:    uzp2 v2.8h, v1.8h, v0.8h
; CHECK-NEXT:    uzp1 v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    uhadd v0.8h, v0.8h, v2.8h
; CHECK-NEXT:    uaddlv s0, v0.8h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %a1 = insertelement <8 x i32> poison, i32 %a, i32 0
  %b1 = insertelement <8 x i32> %a1, i32 %b, i32 1
  %c1 = insertelement <8 x i32> %b1, i32 %c, i32 2
  %d1 = insertelement <8 x i32> %c1, i32 %d, i32 3
  %e1 = insertelement <8 x i32> %d1, i32 %e, i32 4
  %f1 = insertelement <8 x i32> %e1, i32 %f, i32 5
  %g1 = insertelement <8 x i32> %f1, i32 %g, i32 6
  %h1 = insertelement <8 x i32> %g1, i32 %h, i32 7
  %x = and <8 x i32> %h1, <i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535>
  %sh1 = lshr <8 x i32> %h1, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %s = add nuw nsw <8 x i32> %x, %sh1
  %sh2 = lshr <8 x i32> %s, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %res = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %sh2)
  ret i32 %res
}

define i32 @combine_undef_add_8xi32(i32 %a, i32 %b, i32 %c, i32 %d) local_unnamed_addr #0 {
; CHECK-LABEL: combine_undef_add_8xi32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov v1.s[1], w1
; CHECK-NEXT:    uhadd v0.4h, v0.4h, v0.4h
; CHECK-NEXT:    mov v1.s[2], w2
; CHECK-NEXT:    mov v1.s[3], w3
; CHECK-NEXT:    xtn v2.4h, v1.4s
; CHECK-NEXT:    shrn v1.4h, v1.4s, #16
; CHECK-NEXT:    uhadd v1.4h, v2.4h, v1.4h
; CHECK-NEXT:    mov v1.d[1], v0.d[0]
; CHECK-NEXT:    uaddlv s0, v1.8h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %a1 = insertelement <8 x i32> poison, i32 %a, i32 0
  %b1 = insertelement <8 x i32> %a1, i32 %b, i32 1
  %c1 = insertelement <8 x i32> %b1, i32 %c, i32 2
  %d1 = insertelement <8 x i32> %c1, i32 %d, i32 3
  %e1 = insertelement <8 x i32> %d1, i32 undef, i32 4
  %f1 = insertelement <8 x i32> %e1, i32 undef, i32 5
  %g1 = insertelement <8 x i32> %f1, i32 undef, i32 6
  %h1 = insertelement <8 x i32> %g1, i32 undef, i32 7
  %x = and <8 x i32> %h1, <i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535>
  %sh1 = lshr <8 x i32> %h1, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %s = add nuw nsw <8 x i32> %x, %sh1
  %sh2 = lshr <8 x i32> %s, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %res = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %sh2)
  ret i32 %res
}

define i64 @combine_add_4xi64(i64 %a, i64 %b, i64 %c, i64 %d) local_unnamed_addr #0 {
; CHECK-LABEL: combine_add_4xi64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov d0, x2
; CHECK-NEXT:    fmov d1, x0
; CHECK-NEXT:    mov v0.d[1], x3
; CHECK-NEXT:    mov v1.d[1], x1
; CHECK-NEXT:    uzp2 v2.4s, v1.4s, v0.4s
; CHECK-NEXT:    uzp1 v0.4s, v1.4s, v0.4s
; CHECK-NEXT:    uhadd v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    uaddlv d0, v0.4s
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
  %a1 = insertelement <4 x i64> poison, i64 %a, i64 0
  %b1 = insertelement <4 x i64> %a1, i64 %b, i64 1
  %c1 = insertelement <4 x i64> %b1, i64 %c, i64 2
  %d1 = insertelement <4 x i64> %c1, i64 %d, i64 3
  %x = and <4 x i64> %d1, <i64 4294967295, i64 4294967295, i64 4294967295, i64 4294967295>
  %sh1 = lshr <4 x i64> %d1, <i64 32, i64 32, i64 32, i64 32>
  %s = add nuw nsw <4 x i64> %x, %sh1
  %sh2 = lshr <4 x i64> %s, <i64 1, i64 1, i64 1, i64 1>
  %res = call i64 @llvm.vector.reduce.add.v4i64(<4 x i64> %sh2)
  ret i64 %res
}

declare i16 @llvm.vector.reduce.add.v16i16(<16 x i16>)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>)
declare i64 @llvm.vector.reduce.add.v4i64(<4 x i64>)
