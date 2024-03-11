; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 -O0 < %s | FileCheck %s --check-prefix=NOSHRINKW
; RUN: llc --mtriple=loongarch64 -O2 < %s | FileCheck %s --check-prefix=SHRINKW

declare void @abort()

define void @eliminate_restore(i32 %n) nounwind {
; NOSHRINKW-LABEL: eliminate_restore:
; NOSHRINKW:       # %bb.0:
; NOSHRINKW-NEXT:    addi.d $sp, $sp, -16
; NOSHRINKW-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; NOSHRINKW-NEXT:    addi.w $a1, $a0, 0
; NOSHRINKW-NEXT:    ori $a0, $zero, 32
; NOSHRINKW-NEXT:    bltu $a0, $a1, .LBB0_2
; NOSHRINKW-NEXT:    b .LBB0_1
; NOSHRINKW-NEXT:  .LBB0_1: # %if.then
; NOSHRINKW-NEXT:    bl %plt(abort)
; NOSHRINKW-NEXT:  .LBB0_2: # %if.end
; NOSHRINKW-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; NOSHRINKW-NEXT:    addi.d $sp, $sp, 16
; NOSHRINKW-NEXT:    ret
;
; SHRINKW-LABEL: eliminate_restore:
; SHRINKW:       # %bb.0:
; SHRINKW-NEXT:    addi.w $a0, $a0, 0
; SHRINKW-NEXT:    ori $a1, $zero, 32
; SHRINKW-NEXT:    bgeu $a1, $a0, .LBB0_2
; SHRINKW-NEXT:  # %bb.1: # %if.end
; SHRINKW-NEXT:    ret
; SHRINKW-NEXT:  .LBB0_2: # %if.then
; SHRINKW-NEXT:    addi.d $sp, $sp, -16
; SHRINKW-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; SHRINKW-NEXT:    bl %plt(abort)
  %cmp = icmp ule i32 %n, 32
  br i1 %cmp, label %if.then, label %if.end

if.then:
  call void @abort()
  unreachable

if.end:
  ret void
}

declare void @notdead(ptr)

define void @conditional_alloca(i32 %n) nounwind {
; NOSHRINKW-LABEL: conditional_alloca:
; NOSHRINKW:       # %bb.0:
; NOSHRINKW-NEXT:    addi.d $sp, $sp, -32
; NOSHRINKW-NEXT:    st.d $ra, $sp, 24 # 8-byte Folded Spill
; NOSHRINKW-NEXT:    st.d $fp, $sp, 16 # 8-byte Folded Spill
; NOSHRINKW-NEXT:    addi.d $fp, $sp, 32
; NOSHRINKW-NEXT:    addi.w $a1, $a0, 0
; NOSHRINKW-NEXT:    st.d $a0, $fp, -24 # 8-byte Folded Spill
; NOSHRINKW-NEXT:    ori $a0, $zero, 32
; NOSHRINKW-NEXT:    bltu $a0, $a1, .LBB1_2
; NOSHRINKW-NEXT:    b .LBB1_1
; NOSHRINKW-NEXT:  .LBB1_1: # %if.then
; NOSHRINKW-NEXT:    ld.d $a0, $fp, -24 # 8-byte Folded Reload
; NOSHRINKW-NEXT:    bstrpick.d $a0, $a0, 31, 0
; NOSHRINKW-NEXT:    addi.d $a0, $a0, 15
; NOSHRINKW-NEXT:    bstrpick.d $a0, $a0, 32, 4
; NOSHRINKW-NEXT:    slli.d $a1, $a0, 4
; NOSHRINKW-NEXT:    move $a0, $sp
; NOSHRINKW-NEXT:    sub.d $a0, $a0, $a1
; NOSHRINKW-NEXT:    move $sp, $a0
; NOSHRINKW-NEXT:    bl %plt(notdead)
; NOSHRINKW-NEXT:    b .LBB1_2
; NOSHRINKW-NEXT:  .LBB1_2: # %if.end
; NOSHRINKW-NEXT:    addi.d $sp, $fp, -32
; NOSHRINKW-NEXT:    ld.d $fp, $sp, 16 # 8-byte Folded Reload
; NOSHRINKW-NEXT:    ld.d $ra, $sp, 24 # 8-byte Folded Reload
; NOSHRINKW-NEXT:    addi.d $sp, $sp, 32
; NOSHRINKW-NEXT:    ret
;
; SHRINKW-LABEL: conditional_alloca:
; SHRINKW:       # %bb.0:
; SHRINKW-NEXT:    addi.w $a1, $a0, 0
; SHRINKW-NEXT:    ori $a2, $zero, 32
; SHRINKW-NEXT:    bltu $a2, $a1, .LBB1_2
; SHRINKW-NEXT:  # %bb.1: # %if.then
; SHRINKW-NEXT:    addi.d $sp, $sp, -16
; SHRINKW-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; SHRINKW-NEXT:    st.d $fp, $sp, 0 # 8-byte Folded Spill
; SHRINKW-NEXT:    addi.d $fp, $sp, 16
; SHRINKW-NEXT:    bstrpick.d $a0, $a0, 31, 0
; SHRINKW-NEXT:    addi.d $a0, $a0, 15
; SHRINKW-NEXT:    bstrpick.d $a0, $a0, 32, 4
; SHRINKW-NEXT:    slli.d $a0, $a0, 4
; SHRINKW-NEXT:    sub.d $a0, $sp, $a0
; SHRINKW-NEXT:    move $sp, $a0
; SHRINKW-NEXT:    bl %plt(notdead)
; SHRINKW-NEXT:    addi.d $sp, $fp, -16
; SHRINKW-NEXT:    ld.d $fp, $sp, 0 # 8-byte Folded Reload
; SHRINKW-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; SHRINKW-NEXT:    addi.d $sp, $sp, 16
; SHRINKW-NEXT:  .LBB1_2: # %if.end
; SHRINKW-NEXT:    ret
  %cmp = icmp ule i32 %n, 32
  br i1 %cmp, label %if.then, label %if.end

if.then:
  %addr = alloca i8, i32 %n
  call void @notdead(ptr %addr)
  br label %if.end

if.end:
  ret void
}