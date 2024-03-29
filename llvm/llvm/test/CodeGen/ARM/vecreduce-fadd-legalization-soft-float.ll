; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=arm-none-eabi -mattr=-neon | FileCheck %s --check-prefix=CHECK

declare half @llvm.vector.reduce.fadd.f16.v4f16(half, <4 x half>)
declare float @llvm.vector.reduce.fadd.f32.v4f32(float, <4 x float>)
declare double @llvm.vector.reduce.fadd.f64.v2f64(double, <2 x double>)
declare fp128 @llvm.vector.reduce.fadd.f128.v2f128(fp128, <2 x fp128>)

define half @test_v4f16_reassoc(<4 x half> %a) nounwind {
; CHECK-LABEL: test_v4f16_reassoc:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r4, r5, r6, r7, r8, lr}
; CHECK-NEXT:    push {r4, r5, r6, r7, r8, lr}
; CHECK-NEXT:    mov r8, #255
; CHECK-NEXT:    mov r4, r3
; CHECK-NEXT:    orr r8, r8, #65280
; CHECK-NEXT:    mov r5, r2
; CHECK-NEXT:    and r0, r0, r8
; CHECK-NEXT:    mov r6, r1
; CHECK-NEXT:    bl __aeabi_h2f
; CHECK-NEXT:    mov r7, r0
; CHECK-NEXT:    and r0, r6, r8
; CHECK-NEXT:    bl __aeabi_h2f
; CHECK-NEXT:    mov r1, r0
; CHECK-NEXT:    mov r0, r7
; CHECK-NEXT:    bl __aeabi_fadd
; CHECK-NEXT:    bl __aeabi_f2h
; CHECK-NEXT:    mov r6, r0
; CHECK-NEXT:    and r0, r5, r8
; CHECK-NEXT:    bl __aeabi_h2f
; CHECK-NEXT:    mov r5, r0
; CHECK-NEXT:    and r0, r6, r8
; CHECK-NEXT:    bl __aeabi_h2f
; CHECK-NEXT:    mov r1, r5
; CHECK-NEXT:    bl __aeabi_fadd
; CHECK-NEXT:    bl __aeabi_f2h
; CHECK-NEXT:    mov r5, r0
; CHECK-NEXT:    and r0, r4, r8
; CHECK-NEXT:    bl __aeabi_h2f
; CHECK-NEXT:    mov r4, r0
; CHECK-NEXT:    and r0, r5, r8
; CHECK-NEXT:    bl __aeabi_h2f
; CHECK-NEXT:    mov r1, r4
; CHECK-NEXT:    bl __aeabi_fadd
; CHECK-NEXT:    bl __aeabi_f2h
; CHECK-NEXT:    pop {r4, r5, r6, r7, r8, lr}
; CHECK-NEXT:    mov pc, lr
  %b = call reassoc half @llvm.vector.reduce.fadd.f16.v4f16(half -0.0, <4 x half> %a)
  ret half %b
}

define half @test_v4f16_seq(<4 x half> %a) nounwind {
; CHECK-LABEL: test_v4f16_seq:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r4, r5, r6, r7, r8, lr}
; CHECK-NEXT:    push {r4, r5, r6, r7, r8, lr}
; CHECK-NEXT:    mov r8, #255
; CHECK-NEXT:    mov r4, r3
; CHECK-NEXT:    orr r8, r8, #65280
; CHECK-NEXT:    mov r5, r2
; CHECK-NEXT:    and r0, r0, r8
; CHECK-NEXT:    mov r6, r1
; CHECK-NEXT:    bl __aeabi_h2f
; CHECK-NEXT:    mov r7, r0
; CHECK-NEXT:    and r0, r6, r8
; CHECK-NEXT:    bl __aeabi_h2f
; CHECK-NEXT:    mov r1, r0
; CHECK-NEXT:    mov r0, r7
; CHECK-NEXT:    bl __aeabi_fadd
; CHECK-NEXT:    bl __aeabi_f2h
; CHECK-NEXT:    mov r6, r0
; CHECK-NEXT:    and r0, r5, r8
; CHECK-NEXT:    bl __aeabi_h2f
; CHECK-NEXT:    mov r5, r0
; CHECK-NEXT:    and r0, r6, r8
; CHECK-NEXT:    bl __aeabi_h2f
; CHECK-NEXT:    mov r1, r5
; CHECK-NEXT:    bl __aeabi_fadd
; CHECK-NEXT:    bl __aeabi_f2h
; CHECK-NEXT:    mov r5, r0
; CHECK-NEXT:    and r0, r4, r8
; CHECK-NEXT:    bl __aeabi_h2f
; CHECK-NEXT:    mov r4, r0
; CHECK-NEXT:    and r0, r5, r8
; CHECK-NEXT:    bl __aeabi_h2f
; CHECK-NEXT:    mov r1, r4
; CHECK-NEXT:    bl __aeabi_fadd
; CHECK-NEXT:    bl __aeabi_f2h
; CHECK-NEXT:    pop {r4, r5, r6, r7, r8, lr}
; CHECK-NEXT:    mov pc, lr
  %b = call half @llvm.vector.reduce.fadd.f16.v4f16(half -0.0, <4 x half> %a)
  ret half %b
}

define float @test_v4f32_reassoc(<4 x float> %a) nounwind {
; CHECK-LABEL: test_v4f32_reassoc:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r4, r5, r11, lr}
; CHECK-NEXT:    push {r4, r5, r11, lr}
; CHECK-NEXT:    mov r4, r3
; CHECK-NEXT:    mov r5, r2
; CHECK-NEXT:    bl __aeabi_fadd
; CHECK-NEXT:    mov r1, r5
; CHECK-NEXT:    bl __aeabi_fadd
; CHECK-NEXT:    mov r1, r4
; CHECK-NEXT:    bl __aeabi_fadd
; CHECK-NEXT:    pop {r4, r5, r11, lr}
; CHECK-NEXT:    mov pc, lr
  %b = call reassoc float @llvm.vector.reduce.fadd.f32.v4f32(float -0.0, <4 x float> %a)
  ret float %b
}

define float @test_v4f32_seq(<4 x float> %a) nounwind {
; CHECK-LABEL: test_v4f32_seq:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r4, r5, r11, lr}
; CHECK-NEXT:    push {r4, r5, r11, lr}
; CHECK-NEXT:    mov r4, r3
; CHECK-NEXT:    mov r5, r2
; CHECK-NEXT:    bl __aeabi_fadd
; CHECK-NEXT:    mov r1, r5
; CHECK-NEXT:    bl __aeabi_fadd
; CHECK-NEXT:    mov r1, r4
; CHECK-NEXT:    bl __aeabi_fadd
; CHECK-NEXT:    pop {r4, r5, r11, lr}
; CHECK-NEXT:    mov pc, lr
  %b = call float @llvm.vector.reduce.fadd.f32.v4f32(float -0.0, <4 x float> %a)
  ret float %b
}

define double @test_v2f64_reassoc(<2 x double> %a) nounwind {
; CHECK-LABEL: test_v2f64_reassoc:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r11, lr}
; CHECK-NEXT:    push {r11, lr}
; CHECK-NEXT:    bl __aeabi_dadd
; CHECK-NEXT:    pop {r11, lr}
; CHECK-NEXT:    mov pc, lr
  %b = call reassoc double @llvm.vector.reduce.fadd.f64.v2f64(double -0.0, <2 x double> %a)
  ret double %b
}

define double @test_v2f64_seq(<2 x double> %a) nounwind {
; CHECK-LABEL: test_v2f64_seq:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r11, lr}
; CHECK-NEXT:    push {r11, lr}
; CHECK-NEXT:    bl __aeabi_dadd
; CHECK-NEXT:    pop {r11, lr}
; CHECK-NEXT:    mov pc, lr
  %b = call double @llvm.vector.reduce.fadd.f64.v2f64(double -0.0, <2 x double> %a)
  ret double %b
}

define fp128 @test_v2f128_reassoc(<2 x fp128> %a) nounwind {
; CHECK-LABEL: test_v2f128_reassoc:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r11, lr}
; CHECK-NEXT:    push {r11, lr}
; CHECK-NEXT:    .pad #16
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    ldr r12, [sp, #36]
; CHECK-NEXT:    str r12, [sp, #12]
; CHECK-NEXT:    ldr r12, [sp, #32]
; CHECK-NEXT:    str r12, [sp, #8]
; CHECK-NEXT:    ldr r12, [sp, #28]
; CHECK-NEXT:    str r12, [sp, #4]
; CHECK-NEXT:    ldr r12, [sp, #24]
; CHECK-NEXT:    str r12, [sp]
; CHECK-NEXT:    bl __addtf3
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    pop {r11, lr}
; CHECK-NEXT:    mov pc, lr
  %b = call reassoc fp128 @llvm.vector.reduce.fadd.f128.v2f128(fp128 0xL00000000000000008000000000000000, <2 x fp128> %a)
  ret fp128 %b
}

define fp128 @test_v2f128_seq(<2 x fp128> %a) nounwind {
; CHECK-LABEL: test_v2f128_seq:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r11, lr}
; CHECK-NEXT:    push {r11, lr}
; CHECK-NEXT:    .pad #16
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    ldr r12, [sp, #36]
; CHECK-NEXT:    str r12, [sp, #12]
; CHECK-NEXT:    ldr r12, [sp, #32]
; CHECK-NEXT:    str r12, [sp, #8]
; CHECK-NEXT:    ldr r12, [sp, #28]
; CHECK-NEXT:    str r12, [sp, #4]
; CHECK-NEXT:    ldr r12, [sp, #24]
; CHECK-NEXT:    str r12, [sp]
; CHECK-NEXT:    bl __addtf3
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    pop {r11, lr}
; CHECK-NEXT:    mov pc, lr
  %b = call fp128 @llvm.vector.reduce.fadd.f128.v2f128(fp128 0xL00000000000000008000000000000000, <2 x fp128> %a)
  ret fp128 %b
}
