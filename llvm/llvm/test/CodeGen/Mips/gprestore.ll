; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=mips-mti-linux-gnu < %s -relocation-model=pic -mips-jalr-reloc=false | FileCheck %s --check-prefix=O32
; RUN: llc -mtriple=mips64-mti-linux-gnu < %s -relocation-model=pic -mips-jalr-reloc=false | FileCheck %s --check-prefix=N64
; RUN: llc -mtriple=mips64-mti-linux-gnu < %s -relocation-model=pic -target-abi n32 -mips-jalr-reloc=false | FileCheck %s --check-prefix=N32
; RUN: llc -mtriple=mips-mti-linux-gnu < %s -relocation-model=pic -O3 -mips-jalr-reloc=false | FileCheck %s --check-prefix=O3O32
; RUN: llc -mtriple=mips64-mti-linux-gnu < %s -relocation-model=pic -O3 -mips-jalr-reloc=false | FileCheck %s --check-prefix=O3N64
; RUN: llc -mtriple=mips64-mti-linux-gnu < %s -relocation-model=pic -target-abi n32 -O3 -mips-jalr-reloc=false | FileCheck %s --check-prefix=O3N32

; Test that PIC calls use the $25 register. This is an ABI requirement.

@p = external global i32
@q = external global i32
@r = external global i32

define void @f0() nounwind {
; O32-LABEL: f0:
; O32:       # %bb.0: # %entry
; O32-NEXT:    lui $2, %hi(_gp_disp)
; O32-NEXT:    addiu $2, $2, %lo(_gp_disp)
; O32-NEXT:    addiu $sp, $sp, -32
; O32-NEXT:    sw $ra, 28($sp) # 4-byte Folded Spill
; O32-NEXT:    sw $17, 24($sp) # 4-byte Folded Spill
; O32-NEXT:    sw $16, 20($sp) # 4-byte Folded Spill
; O32-NEXT:    addu $16, $2, $25
; O32-NEXT:    lw $25, %call16(f1)($16)
; O32-NEXT:    jalr $25
; O32-NEXT:    move $gp, $16
; O32-NEXT:    lw $1, %got(p)($16)
; O32-NEXT:    lw $4, 0($1)
; O32-NEXT:    lw $25, %call16(f2)($16)
; O32-NEXT:    jalr $25
; O32-NEXT:    move $gp, $16
; O32-NEXT:    lw $1, %got(q)($16)
; O32-NEXT:    lw $17, 0($1)
; O32-NEXT:    lw $25, %call16(f2)($16)
; O32-NEXT:    jalr $25
; O32-NEXT:    move $4, $17
; O32-NEXT:    lw $1, %got(r)($16)
; O32-NEXT:    lw $5, 0($1)
; O32-NEXT:    lw $25, %call16(f3)($16)
; O32-NEXT:    move $4, $17
; O32-NEXT:    jalr $25
; O32-NEXT:    move $gp, $16
; O32-NEXT:    lw $16, 20($sp) # 4-byte Folded Reload
; O32-NEXT:    lw $17, 24($sp) # 4-byte Folded Reload
; O32-NEXT:    lw $ra, 28($sp) # 4-byte Folded Reload
; O32-NEXT:    jr $ra
; O32-NEXT:    addiu $sp, $sp, 32
;
; N64-LABEL: f0:
; N64:       # %bb.0: # %entry
; N64-NEXT:    daddiu $sp, $sp, -32
; N64-NEXT:    sd $ra, 24($sp) # 8-byte Folded Spill
; N64-NEXT:    sd $gp, 16($sp) # 8-byte Folded Spill
; N64-NEXT:    sd $16, 8($sp) # 8-byte Folded Spill
; N64-NEXT:    lui $1, %hi(%neg(%gp_rel(f0)))
; N64-NEXT:    daddu $1, $1, $25
; N64-NEXT:    daddiu $gp, $1, %lo(%neg(%gp_rel(f0)))
; N64-NEXT:    ld $25, %call16(f1)($gp)
; N64-NEXT:    jalr $25
; N64-NEXT:    nop
; N64-NEXT:    ld $1, %got_disp(p)($gp)
; N64-NEXT:    ld $25, %call16(f2)($gp)
; N64-NEXT:    jalr $25
; N64-NEXT:    lw $4, 0($1)
; N64-NEXT:    ld $1, %got_disp(q)($gp)
; N64-NEXT:    lw $16, 0($1)
; N64-NEXT:    ld $25, %call16(f2)($gp)
; N64-NEXT:    jalr $25
; N64-NEXT:    move $4, $16
; N64-NEXT:    ld $1, %got_disp(r)($gp)
; N64-NEXT:    lw $5, 0($1)
; N64-NEXT:    ld $25, %call16(f3)($gp)
; N64-NEXT:    jalr $25
; N64-NEXT:    move $4, $16
; N64-NEXT:    ld $16, 8($sp) # 8-byte Folded Reload
; N64-NEXT:    ld $gp, 16($sp) # 8-byte Folded Reload
; N64-NEXT:    ld $ra, 24($sp) # 8-byte Folded Reload
; N64-NEXT:    jr $ra
; N64-NEXT:    daddiu $sp, $sp, 32
;
; N32-LABEL: f0:
; N32:       # %bb.0: # %entry
; N32-NEXT:    addiu $sp, $sp, -32
; N32-NEXT:    sd $ra, 24($sp) # 8-byte Folded Spill
; N32-NEXT:    sd $gp, 16($sp) # 8-byte Folded Spill
; N32-NEXT:    sd $16, 8($sp) # 8-byte Folded Spill
; N32-NEXT:    lui $1, %hi(%neg(%gp_rel(f0)))
; N32-NEXT:    addu $1, $1, $25
; N32-NEXT:    addiu $gp, $1, %lo(%neg(%gp_rel(f0)))
; N32-NEXT:    lw $25, %call16(f1)($gp)
; N32-NEXT:    jalr $25
; N32-NEXT:    nop
; N32-NEXT:    lw $1, %got_disp(p)($gp)
; N32-NEXT:    lw $25, %call16(f2)($gp)
; N32-NEXT:    jalr $25
; N32-NEXT:    lw $4, 0($1)
; N32-NEXT:    lw $1, %got_disp(q)($gp)
; N32-NEXT:    lw $16, 0($1)
; N32-NEXT:    lw $25, %call16(f2)($gp)
; N32-NEXT:    jalr $25
; N32-NEXT:    move $4, $16
; N32-NEXT:    lw $1, %got_disp(r)($gp)
; N32-NEXT:    lw $5, 0($1)
; N32-NEXT:    lw $25, %call16(f3)($gp)
; N32-NEXT:    jalr $25
; N32-NEXT:    move $4, $16
; N32-NEXT:    ld $16, 8($sp) # 8-byte Folded Reload
; N32-NEXT:    ld $gp, 16($sp) # 8-byte Folded Reload
; N32-NEXT:    ld $ra, 24($sp) # 8-byte Folded Reload
; N32-NEXT:    jr $ra
; N32-NEXT:    addiu $sp, $sp, 32
;
; O3O32-LABEL: f0:
; O3O32:       # %bb.0: # %entry
; O3O32-NEXT:    lui $2, %hi(_gp_disp)
; O3O32-NEXT:    addiu $2, $2, %lo(_gp_disp)
; O3O32-NEXT:    addiu $sp, $sp, -32
; O3O32-NEXT:    sw $ra, 28($sp) # 4-byte Folded Spill
; O3O32-NEXT:    sw $17, 24($sp) # 4-byte Folded Spill
; O3O32-NEXT:    sw $16, 20($sp) # 4-byte Folded Spill
; O3O32-NEXT:    addu $16, $2, $25
; O3O32-NEXT:    lw $25, %call16(f1)($16)
; O3O32-NEXT:    jalr $25
; O3O32-NEXT:    move $gp, $16
; O3O32-NEXT:    lw $1, %got(p)($16)
; O3O32-NEXT:    lw $25, %call16(f2)($16)
; O3O32-NEXT:    move $gp, $16
; O3O32-NEXT:    jalr $25
; O3O32-NEXT:    lw $4, 0($1)
; O3O32-NEXT:    lw $1, %got(q)($16)
; O3O32-NEXT:    lw $25, %call16(f2)($16)
; O3O32-NEXT:    lw $17, 0($1)
; O3O32-NEXT:    jalr $25
; O3O32-NEXT:    move $4, $17
; O3O32-NEXT:    lw $1, %got(r)($16)
; O3O32-NEXT:    lw $25, %call16(f3)($16)
; O3O32-NEXT:    move $4, $17
; O3O32-NEXT:    move $gp, $16
; O3O32-NEXT:    jalr $25
; O3O32-NEXT:    lw $5, 0($1)
; O3O32-NEXT:    lw $16, 20($sp) # 4-byte Folded Reload
; O3O32-NEXT:    lw $17, 24($sp) # 4-byte Folded Reload
; O3O32-NEXT:    lw $ra, 28($sp) # 4-byte Folded Reload
; O3O32-NEXT:    jr $ra
; O3O32-NEXT:    addiu $sp, $sp, 32
;
; O3N64-LABEL: f0:
; O3N64:       # %bb.0: # %entry
; O3N64-NEXT:    daddiu $sp, $sp, -32
; O3N64-NEXT:    sd $ra, 24($sp) # 8-byte Folded Spill
; O3N64-NEXT:    sd $gp, 16($sp) # 8-byte Folded Spill
; O3N64-NEXT:    sd $16, 8($sp) # 8-byte Folded Spill
; O3N64-NEXT:    lui $1, %hi(%neg(%gp_rel(f0)))
; O3N64-NEXT:    daddu $1, $1, $25
; O3N64-NEXT:    daddiu $gp, $1, %lo(%neg(%gp_rel(f0)))
; O3N64-NEXT:    ld $25, %call16(f1)($gp)
; O3N64-NEXT:    jalr $25
; O3N64-NEXT:    nop
; O3N64-NEXT:    ld $1, %got_disp(p)($gp)
; O3N64-NEXT:    ld $25, %call16(f2)($gp)
; O3N64-NEXT:    jalr $25
; O3N64-NEXT:    lw $4, 0($1)
; O3N64-NEXT:    ld $1, %got_disp(q)($gp)
; O3N64-NEXT:    ld $25, %call16(f2)($gp)
; O3N64-NEXT:    lw $16, 0($1)
; O3N64-NEXT:    jalr $25
; O3N64-NEXT:    move $4, $16
; O3N64-NEXT:    ld $1, %got_disp(r)($gp)
; O3N64-NEXT:    ld $25, %call16(f3)($gp)
; O3N64-NEXT:    move $4, $16
; O3N64-NEXT:    jalr $25
; O3N64-NEXT:    lw $5, 0($1)
; O3N64-NEXT:    ld $16, 8($sp) # 8-byte Folded Reload
; O3N64-NEXT:    ld $gp, 16($sp) # 8-byte Folded Reload
; O3N64-NEXT:    ld $ra, 24($sp) # 8-byte Folded Reload
; O3N64-NEXT:    jr $ra
; O3N64-NEXT:    daddiu $sp, $sp, 32
;
; O3N32-LABEL: f0:
; O3N32:       # %bb.0: # %entry
; O3N32-NEXT:    addiu $sp, $sp, -32
; O3N32-NEXT:    sd $ra, 24($sp) # 8-byte Folded Spill
; O3N32-NEXT:    sd $gp, 16($sp) # 8-byte Folded Spill
; O3N32-NEXT:    sd $16, 8($sp) # 8-byte Folded Spill
; O3N32-NEXT:    lui $1, %hi(%neg(%gp_rel(f0)))
; O3N32-NEXT:    addu $1, $1, $25
; O3N32-NEXT:    addiu $gp, $1, %lo(%neg(%gp_rel(f0)))
; O3N32-NEXT:    lw $25, %call16(f1)($gp)
; O3N32-NEXT:    jalr $25
; O3N32-NEXT:    nop
; O3N32-NEXT:    lw $1, %got_disp(p)($gp)
; O3N32-NEXT:    lw $25, %call16(f2)($gp)
; O3N32-NEXT:    jalr $25
; O3N32-NEXT:    lw $4, 0($1)
; O3N32-NEXT:    lw $1, %got_disp(q)($gp)
; O3N32-NEXT:    lw $25, %call16(f2)($gp)
; O3N32-NEXT:    lw $16, 0($1)
; O3N32-NEXT:    jalr $25
; O3N32-NEXT:    move $4, $16
; O3N32-NEXT:    lw $1, %got_disp(r)($gp)
; O3N32-NEXT:    lw $25, %call16(f3)($gp)
; O3N32-NEXT:    move $4, $16
; O3N32-NEXT:    jalr $25
; O3N32-NEXT:    lw $5, 0($1)
; O3N32-NEXT:    ld $16, 8($sp) # 8-byte Folded Reload
; O3N32-NEXT:    ld $gp, 16($sp) # 8-byte Folded Reload
; O3N32-NEXT:    ld $ra, 24($sp) # 8-byte Folded Reload
; O3N32-NEXT:    jr $ra
; O3N32-NEXT:    addiu $sp, $sp, 32
entry:
  tail call void @f1() nounwind
  %tmp = load i32, ptr @p, align 4
  tail call void @f2(i32 %tmp) nounwind
  %tmp1 = load i32, ptr @q, align 4
  tail call void @f2(i32 %tmp1) nounwind
  %tmp2 = load i32, ptr @r, align 4
  tail call void @f3(i32 %tmp1, i32 %tmp2) nounwind
  ret void
}

declare void @f1()

declare void @f2(i32)

declare void @f3(i32, i32)

