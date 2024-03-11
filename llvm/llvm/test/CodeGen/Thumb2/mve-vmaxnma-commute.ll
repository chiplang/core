; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve.fp %s -o - | FileCheck %s

; F32

define arm_aapcs_vfpcc <4 x float> @maxf32(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: maxf32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmaxnma.f32 q0, q1
; CHECK-NEXT:    bx lr
  %aa = tail call fast <4 x float> @llvm.fabs.v4f32(<4 x float> %a)
  %bb = tail call fast <4 x float> @llvm.fabs.v4f32(<4 x float> %b)
  %c = tail call fast <4 x float> @llvm.maxnum.v4f32(<4 x float> %aa, <4 x float> %bb)
  ret <4 x float> %c
}

define arm_aapcs_vfpcc <4 x float> @maxf32_c(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: maxf32_c:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmaxnma.f32 q0, q1
; CHECK-NEXT:    bx lr
  %aa = tail call fast <4 x float> @llvm.fabs.v4f32(<4 x float> %a)
  %bb = tail call fast <4 x float> @llvm.fabs.v4f32(<4 x float> %b)
  %c = tail call fast <4 x float> @llvm.maxnum.v4f32(<4 x float> %bb, <4 x float> %aa)
  ret <4 x float> %c
}

define arm_aapcs_vfpcc <4 x float> @minf32(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: minf32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vminnma.f32 q0, q1
; CHECK-NEXT:    bx lr
  %aa = tail call fast <4 x float> @llvm.fabs.v4f32(<4 x float> %a)
  %bb = tail call fast <4 x float> @llvm.fabs.v4f32(<4 x float> %b)
  %c = tail call fast <4 x float> @llvm.minnum.v4f32(<4 x float> %aa, <4 x float> %bb)
  ret <4 x float> %c
}

define arm_aapcs_vfpcc <4 x float> @minf32_c(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: minf32_c:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vminnma.f32 q0, q1
; CHECK-NEXT:    bx lr
  %aa = tail call fast <4 x float> @llvm.fabs.v4f32(<4 x float> %a)
  %bb = tail call fast <4 x float> @llvm.fabs.v4f32(<4 x float> %b)
  %c = tail call fast <4 x float> @llvm.minnum.v4f32(<4 x float> %bb, <4 x float> %aa)
  ret <4 x float> %c
}


define arm_aapcs_vfpcc <4 x float> @maxpredf32(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: maxpredf32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vpt.f32 gt, q1, q0
; CHECK-NEXT:    vmaxnmat.f32 q0, q1
; CHECK-NEXT:    bx lr
  %c = fcmp olt <4 x float> %a, %b
  %s = tail call fast <4 x float> @llvm.arm.mve.vmaxnma.predicated.v4f32.v4i1(<4 x float> %a, <4 x float> %b, <4 x i1> %c)
  ret <4 x float> %s
}

define arm_aapcs_vfpcc <4 x float> @maxpredf32_c(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: maxpredf32_c:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vpt.f32 gt, q1, q0
; CHECK-NEXT:    vmaxnmat.f32 q1, q0
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    bx lr
  %c = fcmp olt <4 x float> %a, %b
  %s = tail call fast <4 x float> @llvm.arm.mve.vmaxnma.predicated.v4f32.v4i1(<4 x float> %b, <4 x float> %a, <4 x i1> %c)
  ret <4 x float> %s
}

define arm_aapcs_vfpcc <4 x float> @minpredf32(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: minpredf32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vpt.f32 gt, q1, q0
; CHECK-NEXT:    vminnmat.f32 q0, q1
; CHECK-NEXT:    bx lr
  %c = fcmp olt <4 x float> %a, %b
  %s = tail call fast <4 x float> @llvm.arm.mve.vminnma.predicated.v4f32.v4i1(<4 x float> %a, <4 x float> %b, <4 x i1> %c)
  ret <4 x float> %s
}

define arm_aapcs_vfpcc <4 x float> @minpredf32_c(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: minpredf32_c:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vpt.f32 gt, q1, q0
; CHECK-NEXT:    vminnmat.f32 q1, q0
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    bx lr
  %c = fcmp olt <4 x float> %a, %b
  %s = tail call fast <4 x float> @llvm.arm.mve.vminnma.predicated.v4f32.v4i1(<4 x float> %b, <4 x float> %a, <4 x i1> %c)
  ret <4 x float> %s
}



; F16

define arm_aapcs_vfpcc <8 x half> @maxf16(<8 x half> %a, <8 x half> %b) {
; CHECK-LABEL: maxf16:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmaxnma.f16 q0, q1
; CHECK-NEXT:    bx lr
  %aa = tail call fast <8 x half> @llvm.fabs.v8f16(<8 x half> %a)
  %bb = tail call fast <8 x half> @llvm.fabs.v8f16(<8 x half> %b)
  %c = tail call fast <8 x half> @llvm.maxnum.v8f16(<8 x half> %aa, <8 x half> %bb)
  ret <8 x half> %c
}

define arm_aapcs_vfpcc <8 x half> @maxf16_c(<8 x half> %a, <8 x half> %b) {
; CHECK-LABEL: maxf16_c:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmaxnma.f16 q0, q1
; CHECK-NEXT:    bx lr
  %aa = tail call fast <8 x half> @llvm.fabs.v8f16(<8 x half> %a)
  %bb = tail call fast <8 x half> @llvm.fabs.v8f16(<8 x half> %b)
  %c = tail call fast <8 x half> @llvm.maxnum.v8f16(<8 x half> %bb, <8 x half> %aa)
  ret <8 x half> %c
}

define arm_aapcs_vfpcc <8 x half> @minf16(<8 x half> %a, <8 x half> %b) {
; CHECK-LABEL: minf16:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vminnma.f16 q0, q1
; CHECK-NEXT:    bx lr
  %aa = tail call fast <8 x half> @llvm.fabs.v8f16(<8 x half> %a)
  %bb = tail call fast <8 x half> @llvm.fabs.v8f16(<8 x half> %b)
  %c = tail call fast <8 x half> @llvm.minnum.v8f16(<8 x half> %aa, <8 x half> %bb)
  ret <8 x half> %c
}

define arm_aapcs_vfpcc <8 x half> @minf16_c(<8 x half> %a, <8 x half> %b) {
; CHECK-LABEL: minf16_c:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vminnma.f16 q0, q1
; CHECK-NEXT:    bx lr
  %aa = tail call fast <8 x half> @llvm.fabs.v8f16(<8 x half> %a)
  %bb = tail call fast <8 x half> @llvm.fabs.v8f16(<8 x half> %b)
  %c = tail call fast <8 x half> @llvm.minnum.v8f16(<8 x half> %bb, <8 x half> %aa)
  ret <8 x half> %c
}

define arm_aapcs_vfpcc <8 x half> @maxpredf16(<8 x half> %a, <8 x half> %b) {
; CHECK-LABEL: maxpredf16:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vpt.f16 gt, q1, q0
; CHECK-NEXT:    vmaxnmat.f16 q0, q1
; CHECK-NEXT:    bx lr
  %c = fcmp olt <8 x half> %a, %b
  %s = tail call fast <8 x half> @llvm.arm.mve.vmaxnma.predicated.v8f16.v8i1(<8 x half> %a, <8 x half> %b, <8 x i1> %c)
  ret <8 x half> %s
}

define arm_aapcs_vfpcc <8 x half> @maxpredf16_c(<8 x half> %a, <8 x half> %b) {
; CHECK-LABEL: maxpredf16_c:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vpt.f16 gt, q1, q0
; CHECK-NEXT:    vmaxnmat.f16 q1, q0
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    bx lr
  %c = fcmp olt <8 x half> %a, %b
  %s = tail call fast <8 x half> @llvm.arm.mve.vmaxnma.predicated.v8f16.v8i1(<8 x half> %b, <8 x half> %a, <8 x i1> %c)
  ret <8 x half> %s
}

define arm_aapcs_vfpcc <8 x half> @minpredf16(<8 x half> %a, <8 x half> %b) {
; CHECK-LABEL: minpredf16:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vpt.f16 gt, q1, q0
; CHECK-NEXT:    vminnmat.f16 q0, q1
; CHECK-NEXT:    bx lr
  %c = fcmp olt <8 x half> %a, %b
  %s = tail call fast <8 x half> @llvm.arm.mve.vminnma.predicated.v8f16.v8i1(<8 x half> %a, <8 x half> %b, <8 x i1> %c)
  ret <8 x half> %s
}

define arm_aapcs_vfpcc <8 x half> @minpredf16_c(<8 x half> %a, <8 x half> %b) {
; CHECK-LABEL: minpredf16_c:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vpt.f16 gt, q1, q0
; CHECK-NEXT:    vminnmat.f16 q1, q0
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    bx lr
  %c = fcmp olt <8 x half> %a, %b
  %s = tail call fast <8 x half> @llvm.arm.mve.vminnma.predicated.v8f16.v8i1(<8 x half> %b, <8 x half> %a, <8 x i1> %c)
  ret <8 x half> %s
}


; Loops

define void @loop_absmax32(ptr nocapture readonly %0, i32 %1, ptr nocapture %2) {
; CHECK-LABEL: loop_absmax32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    vmov.i32 q0, #0x0
; CHECK-NEXT:    lsrs r1, r1, #3
; CHECK-NEXT:    wls lr, r1, .LBB16_3
; CHECK-NEXT:  @ %bb.1: @ %.preheader
; CHECK-NEXT:    vmov.i32 q0, #0x0
; CHECK-NEXT:  .LBB16_2: @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrw.u32 q1, [r0], #16
; CHECK-NEXT:    vabs.f32 q1, q1
; CHECK-NEXT:    vmaxnm.f32 q0, q0, q1
; CHECK-NEXT:    le lr, .LBB16_2
; CHECK-NEXT:  .LBB16_3:
; CHECK-NEXT:    vldr s4, .LCPI16_0
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vmaxnmav.f32 r0, q0
; CHECK-NEXT:    vmov s0, r0
; CHECK-NEXT:    vstr s0, [r2]
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 2
; CHECK-NEXT:  @ %bb.4:
; CHECK-NEXT:  .LCPI16_0:
; CHECK-NEXT:    .long 0x00000000 @ float 0
  %4 = lshr i32 %1, 3
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %18, label %6

6:                                                ; preds = %3, %6
  %7 = phi i32 [ %16, %6 ], [ %4, %3 ]
  %8 = phi <4 x float> [ %15, %6 ], [ zeroinitializer, %3 ]
  %9 = phi ptr [ %12, %6 ], [ %0, %3 ]
  %10 = bitcast ptr %9 to ptr
  %11 = load <4 x float>, ptr %10, align 4
  %12 = getelementptr inbounds float, ptr %9, i32 4
  %13 = tail call fast <4 x float> @llvm.fabs.v4f32(<4 x float> %11)
  %14 = tail call fast <4 x float> @llvm.fabs.v4f32(<4 x float> %8)
  %15 = tail call fast <4 x float> @llvm.maxnum.v4f32(<4 x float> %14, <4 x float> %13)
  %16 = add nsw i32 %7, -1
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %18, label %6

18:                                               ; preds = %6, %3
  %19 = phi <4 x float> [ zeroinitializer, %3 ], [ %15, %6 ]
  %20 = tail call fast float @llvm.arm.mve.maxnmav.f32.v4f32(float 0.000000e+00, <4 x float> %19)
  store float %20, ptr %2, align 4
  ret void
}

define void @loop_absmax32_c(ptr nocapture readonly %0, i32 %1, ptr nocapture %2) {
; CHECK-LABEL: loop_absmax32_c:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    vmov.i32 q0, #0x0
; CHECK-NEXT:    lsrs r1, r1, #3
; CHECK-NEXT:    wls lr, r1, .LBB17_3
; CHECK-NEXT:  @ %bb.1: @ %.preheader
; CHECK-NEXT:    vmov.i32 q0, #0x0
; CHECK-NEXT:  .LBB17_2: @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrw.u32 q1, [r0], #16
; CHECK-NEXT:    vabs.f32 q1, q1
; CHECK-NEXT:    vmaxnm.f32 q0, q1, q0
; CHECK-NEXT:    le lr, .LBB17_2
; CHECK-NEXT:  .LBB17_3:
; CHECK-NEXT:    vldr s4, .LCPI17_0
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vmaxnmav.f32 r0, q0
; CHECK-NEXT:    vmov s0, r0
; CHECK-NEXT:    vstr s0, [r2]
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 2
; CHECK-NEXT:  @ %bb.4:
; CHECK-NEXT:  .LCPI17_0:
; CHECK-NEXT:    .long 0x00000000 @ float 0
  %4 = lshr i32 %1, 3
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %18, label %6

6:                                                ; preds = %3, %6
  %7 = phi i32 [ %16, %6 ], [ %4, %3 ]
  %8 = phi <4 x float> [ %15, %6 ], [ zeroinitializer, %3 ]
  %9 = phi ptr [ %12, %6 ], [ %0, %3 ]
  %10 = bitcast ptr %9 to ptr
  %11 = load <4 x float>, ptr %10, align 4
  %12 = getelementptr inbounds float, ptr %9, i32 4
  %13 = tail call fast <4 x float> @llvm.fabs.v4f32(<4 x float> %11)
  %14 = tail call fast <4 x float> @llvm.fabs.v4f32(<4 x float> %8)
  %15 = tail call fast <4 x float> @llvm.maxnum.v4f32(<4 x float> %13, <4 x float> %14)
  %16 = add nsw i32 %7, -1
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %18, label %6

18:                                               ; preds = %6, %3
  %19 = phi <4 x float> [ zeroinitializer, %3 ], [ %15, %6 ]
  %20 = tail call fast float @llvm.arm.mve.maxnmav.f32.v4f32(float 0.000000e+00, <4 x float> %19)
  store float %20, ptr %2, align 4
  ret void
}

define void @loop_absmax32_pred(ptr %0, i32 %1, ptr nocapture %2) {
; CHECK-LABEL: loop_absmax32_pred:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    vmov.i32 q0, #0x0
; CHECK-NEXT:    dlstp.32 lr, r1
; CHECK-NEXT:  .LBB18_1: @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrw.u32 q1, [r0], #16
; CHECK-NEXT:    vmaxnma.f32 q0, q1
; CHECK-NEXT:    letp lr, .LBB18_1
; CHECK-NEXT:  @ %bb.2:
; CHECK-NEXT:    vldr s4, .LCPI18_0
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vmaxnmav.f32 r0, q0
; CHECK-NEXT:    vmov s0, r0
; CHECK-NEXT:    vstr s0, [r2]
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 2
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:  .LCPI18_0:
; CHECK-NEXT:    .long 0x00000000 @ float 0
  br label %4

4:                                                ; preds = %4, %3
  %5 = phi <4 x float> [ zeroinitializer, %3 ], [ %12, %4 ]
  %6 = phi i32 [ %1, %3 ], [ %13, %4 ]
  %7 = phi ptr [ %0, %3 ], [ %11, %4 ]
  %8 = tail call <4 x i1> @llvm.arm.mve.vctp32(i32 %6)
  %9 = bitcast ptr %7 to ptr
  %10 = tail call fast <4 x float> @llvm.masked.load.v4f32.p0(ptr %9, i32 4, <4 x i1> %8, <4 x float> zeroinitializer)
  %11 = getelementptr inbounds float, ptr %7, i32 4
  %12 = tail call fast <4 x float> @llvm.arm.mve.vmaxnma.predicated.v4f32.v4i1(<4 x float> %5, <4 x float> %10, <4 x i1> %8)
  %13 = add nsw i32 %6, -4
  %14 = icmp sgt i32 %6, 4
  br i1 %14, label %4, label %15

15:                                               ; preds = %4
  %16 = tail call fast float @llvm.arm.mve.maxnmav.f32.v4f32(float 0.000000e+00, <4 x float> %12)
  store float %16, ptr %2, align 4
  ret void
}

define void @loop_absmax32_pred_c(ptr %0, i32 %1, ptr nocapture %2) {
; CHECK-LABEL: loop_absmax32_pred_c:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    vmov.i32 q0, #0x0
; CHECK-NEXT:    dlstp.32 lr, r1
; CHECK-NEXT:  .LBB19_1: @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrw.u32 q1, [r0], #16
; CHECK-NEXT:    vmaxnma.f32 q1, q0
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    letp lr, .LBB19_1
; CHECK-NEXT:  @ %bb.2:
; CHECK-NEXT:    vldr s0, .LCPI19_0
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    vmaxnmav.f32 r0, q1
; CHECK-NEXT:    vmov s0, r0
; CHECK-NEXT:    vstr s0, [r2]
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 2
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:  .LCPI19_0:
; CHECK-NEXT:    .long 0x00000000 @ float 0
  br label %4

4:                                                ; preds = %4, %3
  %5 = phi <4 x float> [ zeroinitializer, %3 ], [ %12, %4 ]
  %6 = phi i32 [ %1, %3 ], [ %13, %4 ]
  %7 = phi ptr [ %0, %3 ], [ %11, %4 ]
  %8 = tail call <4 x i1> @llvm.arm.mve.vctp32(i32 %6)
  %9 = bitcast ptr %7 to ptr
  %10 = tail call fast <4 x float> @llvm.masked.load.v4f32.p0(ptr %9, i32 4, <4 x i1> %8, <4 x float> zeroinitializer)
  %11 = getelementptr inbounds float, ptr %7, i32 4
  %12 = tail call fast <4 x float> @llvm.arm.mve.vmaxnma.predicated.v4f32.v4i1(<4 x float> %10, <4 x float> %5, <4 x i1> %8)
  %13 = add nsw i32 %6, -4
  %14 = icmp sgt i32 %6, 4
  br i1 %14, label %4, label %15

15:                                               ; preds = %4
  %16 = tail call fast float @llvm.arm.mve.maxnmav.f32.v4f32(float 0.000000e+00, <4 x float> %12)
  store float %16, ptr %2, align 4
  ret void
}






define void @loop_absmax16(ptr nocapture readonly %0, i32 %1, ptr nocapture %2) {
; CHECK-LABEL: loop_absmax16:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    vmov.i32 q0, #0x0
; CHECK-NEXT:    lsrs r1, r1, #3
; CHECK-NEXT:    wls lr, r1, .LBB20_3
; CHECK-NEXT:  @ %bb.1: @ %.preheader
; CHECK-NEXT:    vmov.i32 q0, #0x0
; CHECK-NEXT:  .LBB20_2: @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrw.u32 q1, [r0], #8
; CHECK-NEXT:    vabs.f16 q1, q1
; CHECK-NEXT:    vmaxnm.f16 q0, q0, q1
; CHECK-NEXT:    le lr, .LBB20_2
; CHECK-NEXT:  .LBB20_3:
; CHECK-NEXT:    vldr.16 s4, .LCPI20_0
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vmaxnmav.f16 r0, q0
; CHECK-NEXT:    vmov s0, r0
; CHECK-NEXT:    vstr.16 s0, [r2]
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 1
; CHECK-NEXT:  @ %bb.4:
; CHECK-NEXT:  .LCPI20_0:
; CHECK-NEXT:    .short 0x0000 @ half 0
  %4 = lshr i32 %1, 3
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %18, label %6

6:                                                ; preds = %3, %6
  %7 = phi i32 [ %16, %6 ], [ %4, %3 ]
  %8 = phi <8 x half> [ %15, %6 ], [ zeroinitializer, %3 ]
  %9 = phi ptr [ %12, %6 ], [ %0, %3 ]
  %10 = bitcast ptr %9 to ptr
  %11 = load <8 x half>, ptr %10, align 4
  %12 = getelementptr inbounds half, ptr %9, i32 4
  %13 = tail call fast <8 x half> @llvm.fabs.v8f16(<8 x half> %11)
  %14 = tail call fast <8 x half> @llvm.fabs.v8f16(<8 x half> %8)
  %15 = tail call fast <8 x half> @llvm.maxnum.v8f16(<8 x half> %14, <8 x half> %13)
  %16 = add nsw i32 %7, -1
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %18, label %6

18:                                               ; preds = %6, %3
  %19 = phi <8 x half> [ zeroinitializer, %3 ], [ %15, %6 ]
  %20 = tail call fast half @llvm.arm.mve.maxnmav.f16.v8f16(half 0.000000e+00, <8 x half> %19)
  store half %20, ptr %2, align 4
  ret void
}

define void @loop_absmax16_c(ptr nocapture readonly %0, i32 %1, ptr nocapture %2) {
; CHECK-LABEL: loop_absmax16_c:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    vmov.i32 q0, #0x0
; CHECK-NEXT:    lsrs r1, r1, #3
; CHECK-NEXT:    wls lr, r1, .LBB21_3
; CHECK-NEXT:  @ %bb.1: @ %.preheader
; CHECK-NEXT:    vmov.i32 q0, #0x0
; CHECK-NEXT:  .LBB21_2: @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrw.u32 q1, [r0], #8
; CHECK-NEXT:    vabs.f16 q1, q1
; CHECK-NEXT:    vmaxnm.f16 q0, q1, q0
; CHECK-NEXT:    le lr, .LBB21_2
; CHECK-NEXT:  .LBB21_3:
; CHECK-NEXT:    vldr.16 s4, .LCPI21_0
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vmaxnmav.f16 r0, q0
; CHECK-NEXT:    vmov s0, r0
; CHECK-NEXT:    vstr.16 s0, [r2]
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 1
; CHECK-NEXT:  @ %bb.4:
; CHECK-NEXT:  .LCPI21_0:
; CHECK-NEXT:    .short 0x0000 @ half 0
  %4 = lshr i32 %1, 3
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %18, label %6

6:                                                ; preds = %3, %6
  %7 = phi i32 [ %16, %6 ], [ %4, %3 ]
  %8 = phi <8 x half> [ %15, %6 ], [ zeroinitializer, %3 ]
  %9 = phi ptr [ %12, %6 ], [ %0, %3 ]
  %10 = bitcast ptr %9 to ptr
  %11 = load <8 x half>, ptr %10, align 4
  %12 = getelementptr inbounds half, ptr %9, i32 4
  %13 = tail call fast <8 x half> @llvm.fabs.v8f16(<8 x half> %11)
  %14 = tail call fast <8 x half> @llvm.fabs.v8f16(<8 x half> %8)
  %15 = tail call fast <8 x half> @llvm.maxnum.v8f16(<8 x half> %13, <8 x half> %14)
  %16 = add nsw i32 %7, -1
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %18, label %6

18:                                               ; preds = %6, %3
  %19 = phi <8 x half> [ zeroinitializer, %3 ], [ %15, %6 ]
  %20 = tail call fast half @llvm.arm.mve.maxnmav.f16.v8f16(half 0.000000e+00, <8 x half> %19)
  store half %20, ptr %2, align 4
  ret void
}

define void @loop_absmax16_pred(ptr %0, i32 %1, ptr nocapture %2) {
; CHECK-LABEL: loop_absmax16_pred:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    vmov.i32 q0, #0x0
; CHECK-NEXT:    dlstp.16 lr, r1
; CHECK-NEXT:  .LBB22_1: @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrh.u16 q1, [r0], #8
; CHECK-NEXT:    vmaxnma.f16 q0, q1
; CHECK-NEXT:    letp lr, .LBB22_1
; CHECK-NEXT:  @ %bb.2:
; CHECK-NEXT:    vldr.16 s4, .LCPI22_0
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vmaxnmav.f16 r0, q0
; CHECK-NEXT:    vmov s0, r0
; CHECK-NEXT:    vstr.16 s0, [r2]
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 1
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:  .LCPI22_0:
; CHECK-NEXT:    .short 0x0000 @ half 0
  br label %4

4:                                                ; preds = %4, %3
  %5 = phi <8 x half> [ zeroinitializer, %3 ], [ %12, %4 ]
  %6 = phi i32 [ %1, %3 ], [ %13, %4 ]
  %7 = phi ptr [ %0, %3 ], [ %11, %4 ]
  %8 = tail call <8 x i1> @llvm.arm.mve.vctp16(i32 %6)
  %9 = bitcast ptr %7 to ptr
  %10 = tail call fast <8 x half> @llvm.masked.load.v8f16.p0(ptr %9, i32 4, <8 x i1> %8, <8 x half> zeroinitializer)
  %11 = getelementptr inbounds half, ptr %7, i32 4
  %12 = tail call fast <8 x half> @llvm.arm.mve.vmaxnma.predicated.v8f16.v8i1(<8 x half> %5, <8 x half> %10, <8 x i1> %8)
  %13 = add nsw i32 %6, -8
  %14 = icmp sgt i32 %6, 8
  br i1 %14, label %4, label %15

15:                                               ; preds = %4
  %16 = tail call fast half @llvm.arm.mve.maxnmav.f16.v8f16(half 0.000000e+00, <8 x half> %12)
  store half %16, ptr %2, align 4
  ret void
}

define void @loop_absmax16_pred_c(ptr %0, i32 %1, ptr nocapture %2) {
; CHECK-LABEL: loop_absmax16_pred_c:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    vmov.i32 q0, #0x0
; CHECK-NEXT:    dlstp.16 lr, r1
; CHECK-NEXT:  .LBB23_1: @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrh.u16 q1, [r0], #8
; CHECK-NEXT:    vmaxnma.f16 q1, q0
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    letp lr, .LBB23_1
; CHECK-NEXT:  @ %bb.2:
; CHECK-NEXT:    vldr.16 s0, .LCPI23_0
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    vmaxnmav.f16 r0, q1
; CHECK-NEXT:    vmov s0, r0
; CHECK-NEXT:    vstr.16 s0, [r2]
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 1
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:  .LCPI23_0:
; CHECK-NEXT:    .short 0x0000 @ half 0
  br label %4

4:                                                ; preds = %4, %3
  %5 = phi <8 x half> [ zeroinitializer, %3 ], [ %12, %4 ]
  %6 = phi i32 [ %1, %3 ], [ %13, %4 ]
  %7 = phi ptr [ %0, %3 ], [ %11, %4 ]
  %8 = tail call <8 x i1> @llvm.arm.mve.vctp16(i32 %6)
  %9 = bitcast ptr %7 to ptr
  %10 = tail call fast <8 x half> @llvm.masked.load.v8f16.p0(ptr %9, i32 4, <8 x i1> %8, <8 x half> zeroinitializer)
  %11 = getelementptr inbounds half, ptr %7, i32 4
  %12 = tail call fast <8 x half> @llvm.arm.mve.vmaxnma.predicated.v8f16.v8i1(<8 x half> %10, <8 x half> %5, <8 x i1> %8)
  %13 = add nsw i32 %6, -8
  %14 = icmp sgt i32 %6, 8
  br i1 %14, label %4, label %15

15:                                               ; preds = %4
  %16 = tail call fast half @llvm.arm.mve.maxnmav.f16.v8f16(half 0.000000e+00, <8 x half> %12)
  store half %16, ptr %2, align 4
  ret void
}





declare <4 x i1> @llvm.arm.mve.vctp32(i32)
declare <4 x float> @llvm.masked.load.v4f32.p0(ptr, i32 immarg, <4 x i1>, <4 x float>)
declare <4 x float> @llvm.arm.mve.vminnma.predicated.v4f32.v4i1(<4 x float>, <4 x float>, <4 x i1>)
declare <4 x float> @llvm.arm.mve.vmaxnma.predicated.v4f32.v4i1(<4 x float>, <4 x float>, <4 x i1>)
declare float @llvm.arm.mve.maxnmav.f32.v4f32(float, <4 x float>)
declare <4 x float> @llvm.fabs.v4f32(<4 x float>)
declare <4 x float> @llvm.maxnum.v4f32(<4 x float>, <4 x float>)
declare <4 x float> @llvm.minnum.v4f32(<4 x float>, <4 x float>)

declare <8 x i1> @llvm.arm.mve.vctp16(i32)
declare <8 x half> @llvm.masked.load.v8f16.p0(ptr, i32 immarg, <8 x i1>, <8 x half>)
declare <8 x half> @llvm.arm.mve.vminnma.predicated.v8f16.v8i1(<8 x half>, <8 x half>, <8 x i1>)
declare <8 x half> @llvm.arm.mve.vmaxnma.predicated.v8f16.v8i1(<8 x half>, <8 x half>, <8 x i1>)
declare half @llvm.arm.mve.maxnmav.f16.v8f16(half, <8 x half>)
declare <8 x half> @llvm.fabs.v8f16(<8 x half>)
declare <8 x half> @llvm.maxnum.v8f16(<8 x half>, <8 x half>)
declare <8 x half> @llvm.minnum.v8f16(<8 x half>, <8 x half>)


