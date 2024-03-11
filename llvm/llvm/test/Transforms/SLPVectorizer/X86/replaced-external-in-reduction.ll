; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -passes=slp-vectorizer -mtriple=x86_64-unknown-linux-gnu -S -slp-threshold=-14 < %s | FileCheck %s

define void @test(i32 %0, ptr %p) {
; CHECK-LABEL: define void @test(
; CHECK-SAME: i32 [[TMP0:%.*]], ptr [[P:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <4 x i32> <i32 0, i32 1, i32 0, i32 poison>, i32 [[TMP0]], i32 3
; CHECK-NEXT:    [[TMP2:%.*]] = xor <4 x i32> [[TMP1]], <i32 1, i32 0, i32 1, i32 0>
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <4 x i32> [[TMP2]], i32 3
; CHECK-NEXT:    br i1 false, label [[EXIT:%.*]], label [[PH:%.*]]
; CHECK:       ph:
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <4 x i32> <i32 poison, i32 0, i32 0, i32 0>, i32 [[TMP0]], i32 0
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[TMP5:%.*]] = phi <4 x i32> [ [[TMP2]], [[ENTRY:%.*]] ], [ zeroinitializer, [[PH]] ]
; CHECK-NEXT:    [[TMP6:%.*]] = phi <4 x i32> [ [[TMP2]], [[ENTRY]] ], [ [[TMP4]], [[PH]] ]
; CHECK-NEXT:    [[TMP7:%.*]] = phi <4 x i32> [ [[TMP2]], [[ENTRY]] ], [ zeroinitializer, [[PH]] ]
; CHECK-NEXT:    [[TMP8:%.*]] = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> [[TMP5]])
; CHECK-NEXT:    [[TMP9:%.*]] = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> [[TMP6]])
; CHECK-NEXT:    [[OP_RDX:%.*]] = or i32 [[TMP8]], [[TMP9]]
; CHECK-NEXT:    [[TMP10:%.*]] = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> [[TMP7]])
; CHECK-NEXT:    [[OP_RDX1:%.*]] = or i32 [[OP_RDX]], [[TMP10]]
; CHECK-NEXT:    [[OP_RDX2:%.*]] = or i32 [[OP_RDX1]], [[TMP3]]
; CHECK-NEXT:    store i32 [[OP_RDX2]], ptr [[P]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %xor.1.i = xor i32 1, 0
  %xor.2.i = xor i32 1, 0
  %xor.3.i = xor i32 1, 0
  %xor.4.i = xor i32 %0, 0
  br i1 false, label %exit, label %ph

ph:
  br label %exit

exit:
  %p1 = phi i32 [ %xor.1.i, %entry ], [ 0, %ph ]
  %p2 = phi i32 [ %xor.2.i, %entry ], [ 0, %ph ]
  %p3 = phi i32 [ %xor.3.i, %entry ], [ 0, %ph ]
  %p4 = phi i32 [ %xor.4.i, %entry ], [ 0, %ph ]
  %p5 = phi i32 [ %xor.1.i, %entry ], [ %0, %ph ]
  %p6 = phi i32 [ %xor.2.i, %entry ], [ 0, %ph ]
  %p7 = phi i32 [ %xor.3.i, %entry ], [ 0, %ph ]
  %p8 = phi i32 [ %xor.4.i, %entry ], [ 0, %ph ]
  %p9 = phi i32 [ %xor.4.i, %entry ], [ 0, %ph ]
  %p10 = phi i32 [ %xor.3.i, %entry ], [ 0, %ph ]
  %p11 = phi i32 [ %xor.2.i, %entry ], [ 0, %ph ]
  %p12 = phi i32 [ %xor.1.i, %entry ], [ 0, %ph ]
  %or.1.1.i = or i32 %xor.4.i, %p1
  %or.2.1.i = or i32 %or.1.1.i, %p2
  %or.3.1.i = or i32 %or.2.1.i, %p3
  %or.4.1.i = or i32 %or.3.1.i, %p4
  %or.1.2.i = or i32 %or.4.1.i, %p5
  %or.2.2.i = or i32 %or.1.2.i, %p6
  %or.3.2.i = or i32 %or.2.2.i, %p7
  %or.4.2.i = or i32 %or.3.2.i, %p8
  %or.326.i = or i32 %or.4.2.i, %p9
  %or.1.3.i = or i32 %or.326.i, %p10
  %or.2.3.i = or i32 %or.1.3.i, %p11
  %or.3.3.i = or i32 %or.2.3.i, %p12
  store i32 %or.3.3.i, ptr %p, align 4
  ret void
}