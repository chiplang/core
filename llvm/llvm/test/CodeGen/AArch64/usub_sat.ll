; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-- | FileCheck %s --check-prefixes=CHECK,CHECK-SD
; RUN: llc < %s -mtriple=aarch64-- -global-isel -global-isel-abort=2 2>&1 | FileCheck %s --check-prefixes=CHECK,CHECK-GI

declare i4 @llvm.usub.sat.i4(i4, i4)
declare i8 @llvm.usub.sat.i8(i8, i8)
declare i16 @llvm.usub.sat.i16(i16, i16)
declare i32 @llvm.usub.sat.i32(i32, i32)
declare i64 @llvm.usub.sat.i64(i64, i64)

define i32 @func(i32 %x, i32 %y) nounwind {
; CHECK-SD-LABEL: func:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    subs w8, w0, w1
; CHECK-SD-NEXT:    csel w0, wzr, w8, lo
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: func:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    subs w8, w0, w1
; CHECK-GI-NEXT:    cset w9, lo
; CHECK-GI-NEXT:    tst w9, #0x1
; CHECK-GI-NEXT:    csel w0, wzr, w8, ne
; CHECK-GI-NEXT:    ret
  %tmp = call i32 @llvm.usub.sat.i32(i32 %x, i32 %y);
  ret i32 %tmp;
}

define i64 @func2(i64 %x, i64 %y) nounwind {
; CHECK-SD-LABEL: func2:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    subs x8, x0, x1
; CHECK-SD-NEXT:    csel x0, xzr, x8, lo
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: func2:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    subs x8, x0, x1
; CHECK-GI-NEXT:    cset w9, lo
; CHECK-GI-NEXT:    tst w9, #0x1
; CHECK-GI-NEXT:    csel x0, xzr, x8, ne
; CHECK-GI-NEXT:    ret
  %tmp = call i64 @llvm.usub.sat.i64(i64 %x, i64 %y);
  ret i64 %tmp;
}

define i16 @func16(i16 %x, i16 %y) nounwind {
; CHECK-SD-LABEL: func16:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    and w8, w0, #0xffff
; CHECK-SD-NEXT:    subs w8, w8, w1, uxth
; CHECK-SD-NEXT:    csel w0, wzr, w8, lo
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: func16:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    and w8, w0, #0xffff
; CHECK-GI-NEXT:    sub w8, w8, w1, uxth
; CHECK-GI-NEXT:    cmp w8, w8, uxth
; CHECK-GI-NEXT:    csel w0, wzr, w8, ne
; CHECK-GI-NEXT:    ret
  %tmp = call i16 @llvm.usub.sat.i16(i16 %x, i16 %y);
  ret i16 %tmp;
}

define i8 @func8(i8 %x, i8 %y) nounwind {
; CHECK-SD-LABEL: func8:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    and w8, w0, #0xff
; CHECK-SD-NEXT:    subs w8, w8, w1, uxtb
; CHECK-SD-NEXT:    csel w0, wzr, w8, lo
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: func8:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    and w8, w0, #0xff
; CHECK-GI-NEXT:    sub w8, w8, w1, uxtb
; CHECK-GI-NEXT:    cmp w8, w8, uxtb
; CHECK-GI-NEXT:    csel w0, wzr, w8, ne
; CHECK-GI-NEXT:    ret
  %tmp = call i8 @llvm.usub.sat.i8(i8 %x, i8 %y);
  ret i8 %tmp;
}

define i4 @func3(i4 %x, i4 %y) nounwind {
; CHECK-SD-LABEL: func3:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    and w8, w1, #0xf
; CHECK-SD-NEXT:    and w9, w0, #0xf
; CHECK-SD-NEXT:    subs w8, w9, w8
; CHECK-SD-NEXT:    csel w0, wzr, w8, lo
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: func3:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    and w8, w0, #0xf
; CHECK-GI-NEXT:    and w9, w1, #0xf
; CHECK-GI-NEXT:    sub w8, w8, w9
; CHECK-GI-NEXT:    and w9, w8, #0xf
; CHECK-GI-NEXT:    cmp w8, w9
; CHECK-GI-NEXT:    csel w0, wzr, w8, ne
; CHECK-GI-NEXT:    ret
  %tmp = call i4 @llvm.usub.sat.i4(i4 %x, i4 %y);
  ret i4 %tmp;
}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK: {{.*}}
