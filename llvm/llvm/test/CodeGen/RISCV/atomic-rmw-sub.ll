; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I %s
; RUN: llc -mtriple=riscv32 -mattr=+a -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=RV32IA %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64I %s
; RUN: llc -mtriple=riscv64 -mattr=+a -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=RV64IA %s

define i32 @atomicrmw_sub_i32_constant(ptr %a) nounwind {
; RV32I-LABEL: atomicrmw_sub_i32_constant:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    li a1, 1
; RV32I-NEXT:    li a2, 5
; RV32I-NEXT:    call __atomic_fetch_sub_4
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IA-LABEL: atomicrmw_sub_i32_constant:
; RV32IA:       # %bb.0:
; RV32IA-NEXT:    li a1, -1
; RV32IA-NEXT:    amoadd.w.aqrl a0, a1, (a0)
; RV32IA-NEXT:    ret
;
; RV64I-LABEL: atomicrmw_sub_i32_constant:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    li a1, 1
; RV64I-NEXT:    li a2, 5
; RV64I-NEXT:    call __atomic_fetch_sub_4
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IA-LABEL: atomicrmw_sub_i32_constant:
; RV64IA:       # %bb.0:
; RV64IA-NEXT:    li a1, -1
; RV64IA-NEXT:    amoadd.w.aqrl a0, a1, (a0)
; RV64IA-NEXT:    ret
  %1 = atomicrmw sub ptr %a, i32 1 seq_cst
  ret i32 %1
}

define i64 @atomicrmw_sub_i64_constant(ptr %a) nounwind {
; RV32I-LABEL: atomicrmw_sub_i64_constant:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    li a1, 1
; RV32I-NEXT:    li a3, 5
; RV32I-NEXT:    li a2, 0
; RV32I-NEXT:    call __atomic_fetch_sub_8
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IA-LABEL: atomicrmw_sub_i64_constant:
; RV32IA:       # %bb.0:
; RV32IA-NEXT:    addi sp, sp, -16
; RV32IA-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IA-NEXT:    li a1, 1
; RV32IA-NEXT:    li a3, 5
; RV32IA-NEXT:    li a2, 0
; RV32IA-NEXT:    call __atomic_fetch_sub_8
; RV32IA-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IA-NEXT:    addi sp, sp, 16
; RV32IA-NEXT:    ret
;
; RV64I-LABEL: atomicrmw_sub_i64_constant:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    li a1, 1
; RV64I-NEXT:    li a2, 5
; RV64I-NEXT:    call __atomic_fetch_sub_8
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IA-LABEL: atomicrmw_sub_i64_constant:
; RV64IA:       # %bb.0:
; RV64IA-NEXT:    li a1, -1
; RV64IA-NEXT:    amoadd.d.aqrl a0, a1, (a0)
; RV64IA-NEXT:    ret
  %1 = atomicrmw sub ptr %a, i64 1 seq_cst
  ret i64 %1
}

define i32 @atomicrmw_sub_i32_neg(ptr %a, i32 %x, i32 %y) nounwind {
; RV32I-LABEL: atomicrmw_sub_i32_neg:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sub a1, a1, a2
; RV32I-NEXT:    li a2, 5
; RV32I-NEXT:    call __atomic_fetch_sub_4
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IA-LABEL: atomicrmw_sub_i32_neg:
; RV32IA:       # %bb.0:
; RV32IA-NEXT:    sub a2, a2, a1
; RV32IA-NEXT:    amoadd.w.aqrl a0, a2, (a0)
; RV32IA-NEXT:    ret
;
; RV64I-LABEL: atomicrmw_sub_i32_neg:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    subw a1, a1, a2
; RV64I-NEXT:    li a2, 5
; RV64I-NEXT:    call __atomic_fetch_sub_4
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IA-LABEL: atomicrmw_sub_i32_neg:
; RV64IA:       # %bb.0:
; RV64IA-NEXT:    sub a2, a2, a1
; RV64IA-NEXT:    amoadd.w.aqrl a0, a2, (a0)
; RV64IA-NEXT:    ret
  %b = sub i32 %x, %y
  %1 = atomicrmw sub ptr %a, i32 %b seq_cst
  ret i32 %1
}

define i64 @atomicrmw_sub_i64_neg(ptr %a, i64 %x, i64 %y) nounwind {
; RV32I-LABEL: atomicrmw_sub_i64_neg:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sltu a5, a1, a3
; RV32I-NEXT:    sub a2, a2, a4
; RV32I-NEXT:    sub a2, a2, a5
; RV32I-NEXT:    sub a1, a1, a3
; RV32I-NEXT:    li a3, 5
; RV32I-NEXT:    call __atomic_fetch_sub_8
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IA-LABEL: atomicrmw_sub_i64_neg:
; RV32IA:       # %bb.0:
; RV32IA-NEXT:    addi sp, sp, -16
; RV32IA-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IA-NEXT:    sltu a5, a1, a3
; RV32IA-NEXT:    sub a2, a2, a4
; RV32IA-NEXT:    sub a2, a2, a5
; RV32IA-NEXT:    sub a1, a1, a3
; RV32IA-NEXT:    li a3, 5
; RV32IA-NEXT:    call __atomic_fetch_sub_8
; RV32IA-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IA-NEXT:    addi sp, sp, 16
; RV32IA-NEXT:    ret
;
; RV64I-LABEL: atomicrmw_sub_i64_neg:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sub a1, a1, a2
; RV64I-NEXT:    li a2, 5
; RV64I-NEXT:    call __atomic_fetch_sub_8
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IA-LABEL: atomicrmw_sub_i64_neg:
; RV64IA:       # %bb.0:
; RV64IA-NEXT:    sub a2, a2, a1
; RV64IA-NEXT:    amoadd.d.aqrl a0, a2, (a0)
; RV64IA-NEXT:    ret
  %b = sub i64 %x, %y
  %1 = atomicrmw sub ptr %a, i64 %b seq_cst
  ret i64 %1
}
