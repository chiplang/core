; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv32 -mattr=+v,+zfh,+zvfh | FileCheck %s
; RUN: llc < %s -mtriple=riscv64 -mattr=+v,+zfh,+zvfh | FileCheck %s

; Integers

define void @vector_interleave_store_nxv32i1_nxv16i1(<vscale x 16 x i1> %a, <vscale x 16 x i1> %b, ptr %p) {
; CHECK-LABEL: vector_interleave_store_nxv32i1_nxv16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vsetvli a1, zero, e8, m2, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vmerge.vim v12, v10, 1, v0
; CHECK-NEXT:    vmv1r.v v0, v9
; CHECK-NEXT:    vmerge.vim v8, v10, 1, v0
; CHECK-NEXT:    vwaddu.vv v16, v8, v12
; CHECK-NEXT:    li a1, -1
; CHECK-NEXT:    vwmaccu.vx v16, a1, v12
; CHECK-NEXT:    vmsne.vi v8, v18, 0
; CHECK-NEXT:    vmsne.vi v9, v16, 0
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    srli a1, a1, 2
; CHECK-NEXT:    add a2, a1, a1
; CHECK-NEXT:    vsetvli zero, a2, e8, mf2, ta, ma
; CHECK-NEXT:    vslideup.vx v9, v8, a1
; CHECK-NEXT:    vsetvli a1, zero, e8, m4, ta, ma
; CHECK-NEXT:    vsm.v v9, (a0)
; CHECK-NEXT:    ret
  %res = call <vscale x 32 x i1> @llvm.experimental.vector.interleave2.nxv32i1(<vscale x 16 x i1> %a, <vscale x 16 x i1> %b)
  store <vscale x 32 x i1> %res, ptr %p
  ret void
}

; Shouldn't be lowered to vsseg because it's unaligned
define void @vector_interleave_store_nxv16i16_nxv8i16_align1(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b, ptr %p) {
; CHECK-LABEL: vector_interleave_store_nxv16i16_nxv8i16_align1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m2, ta, ma
; CHECK-NEXT:    vwaddu.vv v12, v8, v10
; CHECK-NEXT:    li a1, -1
; CHECK-NEXT:    vwmaccu.vx v12, a1, v10
; CHECK-NEXT:    vs4r.v v12, (a0)
; CHECK-NEXT:    ret
  %res = call <vscale x 16 x i16> @llvm.experimental.vector.interleave2.nxv16i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b)
  store <vscale x 16 x i16> %res, ptr %p, align 1
  ret void
}

define void @vector_interleave_store_nxv16i16_nxv8i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b, ptr %p) {
; CHECK-LABEL: vector_interleave_store_nxv16i16_nxv8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m2, ta, ma
; CHECK-NEXT:    vsseg2e16.v v8, (a0)
; CHECK-NEXT:    ret
  %res = call <vscale x 16 x i16> @llvm.experimental.vector.interleave2.nxv16i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b)
  store <vscale x 16 x i16> %res, ptr %p
  ret void
}

define void @vector_interleave_store_nxv8i32_nxv4i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b, ptr %p) {
; CHECK-LABEL: vector_interleave_store_nxv8i32_nxv4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vsseg2e32.v v8, (a0)
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x i32> @llvm.experimental.vector.interleave2.nxv8i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b)
  store <vscale x 8 x i32> %res, ptr %p
  ret void
}

define void @vector_interleave_store_nxv4i64_nxv2i64(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b, ptr %p) {
; CHECK-LABEL: vector_interleave_store_nxv4i64_nxv2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e64, m2, ta, ma
; CHECK-NEXT:    vsseg2e64.v v8, (a0)
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x i64> @llvm.experimental.vector.interleave2.nxv4i64(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b)
  store <vscale x 4 x i64> %res, ptr %p
  ret void
}

define void @vector_interleave_store_nxv8i64_nxv4i64(<vscale x 4 x i64> %a, <vscale x 4 x i64> %b, ptr %p) {
; CHECK-LABEL: vector_interleave_store_nxv8i64_nxv4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e64, m4, ta, ma
; CHECK-NEXT:    vsseg2e64.v v8, (a0)
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x i64> @llvm.experimental.vector.interleave2.nxv8i64(<vscale x 4 x i64> %a, <vscale x 4 x i64> %b)
  store <vscale x 8 x i64> %res, ptr %p
  ret void
}

; This shouldn't be lowered to a vsseg because EMUL * NFIELDS >= 8
define void @vector_interleave_store_nxv16i64_nxv8i64(<vscale x 8 x i64> %a, <vscale x 8 x i64> %b, ptr %p) {
; CHECK-LABEL: vector_interleave_store_nxv16i64_nxv8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 4
; CHECK-NEXT:    sub sp, sp, a1
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 16 * vlenb
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vs8r.v v8, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    srli a2, a1, 1
; CHECK-NEXT:    vsetvli a3, zero, e16, m2, ta, mu
; CHECK-NEXT:    vid.v v24
; CHECK-NEXT:    vand.vi v26, v24, 1
; CHECK-NEXT:    vmsne.vi v0, v26, 0
; CHECK-NEXT:    vsrl.vi v6, v24, 1
; CHECK-NEXT:    csrr a3, vlenb
; CHECK-NEXT:    slli a3, a3, 3
; CHECK-NEXT:    add a3, sp, a3
; CHECK-NEXT:    addi a3, a3, 16
; CHECK-NEXT:    vl8r.v v8, (a3) # Unknown-size Folded Reload
; CHECK-NEXT:    vadd.vx v6, v6, a2, v0.t
; CHECK-NEXT:    vmv4r.v v12, v16
; CHECK-NEXT:    vsetvli zero, zero, e64, m8, ta, ma
; CHECK-NEXT:    vrgatherei16.vv v24, v8, v6
; CHECK-NEXT:    addi a2, sp, 16
; CHECK-NEXT:    vs8r.v v24, (a2) # Unknown-size Folded Spill
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    slli a2, a2, 3
; CHECK-NEXT:    add a2, sp, a2
; CHECK-NEXT:    addi a2, a2, 16
; CHECK-NEXT:    vl8r.v v8, (a2) # Unknown-size Folded Reload
; CHECK-NEXT:    vmv4r.v v16, v12
; CHECK-NEXT:    vrgatherei16.vv v8, v16, v6
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a1, a0, a1
; CHECK-NEXT:    vs8r.v v8, (a1)
; CHECK-NEXT:    addi a1, sp, 16
; CHECK-NEXT:    vl8r.v v8, (a1) # Unknown-size Folded Reload
; CHECK-NEXT:    vs8r.v v8, (a0)
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %res = call <vscale x 16 x i64> @llvm.experimental.vector.interleave2.nxv16i64(<vscale x 8 x i64> %a, <vscale x 8 x i64> %b)
  store <vscale x 16 x i64> %res, ptr %p
  ret void
}

declare <vscale x 32 x i1> @llvm.experimental.vector.interleave2.nxv32i1(<vscale x 16 x i1>, <vscale x 16 x i1>)
declare <vscale x 16 x i16> @llvm.experimental.vector.interleave2.nxv16i16(<vscale x 8 x i16>, <vscale x 8 x i16>)
declare <vscale x 8 x i32> @llvm.experimental.vector.interleave2.nxv8i32(<vscale x 4 x i32>, <vscale x 4 x i32>)
declare <vscale x 4 x i64> @llvm.experimental.vector.interleave2.nxv4i64(<vscale x 2 x i64>, <vscale x 2 x i64>)
declare <vscale x 8 x i64> @llvm.experimental.vector.interleave2.nxv8i64(<vscale x 4 x i64>, <vscale x 4 x i64>)
declare <vscale x 16 x i64> @llvm.experimental.vector.interleave2.nxv16i64(<vscale x 8 x i64>, <vscale x 8 x i64>)

; Floats

define void @vector_interleave_store_nxv4f16_nxv2f16(<vscale x 2 x half> %a, <vscale x 2 x half> %b, ptr %p) {
; CHECK-LABEL: vector_interleave_store_nxv4f16_nxv2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vsseg2e16.v v8, (a0)
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x half> @llvm.experimental.vector.interleave2.nxv4f16(<vscale x 2 x half> %a, <vscale x 2 x half> %b)
  store <vscale x 4 x half> %res, ptr %p
  ret void
}

define void @vector_interleave_store_nxv8f16_nxv4f16(<vscale x 4 x half> %a, <vscale x 4 x half> %b, ptr %p) {
; CHECK-LABEL: vector_interleave_store_nxv8f16_nxv4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; CHECK-NEXT:    vsseg2e16.v v8, (a0)
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x half> @llvm.experimental.vector.interleave2.nxv8f16(<vscale x 4 x half> %a, <vscale x 4 x half> %b)
  store <vscale x 8 x half> %res, ptr %p
  ret void
}

define void @vector_interleave_store_nxv4f32_nxv2f32(<vscale x 2 x float> %a, <vscale x 2 x float> %b, ptr %p) {
; CHECK-LABEL: vector_interleave_store_nxv4f32_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; CHECK-NEXT:    vsseg2e32.v v8, (a0)
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x float> @llvm.experimental.vector.interleave2.nxv4f32(<vscale x 2 x float> %a, <vscale x 2 x float> %b)
  store <vscale x 4 x float> %res, ptr %p
  ret void
}

define void @vector_interleave_store_nxv16f16_nxv8f16(<vscale x 8 x half> %a, <vscale x 8 x half> %b, ptr %p) {
; CHECK-LABEL: vector_interleave_store_nxv16f16_nxv8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m2, ta, ma
; CHECK-NEXT:    vsseg2e16.v v8, (a0)
; CHECK-NEXT:    ret
  %res = call <vscale x 16 x half> @llvm.experimental.vector.interleave2.nxv16f16(<vscale x 8 x half> %a, <vscale x 8 x half> %b)
  store <vscale x 16 x half> %res, ptr %p
  ret void
}

define void @vector_interleave_store_nxv8f32_nxv4f32(<vscale x 4 x float> %a, <vscale x 4 x float> %b, ptr %p) {
; CHECK-LABEL: vector_interleave_store_nxv8f32_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vsseg2e32.v v8, (a0)
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x float> @llvm.experimental.vector.interleave2.nxv8f32(<vscale x 4 x float> %a, <vscale x 4 x float> %b)
  store <vscale x 8 x float> %res, ptr %p
  ret void
}

define void @vector_interleave_store_nxv4f64_nxv2f64(<vscale x 2 x double> %a, <vscale x 2 x double> %b, ptr %p) {
; CHECK-LABEL: vector_interleave_store_nxv4f64_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e64, m2, ta, ma
; CHECK-NEXT:    vsseg2e64.v v8, (a0)
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x double> @llvm.experimental.vector.interleave2.nxv4f64(<vscale x 2 x double> %a, <vscale x 2 x double> %b)
  store <vscale x 4 x double> %res, ptr %p
  ret void
}


declare <vscale x 4 x half> @llvm.experimental.vector.interleave2.nxv4f16(<vscale x 2 x half>, <vscale x 2 x half>)
declare <vscale x 8 x half> @llvm.experimental.vector.interleave2.nxv8f16(<vscale x 4 x half>, <vscale x 4 x half>)
declare <vscale x 4 x float> @llvm.experimental.vector.interleave2.nxv4f32(<vscale x 2 x float>, <vscale x 2 x float>)
declare <vscale x 16 x half> @llvm.experimental.vector.interleave2.nxv16f16(<vscale x 8 x half>, <vscale x 8 x half>)
declare <vscale x 8 x float> @llvm.experimental.vector.interleave2.nxv8f32(<vscale x 4 x float>, <vscale x 4 x float>)
declare <vscale x 4 x double> @llvm.experimental.vector.interleave2.nxv4f64(<vscale x 2 x double>, <vscale x 2 x double>)
