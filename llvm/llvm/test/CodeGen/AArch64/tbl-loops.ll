; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64 < %s | FileCheck %s

define void @loop1(ptr noalias nocapture noundef writeonly %dst, ptr nocapture noundef readonly %data, i32 noundef %width) {
; CHECK-LABEL: loop1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    subs w8, w2, #1
; CHECK-NEXT:    b.lt .LBB0_8
; CHECK-NEXT:  // %bb.1: // %for.body.preheader
; CHECK-NEXT:    cmp w8, #6
; CHECK-NEXT:    b.hi .LBB0_3
; CHECK-NEXT:  // %bb.2:
; CHECK-NEXT:    mov w10, wzr
; CHECK-NEXT:    mov x8, x1
; CHECK-NEXT:    mov x9, x0
; CHECK-NEXT:    b .LBB0_6
; CHECK-NEXT:  .LBB0_3: // %vector.ph
; CHECK-NEXT:    add x11, x8, #1
; CHECK-NEXT:    mov w8, #1132396544 // =0x437f0000
; CHECK-NEXT:    add x12, x0, #4
; CHECK-NEXT:    and x10, x11, #0x1fffffff8
; CHECK-NEXT:    dup v0.4s, w8
; CHECK-NEXT:    add x13, x1, #16
; CHECK-NEXT:    add x8, x1, x10, lsl #2
; CHECK-NEXT:    add x9, x0, x10
; CHECK-NEXT:    mov x14, x10
; CHECK-NEXT:  .LBB0_4: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldp q1, q2, [x13, #-16]
; CHECK-NEXT:    subs x14, x14, #8
; CHECK-NEXT:    add x13, x13, #32
; CHECK-NEXT:    fcmgt v3.4s, v1.4s, v0.4s
; CHECK-NEXT:    fcmgt v4.4s, v2.4s, v0.4s
; CHECK-NEXT:    fcmlt v5.4s, v1.4s, #0.0
; CHECK-NEXT:    fcmlt v6.4s, v2.4s, #0.0
; CHECK-NEXT:    bit v1.16b, v0.16b, v3.16b
; CHECK-NEXT:    bit v2.16b, v0.16b, v4.16b
; CHECK-NEXT:    bic v1.16b, v1.16b, v5.16b
; CHECK-NEXT:    bic v2.16b, v2.16b, v6.16b
; CHECK-NEXT:    fcvtzs v1.4s, v1.4s
; CHECK-NEXT:    fcvtzs v2.4s, v2.4s
; CHECK-NEXT:    xtn v1.4h, v1.4s
; CHECK-NEXT:    xtn v2.4h, v2.4s
; CHECK-NEXT:    xtn v1.8b, v1.8h
; CHECK-NEXT:    xtn v2.8b, v2.8h
; CHECK-NEXT:    mov v1.s[1], v2.s[0]
; CHECK-NEXT:    stur d1, [x12, #-4]
; CHECK-NEXT:    add x12, x12, #8
; CHECK-NEXT:    b.ne .LBB0_4
; CHECK-NEXT:  // %bb.5: // %middle.block
; CHECK-NEXT:    cmp x11, x10
; CHECK-NEXT:    b.eq .LBB0_8
; CHECK-NEXT:  .LBB0_6: // %for.body.preheader1
; CHECK-NEXT:    movi d0, #0000000000000000
; CHECK-NEXT:    mov w11, #1132396544 // =0x437f0000
; CHECK-NEXT:    sub w10, w2, w10
; CHECK-NEXT:    fmov s1, w11
; CHECK-NEXT:  .LBB0_7: // %for.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr s2, [x8], #4
; CHECK-NEXT:    fcmp s2, s1
; CHECK-NEXT:    fcsel s3, s1, s2, gt
; CHECK-NEXT:    fcmp s2, #0.0
; CHECK-NEXT:    fcsel s2, s0, s3, mi
; CHECK-NEXT:    subs w10, w10, #1
; CHECK-NEXT:    fcvtzs w11, s2
; CHECK-NEXT:    strb w11, [x9], #1
; CHECK-NEXT:    b.ne .LBB0_7
; CHECK-NEXT:  .LBB0_8: // %for.cond.cleanup
; CHECK-NEXT:    ret
entry:
  %cmp9 = icmp sgt i32 %width, 0
  br i1 %cmp9, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %0 = add i32 %width, -1
  %1 = zext i32 %0 to i64
  %2 = add nuw nsw i64 %1, 1
  %min.iters.check = icmp ult i32 %0, 7
  br i1 %min.iters.check, label %for.body.preheader21, label %vector.ph

vector.ph:                                        ; preds = %for.body.preheader
  %n.vec = and i64 %2, 8589934584
  %ind.end = trunc i64 %n.vec to i32
  %ind.end14 = getelementptr float, ptr %data, i64 %n.vec
  %ind.end16 = getelementptr i8, ptr %dst, i64 %n.vec
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %next.gep = getelementptr float, ptr %data, i64 %index
  %next.gep18 = getelementptr i8, ptr %dst, i64 %index
  %wide.load = load <4 x float>, ptr %next.gep, align 4
  %3 = getelementptr float, ptr %next.gep, i64 4
  %wide.load20 = load <4 x float>, ptr %3, align 4
  %4 = fcmp olt <4 x float> %wide.load, zeroinitializer
  %5 = fcmp olt <4 x float> %wide.load20, zeroinitializer
  %6 = fcmp ogt <4 x float> %wide.load, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>
  %7 = fcmp ogt <4 x float> %wide.load20, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>
  %8 = select <4 x i1> %6, <4 x float> <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, <4 x float> %wide.load
  %9 = select <4 x i1> %7, <4 x float> <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, <4 x float> %wide.load20
  %10 = select <4 x i1> %4, <4 x float> zeroinitializer, <4 x float> %8
  %11 = select <4 x i1> %5, <4 x float> zeroinitializer, <4 x float> %9
  %12 = fptoui <4 x float> %10 to <4 x i8>
  %13 = fptoui <4 x float> %11 to <4 x i8>
  store <4 x i8> %12, ptr %next.gep18, align 1
  %14 = getelementptr i8, ptr %next.gep18, i64 4
  store <4 x i8> %13, ptr %14, align 1
  %index.next = add nuw i64 %index, 8
  %15 = icmp eq i64 %index.next, %n.vec
  br i1 %15, label %middle.block, label %vector.body

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %2, %n.vec
  br i1 %cmp.n, label %for.cond.cleanup, label %for.body.preheader21

for.body.preheader21:                             ; preds = %for.body.preheader, %middle.block
  %i.012.ph = phi i32 [ 0, %for.body.preheader ], [ %ind.end, %middle.block ]
  %src.011.ph = phi ptr [ %data, %for.body.preheader ], [ %ind.end14, %middle.block ]
  %dst.addr.010.ph = phi ptr [ %dst, %for.body.preheader ], [ %ind.end16, %middle.block ]
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader21, %for.body
  %i.012 = phi i32 [ %inc, %for.body ], [ %i.012.ph, %for.body.preheader21 ]
  %src.011 = phi ptr [ %add.ptr, %for.body ], [ %src.011.ph, %for.body.preheader21 ]
  %dst.addr.010 = phi ptr [ %add.ptr2, %for.body ], [ %dst.addr.010.ph, %for.body.preheader21 ]
  %16 = load float, ptr %src.011, align 4
  %cmp.i = fcmp olt float %16, 0.000000e+00
  %cmp1.i = fcmp ogt float %16, 2.550000e+02
  %.x.i = select i1 %cmp1.i, float 2.550000e+02, float %16
  %retval.0.i = select i1 %cmp.i, float 0.000000e+00, float %.x.i
  %conv = fptoui float %retval.0.i to i8
  store i8 %conv, ptr %dst.addr.010, align 1
  %add.ptr = getelementptr inbounds float, ptr %src.011, i64 1
  %add.ptr2 = getelementptr inbounds i8, ptr %dst.addr.010, i64 1
  %inc = add nuw nsw i32 %i.012, 1
  %exitcond.not = icmp eq i32 %inc, %width
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

define void @loop2(ptr noalias nocapture noundef writeonly %dst, ptr nocapture noundef readonly %data, i32 noundef %width) {
; CHECK-LABEL: loop2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    subs w8, w2, #1
; CHECK-NEXT:    b.lt .LBB1_7
; CHECK-NEXT:  // %bb.1: // %for.body.preheader
; CHECK-NEXT:    cmp w8, #2
; CHECK-NEXT:    b.ls .LBB1_4
; CHECK-NEXT:  // %bb.2: // %vector.memcheck
; CHECK-NEXT:    ubfiz x9, x8, #1, #32
; CHECK-NEXT:    add x9, x9, #2
; CHECK-NEXT:    add x10, x1, x9, lsl #2
; CHECK-NEXT:    cmp x10, x0
; CHECK-NEXT:    b.ls .LBB1_8
; CHECK-NEXT:  // %bb.3: // %vector.memcheck
; CHECK-NEXT:    add x9, x0, x9
; CHECK-NEXT:    cmp x9, x1
; CHECK-NEXT:    b.ls .LBB1_8
; CHECK-NEXT:  .LBB1_4:
; CHECK-NEXT:    mov w10, wzr
; CHECK-NEXT:    mov x8, x1
; CHECK-NEXT:    mov x9, x0
; CHECK-NEXT:  .LBB1_5: // %for.body.preheader1
; CHECK-NEXT:    movi d0, #0000000000000000
; CHECK-NEXT:    mov w11, #1132396544 // =0x437f0000
; CHECK-NEXT:    sub w10, w2, w10
; CHECK-NEXT:    fmov s1, w11
; CHECK-NEXT:  .LBB1_6: // %for.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldp s2, s3, [x8], #8
; CHECK-NEXT:    fcmp s2, s1
; CHECK-NEXT:    fcsel s4, s1, s2, gt
; CHECK-NEXT:    fcmp s2, #0.0
; CHECK-NEXT:    fcsel s2, s0, s4, mi
; CHECK-NEXT:    fcmp s3, s1
; CHECK-NEXT:    fcsel s4, s1, s3, gt
; CHECK-NEXT:    fcmp s3, #0.0
; CHECK-NEXT:    fcvtzs w11, s2
; CHECK-NEXT:    fcsel s3, s0, s4, mi
; CHECK-NEXT:    subs w10, w10, #1
; CHECK-NEXT:    strb w11, [x9]
; CHECK-NEXT:    fcvtzs w12, s3
; CHECK-NEXT:    strb w12, [x9, #1]
; CHECK-NEXT:    add x9, x9, #2
; CHECK-NEXT:    b.ne .LBB1_6
; CHECK-NEXT:  .LBB1_7: // %for.cond.cleanup
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB1_8: // %vector.ph
; CHECK-NEXT:    add x11, x8, #1
; CHECK-NEXT:    mov w8, #1132396544 // =0x437f0000
; CHECK-NEXT:    and x10, x11, #0x1fffffffc
; CHECK-NEXT:    dup v0.4s, w8
; CHECK-NEXT:    add x8, x1, x10, lsl #3
; CHECK-NEXT:    add x9, x0, x10, lsl #1
; CHECK-NEXT:    mov x12, x10
; CHECK-NEXT:  .LBB1_9: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ld2 { v1.4s, v2.4s }, [x1], #32
; CHECK-NEXT:    subs x12, x12, #4
; CHECK-NEXT:    fcmgt v3.4s, v1.4s, v0.4s
; CHECK-NEXT:    fcmgt v4.4s, v2.4s, v0.4s
; CHECK-NEXT:    fcmlt v5.4s, v1.4s, #0.0
; CHECK-NEXT:    bsl v3.16b, v0.16b, v1.16b
; CHECK-NEXT:    bsl v4.16b, v0.16b, v2.16b
; CHECK-NEXT:    fcmlt v1.4s, v2.4s, #0.0
; CHECK-NEXT:    bic v2.16b, v3.16b, v5.16b
; CHECK-NEXT:    bic v1.16b, v4.16b, v1.16b
; CHECK-NEXT:    fcvtzs v2.4s, v2.4s
; CHECK-NEXT:    fcvtzs v1.4s, v1.4s
; CHECK-NEXT:    xtn v2.4h, v2.4s
; CHECK-NEXT:    xtn v1.4h, v1.4s
; CHECK-NEXT:    trn1 v1.8b, v2.8b, v1.8b
; CHECK-NEXT:    str d1, [x0], #8
; CHECK-NEXT:    b.ne .LBB1_9
; CHECK-NEXT:  // %bb.10: // %middle.block
; CHECK-NEXT:    cmp x11, x10
; CHECK-NEXT:    b.ne .LBB1_5
; CHECK-NEXT:    b .LBB1_7
entry:
  %cmp19 = icmp sgt i32 %width, 0
  br i1 %cmp19, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %0 = add i32 %width, -1
  %1 = zext i32 %0 to i64
  %2 = add nuw nsw i64 %1, 1
  %min.iters.check = icmp ult i32 %0, 3
  br i1 %min.iters.check, label %for.body.preheader35, label %vector.memcheck

vector.memcheck:                                  ; preds = %for.body.preheader
  %3 = add i32 %width, -1
  %4 = zext i32 %3 to i64
  %5 = shl nuw nsw i64 %4, 1
  %6 = add nuw nsw i64 %5, 2
  %scevgep = getelementptr i8, ptr %dst, i64 %6
  %scevgep24 = getelementptr float, ptr %data, i64 %6
  %bound0 = icmp ugt ptr %scevgep24, %dst
  %bound1 = icmp ugt ptr %scevgep, %data
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %for.body.preheader35, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %n.vec = and i64 %2, 8589934588
  %ind.end = trunc i64 %n.vec to i32
  %7 = shl nuw nsw i64 %n.vec, 1
  %ind.end27 = getelementptr float, ptr %data, i64 %7
  %8 = shl nuw nsw i64 %n.vec, 1
  %ind.end29 = getelementptr i8, ptr %dst, i64 %8
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %9 = shl i64 %index, 1
  %next.gep = getelementptr float, ptr %data, i64 %9
  %10 = shl i64 %index, 1
  %wide.vec = load <8 x float>, ptr %next.gep, align 4
  %strided.vec = shufflevector <8 x float> %wide.vec, <8 x float> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %strided.vec34 = shufflevector <8 x float> %wide.vec, <8 x float> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %11 = fcmp olt <4 x float> %strided.vec, zeroinitializer
  %12 = fcmp ogt <4 x float> %strided.vec, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>
  %13 = select <4 x i1> %12, <4 x float> <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, <4 x float> %strided.vec
  %14 = select <4 x i1> %11, <4 x float> zeroinitializer, <4 x float> %13
  %15 = fptoui <4 x float> %14 to <4 x i8>
  %16 = fcmp olt <4 x float> %strided.vec34, zeroinitializer
  %17 = fcmp ogt <4 x float> %strided.vec34, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>
  %18 = select <4 x i1> %17, <4 x float> <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, <4 x float> %strided.vec34
  %19 = select <4 x i1> %16, <4 x float> zeroinitializer, <4 x float> %18
  %20 = fptoui <4 x float> %19 to <4 x i8>
  %21 = getelementptr inbounds i8, ptr %dst, i64 %10
  %interleaved.vec = shufflevector <4 x i8> %15, <4 x i8> %20, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 2, i32 6, i32 3, i32 7>
  store <8 x i8> %interleaved.vec, ptr %21, align 1
  %index.next = add nuw i64 %index, 4
  %22 = icmp eq i64 %index.next, %n.vec
  br i1 %22, label %middle.block, label %vector.body

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %2, %n.vec
  br i1 %cmp.n, label %for.cond.cleanup, label %for.body.preheader35

for.body.preheader35:                             ; preds = %vector.memcheck, %for.body.preheader, %middle.block
  %i.022.ph = phi i32 [ 0, %vector.memcheck ], [ 0, %for.body.preheader ], [ %ind.end, %middle.block ]
  %src.021.ph = phi ptr [ %data, %vector.memcheck ], [ %data, %for.body.preheader ], [ %ind.end27, %middle.block ]
  %dst.addr.020.ph = phi ptr [ %dst, %vector.memcheck ], [ %dst, %for.body.preheader ], [ %ind.end29, %middle.block ]
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader35, %for.body
  %i.022 = phi i32 [ %inc, %for.body ], [ %i.022.ph, %for.body.preheader35 ]
  %src.021 = phi ptr [ %add.ptr, %for.body ], [ %src.021.ph, %for.body.preheader35 ]
  %dst.addr.020 = phi ptr [ %add.ptr6, %for.body ], [ %dst.addr.020.ph, %for.body.preheader35 ]
  %23 = load float, ptr %src.021, align 4
  %cmp.i = fcmp olt float %23, 0.000000e+00
  %cmp1.i = fcmp ogt float %23, 2.550000e+02
  %.x.i = select i1 %cmp1.i, float 2.550000e+02, float %23
  %retval.0.i = select i1 %cmp.i, float 0.000000e+00, float %.x.i
  %conv = fptoui float %retval.0.i to i8
  store i8 %conv, ptr %dst.addr.020, align 1
  %arrayidx2 = getelementptr inbounds float, ptr %src.021, i64 1
  %24 = load float, ptr %arrayidx2, align 4
  %cmp.i15 = fcmp olt float %24, 0.000000e+00
  %cmp1.i16 = fcmp ogt float %24, 2.550000e+02
  %.x.i17 = select i1 %cmp1.i16, float 2.550000e+02, float %24
  %retval.0.i18 = select i1 %cmp.i15, float 0.000000e+00, float %.x.i17
  %conv4 = fptoui float %retval.0.i18 to i8
  %arrayidx5 = getelementptr inbounds i8, ptr %dst.addr.020, i64 1
  store i8 %conv4, ptr %arrayidx5, align 1
  %add.ptr = getelementptr inbounds float, ptr %src.021, i64 2
  %add.ptr6 = getelementptr inbounds i8, ptr %dst.addr.020, i64 2
  %inc = add nuw nsw i32 %i.022, 1
  %exitcond.not = icmp eq i32 %inc, %width
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

define void @loop3(ptr noalias nocapture noundef writeonly %dst, ptr nocapture noundef readonly %data, i32 noundef %width) {
; CHECK-LABEL: loop3:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    subs w8, w2, #1
; CHECK-NEXT:    b.lt .LBB2_9
; CHECK-NEXT:  // %bb.1: // %for.body.preheader
; CHECK-NEXT:    cmp w8, #2
; CHECK-NEXT:    b.ls .LBB2_6
; CHECK-NEXT:  // %bb.2: // %vector.memcheck
; CHECK-NEXT:    add x9, x8, w8, uxtw #1
; CHECK-NEXT:    add x9, x9, #3
; CHECK-NEXT:    add x10, x1, x9, lsl #2
; CHECK-NEXT:    add x9, x0, x9
; CHECK-NEXT:    cmp x10, x0
; CHECK-NEXT:    ccmp x9, x1, #0, hi
; CHECK-NEXT:    b.hi .LBB2_6
; CHECK-NEXT:  // %bb.3: // %vector.ph
; CHECK-NEXT:    add x11, x8, #1
; CHECK-NEXT:    mov w8, #1132396544 // =0x437f0000
; CHECK-NEXT:    adrp x12, .LCPI2_0
; CHECK-NEXT:    and x10, x11, #0x1fffffffc
; CHECK-NEXT:    dup v0.4s, w8
; CHECK-NEXT:    ldr q1, [x12, :lo12:.LCPI2_0]
; CHECK-NEXT:    add x9, x10, x10, lsl #1
; CHECK-NEXT:    mov x12, x10
; CHECK-NEXT:    add x8, x1, x9, lsl #2
; CHECK-NEXT:    add x9, x0, x9
; CHECK-NEXT:  .LBB2_4: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ld3 { v2.4s, v3.4s, v4.4s }, [x1], #48
; CHECK-NEXT:    add x13, x0, #8
; CHECK-NEXT:    subs x12, x12, #4
; CHECK-NEXT:    fcmgt v5.4s, v2.4s, v0.4s
; CHECK-NEXT:    fcmgt v6.4s, v3.4s, v0.4s
; CHECK-NEXT:    fcmgt v7.4s, v4.4s, v0.4s
; CHECK-NEXT:    fcmlt v16.4s, v2.4s, #0.0
; CHECK-NEXT:    fcmlt v17.4s, v3.4s, #0.0
; CHECK-NEXT:    bsl v5.16b, v0.16b, v2.16b
; CHECK-NEXT:    bsl v6.16b, v0.16b, v3.16b
; CHECK-NEXT:    bsl v7.16b, v0.16b, v4.16b
; CHECK-NEXT:    fcmlt v2.4s, v4.4s, #0.0
; CHECK-NEXT:    bic v3.16b, v5.16b, v16.16b
; CHECK-NEXT:    bic v4.16b, v6.16b, v17.16b
; CHECK-NEXT:    bic v2.16b, v7.16b, v2.16b
; CHECK-NEXT:    fcvtzs v3.4s, v3.4s
; CHECK-NEXT:    fcvtzs v4.4s, v4.4s
; CHECK-NEXT:    fcvtzs v2.4s, v2.4s
; CHECK-NEXT:    xtn v5.4h, v3.4s
; CHECK-NEXT:    xtn v6.4h, v4.4s
; CHECK-NEXT:    xtn v7.4h, v2.4s
; CHECK-NEXT:    tbl v2.16b, { v5.16b, v6.16b, v7.16b }, v1.16b
; CHECK-NEXT:    st1 { v2.s }[2], [x13]
; CHECK-NEXT:    str d2, [x0], #12
; CHECK-NEXT:    b.ne .LBB2_4
; CHECK-NEXT:  // %bb.5: // %middle.block
; CHECK-NEXT:    cmp x11, x10
; CHECK-NEXT:    b.ne .LBB2_7
; CHECK-NEXT:    b .LBB2_9
; CHECK-NEXT:  .LBB2_6:
; CHECK-NEXT:    mov w10, wzr
; CHECK-NEXT:    mov x8, x1
; CHECK-NEXT:    mov x9, x0
; CHECK-NEXT:  .LBB2_7: // %for.body.preheader1
; CHECK-NEXT:    movi d0, #0000000000000000
; CHECK-NEXT:    mov w11, #1132396544 // =0x437f0000
; CHECK-NEXT:    sub w10, w2, w10
; CHECK-NEXT:    fmov s1, w11
; CHECK-NEXT:  .LBB2_8: // %for.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldp s2, s3, [x8]
; CHECK-NEXT:    fcmp s2, s1
; CHECK-NEXT:    fcsel s4, s1, s2, gt
; CHECK-NEXT:    fcmp s2, #0.0
; CHECK-NEXT:    fcsel s2, s0, s4, mi
; CHECK-NEXT:    fcmp s3, s1
; CHECK-NEXT:    fcsel s4, s1, s3, gt
; CHECK-NEXT:    fcmp s3, #0.0
; CHECK-NEXT:    ldr s3, [x8, #8]
; CHECK-NEXT:    fcvtzs w11, s2
; CHECK-NEXT:    add x8, x8, #12
; CHECK-NEXT:    fcsel s4, s0, s4, mi
; CHECK-NEXT:    fcmp s3, s1
; CHECK-NEXT:    strb w11, [x9]
; CHECK-NEXT:    fcsel s5, s1, s3, gt
; CHECK-NEXT:    fcmp s3, #0.0
; CHECK-NEXT:    fcvtzs w12, s4
; CHECK-NEXT:    fcsel s3, s0, s5, mi
; CHECK-NEXT:    subs w10, w10, #1
; CHECK-NEXT:    strb w12, [x9, #1]
; CHECK-NEXT:    fcvtzs w13, s3
; CHECK-NEXT:    strb w13, [x9, #2]
; CHECK-NEXT:    add x9, x9, #3
; CHECK-NEXT:    b.ne .LBB2_8
; CHECK-NEXT:  .LBB2_9: // %for.cond.cleanup
; CHECK-NEXT:    ret
entry:
  %cmp29 = icmp sgt i32 %width, 0
  br i1 %cmp29, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %0 = add i32 %width, -1
  %1 = zext i32 %0 to i64
  %2 = add nuw nsw i64 %1, 1
  %min.iters.check = icmp ult i32 %0, 3
  br i1 %min.iters.check, label %for.body.preheader46, label %vector.memcheck

vector.memcheck:                                  ; preds = %for.body.preheader
  %3 = add i32 %width, -1
  %4 = zext i32 %3 to i64
  %5 = mul nuw nsw i64 %4, 3
  %6 = add nuw nsw i64 %5, 3
  %scevgep = getelementptr i8, ptr %dst, i64 %6
  %scevgep34 = getelementptr float, ptr %data, i64 %6
  %bound0 = icmp ugt ptr %scevgep34, %dst
  %bound1 = icmp ugt ptr %scevgep, %data
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %for.body.preheader46, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %n.vec = and i64 %2, 8589934588
  %ind.end = trunc i64 %n.vec to i32
  %7 = mul nuw nsw i64 %n.vec, 3
  %ind.end37 = getelementptr float, ptr %data, i64 %7
  %8 = mul nuw nsw i64 %n.vec, 3
  %ind.end39 = getelementptr i8, ptr %dst, i64 %8
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %9 = mul i64 %index, 3
  %next.gep = getelementptr float, ptr %data, i64 %9
  %10 = mul i64 %index, 3
  %wide.vec = load <12 x float>, ptr %next.gep, align 4
  %strided.vec = shufflevector <12 x float> %wide.vec, <12 x float> poison, <4 x i32> <i32 0, i32 3, i32 6, i32 9>
  %strided.vec44 = shufflevector <12 x float> %wide.vec, <12 x float> poison, <4 x i32> <i32 1, i32 4, i32 7, i32 10>
  %strided.vec45 = shufflevector <12 x float> %wide.vec, <12 x float> poison, <4 x i32> <i32 2, i32 5, i32 8, i32 11>
  %11 = fcmp olt <4 x float> %strided.vec, zeroinitializer
  %12 = fcmp ogt <4 x float> %strided.vec, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>
  %13 = select <4 x i1> %12, <4 x float> <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, <4 x float> %strided.vec
  %14 = select <4 x i1> %11, <4 x float> zeroinitializer, <4 x float> %13
  %15 = fptoui <4 x float> %14 to <4 x i8>
  %16 = fcmp olt <4 x float> %strided.vec44, zeroinitializer
  %17 = fcmp ogt <4 x float> %strided.vec44, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>
  %18 = select <4 x i1> %17, <4 x float> <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, <4 x float> %strided.vec44
  %19 = select <4 x i1> %16, <4 x float> zeroinitializer, <4 x float> %18
  %20 = fptoui <4 x float> %19 to <4 x i8>
  %21 = fcmp olt <4 x float> %strided.vec45, zeroinitializer
  %22 = fcmp ogt <4 x float> %strided.vec45, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>
  %23 = select <4 x i1> %22, <4 x float> <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, <4 x float> %strided.vec45
  %24 = select <4 x i1> %21, <4 x float> zeroinitializer, <4 x float> %23
  %25 = fptoui <4 x float> %24 to <4 x i8>
  %26 = getelementptr inbounds i8, ptr %dst, i64 %10
  %27 = shufflevector <4 x i8> %15, <4 x i8> %20, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %28 = shufflevector <4 x i8> %25, <4 x i8> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef>
  %interleaved.vec = shufflevector <8 x i8> %27, <8 x i8> %28, <12 x i32> <i32 0, i32 4, i32 8, i32 1, i32 5, i32 9, i32 2, i32 6, i32 10, i32 3, i32 7, i32 11>
  store <12 x i8> %interleaved.vec, ptr %26, align 1
  %index.next = add nuw i64 %index, 4
  %29 = icmp eq i64 %index.next, %n.vec
  br i1 %29, label %middle.block, label %vector.body

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %2, %n.vec
  br i1 %cmp.n, label %for.cond.cleanup, label %for.body.preheader46

for.body.preheader46:                             ; preds = %vector.memcheck, %for.body.preheader, %middle.block
  %i.032.ph = phi i32 [ 0, %vector.memcheck ], [ 0, %for.body.preheader ], [ %ind.end, %middle.block ]
  %src.031.ph = phi ptr [ %data, %vector.memcheck ], [ %data, %for.body.preheader ], [ %ind.end37, %middle.block ]
  %dst.addr.030.ph = phi ptr [ %dst, %vector.memcheck ], [ %dst, %for.body.preheader ], [ %ind.end39, %middle.block ]
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader46, %for.body
  %i.032 = phi i32 [ %inc, %for.body ], [ %i.032.ph, %for.body.preheader46 ]
  %src.031 = phi ptr [ %add.ptr, %for.body ], [ %src.031.ph, %for.body.preheader46 ]
  %dst.addr.030 = phi ptr [ %add.ptr10, %for.body ], [ %dst.addr.030.ph, %for.body.preheader46 ]
  %30 = load float, ptr %src.031, align 4
  %cmp.i = fcmp olt float %30, 0.000000e+00
  %cmp1.i = fcmp ogt float %30, 2.550000e+02
  %.x.i = select i1 %cmp1.i, float 2.550000e+02, float %30
  %retval.0.i = select i1 %cmp.i, float 0.000000e+00, float %.x.i
  %conv = fptoui float %retval.0.i to i8
  store i8 %conv, ptr %dst.addr.030, align 1
  %arrayidx2 = getelementptr inbounds float, ptr %src.031, i64 1
  %31 = load float, ptr %arrayidx2, align 4
  %cmp.i21 = fcmp olt float %31, 0.000000e+00
  %cmp1.i22 = fcmp ogt float %31, 2.550000e+02
  %.x.i23 = select i1 %cmp1.i22, float 2.550000e+02, float %31
  %retval.0.i24 = select i1 %cmp.i21, float 0.000000e+00, float %.x.i23
  %conv4 = fptoui float %retval.0.i24 to i8
  %arrayidx5 = getelementptr inbounds i8, ptr %dst.addr.030, i64 1
  store i8 %conv4, ptr %arrayidx5, align 1
  %arrayidx6 = getelementptr inbounds float, ptr %src.031, i64 2
  %32 = load float, ptr %arrayidx6, align 4
  %cmp.i25 = fcmp olt float %32, 0.000000e+00
  %cmp1.i26 = fcmp ogt float %32, 2.550000e+02
  %.x.i27 = select i1 %cmp1.i26, float 2.550000e+02, float %32
  %retval.0.i28 = select i1 %cmp.i25, float 0.000000e+00, float %.x.i27
  %conv8 = fptoui float %retval.0.i28 to i8
  %arrayidx9 = getelementptr inbounds i8, ptr %dst.addr.030, i64 2
  store i8 %conv8, ptr %arrayidx9, align 1
  %add.ptr = getelementptr inbounds float, ptr %src.031, i64 3
  %add.ptr10 = getelementptr inbounds i8, ptr %dst.addr.030, i64 3
  %inc = add nuw nsw i32 %i.032, 1
  %exitcond.not = icmp eq i32 %inc, %width
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

define void @loop4(ptr noalias nocapture noundef writeonly %dst, ptr nocapture noundef readonly %data, i32 noundef %width) {
; CHECK-LABEL: loop4:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    subs w8, w2, #1
; CHECK-NEXT:    b.lt .LBB3_7
; CHECK-NEXT:  // %bb.1: // %for.body.preheader
; CHECK-NEXT:    cmp w8, #2
; CHECK-NEXT:    b.ls .LBB3_4
; CHECK-NEXT:  // %bb.2: // %vector.memcheck
; CHECK-NEXT:    ubfiz x9, x8, #2, #32
; CHECK-NEXT:    add x9, x9, #4
; CHECK-NEXT:    add x10, x1, x9, lsl #2
; CHECK-NEXT:    cmp x10, x0
; CHECK-NEXT:    b.ls .LBB3_8
; CHECK-NEXT:  // %bb.3: // %vector.memcheck
; CHECK-NEXT:    add x9, x0, x9
; CHECK-NEXT:    cmp x9, x1
; CHECK-NEXT:    b.ls .LBB3_8
; CHECK-NEXT:  .LBB3_4:
; CHECK-NEXT:    mov w10, wzr
; CHECK-NEXT:    mov x8, x1
; CHECK-NEXT:    mov x9, x0
; CHECK-NEXT:  .LBB3_5: // %for.body.preheader1
; CHECK-NEXT:    movi d0, #0000000000000000
; CHECK-NEXT:    mov w11, #1132396544 // =0x437f0000
; CHECK-NEXT:    sub w10, w2, w10
; CHECK-NEXT:    fmov s1, w11
; CHECK-NEXT:  .LBB3_6: // %for.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldp s2, s3, [x8]
; CHECK-NEXT:    fcmp s2, s1
; CHECK-NEXT:    fcsel s4, s1, s2, gt
; CHECK-NEXT:    fcmp s2, #0.0
; CHECK-NEXT:    fcsel s2, s0, s4, mi
; CHECK-NEXT:    fcmp s3, s1
; CHECK-NEXT:    fcsel s4, s1, s3, gt
; CHECK-NEXT:    fcmp s3, #0.0
; CHECK-NEXT:    fcvtzs w11, s2
; CHECK-NEXT:    ldp s3, s5, [x8, #8]
; CHECK-NEXT:    add x8, x8, #16
; CHECK-NEXT:    fcsel s4, s0, s4, mi
; CHECK-NEXT:    fcmp s3, s1
; CHECK-NEXT:    strb w11, [x9]
; CHECK-NEXT:    fcvtzs w12, s4
; CHECK-NEXT:    fcsel s6, s1, s3, gt
; CHECK-NEXT:    fcmp s3, #0.0
; CHECK-NEXT:    fcsel s3, s0, s6, mi
; CHECK-NEXT:    fcmp s5, s1
; CHECK-NEXT:    strb w12, [x9, #1]
; CHECK-NEXT:    fcsel s6, s1, s5, gt
; CHECK-NEXT:    fcmp s5, #0.0
; CHECK-NEXT:    fcvtzs w13, s3
; CHECK-NEXT:    fcsel s2, s0, s6, mi
; CHECK-NEXT:    subs w10, w10, #1
; CHECK-NEXT:    strb w13, [x9, #2]
; CHECK-NEXT:    fcvtzs w14, s2
; CHECK-NEXT:    strb w14, [x9, #3]
; CHECK-NEXT:    add x9, x9, #4
; CHECK-NEXT:    b.ne .LBB3_6
; CHECK-NEXT:  .LBB3_7: // %for.cond.cleanup
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB3_8: // %vector.ph
; CHECK-NEXT:    add x11, x8, #1
; CHECK-NEXT:    mov w8, #1132396544 // =0x437f0000
; CHECK-NEXT:    adrp x12, .LCPI3_0
; CHECK-NEXT:    and x10, x11, #0x1fffffffc
; CHECK-NEXT:    dup v0.4s, w8
; CHECK-NEXT:    ldr q1, [x12, :lo12:.LCPI3_0]
; CHECK-NEXT:    add x8, x1, x10, lsl #4
; CHECK-NEXT:    add x9, x0, x10, lsl #2
; CHECK-NEXT:    mov x12, x10
; CHECK-NEXT:  .LBB3_9: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ld4 { v2.4s, v3.4s, v4.4s, v5.4s }, [x1], #64
; CHECK-NEXT:    subs x12, x12, #4
; CHECK-NEXT:    fcmgt v6.4s, v2.4s, v0.4s
; CHECK-NEXT:    fcmgt v7.4s, v3.4s, v0.4s
; CHECK-NEXT:    fcmgt v16.4s, v4.4s, v0.4s
; CHECK-NEXT:    fcmgt v17.4s, v5.4s, v0.4s
; CHECK-NEXT:    fcmlt v18.4s, v2.4s, #0.0
; CHECK-NEXT:    fcmlt v19.4s, v3.4s, #0.0
; CHECK-NEXT:    fcmlt v20.4s, v4.4s, #0.0
; CHECK-NEXT:    bsl v6.16b, v0.16b, v2.16b
; CHECK-NEXT:    bsl v7.16b, v0.16b, v3.16b
; CHECK-NEXT:    bsl v16.16b, v0.16b, v4.16b
; CHECK-NEXT:    bsl v17.16b, v0.16b, v5.16b
; CHECK-NEXT:    fcmlt v2.4s, v5.4s, #0.0
; CHECK-NEXT:    bic v3.16b, v6.16b, v18.16b
; CHECK-NEXT:    bic v4.16b, v7.16b, v19.16b
; CHECK-NEXT:    bic v5.16b, v16.16b, v20.16b
; CHECK-NEXT:    bic v2.16b, v17.16b, v2.16b
; CHECK-NEXT:    fcvtzs v3.4s, v3.4s
; CHECK-NEXT:    fcvtzs v4.4s, v4.4s
; CHECK-NEXT:    fcvtzs v5.4s, v5.4s
; CHECK-NEXT:    fcvtzs v2.4s, v2.4s
; CHECK-NEXT:    xtn v16.4h, v3.4s
; CHECK-NEXT:    xtn v17.4h, v4.4s
; CHECK-NEXT:    xtn v18.4h, v5.4s
; CHECK-NEXT:    xtn v19.4h, v2.4s
; CHECK-NEXT:    tbl v2.16b, { v16.16b, v17.16b, v18.16b, v19.16b }, v1.16b
; CHECK-NEXT:    str q2, [x0], #16
; CHECK-NEXT:    b.ne .LBB3_9
; CHECK-NEXT:  // %bb.10: // %middle.block
; CHECK-NEXT:    cmp x11, x10
; CHECK-NEXT:    b.ne .LBB3_5
; CHECK-NEXT:    b .LBB3_7
entry:
  %cmp39 = icmp sgt i32 %width, 0
  br i1 %cmp39, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %0 = add i32 %width, -1
  %1 = zext i32 %0 to i64
  %2 = add nuw nsw i64 %1, 1
  %min.iters.check = icmp ult i32 %0, 3
  br i1 %min.iters.check, label %for.body.preheader57, label %vector.memcheck

vector.memcheck:                                  ; preds = %for.body.preheader
  %3 = add i32 %width, -1
  %4 = zext i32 %3 to i64
  %5 = shl nuw nsw i64 %4, 2
  %6 = add nuw nsw i64 %5, 4
  %scevgep = getelementptr i8, ptr %dst, i64 %6
  %scevgep44 = getelementptr float, ptr %data, i64 %6
  %bound0 = icmp ugt ptr %scevgep44, %dst
  %bound1 = icmp ugt ptr %scevgep, %data
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %for.body.preheader57, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %n.vec = and i64 %2, 8589934588
  %ind.end = trunc i64 %n.vec to i32
  %7 = shl nuw nsw i64 %n.vec, 2
  %ind.end47 = getelementptr float, ptr %data, i64 %7
  %8 = shl nuw nsw i64 %n.vec, 2
  %ind.end49 = getelementptr i8, ptr %dst, i64 %8
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %9 = shl i64 %index, 2
  %next.gep = getelementptr float, ptr %data, i64 %9
  %10 = shl i64 %index, 2
  %wide.vec = load <16 x float>, ptr %next.gep, align 4
  %strided.vec = shufflevector <16 x float> %wide.vec, <16 x float> poison, <4 x i32> <i32 0, i32 4, i32 8, i32 12>
  %strided.vec54 = shufflevector <16 x float> %wide.vec, <16 x float> poison, <4 x i32> <i32 1, i32 5, i32 9, i32 13>
  %strided.vec55 = shufflevector <16 x float> %wide.vec, <16 x float> poison, <4 x i32> <i32 2, i32 6, i32 10, i32 14>
  %strided.vec56 = shufflevector <16 x float> %wide.vec, <16 x float> poison, <4 x i32> <i32 3, i32 7, i32 11, i32 15>
  %11 = fcmp olt <4 x float> %strided.vec, zeroinitializer
  %12 = fcmp ogt <4 x float> %strided.vec, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>
  %13 = select <4 x i1> %12, <4 x float> <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, <4 x float> %strided.vec
  %14 = select <4 x i1> %11, <4 x float> zeroinitializer, <4 x float> %13
  %15 = fptoui <4 x float> %14 to <4 x i8>
  %16 = fcmp olt <4 x float> %strided.vec54, zeroinitializer
  %17 = fcmp ogt <4 x float> %strided.vec54, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>
  %18 = select <4 x i1> %17, <4 x float> <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, <4 x float> %strided.vec54
  %19 = select <4 x i1> %16, <4 x float> zeroinitializer, <4 x float> %18
  %20 = fptoui <4 x float> %19 to <4 x i8>
  %21 = fcmp olt <4 x float> %strided.vec55, zeroinitializer
  %22 = fcmp ogt <4 x float> %strided.vec55, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>
  %23 = select <4 x i1> %22, <4 x float> <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, <4 x float> %strided.vec55
  %24 = select <4 x i1> %21, <4 x float> zeroinitializer, <4 x float> %23
  %25 = fptoui <4 x float> %24 to <4 x i8>
  %26 = fcmp olt <4 x float> %strided.vec56, zeroinitializer
  %27 = fcmp ogt <4 x float> %strided.vec56, <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>
  %28 = select <4 x i1> %27, <4 x float> <float 2.550000e+02, float 2.550000e+02, float 2.550000e+02, float 2.550000e+02>, <4 x float> %strided.vec56
  %29 = select <4 x i1> %26, <4 x float> zeroinitializer, <4 x float> %28
  %30 = fptoui <4 x float> %29 to <4 x i8>
  %31 = getelementptr inbounds i8, ptr %dst, i64 %10
  %32 = shufflevector <4 x i8> %15, <4 x i8> %20, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %33 = shufflevector <4 x i8> %25, <4 x i8> %30, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %interleaved.vec = shufflevector <8 x i8> %32, <8 x i8> %33, <16 x i32> <i32 0, i32 4, i32 8, i32 12, i32 1, i32 5, i32 9, i32 13, i32 2, i32 6, i32 10, i32 14, i32 3, i32 7, i32 11, i32 15>
  store <16 x i8> %interleaved.vec, ptr %31, align 1
  %index.next = add nuw i64 %index, 4
  %34 = icmp eq i64 %index.next, %n.vec
  br i1 %34, label %middle.block, label %vector.body

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %2, %n.vec
  br i1 %cmp.n, label %for.cond.cleanup, label %for.body.preheader57

for.body.preheader57:                             ; preds = %vector.memcheck, %for.body.preheader, %middle.block
  %i.042.ph = phi i32 [ 0, %vector.memcheck ], [ 0, %for.body.preheader ], [ %ind.end, %middle.block ]
  %src.041.ph = phi ptr [ %data, %vector.memcheck ], [ %data, %for.body.preheader ], [ %ind.end47, %middle.block ]
  %dst.addr.040.ph = phi ptr [ %dst, %vector.memcheck ], [ %dst, %for.body.preheader ], [ %ind.end49, %middle.block ]
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader57, %for.body
  %i.042 = phi i32 [ %inc, %for.body ], [ %i.042.ph, %for.body.preheader57 ]
  %src.041 = phi ptr [ %add.ptr, %for.body ], [ %src.041.ph, %for.body.preheader57 ]
  %dst.addr.040 = phi ptr [ %add.ptr14, %for.body ], [ %dst.addr.040.ph, %for.body.preheader57 ]
  %35 = load float, ptr %src.041, align 4
  %cmp.i = fcmp olt float %35, 0.000000e+00
  %cmp1.i = fcmp ogt float %35, 2.550000e+02
  %.x.i = select i1 %cmp1.i, float 2.550000e+02, float %35
  %retval.0.i = select i1 %cmp.i, float 0.000000e+00, float %.x.i
  %conv = fptoui float %retval.0.i to i8
  store i8 %conv, ptr %dst.addr.040, align 1
  %arrayidx2 = getelementptr inbounds float, ptr %src.041, i64 1
  %36 = load float, ptr %arrayidx2, align 4
  %cmp.i27 = fcmp olt float %36, 0.000000e+00
  %cmp1.i28 = fcmp ogt float %36, 2.550000e+02
  %.x.i29 = select i1 %cmp1.i28, float 2.550000e+02, float %36
  %retval.0.i30 = select i1 %cmp.i27, float 0.000000e+00, float %.x.i29
  %conv4 = fptoui float %retval.0.i30 to i8
  %arrayidx5 = getelementptr inbounds i8, ptr %dst.addr.040, i64 1
  store i8 %conv4, ptr %arrayidx5, align 1
  %arrayidx6 = getelementptr inbounds float, ptr %src.041, i64 2
  %37 = load float, ptr %arrayidx6, align 4
  %cmp.i31 = fcmp olt float %37, 0.000000e+00
  %cmp1.i32 = fcmp ogt float %37, 2.550000e+02
  %.x.i33 = select i1 %cmp1.i32, float 2.550000e+02, float %37
  %retval.0.i34 = select i1 %cmp.i31, float 0.000000e+00, float %.x.i33
  %conv8 = fptoui float %retval.0.i34 to i8
  %arrayidx9 = getelementptr inbounds i8, ptr %dst.addr.040, i64 2
  store i8 %conv8, ptr %arrayidx9, align 1
  %arrayidx10 = getelementptr inbounds float, ptr %src.041, i64 3
  %38 = load float, ptr %arrayidx10, align 4
  %cmp.i35 = fcmp olt float %38, 0.000000e+00
  %cmp1.i36 = fcmp ogt float %38, 2.550000e+02
  %.x.i37 = select i1 %cmp1.i36, float 2.550000e+02, float %38
  %retval.0.i38 = select i1 %cmp.i35, float 0.000000e+00, float %.x.i37
  %conv12 = fptoui float %retval.0.i38 to i8
  %arrayidx13 = getelementptr inbounds i8, ptr %dst.addr.040, i64 3
  store i8 %conv12, ptr %arrayidx13, align 1
  %add.ptr = getelementptr inbounds float, ptr %src.041, i64 4
  %add.ptr14 = getelementptr inbounds i8, ptr %dst.addr.040, i64 4
  %inc = add nuw nsw i32 %i.042, 1
  %exitcond.not = icmp eq i32 %inc, %width
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}
