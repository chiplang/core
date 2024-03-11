; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s
;
; Verify that memchr calls with a string consisting of all the same
; characters are folded and those with mixed strings are not.

declare ptr @memchr(ptr, i32, i64)

@a00000 = constant [5 x i8] zeroinitializer
@a11111 = constant [5 x i8] c"\01\01\01\01\01"
@a111122 = constant [6 x i8] c"\01\01\01\01\02\02"
@a1110111 = constant [7 x i8] c"\01\01\01\00\01\01\01"


; Fold memchr(a00000, C, 5) to *a00000 == C ? a00000 : null.
; TODO: This depends on getConstantStringInfo() being able to handle
; implicitly zeroed out constants.

define ptr @fold_memchr_a00000_c_5(i32 %C) {
; CHECK-LABEL: @fold_memchr_a00000_c_5(
; CHECK-NEXT:    [[RET:%.*]] = call ptr @memchr(ptr noundef nonnull dereferenceable(1) @a00000, i32 [[C:%.*]], i64 5)
; CHECK-NEXT:    ret ptr [[RET]]
;

  %ret = call ptr @memchr(ptr @a00000, i32 %C, i64 5)
  ret ptr %ret
}


; Fold memchr(a11111, C, 5) to *a11111 == C ? a11111 : null.

define ptr @fold_memchr_a11111_c_5(i32 %C) {
; CHECK-LABEL: @fold_memchr_a11111_c_5(
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i32 [[C:%.*]] to i8
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i8 [[TMP1]], 1
; CHECK-NEXT:    [[MEMCHR_SEL2:%.*]] = select i1 [[TMP2]], ptr @a11111, ptr null
; CHECK-NEXT:    ret ptr [[MEMCHR_SEL2]]
;

  %ret = call ptr @memchr(ptr @a11111, i32 %C, i64 5)
  ret ptr %ret
}


; Fold memchr(a11111, C, N) to N && *a11111 == C ? a11111 : null,
; on the assumption that N is in bounds.

define ptr @fold_memchr_a11111_c_n(i32 %C, i64 %N) {
; CHECK-LABEL: @fold_memchr_a11111_c_n(
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i32 [[C:%.*]] to i8
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i8 [[TMP1]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ne i64 [[N:%.*]], 0
; CHECK-NEXT:    [[TMP4:%.*]] = and i1 [[TMP3]], [[TMP2]]
; CHECK-NEXT:    [[MEMCHR_SEL2:%.*]] = select i1 [[TMP4]], ptr @a11111, ptr null
; CHECK-NEXT:    ret ptr [[MEMCHR_SEL2]]
;

  %ret = call ptr @memchr(ptr @a11111, i32 %C, i64 %N)
  ret ptr %ret
}


; Fold memchr(a111122, C, N) to
;   N != 0 && C == 1 ? a111122 : N > 4 && C == 2 ? a111122 + 4 : null.

define ptr @fold_memchr_a111122_c_n(i32 %C, i64 %N) {
; CHECK-LABEL: @fold_memchr_a111122_c_n(
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i32 [[C:%.*]] to i8
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i8 [[TMP1]], 2
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ugt i64 [[N:%.*]], 4
; CHECK-NEXT:    [[TMP4:%.*]] = and i1 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    [[MEMCHR_SEL1:%.*]] = select i1 [[TMP4]], ptr getelementptr inbounds ([6 x i8], ptr @a111122, i64 0, i64 4), ptr null
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i8 [[TMP1]], 1
; CHECK-NEXT:    [[TMP6:%.*]] = icmp ne i64 [[N]], 0
; CHECK-NEXT:    [[TMP7:%.*]] = and i1 [[TMP6]], [[TMP5]]
; CHECK-NEXT:    [[MEMCHR_SEL2:%.*]] = select i1 [[TMP7]], ptr @a111122, ptr [[MEMCHR_SEL1]]
; CHECK-NEXT:    ret ptr [[MEMCHR_SEL2]]
;

  %ret = call ptr @memchr(ptr @a111122, i32 %C, i64 %N)
  ret ptr %ret
}


; Fold memchr(a1110111, C, 3) to a1110111[2] == C ? a1110111 : null.

define ptr @fold_memchr_a1110111_c_3(i32 %C) {
; CHECK-LABEL: @fold_memchr_a1110111_c_3(
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i32 [[C:%.*]] to i8
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i8 [[TMP1]], 1
; CHECK-NEXT:    [[MEMCHR_SEL2:%.*]] = select i1 [[TMP2]], ptr @a1110111, ptr null
; CHECK-NEXT:    ret ptr [[MEMCHR_SEL2]]
;

  %ret = call ptr @memchr(ptr @a1110111, i32 %C, i64 3)
  ret ptr %ret
}


; Don't fold memchr(a1110111, C, 4).

define ptr @call_memchr_a1110111_c_4(i32 %C) {
; CHECK-LABEL: @call_memchr_a1110111_c_4(
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i32 [[C:%.*]] to i8
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i8 [[TMP1]], 0
; CHECK-NEXT:    [[MEMCHR_SEL1:%.*]] = select i1 [[TMP2]], ptr getelementptr inbounds ([7 x i8], ptr @a1110111, i64 0, i64 3), ptr null
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq i8 [[TMP1]], 1
; CHECK-NEXT:    [[MEMCHR_SEL2:%.*]] = select i1 [[TMP3]], ptr @a1110111, ptr [[MEMCHR_SEL1]]
; CHECK-NEXT:    ret ptr [[MEMCHR_SEL2]]
;

  %ret = call ptr @memchr(ptr @a1110111, i32 %C, i64 4)
  ret ptr %ret
}


; Don't fold memchr(a1110111, C, 7).

define ptr @call_memchr_a1110111_c_7(i32 %C) {
; CHECK-LABEL: @call_memchr_a1110111_c_7(
; CHECK-NEXT:    [[RET:%.*]] = call ptr @memchr(ptr noundef nonnull dereferenceable(1) @a1110111, i32 [[C:%.*]], i64 7)
; CHECK-NEXT:    ret ptr [[RET]]
;

  %ret = call ptr @memchr(ptr @a1110111, i32 %C, i64 7)
  ret ptr %ret
}


; Don't fold memchr(a1110111, C, N).

define ptr @call_memchr_a1110111_c_n(i32 %C, i64 %N) {
; CHECK-LABEL: @call_memchr_a1110111_c_n(
; CHECK-NEXT:    [[RET:%.*]] = call ptr @memchr(ptr nonnull @a1110111, i32 [[C:%.*]], i64 [[N:%.*]])
; CHECK-NEXT:    ret ptr [[RET]]
;

  %ret = call ptr @memchr(ptr @a1110111, i32 %C, i64 %N)
  ret ptr %ret
}