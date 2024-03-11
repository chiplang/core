; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+zve32f,+f,+zvl64b \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+zve32f,+f,+zvl64b \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK

; Sanity check that type legalization kicks in for vscale x 1 types with Zve32.

; NOTE: The load and store are widened by using VP_LOAD/STORE. The add/fadd are
; widened by using the next larger LMUL and operating on the whole vector. This
; isn't optimal, but doesn't crash.

define void @vadd_vv_nxv1i8(ptr %pa, ptr %pb) {
; CHECK-LABEL: vadd_vv_nxv1i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    srli a2, a2, 3
; CHECK-NEXT:    vsetvli zero, a2, e8, mf4, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vle8.v v9, (a1)
; CHECK-NEXT:    vsetvli a1, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vadd.vv v8, v8, v9
; CHECK-NEXT:    vsetvli zero, a2, e8, mf4, ta, ma
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  %va = load <vscale x 1 x i8>, ptr %pa
  %vb = load <vscale x 1 x i8>, ptr %pb
  %vc = add <vscale x 1 x i8> %va, %vb
  store <vscale x 1 x i8> %vc, ptr %pa
  ret void
}

define void @vadd_vv_nxv1i16(ptr %pa, ptr %pb) {
; CHECK-LABEL: vadd_vv_nxv1i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    srli a2, a2, 3
; CHECK-NEXT:    vsetvli zero, a2, e16, mf2, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vle16.v v9, (a1)
; CHECK-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vadd.vv v8, v8, v9
; CHECK-NEXT:    vsetvli zero, a2, e16, mf2, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0)
; CHECK-NEXT:    ret
  %va = load <vscale x 1 x i16>, ptr %pa
  %vb = load <vscale x 1 x i16>, ptr %pb
  %vc = add <vscale x 1 x i16> %va, %vb
  store <vscale x 1 x i16> %vc, ptr %pa
  ret void
}

define void @vadd_vv_nxv1i32(ptr %pa, ptr %pb) {
; CHECK-LABEL: vadd_vv_nxv1i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    srli a2, a2, 3
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vle32.v v9, (a1)
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; CHECK-NEXT:    vadd.vv v8, v8, v9
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    ret
  %va = load <vscale x 1 x i32>, ptr %pa
  %vb = load <vscale x 1 x i32>, ptr %pb
  %vc = add <vscale x 1 x i32> %va, %vb
  store <vscale x 1 x i32> %vc, ptr %pa
  ret void
}

define void @vfadd_vv_nxv1f32(ptr %pa, ptr %pb) {
; CHECK-LABEL: vfadd_vv_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    srli a2, a2, 3
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vle32.v v9, (a1)
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfadd.vv v8, v8, v9
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    ret
  %va = load <vscale x 1 x float>, ptr %pa
  %vb = load <vscale x 1 x float>, ptr %pb
  %vc = fadd <vscale x 1 x float> %va, %vb
  store <vscale x 1 x float> %vc, ptr %pa
  ret void
}
