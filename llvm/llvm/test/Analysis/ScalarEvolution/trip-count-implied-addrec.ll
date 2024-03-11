; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -disable-output "-passes=print<scalar-evolution>"  -scalar-evolution-classify-expressions=0 2>&1 | FileCheck %s

; A collection of tests that show we can use facts about an exit test to
; infer tighter bounds on an IV, and thus refine an IV into an addrec. The
; basic tactic being used is proving NW from exit structure and then
; implying NUW/NSW.  Once NSW/NUW is inferred, we can derive addrecs from
; the zext/sext cases that we couldn't at initial SCEV construction.

@G = external global i8

define void @nw_implies_nuw(i16 %n) mustprogress {
; CHECK-LABEL: 'nw_implies_nuw'
; CHECK-NEXT:  Determining loop execution counts for: @nw_implies_nuw
; CHECK-NEXT:  Loop %for.body: backedge-taken count is %n
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is i16 -1
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is %n
; CHECK-NEXT:  Loop %for.body: Trip multiple is 1
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i8 [ %iv.next, %for.body ], [ 0, %entry ]
  %iv.next = add i8 %iv, 1
  %zext = zext i8 %iv to i16
  %cmp = icmp ult i16 %zext, %n
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @neg_nw_nuw(i16 %n) mustprogress {
; CHECK-LABEL: 'neg_nw_nuw'
; CHECK-NEXT:  Determining loop execution counts for: @neg_nw_nuw
; CHECK-NEXT:  Loop %for.body: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable constant max backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable symbolic max backedge-taken count.
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i8 [ %iv.next, %for.body ], [ 0, %entry ]
  %iv.next = add i8 %iv, -1
  %zext = zext i8 %iv to i16
  %cmp = icmp ult i16 %zext, %n
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @nw_implies_nsw(i16 %n) mustprogress {
; CHECK-LABEL: 'nw_implies_nsw'
; CHECK-NEXT:  Determining loop execution counts for: @nw_implies_nsw
; CHECK-NEXT:  Loop %for.body: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable constant max backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable symbolic max backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is (128 + (-128 smax %n))
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:      {-128,+,1}<%for.body> Added Flags: <nssw>
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i8 [ %iv.next, %for.body ], [ -128, %entry ]
  %iv.next = add i8 %iv, 1
  %zext = sext i8 %iv to i16
  %cmp = icmp slt i16 %zext, %n
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @neg_nw_nsw(i16 %n) mustprogress {
; CHECK-LABEL: 'neg_nw_nsw'
; CHECK-NEXT:  Determining loop execution counts for: @neg_nw_nsw
; CHECK-NEXT:  Loop %for.body: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable constant max backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable symbolic max backedge-taken count.
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i8 [ %iv.next, %for.body ], [ -128, %entry ]
  %iv.next = add i8 %iv, -1
  %zext = sext i8 %iv to i16
  %cmp = icmp slt i16 %zext, %n
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}


define void @actually_infinite() {
; CHECK-LABEL: 'actually_infinite'
; CHECK-NEXT:  Determining loop execution counts for: @actually_infinite
; CHECK-NEXT:  Loop %for.body: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable constant max backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable symbolic max backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is i16 257
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:      {0,+,1}<%for.body> Added Flags: <nusw>
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i8 [ %iv.next, %for.body ], [ 0, %entry ]
  store volatile i8 %iv, ptr @G
  %iv.next = add i8 %iv, 1
  %zext = zext i8 %iv to i16
  %cmp = icmp ult i16 %zext, 257
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @rhs_mustexit_1(i16 %n.raw) mustprogress {
; CHECK-LABEL: 'rhs_mustexit_1'
; CHECK-NEXT:  Determining loop execution counts for: @rhs_mustexit_1
; CHECK-NEXT:  Loop %for.body: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable constant max backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable symbolic max backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is (-1 + (1 umax (-1 + (zext i8 (trunc i16 %n.raw to i8) to i16))<nsw>))
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:      {1,+,1}<nw><%for.body> Added Flags: <nusw>
;
entry:
  %n.and = and i16 %n.raw, 255
  %n = add nsw i16 %n.and, -1
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i8 [ %iv.next, %for.body ], [ 0, %entry ]
  %iv.next = add i8 %iv, 1
  store i8 %iv, ptr @G
  %zext = zext i8 %iv.next to i16
  %cmp = icmp ult i16 %zext, %n
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @rhs_mustexit_3(i16 %n.raw) mustprogress {
; CHECK-LABEL: 'rhs_mustexit_3'
; CHECK-NEXT:  Determining loop execution counts for: @rhs_mustexit_3
; CHECK-NEXT:  Loop %for.body: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable constant max backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable symbolic max backedge-taken count.
;
entry:
  %n.and = and i16 %n.raw, 255
  %n = add nsw i16 %n.and, -3
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i8 [ %iv.next, %for.body ], [ 0, %entry ]
  %iv.next = add i8 %iv, 3
  store i8 %iv, ptr @G
  %zext = zext i8 %iv.next to i16
  %cmp = icmp ult i16 %zext, %n
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}

; Unknown, but non-zero step
define void @rhs_mustexit_nonzero_step(i16 %n.raw, i8 %step.raw) mustprogress {
; CHECK-LABEL: 'rhs_mustexit_nonzero_step'
; CHECK-NEXT:  Determining loop execution counts for: @rhs_mustexit_nonzero_step
; CHECK-NEXT:  Loop %for.body: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable constant max backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable symbolic max backedge-taken count.
;
entry:
  %n.and = and i16 %n.raw, 255
  %n = add nsw i16 %n.and, -3
  %step = add nuw i8 %step.raw, 1
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i8 [ %iv.next, %for.body ], [ 0, %entry ]
  %iv.next = add i8 %iv, %step
  store i8 %iv, ptr @G
  %zext = zext i8 %iv.next to i16
  %cmp = icmp ult i16 %zext, %n
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @neg_maybe_zero_step(i16 %n.raw, i8 %step) mustprogress {
; CHECK-LABEL: 'neg_maybe_zero_step'
; CHECK-NEXT:  Determining loop execution counts for: @neg_maybe_zero_step
; CHECK-NEXT:  Loop %for.body: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable constant max backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable symbolic max backedge-taken count.
;
entry:
  %n.and = and i16 %n.raw, 255
  %n = add nsw i16 %n.and, -3
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i8 [ %iv.next, %for.body ], [ 0, %entry ]
  %iv.next = add i8 %iv, %step
  store i8 %iv, ptr @G
  %zext = zext i8 %iv.next to i16
  %cmp = icmp ult i16 %zext, %n
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @neg_rhs_wrong_range(i16 %n.raw) mustprogress {
; CHECK-LABEL: 'neg_rhs_wrong_range'
; CHECK-NEXT:  Determining loop execution counts for: @neg_rhs_wrong_range
; CHECK-NEXT:  Loop %for.body: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable constant max backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable symbolic max backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is ((-1 + (2 umax (-1 + (zext i8 (trunc i16 %n.raw to i8) to i16))<nsw>)) /u 2)
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:      {2,+,2}<nw><%for.body> Added Flags: <nusw>
;
entry:
  %n.and = and i16 %n.raw, 255
  %n = add nsw i16 %n.and, -1
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i8 [ %iv.next, %for.body ], [ 0, %entry ]
  %iv.next = add i8 %iv, 2
  store i8 %iv, ptr @G
  %zext = zext i8 %iv.next to i16
  %cmp = icmp ult i16 %zext, %n
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @neg_rhs_maybe_infinite(i16 %n.raw) {
; CHECK-LABEL: 'neg_rhs_maybe_infinite'
; CHECK-NEXT:  Determining loop execution counts for: @neg_rhs_maybe_infinite
; CHECK-NEXT:  Loop %for.body: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable constant max backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable symbolic max backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is (-1 + (1 umax (-1 + (zext i8 (trunc i16 %n.raw to i8) to i16))<nsw>))
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:      {1,+,1}<%for.body> Added Flags: <nusw>
;
entry:
  %n.and = and i16 %n.raw, 255
  %n = add nsw i16 %n.and, -1
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i8 [ %iv.next, %for.body ], [ 0, %entry ]
  %iv.next = add i8 %iv, 1
  store i8 %iv, ptr @G
  %zext = zext i8 %iv.next to i16
  %cmp = icmp ult i16 %zext, %n
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}

; Because of the range on RHS including only values within i8, we don't need
; the must exit property
define void @rhs_narrow_range(i16 %n.raw) {
; CHECK-LABEL: 'rhs_narrow_range'
; CHECK-NEXT:  Determining loop execution counts for: @rhs_narrow_range
; CHECK-NEXT:  Loop %for.body: backedge-taken count is (-1 + (1 umax (2 * (zext i7 (trunc i16 (%n.raw /u 2) to i7) to i16))<nuw><nsw>))<nsw>
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is i16 253
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is (-1 + (1 umax (2 * (zext i7 (trunc i16 (%n.raw /u 2) to i7) to i16))<nuw><nsw>))<nsw>
; CHECK-NEXT:  Loop %for.body: Trip multiple is 1
;
entry:
  %n = and i16 %n.raw, 254
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i8 [ %iv.next, %for.body ], [ 0, %entry ]
  %iv.next = add i8 %iv, 1
  store i8 %iv, ptr @G
  %zext = zext i8 %iv.next to i16
  %cmp = icmp ult i16 %zext, %n
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @ugt_constant_rhs(i16 %n.raw, i8 %start) mustprogress {
;
; CHECK-LABEL: 'ugt_constant_rhs'
; CHECK-NEXT:  Determining loop execution counts for: @ugt_constant_rhs
; CHECK-NEXT:  Loop %for.body: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable constant max backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable symbolic max backedge-taken count.
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i8 [ %iv.next, %for.body ], [ %start, %entry ]
  %iv.next = add i8 %iv, 1
  %zext = zext i8 %iv.next to i16
  %cmp = icmp ugt i16 %zext, 254
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @ult_constant_rhs(i16 %n.raw, i8 %start) {
;
; CHECK-LABEL: 'ult_constant_rhs'
; CHECK-NEXT:  Determining loop execution counts for: @ult_constant_rhs
; CHECK-NEXT:  Loop %for.body: backedge-taken count is (255 + (-1 * (zext i8 (1 + %start) to i16))<nsw>)<nsw>
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is i16 255
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is (255 + (-1 * (zext i8 (1 + %start) to i16))<nsw>)<nsw>
; CHECK-NEXT:  Loop %for.body: Trip multiple is 1
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i8 [ %iv.next, %for.body ], [ %start, %entry ]
  %iv.next = add i8 %iv, 1
  %zext = zext i8 %iv.next to i16
  %cmp = icmp ult i16 %zext, 255
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @ult_constant_rhs_stride2(i16 %n.raw, i8 %start) {
;
; CHECK-LABEL: 'ult_constant_rhs_stride2'
; CHECK-NEXT:  Determining loop execution counts for: @ult_constant_rhs_stride2
; CHECK-NEXT:  Loop %for.body: backedge-taken count is ((1 + (-1 * (zext i8 (2 + %start) to i16))<nsw> + (254 umax (zext i8 (2 + %start) to i16))) /u 2)
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is i16 127
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is ((1 + (-1 * (zext i8 (2 + %start) to i16))<nsw> + (254 umax (zext i8 (2 + %start) to i16))) /u 2)
; CHECK-NEXT:  Loop %for.body: Trip multiple is 1
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i8 [ %iv.next, %for.body ], [ %start, %entry ]
  %iv.next = add i8 %iv, 2
  %zext = zext i8 %iv.next to i16
  %cmp = icmp ult i16 %zext, 254
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @ult_constant_rhs_stride2_neg(i16 %n.raw, i8 %start) {
;
; CHECK-LABEL: 'ult_constant_rhs_stride2_neg'
; CHECK-NEXT:  Determining loop execution counts for: @ult_constant_rhs_stride2_neg
; CHECK-NEXT:  Loop %for.body: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable constant max backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Unpredictable symbolic max backedge-taken count.
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is ((256 + (-1 * (zext i8 (2 + %start) to i16))<nsw>)<nsw> /u 2)
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:      {(2 + %start),+,2}<%for.body> Added Flags: <nusw>
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i8 [ %iv.next, %for.body ], [ %start, %entry ]
  %iv.next = add i8 %iv, 2
  %zext = zext i8 %iv.next to i16
  %cmp = icmp ult i16 %zext, 255
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}


define void @ult_restricted_rhs(i16 %n.raw) {
; CHECK-LABEL: 'ult_restricted_rhs'
; CHECK-NEXT:  Determining loop execution counts for: @ult_restricted_rhs
; CHECK-NEXT:  Loop %for.body: backedge-taken count is (-1 + (1 umax (zext i8 (trunc i16 %n.raw to i8) to i16)))<nsw>
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is i16 254
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is (-1 + (1 umax (zext i8 (trunc i16 %n.raw to i8) to i16)))<nsw>
; CHECK-NEXT:  Loop %for.body: Trip multiple is 1
;
entry:
  %n = and i16 %n.raw, 255
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i8 [ %iv.next, %for.body ], [ 0, %entry ]
  %iv.next = add i8 %iv, 1
  %zext = zext i8 %iv.next to i16
  %cmp = icmp ult i16 %zext, %n
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @ult_guarded_rhs(i16 %n) {;
; CHECK-LABEL: 'ult_guarded_rhs'
; CHECK-NEXT:  Determining loop execution counts for: @ult_guarded_rhs
; CHECK-NEXT:  Loop %for.body: backedge-taken count is (-1 + (1 umax %n))
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is i16 -2
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is (-1 + (1 umax %n))
; CHECK-NEXT:  Loop %for.body: Trip multiple is 1
;
entry:
  %in_range = icmp ult i16 %n, 256
  br i1 %in_range, label %for.body, label %for.end

for.body:                                         ; preds = %entry, %for.body
  %iv = phi i8 [ %iv.next, %for.body ], [ 0, %entry ]
  %iv.next = add i8 %iv, 1
  %zext = zext i8 %iv.next to i16
  %cmp = icmp ult i16 %zext, %n
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}



declare void @llvm.assume(i1)

