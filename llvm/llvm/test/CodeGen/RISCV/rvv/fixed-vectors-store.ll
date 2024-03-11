; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=riscv32 -mattr=+v,+zfh,+zvfh -verify-machineinstrs < %s | FileCheck -check-prefixes=CHECK,RV32 %s
; RUN: llc -mtriple=riscv64 -mattr=+v,+zfh,+zvfh -verify-machineinstrs < %s | FileCheck -check-prefixes=CHECK,RV64 %s

define void @store_v5i8(ptr %p, <5 x i8> %v) {
; CHECK-LABEL: store_v5i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 5, e8, mf2, ta, ma
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  store <5 x i8> %v, ptr %p
  ret void
}

define void @store_v5i8_align1(ptr %p, <5 x i8> %v) {
; CHECK-LABEL: store_v5i8_align1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 5, e8, mf2, ta, ma
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  store <5 x i8> %v, ptr %p, align 1
  ret void
}


define void @store_v6i8(ptr %p, <6 x i8> %v) {
; CHECK-LABEL: store_v6i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 6, e8, mf2, ta, ma
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  store <6 x i8> %v, ptr %p
  ret void
}

define void @store_v12i8(ptr %p, <12 x i8> %v) {
; CHECK-LABEL: store_v12i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 12, e8, m1, ta, ma
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  store <12 x i8> %v, ptr %p
  ret void
}

define void @store_v6i16(ptr %p, <6 x i16> %v) {
; CHECK-LABEL: store_v6i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 6, e16, m1, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0)
; CHECK-NEXT:    ret
  store <6 x i16> %v, ptr %p
  ret void
}

define void @store_v6f16(ptr %p, <6 x half> %v) {
; CHECK-LABEL: store_v6f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 6, e16, m1, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0)
; CHECK-NEXT:    ret
  store <6 x half> %v, ptr %p
  ret void
}

define void @store_v6f32(ptr %p, <6 x float> %v) {
; CHECK-LABEL: store_v6f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 6, e32, m2, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    ret
  store <6 x float> %v, ptr %p
  ret void
}

define void @store_v6f64(ptr %p, <6 x double> %v) {
; CHECK-LABEL: store_v6f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 6, e64, m4, ta, ma
; CHECK-NEXT:    vse64.v v8, (a0)
; CHECK-NEXT:    ret
  store <6 x double> %v, ptr %p
  ret void
}

define void @store_v6i1(ptr %p, <6 x i1> %v) {
; CHECK-LABEL: store_v6i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vfirst.m a1, v0
; CHECK-NEXT:    seqz a1, a1
; CHECK-NEXT:    vmv.x.s a2, v0
; CHECK-NEXT:    andi a3, a2, 2
; CHECK-NEXT:    or a1, a1, a3
; CHECK-NEXT:    andi a3, a2, 4
; CHECK-NEXT:    andi a4, a2, 8
; CHECK-NEXT:    or a3, a3, a4
; CHECK-NEXT:    or a1, a1, a3
; CHECK-NEXT:    andi a3, a2, 16
; CHECK-NEXT:    andi a2, a2, -32
; CHECK-NEXT:    or a2, a3, a2
; CHECK-NEXT:    or a1, a1, a2
; CHECK-NEXT:    andi a1, a1, 63
; CHECK-NEXT:    sb a1, 0(a0)
; CHECK-NEXT:    ret
  store <6 x i1> %v, ptr %p
  ret void
}

define void @store_constant_v2i8(ptr %p) {
; CHECK-LABEL: store_constant_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 1539
; CHECK-NEXT:    sh a1, 0(a0)
; CHECK-NEXT:    ret
  store <2 x i8> <i8 3, i8 6>, ptr %p
  ret void
}

define void @store_constant_v2i16(ptr %p) {
; CHECK-LABEL: store_constant_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 96
; CHECK-NEXT:    addi a1, a1, 3
; CHECK-NEXT:    sw a1, 0(a0)
; CHECK-NEXT:    ret
  store <2 x i16> <i16 3, i16 6>, ptr %p
  ret void
}

define void @store_constant_v2i32(ptr %p) {
; CHECK-LABEL: store_constant_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 3
; CHECK-NEXT:    vid.v v9
; CHECK-NEXT:    li a1, 3
; CHECK-NEXT:    vmadd.vx v9, a1, v8
; CHECK-NEXT:    vse32.v v9, (a0)
; CHECK-NEXT:    ret
  store <2 x i32> <i32 3, i32 6>, ptr %p
  ret void
}

define void @store_constant_v4i8(ptr %p) {
; CHECK-LABEL: store_constant_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 4176
; CHECK-NEXT:    addi a1, a1, 1539
; CHECK-NEXT:    sw a1, 0(a0)
; CHECK-NEXT:    ret
  store <4 x i8> <i8 3, i8 6, i8 5, i8 1>, ptr %p
  ret void
}

define void @store_constant_v4i16(ptr %p) {
; CHECK-LABEL: store_constant_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 4176
; CHECK-NEXT:    addi a1, a1, 1539
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v8, a1
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vsext.vf2 v9, v8
; CHECK-NEXT:    vse16.v v9, (a0)
; CHECK-NEXT:    ret
  store <4 x i16> <i16 3, i16 6, i16 5, i16 1>, ptr %p
  ret void
}

define void @store_constant_v4i32(ptr %p) {
; CHECK-LABEL: store_constant_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 4176
; CHECK-NEXT:    addi a1, a1, 1539
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v8, a1
; CHECK-NEXT:    vsext.vf4 v9, v8
; CHECK-NEXT:    vse32.v v9, (a0)
; CHECK-NEXT:    ret
  store <4 x i32> <i32 3, i32 6, i32 5, i32 1>, ptr %p
  ret void
}

define void @store_id_v4i8(ptr %p) {
; CHECK-LABEL: store_id_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 12320
; CHECK-NEXT:    addi a1, a1, 256
; CHECK-NEXT:    sw a1, 0(a0)
; CHECK-NEXT:    ret
  store <4 x i8> <i8 0, i8 1, i8 2, i8 3>, ptr %p
  ret void
}

define void @store_constant_v2i8_align1(ptr %p) {
; CHECK-LABEL: store_constant_v2i8_align1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 3
; CHECK-NEXT:    vid.v v9
; CHECK-NEXT:    li a1, 3
; CHECK-NEXT:    vmadd.vx v9, a1, v8
; CHECK-NEXT:    vse8.v v9, (a0)
; CHECK-NEXT:    ret
  store <2 x i8> <i8 3, i8 6>, ptr %p, align 1
  ret void
}

define void @store_constant_splat_v2i8(ptr %p) {
; CHECK-LABEL: store_constant_splat_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 771
; CHECK-NEXT:    sh a1, 0(a0)
; CHECK-NEXT:    ret
  store <2 x i8> <i8 3, i8 3>, ptr %p
  ret void
}

define void @store_constant_undef_v2i8(ptr %p) {
; CHECK-LABEL: store_constant_undef_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 768
; CHECK-NEXT:    sh a1, 0(a0)
; CHECK-NEXT:    ret
  store <2 x i8> <i8 undef, i8 3>, ptr %p
  ret void
}

define void @store_constant_v2i8_volatile(ptr %p) {
; CHECK-LABEL: store_constant_v2i8_volatile:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 1
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  store volatile <2 x i8> <i8 1, i8 1>, ptr %p
  ret void
}


define void @exact_vlen_i32_m1(ptr %p) vscale_range(2,2) {
; CHECK-LABEL: exact_vlen_i32_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vs1r.v v8, (a0)
; CHECK-NEXT:    ret
  store <4 x i32> zeroinitializer, ptr %p
  ret void
}

define void @exact_vlen_i8_m1(ptr %p) vscale_range(2,2) {
; CHECK-LABEL: exact_vlen_i8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vs1r.v v8, (a0)
; CHECK-NEXT:    ret
  store <16 x i8> zeroinitializer, ptr %p
  ret void
}

define void @exact_vlen_i8_m2(ptr %p) vscale_range(2,2) {
; CHECK-LABEL: exact_vlen_i8_m2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m2, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vs2r.v v8, (a0)
; CHECK-NEXT:    ret
  store <32 x i8> zeroinitializer, ptr %p
  ret void
}

define void @exact_vlen_i8_m8(ptr %p) vscale_range(2,2) {
; CHECK-LABEL: exact_vlen_i8_m8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m8, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vs8r.v v8, (a0)
; CHECK-NEXT:    ret
  store <128 x i8> zeroinitializer, ptr %p
  ret void
}

define void @exact_vlen_i64_m8(ptr %p) vscale_range(2,2) {
; CHECK-LABEL: exact_vlen_i64_m8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vs8r.v v8, (a0)
; CHECK-NEXT:    ret
  store <16 x i64> zeroinitializer, ptr %p
  ret void
}

;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; RV32: {{.*}}
; RV64: {{.*}}
