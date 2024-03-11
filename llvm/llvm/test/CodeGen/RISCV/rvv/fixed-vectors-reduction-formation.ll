; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v,+m,+zbb -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+v,+m,+zbb -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64

define i32 @reduce_sum_2xi32(<2 x i32> %v) {
; CHECK-LABEL: reduce_sum_2xi32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vmv.s.x v9, zero
; CHECK-NEXT:    vredsum.vs v8, v8, v9
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %e0 = extractelement <2 x i32> %v, i32 0
  %e1 = extractelement <2 x i32> %v, i32 1
  %add0 = add i32 %e0, %e1
  ret i32 %add0
}

define i32 @reduce_sum_4xi32(<4 x i32> %v) {
; CHECK-LABEL: reduce_sum_4xi32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v9, zero
; CHECK-NEXT:    vredsum.vs v8, v8, v9
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %e0 = extractelement <4 x i32> %v, i32 0
  %e1 = extractelement <4 x i32> %v, i32 1
  %e2 = extractelement <4 x i32> %v, i32 2
  %e3 = extractelement <4 x i32> %v, i32 3
  %add0 = add i32 %e0, %e1
  %add1 = add i32 %add0, %e2
  %add2 = add i32 %add1, %e3
  ret i32 %add2
}

define i32 @reduce_sum_8xi32(<8 x i32> %v) {
; CHECK-LABEL: reduce_sum_8xi32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vmv.s.x v10, zero
; CHECK-NEXT:    vredsum.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %e0 = extractelement <8 x i32> %v, i32 0
  %e1 = extractelement <8 x i32> %v, i32 1
  %e2 = extractelement <8 x i32> %v, i32 2
  %e3 = extractelement <8 x i32> %v, i32 3
  %e4 = extractelement <8 x i32> %v, i32 4
  %e5 = extractelement <8 x i32> %v, i32 5
  %e6 = extractelement <8 x i32> %v, i32 6
  %e7 = extractelement <8 x i32> %v, i32 7
  %add0 = add i32 %e0, %e1
  %add1 = add i32 %add0, %e2
  %add2 = add i32 %add1, %e3
  %add3 = add i32 %add2, %e4
  %add4 = add i32 %add3, %e5
  %add5 = add i32 %add4, %e6
  %add6 = add i32 %add5, %e7
  ret i32 %add6
}

define i32 @reduce_sum_16xi32(<16 x i32> %v) {
; CHECK-LABEL: reduce_sum_16xi32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vmv.s.x v12, zero
; CHECK-NEXT:    vredsum.vs v8, v8, v12
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %e2 = extractelement <16 x i32> %v, i32 2
  %e3 = extractelement <16 x i32> %v, i32 3
  %e4 = extractelement <16 x i32> %v, i32 4
  %e5 = extractelement <16 x i32> %v, i32 5
  %e6 = extractelement <16 x i32> %v, i32 6
  %e7 = extractelement <16 x i32> %v, i32 7
  %e8 = extractelement <16 x i32> %v, i32 8
  %e9 = extractelement <16 x i32> %v, i32 9
  %e10 = extractelement <16 x i32> %v, i32 10
  %e11 = extractelement <16 x i32> %v, i32 11
  %e12 = extractelement <16 x i32> %v, i32 12
  %e13 = extractelement <16 x i32> %v, i32 13
  %e14 = extractelement <16 x i32> %v, i32 14
  %e15 = extractelement <16 x i32> %v, i32 15
  %add0 = add i32 %e0, %e1
  %add1 = add i32 %add0, %e2
  %add2 = add i32 %add1, %e3
  %add3 = add i32 %add2, %e4
  %add4 = add i32 %add3, %e5
  %add5 = add i32 %add4, %e6
  %add6 = add i32 %add5, %e7
  %add7 = add i32 %add6, %e8
  %add8 = add i32 %add7, %e9
  %add9 = add i32 %add8, %e10
  %add10 = add i32 %add9, %e11
  %add11 = add i32 %add10, %e12
  %add12 = add i32 %add11, %e13
  %add13 = add i32 %add12, %e14
  %add14 = add i32 %add13, %e15
  ret i32 %add14
}

define i32 @reduce_sum_16xi32_prefix2(ptr %p) {
; CHECK-LABEL: reduce_sum_16xi32_prefix2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmv.s.x v9, zero
; CHECK-NEXT:    vredsum.vs v8, v8, v9
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %add0 = add i32 %e0, %e1
  ret i32 %add0
}

define i32 @reduce_sum_16xi32_prefix3(ptr %p) {
; CHECK-LABEL: reduce_sum_16xi32_prefix3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmv.s.x v9, zero
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    vredsum.vs v8, v8, v9
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %e2 = extractelement <16 x i32> %v, i32 2
  %add0 = add i32 %e0, %e1
  %add1 = add i32 %add0, %e2
  ret i32 %add1
}

define i32 @reduce_sum_16xi32_prefix4(ptr %p) {
; CHECK-LABEL: reduce_sum_16xi32_prefix4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmv.s.x v9, zero
; CHECK-NEXT:    vredsum.vs v8, v8, v9
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %e2 = extractelement <16 x i32> %v, i32 2
  %e3 = extractelement <16 x i32> %v, i32 3
  %add0 = add i32 %e0, %e1
  %add1 = add i32 %add0, %e2
  %add2 = add i32 %add1, %e3
  ret i32 %add2
}

define i32 @reduce_sum_16xi32_prefix5(ptr %p) {
; CHECK-LABEL: reduce_sum_16xi32_prefix5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 224
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.s.x v0, a1
; CHECK-NEXT:    vmv.v.i v8, -1
; CHECK-NEXT:    vmerge.vim v8, v8, 0, v0
; CHECK-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v10, (a0)
; CHECK-NEXT:    vsext.vf4 v12, v8
; CHECK-NEXT:    vand.vv v8, v10, v12
; CHECK-NEXT:    vmv.s.x v10, zero
; CHECK-NEXT:    vredsum.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %e2 = extractelement <16 x i32> %v, i32 2
  %e3 = extractelement <16 x i32> %v, i32 3
  %e4 = extractelement <16 x i32> %v, i32 4
  %add0 = add i32 %e0, %e1
  %add1 = add i32 %add0, %e2
  %add2 = add i32 %add1, %e3
  %add3 = add i32 %add2, %e4
  ret i32 %add3
}

define i32 @reduce_sum_16xi32_prefix6(ptr %p) {
; CHECK-LABEL: reduce_sum_16xi32_prefix6:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 192
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.s.x v0, a1
; CHECK-NEXT:    vmv.v.i v8, -1
; CHECK-NEXT:    vmerge.vim v8, v8, 0, v0
; CHECK-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v10, (a0)
; CHECK-NEXT:    vsext.vf4 v12, v8
; CHECK-NEXT:    vand.vv v8, v10, v12
; CHECK-NEXT:    vmv.s.x v10, zero
; CHECK-NEXT:    vredsum.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %e2 = extractelement <16 x i32> %v, i32 2
  %e3 = extractelement <16 x i32> %v, i32 3
  %e4 = extractelement <16 x i32> %v, i32 4
  %e5 = extractelement <16 x i32> %v, i32 5
  %add0 = add i32 %e0, %e1
  %add1 = add i32 %add0, %e2
  %add2 = add i32 %add1, %e3
  %add3 = add i32 %add2, %e4
  %add4 = add i32 %add3, %e5
  ret i32 %add4
}

define i32 @reduce_sum_16xi32_prefix7(ptr %p) {
; CHECK-LABEL: reduce_sum_16xi32_prefix7:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmv.s.x v10, zero
; CHECK-NEXT:    vslideup.vi v8, v10, 7
; CHECK-NEXT:    vredsum.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %e2 = extractelement <16 x i32> %v, i32 2
  %e3 = extractelement <16 x i32> %v, i32 3
  %e4 = extractelement <16 x i32> %v, i32 4
  %e5 = extractelement <16 x i32> %v, i32 5
  %e6 = extractelement <16 x i32> %v, i32 6
  %add0 = add i32 %e0, %e1
  %add1 = add i32 %add0, %e2
  %add2 = add i32 %add1, %e3
  %add3 = add i32 %add2, %e4
  %add4 = add i32 %add3, %e5
  %add5 = add i32 %add4, %e6
  ret i32 %add5
}

define i32 @reduce_sum_16xi32_prefix8(ptr %p) {
; CHECK-LABEL: reduce_sum_16xi32_prefix8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmv.s.x v10, zero
; CHECK-NEXT:    vredsum.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %e2 = extractelement <16 x i32> %v, i32 2
  %e3 = extractelement <16 x i32> %v, i32 3
  %e4 = extractelement <16 x i32> %v, i32 4
  %e5 = extractelement <16 x i32> %v, i32 5
  %e6 = extractelement <16 x i32> %v, i32 6
  %e7 = extractelement <16 x i32> %v, i32 7
  %add0 = add i32 %e0, %e1
  %add1 = add i32 %add0, %e2
  %add2 = add i32 %add1, %e3
  %add3 = add i32 %add2, %e4
  %add4 = add i32 %add3, %e5
  %add5 = add i32 %add4, %e6
  %add6 = add i32 %add5, %e7
  ret i32 %add6
}

define i32 @reduce_sum_16xi32_prefix9(ptr %p) {
; CHECK-LABEL: reduce_sum_16xi32_prefix9:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    li a0, -512
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetvli zero, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v12, -1
; CHECK-NEXT:    vmerge.vim v12, v12, 0, v0
; CHECK-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; CHECK-NEXT:    vsext.vf4 v16, v12
; CHECK-NEXT:    vand.vv v8, v8, v16
; CHECK-NEXT:    vmv.s.x v12, zero
; CHECK-NEXT:    vredsum.vs v8, v8, v12
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %e2 = extractelement <16 x i32> %v, i32 2
  %e3 = extractelement <16 x i32> %v, i32 3
  %e4 = extractelement <16 x i32> %v, i32 4
  %e5 = extractelement <16 x i32> %v, i32 5
  %e6 = extractelement <16 x i32> %v, i32 6
  %e7 = extractelement <16 x i32> %v, i32 7
  %e8 = extractelement <16 x i32> %v, i32 8
  %add0 = add i32 %e0, %e1
  %add1 = add i32 %add0, %e2
  %add2 = add i32 %add1, %e3
  %add3 = add i32 %add2, %e4
  %add4 = add i32 %add3, %e5
  %add5 = add i32 %add4, %e6
  %add6 = add i32 %add5, %e7
  %add7 = add i32 %add6, %e8
  ret i32 %add7
}

define i32 @reduce_sum_16xi32_prefix13(ptr %p) {
; CHECK-LABEL: reduce_sum_16xi32_prefix13:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    lui a0, 14
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetvli zero, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v12, -1
; CHECK-NEXT:    vmerge.vim v12, v12, 0, v0
; CHECK-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; CHECK-NEXT:    vsext.vf4 v16, v12
; CHECK-NEXT:    vand.vv v8, v8, v16
; CHECK-NEXT:    vmv.s.x v12, zero
; CHECK-NEXT:    vredsum.vs v8, v8, v12
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %e2 = extractelement <16 x i32> %v, i32 2
  %e3 = extractelement <16 x i32> %v, i32 3
  %e4 = extractelement <16 x i32> %v, i32 4
  %e5 = extractelement <16 x i32> %v, i32 5
  %e6 = extractelement <16 x i32> %v, i32 6
  %e7 = extractelement <16 x i32> %v, i32 7
  %e8 = extractelement <16 x i32> %v, i32 8
  %e9 = extractelement <16 x i32> %v, i32 9
  %e10 = extractelement <16 x i32> %v, i32 10
  %e11 = extractelement <16 x i32> %v, i32 11
  %e12 = extractelement <16 x i32> %v, i32 12
  %add0 = add i32 %e0, %e1
  %add1 = add i32 %add0, %e2
  %add2 = add i32 %add1, %e3
  %add3 = add i32 %add2, %e4
  %add4 = add i32 %add3, %e5
  %add5 = add i32 %add4, %e6
  %add6 = add i32 %add5, %e7
  %add7 = add i32 %add6, %e8
  %add8 = add i32 %add7, %e9
  %add9 = add i32 %add8, %e10
  %add10 = add i32 %add9, %e11
  %add11 = add i32 %add10, %e12
  ret i32 %add11
}


define i32 @reduce_sum_16xi32_prefix14(ptr %p) {
; CHECK-LABEL: reduce_sum_16xi32_prefix14:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    lui a0, 12
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetvli zero, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v12, -1
; CHECK-NEXT:    vmerge.vim v12, v12, 0, v0
; CHECK-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; CHECK-NEXT:    vsext.vf4 v16, v12
; CHECK-NEXT:    vand.vv v8, v8, v16
; CHECK-NEXT:    vmv.s.x v12, zero
; CHECK-NEXT:    vredsum.vs v8, v8, v12
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %e2 = extractelement <16 x i32> %v, i32 2
  %e3 = extractelement <16 x i32> %v, i32 3
  %e4 = extractelement <16 x i32> %v, i32 4
  %e5 = extractelement <16 x i32> %v, i32 5
  %e6 = extractelement <16 x i32> %v, i32 6
  %e7 = extractelement <16 x i32> %v, i32 7
  %e8 = extractelement <16 x i32> %v, i32 8
  %e9 = extractelement <16 x i32> %v, i32 9
  %e10 = extractelement <16 x i32> %v, i32 10
  %e11 = extractelement <16 x i32> %v, i32 11
  %e12 = extractelement <16 x i32> %v, i32 12
  %e13 = extractelement <16 x i32> %v, i32 13
  %add0 = add i32 %e0, %e1
  %add1 = add i32 %add0, %e2
  %add2 = add i32 %add1, %e3
  %add3 = add i32 %add2, %e4
  %add4 = add i32 %add3, %e5
  %add5 = add i32 %add4, %e6
  %add6 = add i32 %add5, %e7
  %add7 = add i32 %add6, %e8
  %add8 = add i32 %add7, %e9
  %add9 = add i32 %add8, %e10
  %add10 = add i32 %add9, %e11
  %add11 = add i32 %add10, %e12
  %add12 = add i32 %add11, %e13
  ret i32 %add12
}

define i32 @reduce_sum_16xi32_prefix15(ptr %p) {
; CHECK-LABEL: reduce_sum_16xi32_prefix15:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmv.s.x v12, zero
; CHECK-NEXT:    vslideup.vi v8, v12, 15
; CHECK-NEXT:    vredsum.vs v8, v8, v12
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %e2 = extractelement <16 x i32> %v, i32 2
  %e3 = extractelement <16 x i32> %v, i32 3
  %e4 = extractelement <16 x i32> %v, i32 4
  %e5 = extractelement <16 x i32> %v, i32 5
  %e6 = extractelement <16 x i32> %v, i32 6
  %e7 = extractelement <16 x i32> %v, i32 7
  %e8 = extractelement <16 x i32> %v, i32 8
  %e9 = extractelement <16 x i32> %v, i32 9
  %e10 = extractelement <16 x i32> %v, i32 10
  %e11 = extractelement <16 x i32> %v, i32 11
  %e12 = extractelement <16 x i32> %v, i32 12
  %e13 = extractelement <16 x i32> %v, i32 13
  %e14 = extractelement <16 x i32> %v, i32 14
  %add0 = add i32 %e0, %e1
  %add1 = add i32 %add0, %e2
  %add2 = add i32 %add1, %e3
  %add3 = add i32 %add2, %e4
  %add4 = add i32 %add3, %e5
  %add5 = add i32 %add4, %e6
  %add6 = add i32 %add5, %e7
  %add7 = add i32 %add6, %e8
  %add8 = add i32 %add7, %e9
  %add9 = add i32 %add8, %e10
  %add10 = add i32 %add9, %e11
  %add11 = add i32 %add10, %e12
  %add12 = add i32 %add11, %e13
  %add13 = add i32 %add12, %e14
  ret i32 %add13
}

; Check that we can match with the operand ordered reversed, but the
; reduction order unchanged.
define i32 @reduce_sum_4xi32_op_order(<4 x i32> %v) {
; CHECK-LABEL: reduce_sum_4xi32_op_order:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v9, zero
; CHECK-NEXT:    vredsum.vs v8, v8, v9
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %e0 = extractelement <4 x i32> %v, i32 0
  %e1 = extractelement <4 x i32> %v, i32 1
  %e2 = extractelement <4 x i32> %v, i32 2
  %e3 = extractelement <4 x i32> %v, i32 3
  %add0 = add i32 %e1, %e0
  %add1 = add i32 %e2, %add0
  %add2 = add i32 %add1, %e3
  ret i32 %add2
}

; Negative test - Reduction order isn't compatibile with current
; incremental matching scheme.
define i32 @reduce_sum_4xi32_reduce_order(<4 x i32> %v) {
; RV32-LABEL: reduce_sum_4xi32_reduce_order:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; RV32-NEXT:    vmv.x.s a0, v8
; RV32-NEXT:    vslidedown.vi v9, v8, 1
; RV32-NEXT:    vmv.x.s a1, v9
; RV32-NEXT:    vslidedown.vi v9, v8, 2
; RV32-NEXT:    vmv.x.s a2, v9
; RV32-NEXT:    vslidedown.vi v8, v8, 3
; RV32-NEXT:    vmv.x.s a3, v8
; RV32-NEXT:    add a1, a1, a2
; RV32-NEXT:    add a0, a0, a3
; RV32-NEXT:    add a0, a0, a1
; RV32-NEXT:    ret
;
; RV64-LABEL: reduce_sum_4xi32_reduce_order:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; RV64-NEXT:    vmv.x.s a0, v8
; RV64-NEXT:    vslidedown.vi v9, v8, 1
; RV64-NEXT:    vmv.x.s a1, v9
; RV64-NEXT:    vslidedown.vi v9, v8, 2
; RV64-NEXT:    vmv.x.s a2, v9
; RV64-NEXT:    vslidedown.vi v8, v8, 3
; RV64-NEXT:    vmv.x.s a3, v8
; RV64-NEXT:    add a1, a1, a2
; RV64-NEXT:    add a0, a0, a3
; RV64-NEXT:    addw a0, a0, a1
; RV64-NEXT:    ret
  %e0 = extractelement <4 x i32> %v, i32 0
  %e1 = extractelement <4 x i32> %v, i32 1
  %e2 = extractelement <4 x i32> %v, i32 2
  %e3 = extractelement <4 x i32> %v, i32 3
  %add0 = add i32 %e1, %e2
  %add1 = add i32 %e0, %add0
  %add2 = add i32 %add1, %e3
  ret i32 %add2
}

;; Most of the cornercases are exercised above, the following just
;; makes sure that other opcodes work as expected.

define i32 @reduce_xor_16xi32_prefix2(ptr %p) {
; CHECK-LABEL: reduce_xor_16xi32_prefix2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmv.s.x v9, zero
; CHECK-NEXT:    vredxor.vs v8, v8, v9
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %xor0 = xor i32 %e0, %e1
  ret i32 %xor0
}

define i32 @reduce_xor_16xi32_prefix5(ptr %p) {
; CHECK-LABEL: reduce_xor_16xi32_prefix5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 224
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.s.x v0, a1
; CHECK-NEXT:    vmv.v.i v8, -1
; CHECK-NEXT:    vmerge.vim v8, v8, 0, v0
; CHECK-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v10, (a0)
; CHECK-NEXT:    vsext.vf4 v12, v8
; CHECK-NEXT:    vand.vv v8, v10, v12
; CHECK-NEXT:    vmv.s.x v10, zero
; CHECK-NEXT:    vredxor.vs v8, v8, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %e2 = extractelement <16 x i32> %v, i32 2
  %e3 = extractelement <16 x i32> %v, i32 3
  %e4 = extractelement <16 x i32> %v, i32 4
  %xor0 = xor i32 %e0, %e1
  %xor1 = xor i32 %xor0, %e2
  %xor2 = xor i32 %xor1, %e3
  %xor3 = xor i32 %xor2, %e4
  ret i32 %xor3
}

define i32 @reduce_and_16xi32_prefix2(ptr %p) {
; CHECK-LABEL: reduce_and_16xi32_prefix2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vredand.vs v8, v8, v8
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %and0 = and i32 %e0, %e1
  ret i32 %and0
}

define i32 @reduce_and_16xi32_prefix5(ptr %p) {
; CHECK-LABEL: reduce_and_16xi32_prefix5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v8, -1
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v10, (a0)
; CHECK-NEXT:    vsetivli zero, 6, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v10, v8, 5
; CHECK-NEXT:    vsetivli zero, 7, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v10, v8, 6
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vslideup.vi v10, v8, 7
; CHECK-NEXT:    vredand.vs v8, v10, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %e2 = extractelement <16 x i32> %v, i32 2
  %e3 = extractelement <16 x i32> %v, i32 3
  %e4 = extractelement <16 x i32> %v, i32 4
  %and0 = and i32 %e0, %e1
  %and1 = and i32 %and0, %e2
  %and2 = and i32 %and1, %e3
  %and3 = and i32 %and2, %e4
  ret i32 %and3
}

define i32 @reduce_or_16xi32_prefix2(ptr %p) {
; CHECK-LABEL: reduce_or_16xi32_prefix2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vredor.vs v8, v8, v8
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %or0 = or i32 %e0, %e1
  ret i32 %or0
}

define i32 @reduce_or_16xi32_prefix5(ptr %p) {
; CHECK-LABEL: reduce_or_16xi32_prefix5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 224
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.s.x v0, a1
; CHECK-NEXT:    vmv.v.i v8, -1
; CHECK-NEXT:    vmerge.vim v8, v8, 0, v0
; CHECK-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v10, (a0)
; CHECK-NEXT:    vsext.vf4 v12, v8
; CHECK-NEXT:    vand.vv v8, v10, v12
; CHECK-NEXT:    vredor.vs v8, v8, v8
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %e2 = extractelement <16 x i32> %v, i32 2
  %e3 = extractelement <16 x i32> %v, i32 3
  %e4 = extractelement <16 x i32> %v, i32 4
  %or0 = or i32 %e0, %e1
  %or1 = or i32 %or0, %e2
  %or2 = or i32 %or1, %e3
  %or3 = or i32 %or2, %e4
  ret i32 %or3
}

declare i32 @llvm.smax.i32(i32 %a, i32 %b)
declare i32 @llvm.smin.i32(i32 %a, i32 %b)
declare i32 @llvm.umax.i32(i32 %a, i32 %b)
declare i32 @llvm.umin.i32(i32 %a, i32 %b)

define i32 @reduce_smax_16xi32_prefix2(ptr %p) {
; CHECK-LABEL: reduce_smax_16xi32_prefix2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vredmax.vs v8, v8, v8
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %smax0 = call i32 @llvm.smax.i32(i32 %e0, i32 %e1)
  ret i32 %smax0
}

define i32 @reduce_smax_16xi32_prefix5(ptr %p) {
; CHECK-LABEL: reduce_smax_16xi32_prefix5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 524288
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmv.s.x v10, a1
; CHECK-NEXT:    vsetivli zero, 6, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 5
; CHECK-NEXT:    vsetivli zero, 7, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 6
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 7
; CHECK-NEXT:    vredmax.vs v8, v8, v8
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %e2 = extractelement <16 x i32> %v, i32 2
  %e3 = extractelement <16 x i32> %v, i32 3
  %e4 = extractelement <16 x i32> %v, i32 4
  %smax0 = call i32 @llvm.smax.i32(i32 %e0, i32 %e1)
  %smax1 = call i32 @llvm.smax.i32(i32 %smax0, i32 %e2)
  %smax2 = call i32 @llvm.smax.i32(i32 %smax1, i32 %e3)
  %smax3 = call i32 @llvm.smax.i32(i32 %smax2, i32 %e4)
  ret i32 %smax3
}

define i32 @reduce_smin_16xi32_prefix2(ptr %p) {
; CHECK-LABEL: reduce_smin_16xi32_prefix2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vredmin.vs v8, v8, v8
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %smin0 = call i32 @llvm.smin.i32(i32 %e0, i32 %e1)
  ret i32 %smin0
}

define i32 @reduce_smin_16xi32_prefix5(ptr %p) {
; CHECK-LABEL: reduce_smin_16xi32_prefix5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 524288
; CHECK-NEXT:    addi a1, a1, -1
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmv.s.x v10, a1
; CHECK-NEXT:    vsetivli zero, 6, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 5
; CHECK-NEXT:    vsetivli zero, 7, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 6
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 7
; CHECK-NEXT:    vredmin.vs v8, v8, v8
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %e2 = extractelement <16 x i32> %v, i32 2
  %e3 = extractelement <16 x i32> %v, i32 3
  %e4 = extractelement <16 x i32> %v, i32 4
  %smin0 = call i32 @llvm.smin.i32(i32 %e0, i32 %e1)
  %smin1 = call i32 @llvm.smin.i32(i32 %smin0, i32 %e2)
  %smin2 = call i32 @llvm.smin.i32(i32 %smin1, i32 %e3)
  %smin3 = call i32 @llvm.smin.i32(i32 %smin2, i32 %e4)
  ret i32 %smin3
}

define i32 @reduce_umax_16xi32_prefix2(ptr %p) {
; CHECK-LABEL: reduce_umax_16xi32_prefix2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vredmaxu.vs v8, v8, v8
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %umax0 = call i32 @llvm.umax.i32(i32 %e0, i32 %e1)
  ret i32 %umax0
}

define i32 @reduce_umax_16xi32_prefix5(ptr %p) {
; CHECK-LABEL: reduce_umax_16xi32_prefix5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 224
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.s.x v0, a1
; CHECK-NEXT:    vmv.v.i v8, -1
; CHECK-NEXT:    vmerge.vim v8, v8, 0, v0
; CHECK-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v10, (a0)
; CHECK-NEXT:    vsext.vf4 v12, v8
; CHECK-NEXT:    vand.vv v8, v10, v12
; CHECK-NEXT:    vredmaxu.vs v8, v8, v8
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %e2 = extractelement <16 x i32> %v, i32 2
  %e3 = extractelement <16 x i32> %v, i32 3
  %e4 = extractelement <16 x i32> %v, i32 4
  %umax0 = call i32 @llvm.umax.i32(i32 %e0, i32 %e1)
  %umax1 = call i32 @llvm.umax.i32(i32 %umax0, i32 %e2)
  %umax2 = call i32 @llvm.umax.i32(i32 %umax1, i32 %e3)
  %umax3 = call i32 @llvm.umax.i32(i32 %umax2, i32 %e4)
  ret i32 %umax3
}

define i32 @reduce_umin_16xi32_prefix2(ptr %p) {
; CHECK-LABEL: reduce_umin_16xi32_prefix2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vredminu.vs v8, v8, v8
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %umin0 = call i32 @llvm.umin.i32(i32 %e0, i32 %e1)
  ret i32 %umin0
}

define i32 @reduce_umin_16xi32_prefix5(ptr %p) {
; CHECK-LABEL: reduce_umin_16xi32_prefix5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v8, -1
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v10, (a0)
; CHECK-NEXT:    vsetivli zero, 6, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v10, v8, 5
; CHECK-NEXT:    vsetivli zero, 7, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v10, v8, 6
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vslideup.vi v10, v8, 7
; CHECK-NEXT:    vredminu.vs v8, v10, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %v = load <16 x i32>, ptr %p, align 256
  %e0 = extractelement <16 x i32> %v, i32 0
  %e1 = extractelement <16 x i32> %v, i32 1
  %e2 = extractelement <16 x i32> %v, i32 2
  %e3 = extractelement <16 x i32> %v, i32 3
  %e4 = extractelement <16 x i32> %v, i32 4
  %umin0 = call i32 @llvm.umin.i32(i32 %e0, i32 %e1)
  %umin1 = call i32 @llvm.umin.i32(i32 %umin0, i32 %e2)
  %umin2 = call i32 @llvm.umin.i32(i32 %umin1, i32 %e3)
  %umin3 = call i32 @llvm.umin.i32(i32 %umin2, i32 %e4)
  ret i32 %umin3
}

define float @reduce_fadd_16xf32_prefix2(ptr %p) {
; CHECK-LABEL: reduce_fadd_16xf32_prefix2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmv.s.x v9, zero
; CHECK-NEXT:    vfredusum.vs v8, v8, v9
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %v = load <16 x float>, ptr %p, align 256
  %e0 = extractelement <16 x float> %v, i32 0
  %e1 = extractelement <16 x float> %v, i32 1
  %fadd0 = fadd fast float %e0, %e1
  ret float %fadd0
}

define float @reduce_fadd_16xi32_prefix5(ptr %p) {
; CHECK-LABEL: reduce_fadd_16xi32_prefix5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 524288
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmv.s.x v10, a1
; CHECK-NEXT:    vsetivli zero, 6, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 5
; CHECK-NEXT:    vsetivli zero, 7, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 6
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 7
; CHECK-NEXT:    vfredusum.vs v8, v8, v10
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %v = load <16 x float>, ptr %p, align 256
  %e0 = extractelement <16 x float> %v, i32 0
  %e1 = extractelement <16 x float> %v, i32 1
  %e2 = extractelement <16 x float> %v, i32 2
  %e3 = extractelement <16 x float> %v, i32 3
  %e4 = extractelement <16 x float> %v, i32 4
  %fadd0 = fadd fast float %e0, %e1
  %fadd1 = fadd fast float %fadd0, %e2
  %fadd2 = fadd fast float %fadd1, %e3
  %fadd3 = fadd fast float %fadd2, %e4
  ret float %fadd3
}

;; Corner case tests for fadd associativity

; Negative test, not associative.  Would need strict opcode.
define float @reduce_fadd_2xf32_non_associative(ptr %p) {
; CHECK-LABEL: reduce_fadd_2xf32_non_associative:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfmv.f.s fa5, v8
; CHECK-NEXT:    vslidedown.vi v8, v8, 1
; CHECK-NEXT:    vfmv.f.s fa4, v8
; CHECK-NEXT:    fadd.s fa0, fa5, fa4
; CHECK-NEXT:    ret
  %v = load <2 x float>, ptr %p, align 256
  %e0 = extractelement <2 x float> %v, i32 0
  %e1 = extractelement <2 x float> %v, i32 1
  %fadd0 = fadd float %e0, %e1
  ret float %fadd0
}

; Positive test - minimal set of fast math flags
define float @reduce_fadd_2xf32_reassoc_only(ptr %p) {
; CHECK-LABEL: reduce_fadd_2xf32_reassoc_only:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    lui a0, 524288
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vfredusum.vs v8, v8, v9
; CHECK-NEXT:    vfmv.f.s fa0, v8
; CHECK-NEXT:    ret
  %v = load <2 x float>, ptr %p, align 256
  %e0 = extractelement <2 x float> %v, i32 0
  %e1 = extractelement <2 x float> %v, i32 1
  %fadd0 = fadd reassoc float %e0, %e1
  ret float %fadd0
}

; Negative test - wrong fast math flag.
define float @reduce_fadd_2xf32_ninf_only(ptr %p) {
; CHECK-LABEL: reduce_fadd_2xf32_ninf_only:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfmv.f.s fa5, v8
; CHECK-NEXT:    vslidedown.vi v8, v8, 1
; CHECK-NEXT:    vfmv.f.s fa4, v8
; CHECK-NEXT:    fadd.s fa0, fa5, fa4
; CHECK-NEXT:    ret
  %v = load <2 x float>, ptr %p, align 256
  %e0 = extractelement <2 x float> %v, i32 0
  %e1 = extractelement <2 x float> %v, i32 1
  %fadd0 = fadd ninf float %e0, %e1
  ret float %fadd0
}


; Negative test - last fadd is not associative
define float @reduce_fadd_4xi32_non_associative(ptr %p) {
; CHECK-LABEL: reduce_fadd_4xi32_non_associative:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vslidedown.vi v9, v8, 3
; CHECK-NEXT:    vfmv.f.s fa5, v9
; CHECK-NEXT:    lui a0, 524288
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    vfredusum.vs v8, v8, v9
; CHECK-NEXT:    vfmv.f.s fa4, v8
; CHECK-NEXT:    fadd.s fa0, fa4, fa5
; CHECK-NEXT:    ret
  %v = load <4 x float>, ptr %p, align 256
  %e0 = extractelement <4 x float> %v, i32 0
  %e1 = extractelement <4 x float> %v, i32 1
  %e2 = extractelement <4 x float> %v, i32 2
  %e3 = extractelement <4 x float> %v, i32 3
  %fadd0 = fadd fast float %e0, %e1
  %fadd1 = fadd fast float %fadd0, %e2
  %fadd2 = fadd float %fadd1, %e3
  ret float %fadd2
}

; Negative test - first fadd is not associative
; We could form a reduce for elements 2 and 3.
define float @reduce_fadd_4xi32_non_associative2(ptr %p) {
; CHECK-LABEL: reduce_fadd_4xi32_non_associative2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfmv.f.s fa5, v8
; CHECK-NEXT:    vslidedown.vi v9, v8, 1
; CHECK-NEXT:    vfmv.f.s fa4, v9
; CHECK-NEXT:    vslidedown.vi v9, v8, 2
; CHECK-NEXT:    vfmv.f.s fa3, v9
; CHECK-NEXT:    vslidedown.vi v8, v8, 3
; CHECK-NEXT:    vfmv.f.s fa2, v8
; CHECK-NEXT:    fadd.s fa5, fa5, fa4
; CHECK-NEXT:    fadd.s fa4, fa3, fa2
; CHECK-NEXT:    fadd.s fa0, fa5, fa4
; CHECK-NEXT:    ret
  %v = load <4 x float>, ptr %p, align 256
  %e0 = extractelement <4 x float> %v, i32 0
  %e1 = extractelement <4 x float> %v, i32 1
  %e2 = extractelement <4 x float> %v, i32 2
  %e3 = extractelement <4 x float> %v, i32 3
  %fadd0 = fadd float %e0, %e1
  %fadd1 = fadd fast float %fadd0, %e2
  %fadd2 = fadd fast float %fadd1, %e3
  ret float %fadd2
}
