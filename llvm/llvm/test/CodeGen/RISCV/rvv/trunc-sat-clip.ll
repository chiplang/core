; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=riscv64 -mattr=+v -verify-machineinstrs < %s | FileCheck %s

declare <4 x i16> @llvm.smax.v4i16(<4 x i16>, <4 x i16>)
declare <4 x i16> @llvm.smin.v4i16(<4 x i16>, <4 x i16>)
declare <4 x i32> @llvm.smax.v4i32(<4 x i32>, <4 x i32>)
declare <4 x i32> @llvm.smin.v4i32(<4 x i32>, <4 x i32>)
declare <4 x i64> @llvm.smax.v4i64(<4 x i64>, <4 x i64>)
declare <4 x i64> @llvm.smin.v4i64(<4 x i64>, <4 x i64>)

declare <4 x i16> @llvm.umax.v4i16(<4 x i16>, <4 x i16>)
declare <4 x i16> @llvm.umin.v4i16(<4 x i16>, <4 x i16>)
declare <4 x i32> @llvm.umax.v4i32(<4 x i32>, <4 x i32>)
declare <4 x i32> @llvm.umin.v4i32(<4 x i32>, <4 x i32>)
declare <4 x i64> @llvm.umax.v4i64(<4 x i64>, <4 x i64>)
declare <4 x i64> @llvm.umin.v4i64(<4 x i64>, <4 x i64>)

define void @trunc_sat_i8i16_maxmin(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_i8i16_maxmin:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vnclip.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i16>, ptr %x, align 16
  %2 = tail call <4 x i16> @llvm.smax.v4i16(<4 x i16> %1, <4 x i16> <i16 -128, i16 -128, i16 -128, i16 -128>)
  %3 = tail call <4 x i16> @llvm.smin.v4i16(<4 x i16> %2, <4 x i16> <i16 127, i16 127, i16 127, i16 127>)
  %4 = trunc <4 x i16> %3 to <4 x i8>
  store <4 x i8> %4, ptr %y, align 8
  ret void
}

define void @trunc_sat_i8i16_minmax(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_i8i16_minmax:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vnclip.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i16>, ptr %x, align 16
  %2 = tail call <4 x i16> @llvm.smin.v4i16(<4 x i16> %1, <4 x i16> <i16 127, i16 127, i16 127, i16 127>)
  %3 = tail call <4 x i16> @llvm.smax.v4i16(<4 x i16> %2, <4 x i16> <i16 -128, i16 -128, i16 -128, i16 -128>)
  %4 = trunc <4 x i16> %3 to <4 x i8>
  store <4 x i8> %4, ptr %y, align 8
  ret void
}

define void @trunc_sat_i8i16_notopt(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_i8i16_notopt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    li a0, -127
; CHECK-NEXT:    vmax.vx v8, v8, a0
; CHECK-NEXT:    li a0, 128
; CHECK-NEXT:    vmin.vx v8, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i16>, ptr %x, align 16
  %2 = tail call <4 x i16> @llvm.smax.v4i16(<4 x i16> %1, <4 x i16> <i16 -127, i16 -127, i16 -127, i16 -127>)
  %3 = tail call <4 x i16> @llvm.smin.v4i16(<4 x i16> %2, <4 x i16> <i16 128, i16 128, i16 128, i16 128>)
  %4 = trunc <4 x i16> %3 to <4 x i8>
  store <4 x i8> %4, ptr %y, align 8
  ret void
}

define void @trunc_sat_u8u16_min(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_u8u16_min:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vnclipu.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i16>, ptr %x, align 16
  %2 = tail call <4 x i16> @llvm.umin.v4i16(<4 x i16> %1, <4 x i16> <i16 255, i16 255, i16 255, i16 255>)
  %3 = trunc <4 x i16> %2 to <4 x i8>
  store <4 x i8> %3, ptr %y, align 8
  ret void
}

define void @trunc_sat_u8u16_notopt(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_u8u16_notopt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    li a0, 127
; CHECK-NEXT:    vminu.vx v8, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i16>, ptr %x, align 16
  %2 = tail call <4 x i16> @llvm.umin.v4i16(<4 x i16> %1, <4 x i16> <i16 127, i16 127, i16 127, i16 127>)
  %3 = trunc <4 x i16> %2 to <4 x i8>
  store <4 x i8> %3, ptr %y, align 8
  ret void
}

define void @trunc_sat_u8u16_maxmin(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_u8u16_maxmin:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vnclipu.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i16>, ptr %x, align 16
  %2 = tail call <4 x i16> @llvm.umax.v4i16(<4 x i16> %1, <4 x i16> <i16 0, i16 0, i16 0, i16 0>)
  %3 = tail call <4 x i16> @llvm.umin.v4i16(<4 x i16> %2, <4 x i16> <i16 255, i16 255, i16 255, i16 255>)
  %4 = trunc <4 x i16> %3 to <4 x i8>
  store <4 x i8> %4, ptr %y, align 8
  ret void
}

define void @trunc_sat_u8u16_minmax(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_u8u16_minmax:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vnclipu.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i16>, ptr %x, align 16
  %2 = tail call <4 x i16> @llvm.umin.v4i16(<4 x i16> %1, <4 x i16> <i16 255, i16 255, i16 255, i16 255>)
  %3 = tail call <4 x i16> @llvm.umax.v4i16(<4 x i16> %2, <4 x i16> <i16 0, i16 0, i16 0, i16 0>)
  %4 = trunc <4 x i16> %3 to <4 x i8>
  store <4 x i8> %4, ptr %y, align 8
  ret void
}


define void @trunc_sat_i16i32_notopt(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_i16i32_notopt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    lui a0, 1048568
; CHECK-NEXT:    addi a0, a0, 1
; CHECK-NEXT:    vmax.vx v8, v8, a0
; CHECK-NEXT:    lui a0, 8
; CHECK-NEXT:    vmin.vx v8, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse16.v v8, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i32>, ptr %x, align 32
  %2 = tail call <4 x i32> @llvm.smax.v4i32(<4 x i32> %1, <4 x i32> <i32 -32767, i32 -32767, i32 -32767, i32 -32767>)
  %3 = tail call <4 x i32> @llvm.smin.v4i32(<4 x i32> %2, <4 x i32> <i32 32768, i32 32768, i32 32768, i32 32768>)
  %4 = trunc <4 x i32> %3 to <4 x i16>
  store <4 x i16> %4, ptr %y, align 16
  ret void
}

define void @trunc_sat_i16i32_maxmin(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_i16i32_maxmin:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vnclip.wi v8, v8, 0
; CHECK-NEXT:    vse16.v v8, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i32>, ptr %x, align 32
  %2 = tail call <4 x i32> @llvm.smax.v4i32(<4 x i32> %1, <4 x i32> <i32 -32768, i32 -32768, i32 -32768, i32 -32768>)
  %3 = tail call <4 x i32> @llvm.smin.v4i32(<4 x i32> %2, <4 x i32> <i32 32767, i32 32767, i32 32767, i32 32767>)
  %4 = trunc <4 x i32> %3 to <4 x i16>
  store <4 x i16> %4, ptr %y, align 16
  ret void
}

define void @trunc_sat_i16i32_minmax(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_i16i32_minmax:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vnclip.wi v8, v8, 0
; CHECK-NEXT:    vse16.v v8, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i32>, ptr %x, align 32
  %2 = tail call <4 x i32> @llvm.smin.v4i32(<4 x i32> %1, <4 x i32> <i32 32767, i32 32767, i32 32767, i32 32767>)
  %3 = tail call <4 x i32> @llvm.smax.v4i32(<4 x i32> %2, <4 x i32> <i32 -32768, i32 -32768, i32 -32768, i32 -32768>)
  %4 = trunc <4 x i32> %3 to <4 x i16>
  store <4 x i16> %4, ptr %y, align 16
  ret void
}

define void @trunc_sat_u16u32_notopt(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_u16u32_notopt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    lui a0, 8
; CHECK-NEXT:    addi a0, a0, -1
; CHECK-NEXT:    vminu.vx v8, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse16.v v8, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i32>, ptr %x, align 32
  %2 = tail call <4 x i32> @llvm.umin.v4i32(<4 x i32> %1, <4 x i32> <i32 32767, i32 32767, i32 32767, i32 32767>)
  %3 = trunc <4 x i32> %2 to <4 x i16>
  store <4 x i16> %3, ptr %y, align 16
  ret void
}

define void @trunc_sat_u16u32_min(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_u16u32_min:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vnclipu.wi v8, v8, 0
; CHECK-NEXT:    vse16.v v8, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i32>, ptr %x, align 32
  %2 = tail call <4 x i32> @llvm.umin.v4i32(<4 x i32> %1, <4 x i32> <i32 65535, i32 65535, i32 65535, i32 65535>)
  %3 = trunc <4 x i32> %2 to <4 x i16>
  store <4 x i16> %3, ptr %y, align 16
  ret void
}

define void @trunc_sat_u16u32_minmax(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_u16u32_minmax:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vnclipu.wi v8, v8, 0
; CHECK-NEXT:    vse16.v v8, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i32>, ptr %x, align 32
  %2 = tail call <4 x i32> @llvm.umax.v4i32(<4 x i32> %1, <4 x i32> <i32 0, i32 0, i32 0, i32 0>)
  %3 = tail call <4 x i32> @llvm.umin.v4i32(<4 x i32> %2, <4 x i32> <i32 65535, i32 65535, i32 65535, i32 65535>)
  %4 = trunc <4 x i32> %3 to <4 x i16>
  store <4 x i16> %4, ptr %y, align 16
  ret void
}

define void @trunc_sat_u16u32_maxmin(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_u16u32_maxmin:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vnclipu.wi v8, v8, 0
; CHECK-NEXT:    vse16.v v8, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i32>, ptr %x, align 32
  %2 = tail call <4 x i32> @llvm.umin.v4i32(<4 x i32> %1, <4 x i32> <i32 65535, i32 65535, i32 65535, i32 65535>)
  %3 = tail call <4 x i32> @llvm.umax.v4i32(<4 x i32> %2, <4 x i32> <i32 0, i32 0, i32 0, i32 0>)
  %4 = trunc <4 x i32> %3 to <4 x i16>
  store <4 x i16> %4, ptr %y, align 16
  ret void
}


define void @trunc_sat_i32i64_notopt(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_i32i64_notopt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    lui a0, 524288
; CHECK-NEXT:    addiw a0, a0, 1
; CHECK-NEXT:    vmax.vx v8, v8, a0
; CHECK-NEXT:    li a0, 1
; CHECK-NEXT:    slli a0, a0, 31
; CHECK-NEXT:    vmin.vx v8, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; CHECK-NEXT:    vnsrl.wi v10, v8, 0
; CHECK-NEXT:    vse32.v v10, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i64>, ptr %x, align 64
  %2 = tail call <4 x i64> @llvm.smax.v4i64(<4 x i64> %1, <4 x i64> <i64 -2147483647, i64 -2147483647, i64 -2147483647, i64 -2147483647>)
  %3 = tail call <4 x i64> @llvm.smin.v4i64(<4 x i64> %2, <4 x i64> <i64 2147483648, i64 2147483648, i64 2147483648, i64 2147483648>)
  %4 = trunc <4 x i64> %3 to <4 x i32>
  store <4 x i32> %4, ptr %y, align 32
  ret void
}

define void @trunc_sat_i32i64_maxmin(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_i32i64_maxmin:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vnclip.wi v10, v8, 0
; CHECK-NEXT:    vse32.v v10, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i64>, ptr %x, align 64
  %2 = tail call <4 x i64> @llvm.smax.v4i64(<4 x i64> %1, <4 x i64> <i64 -2147483648, i64 -2147483648, i64 -2147483648, i64 -2147483648>)
  %3 = tail call <4 x i64> @llvm.smin.v4i64(<4 x i64> %2, <4 x i64> <i64 2147483647, i64 2147483647, i64 2147483647, i64 2147483647>)
  %4 = trunc <4 x i64> %3 to <4 x i32>
  store <4 x i32> %4, ptr %y, align 32
  ret void
}

define void @trunc_sat_i32i64_minmax(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_i32i64_minmax:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vnclip.wi v10, v8, 0
; CHECK-NEXT:    vse32.v v10, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i64>, ptr %x, align 64
  %2 = tail call <4 x i64> @llvm.smin.v4i64(<4 x i64> %1, <4 x i64> <i64 2147483647, i64 2147483647, i64 2147483647, i64 2147483647>)
  %3 = tail call <4 x i64> @llvm.smax.v4i64(<4 x i64> %2, <4 x i64> <i64 -2147483648, i64 -2147483648, i64 -2147483648, i64 -2147483648>)
  %4 = trunc <4 x i64> %3 to <4 x i32>
  store <4 x i32> %4, ptr %y, align 32
  ret void
}


define void @trunc_sat_u32u64_notopt(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_u32u64_notopt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    lui a0, 524288
; CHECK-NEXT:    addiw a0, a0, -1
; CHECK-NEXT:    vminu.vx v8, v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; CHECK-NEXT:    vnsrl.wi v10, v8, 0
; CHECK-NEXT:    vse32.v v10, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i64>, ptr %x, align 64
  %2 = tail call <4 x i64> @llvm.umin.v4i64(<4 x i64> %1, <4 x i64> <i64 2147483647, i64 2147483647, i64 2147483647, i64 2147483647>)
  %3 = trunc <4 x i64> %2 to <4 x i32>
  store <4 x i32> %3, ptr %y, align 32
  ret void
}

define void @trunc_sat_u32u64_min(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_u32u64_min:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vnclipu.wi v10, v8, 0
; CHECK-NEXT:    vse32.v v10, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i64>, ptr %x, align 64
  %2 = tail call <4 x i64> @llvm.umin.v4i64(<4 x i64> %1, <4 x i64> <i64 4294967295, i64 4294967295, i64 4294967295, i64 4294967295>)
  %3 = trunc <4 x i64> %2 to <4 x i32>
  store <4 x i32> %3, ptr %y, align 32
  ret void
}


define void @trunc_sat_u32u64_maxmin(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_u32u64_maxmin:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vnclipu.wi v10, v8, 0
; CHECK-NEXT:    vse32.v v10, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i64>, ptr %x, align 64
  %2 = tail call <4 x i64> @llvm.umax.v4i64(<4 x i64> %1, <4 x i64> <i64 0, i64 0, i64 0, i64 0>)
  %3 = tail call <4 x i64> @llvm.umin.v4i64(<4 x i64> %2, <4 x i64> <i64 4294967295, i64 4294967295, i64 4294967295, i64 4294967295>)
  %4 = trunc <4 x i64> %3 to <4 x i32>
  store <4 x i32> %4, ptr %y, align 32
  ret void
}

define void @trunc_sat_u32u64_minmax(ptr %x, ptr %y) {
; CHECK-LABEL: trunc_sat_u32u64_minmax:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vnclipu.wi v10, v8, 0
; CHECK-NEXT:    vse32.v v10, (a1)
; CHECK-NEXT:    ret
  %1 = load <4 x i64>, ptr %x, align 64
  %2 = tail call <4 x i64> @llvm.umin.v4i64(<4 x i64> %1, <4 x i64> <i64 4294967295, i64 4294967295, i64 4294967295, i64 4294967295>)
  %3 = tail call <4 x i64> @llvm.umax.v4i64(<4 x i64> %2, <4 x i64> <i64 0, i64 0, i64 0, i64 0>)
  %4 = trunc <4 x i64> %3 to <4 x i32>
  store <4 x i32> %4, ptr %y, align 32
  ret void
}
