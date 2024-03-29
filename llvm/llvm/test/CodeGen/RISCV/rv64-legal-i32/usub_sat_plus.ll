; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv64 -mattr=+m \
; RUN:   -riscv-experimental-rv64-legal-i32 | FileCheck %s --check-prefix=RV64I
; RUN: llc < %s -mtriple=riscv64 -mattr=+m,+zbb \
; RUN:   -riscv-experimental-rv64-legal-i32 | FileCheck %s --check-prefix=RV64IZbb

declare i4 @llvm.usub.sat.i4(i4, i4)
declare i8 @llvm.usub.sat.i8(i8, i8)
declare i16 @llvm.usub.sat.i16(i16, i16)
declare i32 @llvm.usub.sat.i32(i32, i32)
declare i64 @llvm.usub.sat.i64(i64, i64)

define i32 @func32(i32 %x, i32 %y, i32 %z) nounwind {
; RV64I-LABEL: func32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    mul a1, a1, a2
; RV64I-NEXT:    subw a1, a0, a1
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    sltu a0, a0, a1
; RV64I-NEXT:    addi a0, a0, -1
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64IZbb-LABEL: func32:
; RV64IZbb:       # %bb.0:
; RV64IZbb-NEXT:    mulw a1, a1, a2
; RV64IZbb-NEXT:    sext.w a0, a0
; RV64IZbb-NEXT:    maxu a0, a0, a1
; RV64IZbb-NEXT:    sub a0, a0, a1
; RV64IZbb-NEXT:    ret
  %a = mul i32 %y, %z
  %tmp = call i32 @llvm.usub.sat.i32(i32 %x, i32 %a)
  ret i32 %tmp
}

define i64 @func64(i64 %x, i64 %y, i64 %z) nounwind {
; RV64I-LABEL: func64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sub a1, a0, a2
; RV64I-NEXT:    sltu a0, a0, a1
; RV64I-NEXT:    addi a0, a0, -1
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64IZbb-LABEL: func64:
; RV64IZbb:       # %bb.0:
; RV64IZbb-NEXT:    maxu a0, a0, a2
; RV64IZbb-NEXT:    sub a0, a0, a2
; RV64IZbb-NEXT:    ret
  %a = mul i64 %y, %z
  %tmp = call i64 @llvm.usub.sat.i64(i64 %x, i64 %z)
  ret i64 %tmp
}

define i16 @func16(i16 %x, i16 %y, i16 %z) nounwind {
; RV64I-LABEL: func16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    lui a3, 16
; RV64I-NEXT:    addi a3, a3, -1
; RV64I-NEXT:    and a0, a0, a3
; RV64I-NEXT:    mul a1, a1, a2
; RV64I-NEXT:    and a1, a1, a3
; RV64I-NEXT:    subw a1, a0, a1
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    sltu a0, a0, a1
; RV64I-NEXT:    addi a0, a0, -1
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64IZbb-LABEL: func16:
; RV64IZbb:       # %bb.0:
; RV64IZbb-NEXT:    zext.h a0, a0
; RV64IZbb-NEXT:    mul a1, a1, a2
; RV64IZbb-NEXT:    zext.h a1, a1
; RV64IZbb-NEXT:    maxu a0, a0, a1
; RV64IZbb-NEXT:    sub a0, a0, a1
; RV64IZbb-NEXT:    ret
  %a = mul i16 %y, %z
  %tmp = call i16 @llvm.usub.sat.i16(i16 %x, i16 %a)
  ret i16 %tmp
}

define i8 @func8(i8 %x, i8 %y, i8 %z) nounwind {
; RV64I-LABEL: func8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    andi a0, a0, 255
; RV64I-NEXT:    mul a1, a1, a2
; RV64I-NEXT:    andi a1, a1, 255
; RV64I-NEXT:    subw a1, a0, a1
; RV64I-NEXT:    sltu a0, a0, a1
; RV64I-NEXT:    addi a0, a0, -1
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64IZbb-LABEL: func8:
; RV64IZbb:       # %bb.0:
; RV64IZbb-NEXT:    andi a0, a0, 255
; RV64IZbb-NEXT:    mul a1, a1, a2
; RV64IZbb-NEXT:    andi a1, a1, 255
; RV64IZbb-NEXT:    maxu a0, a0, a1
; RV64IZbb-NEXT:    sub a0, a0, a1
; RV64IZbb-NEXT:    ret
  %a = mul i8 %y, %z
  %tmp = call i8 @llvm.usub.sat.i8(i8 %x, i8 %a)
  ret i8 %tmp
}

define i4 @func4(i4 %x, i4 %y, i4 %z) nounwind {
; RV64I-LABEL: func4:
; RV64I:       # %bb.0:
; RV64I-NEXT:    andi a0, a0, 15
; RV64I-NEXT:    mul a1, a1, a2
; RV64I-NEXT:    andi a1, a1, 15
; RV64I-NEXT:    subw a1, a0, a1
; RV64I-NEXT:    sltu a0, a0, a1
; RV64I-NEXT:    addi a0, a0, -1
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    ret
;
; RV64IZbb-LABEL: func4:
; RV64IZbb:       # %bb.0:
; RV64IZbb-NEXT:    andi a0, a0, 15
; RV64IZbb-NEXT:    mul a1, a1, a2
; RV64IZbb-NEXT:    andi a1, a1, 15
; RV64IZbb-NEXT:    maxu a0, a0, a1
; RV64IZbb-NEXT:    sub a0, a0, a1
; RV64IZbb-NEXT:    ret
  %a = mul i4 %y, %z
  %tmp = call i4 @llvm.usub.sat.i4(i4 %x, i4 %a)
  ret i4 %tmp
}
