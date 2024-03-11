; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 < %s | FileCheck %s

;; Perform tail call optimization for global address.
declare i32 @callee_tail(i32 %i)
define i32 @caller_tail(i32 %i) nounwind {
; CHECK-LABEL: caller_tail:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    b %plt(callee_tail)
entry:
  %r = tail call i32 @callee_tail(i32 %i)
  ret i32 %r
}

;; Perform tail call optimization for external symbol.
;; Bytes copied should be large enough, otherwise the memcpy call would be optimized to multiple ld/st insns.
@dest = global [2 x i8] zeroinitializer
declare void @llvm.memcpy.p0.p0.i32(ptr, ptr, i32, i1)
define void @caller_extern(ptr %src) optsize {
; CHECK-LABEL: caller_extern:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pcalau12i $a1, %got_pc_hi20(dest)
; CHECK-NEXT:    ld.d $a1, $a1, %got_pc_lo12(dest)
; CHECK-NEXT:    ori $a2, $zero, 33
; CHECK-NEXT:    move $a3, $a0
; CHECK-NEXT:    move $a0, $a1
; CHECK-NEXT:    move $a1, $a3
; CHECK-NEXT:    b %plt(memcpy)
entry:
  tail call void @llvm.memcpy.p0.p0.i32(ptr @dest, ptr %src, i32 33, i1 false)
  ret void
}

;; Perform indirect tail call optimization (for function pointer call).
declare void @callee_indirect1()
declare void @callee_indirect2()
define void @caller_indirect_tail(i32 %a) nounwind {
; CHECK-LABEL: caller_indirect_tail:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pcalau12i $a1, %got_pc_hi20(callee_indirect2)
; CHECK-NEXT:    ld.d $a1, $a1, %got_pc_lo12(callee_indirect2)
; CHECK-NEXT:    pcalau12i $a2, %got_pc_hi20(callee_indirect1)
; CHECK-NEXT:    ld.d $a2, $a2, %got_pc_lo12(callee_indirect1)
; CHECK-NEXT:    addi.w $a0, $a0, 0
; CHECK-NEXT:    sltui $a0, $a0, 1
; CHECK-NEXT:    masknez $a1, $a1, $a0
; CHECK-NEXT:    maskeqz $a0, $a2, $a0
; CHECK-NEXT:    or $a0, $a0, $a1
; CHECK-NEXT:    jr $a0
entry:
  %tobool = icmp eq i32 %a, 0
  %callee = select i1 %tobool, ptr @callee_indirect1, ptr @callee_indirect2
  tail call void %callee()
  ret void
}

;; Do not tail call optimize functions with varargs passed by stack.
declare i32 @callee_varargs(i32, ...)
define void @caller_varargs(i32 %a, i32 %b) nounwind {
; CHECK-LABEL: caller_varargs:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi.d $sp, $sp, -16
; CHECK-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; CHECK-NEXT:    st.d $a0, $sp, 0
; CHECK-NEXT:    move $a2, $a1
; CHECK-NEXT:    move $a3, $a0
; CHECK-NEXT:    move $a4, $a0
; CHECK-NEXT:    move $a5, $a1
; CHECK-NEXT:    move $a6, $a1
; CHECK-NEXT:    move $a7, $a0
; CHECK-NEXT:    bl %plt(callee_varargs)
; CHECK-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; CHECK-NEXT:    addi.d $sp, $sp, 16
; CHECK-NEXT:    ret
entry:
  %call = tail call i32 (i32, ...) @callee_varargs(i32 %a, i32 %b, i32 %b, i32 %a, i32 %a, i32 %b, i32 %b, i32 %a, i32 %a)
  ret void
}

;; Do not tail call optimize if stack is used to pass parameters.
declare i32 @callee_args(i32 %a, i32 %b, i32 %c, i32 %dd, i32 %e, i32 %ff, i32 %g, i32 %h, i32 %i)
define i32 @caller_args(i32 %a, i32 %b, i32 %c, i32 %dd, i32 %e, i32 %ff, i32 %g, i32 %h, i32 %i) nounwind {
; CHECK-LABEL: caller_args:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi.d $sp, $sp, -16
; CHECK-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; CHECK-NEXT:    ld.d $t0, $sp, 16
; CHECK-NEXT:    st.d $t0, $sp, 0
; CHECK-NEXT:    bl %plt(callee_args)
; CHECK-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; CHECK-NEXT:    addi.d $sp, $sp, 16
; CHECK-NEXT:    ret
entry:
  %r = tail call i32 @callee_args(i32 %a, i32 %b, i32 %c, i32 %dd, i32 %e, i32 %ff, i32 %g, i32 %h, i32 %i)
  ret i32 %r
}

;; Do not tail call optimize if parameters need to be passed indirectly.
declare i32 @callee_indirect_args(i256 %a)
define void @caller_indirect_args() nounwind {
; CHECK-LABEL: caller_indirect_args:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi.d $sp, $sp, -48
; CHECK-NEXT:    st.d $ra, $sp, 40 # 8-byte Folded Spill
; CHECK-NEXT:    st.d $zero, $sp, 24
; CHECK-NEXT:    st.d $zero, $sp, 16
; CHECK-NEXT:    st.d $zero, $sp, 8
; CHECK-NEXT:    ori $a1, $zero, 1
; CHECK-NEXT:    addi.d $a0, $sp, 0
; CHECK-NEXT:    st.d $a1, $sp, 0
; CHECK-NEXT:    bl %plt(callee_indirect_args)
; CHECK-NEXT:    ld.d $ra, $sp, 40 # 8-byte Folded Reload
; CHECK-NEXT:    addi.d $sp, $sp, 48
; CHECK-NEXT:    ret
entry:
  %call = tail call i32 @callee_indirect_args(i256 1)
  ret void
}

;; Do not tail call optimize if byval parameters need to be passed.
declare i32 @callee_byval(ptr byval(ptr) %a)
define i32 @caller_byval() nounwind {
; CHECK-LABEL: caller_byval:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi.d $sp, $sp, -32
; CHECK-NEXT:    st.d $ra, $sp, 24 # 8-byte Folded Spill
; CHECK-NEXT:    ld.d $a0, $sp, 16
; CHECK-NEXT:    st.d $a0, $sp, 8
; CHECK-NEXT:    addi.d $a0, $sp, 8
; CHECK-NEXT:    bl %plt(callee_byval)
; CHECK-NEXT:    ld.d $ra, $sp, 24 # 8-byte Folded Reload
; CHECK-NEXT:    addi.d $sp, $sp, 32
; CHECK-NEXT:    ret
entry:
  %a = alloca ptr
  %r = tail call i32 @callee_byval(ptr byval(ptr) %a)
  ret i32 %r
}

;; Do not tail call optimize if callee uses structret semantics.
%struct.A = type { i32 }
@a = global %struct.A zeroinitializer

declare void @callee_struct(ptr sret(%struct.A) %a)
define void @caller_nostruct() nounwind {
; CHECK-LABEL: caller_nostruct:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi.d $sp, $sp, -16
; CHECK-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; CHECK-NEXT:    pcalau12i $a0, %got_pc_hi20(a)
; CHECK-NEXT:    ld.d $a0, $a0, %got_pc_lo12(a)
; CHECK-NEXT:    bl %plt(callee_struct)
; CHECK-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; CHECK-NEXT:    addi.d $sp, $sp, 16
; CHECK-NEXT:    ret
entry:
  tail call void @callee_struct(ptr sret(%struct.A) @a)
  ret void
}

;; Do not tail call optimize if caller uses structret semantics.
declare void @callee_nostruct()
define void @caller_struct(ptr sret(%struct.A) %a) nounwind {
; CHECK-LABEL: caller_struct:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi.d $sp, $sp, -16
; CHECK-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; CHECK-NEXT:    bl %plt(callee_nostruct)
; CHECK-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; CHECK-NEXT:    addi.d $sp, $sp, 16
; CHECK-NEXT:    ret
entry:
  tail call void @callee_nostruct()
  ret void
}

;; Do not tail call optimize if disabled.
define i32 @disable_tail_calls(i32 %i) nounwind "disable-tail-calls"="true" {
; CHECK-LABEL: disable_tail_calls:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi.d $sp, $sp, -16
; CHECK-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; CHECK-NEXT:    bl %plt(callee_tail)
; CHECK-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; CHECK-NEXT:    addi.d $sp, $sp, 16
; CHECK-NEXT:    ret
entry:
  %rv = tail call i32 @callee_tail(i32 %i)
  ret i32 %rv
}
