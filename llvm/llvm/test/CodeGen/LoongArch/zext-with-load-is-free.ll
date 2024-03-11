; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc --mtriple=loongarch32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefix=LA32
; RUN: llc --mtriple=loongarch64 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefix=LA64

define zeroext i8 @test_zext_i8(ptr %p) nounwind {
; LA32-LABEL: test_zext_i8:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.bu $a0, $a0, 0
; LA32-NEXT:    ret
;
; LA64-LABEL: test_zext_i8:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.bu $a0, $a0, 0
; LA64-NEXT:    ret
  %a = load i8, ptr %p, align 1
  br label %exit
exit:
  ret i8 %a
}

define zeroext i16 @test_zext_i16(ptr %p) nounwind {
; LA32-LABEL: test_zext_i16:
; LA32:       # %bb.0:
; LA32-NEXT:    ld.bu $a1, $a0, 1
; LA32-NEXT:    ld.bu $a0, $a0, 0
; LA32-NEXT:    slli.w $a1, $a1, 8
; LA32-NEXT:    or $a0, $a1, $a0
; LA32-NEXT:    ret
;
; LA64-LABEL: test_zext_i16:
; LA64:       # %bb.0:
; LA64-NEXT:    ld.hu $a0, $a0, 0
; LA64-NEXT:    ret
  %a = load i16, ptr %p, align 1
  br label %exit
exit:
  ret i16 %a
}
