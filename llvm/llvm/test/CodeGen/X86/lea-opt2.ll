; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown -verify-machineinstrs | FileCheck %s

; This file tests following optimization
;
;        leal    (%rdx,%rax), %esi
;        subl    %esi, %ecx
;
; can be transformed to
;
;        subl    %edx, %ecx
;        subl    %eax, %ecx

; C - (A + B)   -->    C - A - B
define i32 @test1(ptr %p, i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    # kill: def $edx killed $edx def $rdx
; CHECK-NEXT:    movl %esi, %eax
; CHECK-NEXT:    subl %edx, %ecx
; CHECK-NEXT:    subl %eax, %ecx
; CHECK-NEXT:    movl %ecx, (%rdi)
; CHECK-NEXT:    subl %edx, %eax
; CHECK-NEXT:    # kill: def $eax killed $eax killed $rax
; CHECK-NEXT:    retq
entry:
  %0 = add i32 %b, %a
  %sub = sub i32 %c, %0
  store i32 %sub, ptr %p, align 4
  %sub1 = sub i32 %a, %b
  ret i32 %sub1
}

; (A + B) + C   -->    C + A + B
define i32 @test2(ptr %p, i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    # kill: def $edx killed $edx def $rdx
; CHECK-NEXT:    movl %esi, %eax
; CHECK-NEXT:    addl %eax, %ecx
; CHECK-NEXT:    addl %edx, %ecx
; CHECK-NEXT:    movl %ecx, (%rdi)
; CHECK-NEXT:    subl %edx, %eax
; CHECK-NEXT:    # kill: def $eax killed $eax killed $rax
; CHECK-NEXT:    retq
entry:
  %0 = add i32 %a, %b
  %1 = add i32 %c, %0
  store i32 %1, ptr %p, align 4
  %sub1 = sub i32 %a, %b
  ret i32 %sub1
}

; C + (A + B)   -->    C + A + B
define i32 @test3(ptr %p, i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test3:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    # kill: def $edx killed $edx def $rdx
; CHECK-NEXT:    movl %esi, %eax
; CHECK-NEXT:    addl %eax, %ecx
; CHECK-NEXT:    addl %edx, %ecx
; CHECK-NEXT:    movl %ecx, (%rdi)
; CHECK-NEXT:    subl %edx, %eax
; CHECK-NEXT:    # kill: def $eax killed $eax killed $rax
; CHECK-NEXT:    retq
entry:
  %0 = add i32 %a, %b
  %1 = add i32 %0, %c
  store i32 %1, ptr %p, align 4
  %sub1 = sub i32 %a, %b
  ret i32 %sub1
}

; (A + B) - C
; Can't be converted to A - C + B without introduce MOV
define i32 @test4(ptr %p, i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    # kill: def $edx killed $edx def $rdx
; CHECK-NEXT:    movl %esi, %eax
; CHECK-NEXT:    leal (%rdx,%rax), %esi
; CHECK-NEXT:    subl %ecx, %esi
; CHECK-NEXT:    movl %esi, (%rdi)
; CHECK-NEXT:    subl %edx, %eax
; CHECK-NEXT:    # kill: def $eax killed $eax killed $rax
; CHECK-NEXT:    retq
entry:
  %0 = add i32 %b, %a
  %sub = sub i32 %0, %c
  store i32 %sub, ptr %p, align 4
  %sub1 = sub i32 %a, %b
  ret i32 %sub1
}

define i64 @test5(ptr %p, i64 %a, i64 %b, i64 %c) {
; CHECK-LABEL: test5:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq (%rdi), %rax
; CHECK-NEXT:    subq %rdx, %rcx
; CHECK-NEXT:    subq %rax, %rcx
; CHECK-NEXT:    movq %rcx, (%rdi)
; CHECK-NEXT:    subq %rdx, %rax
; CHECK-NEXT:    retq
entry:
  %ld = load i64, ptr %p, align 8
  %0 = add i64 %b, %ld
  %sub = sub i64 %c, %0
  store i64 %sub, ptr %p, align 8
  %sub1 = sub i64 %ld, %b
  ret i64 %sub1
}

define i64 @test6(ptr %p, i64 %a, i64 %b, i64 %c) {
; CHECK-LABEL: test6:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq (%rdi), %rax
; CHECK-NEXT:    addq %rdx, %rcx
; CHECK-NEXT:    addq %rax, %rcx
; CHECK-NEXT:    movq %rcx, (%rdi)
; CHECK-NEXT:    subq %rdx, %rax
; CHECK-NEXT:    retq
entry:
  %ld = load i64, ptr %p, align 8
  %0 = add i64 %b, %ld
  %1 = add i64 %0, %c
  store i64 %1, ptr %p, align 8
  %sub1 = sub i64 %ld, %b
  ret i64 %sub1
}

define i64 @test7(ptr %p, i64 %a, i64 %b, i64 %c) {
; CHECK-LABEL: test7:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq (%rdi), %rax
; CHECK-NEXT:    addq %rdx, %rcx
; CHECK-NEXT:    addq %rax, %rcx
; CHECK-NEXT:    movq %rcx, (%rdi)
; CHECK-NEXT:    subq %rdx, %rax
; CHECK-NEXT:    retq
entry:
  %ld = load i64, ptr %p, align 8
  %0 = add i64 %b, %ld
  %1 = add i64 %c, %0
  store i64 %1, ptr %p, align 8
  %sub1 = sub i64 %ld, %b
  ret i64 %sub1
}

; The sub instruction generated flags is used by following branch,
; so it should not be transformed.
define i64 @test8(ptr %p, i64 %a, i64 %b, i64 %c) {
; CHECK-LABEL: test8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq (%rdi), %rax
; CHECK-NEXT:    leaq (%rdx,%rax), %rsi
; CHECK-NEXT:    subq %rsi, %rcx
; CHECK-NEXT:    ja .LBB7_2
; CHECK-NEXT:  # %bb.1: # %then
; CHECK-NEXT:    movq %rcx, (%rdi)
; CHECK-NEXT:    subq %rdx, %rax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB7_2: # %else
; CHECK-NEXT:    movq $0, (%rdi)
; CHECK-NEXT:    subq %rdx, %rax
; CHECK-NEXT:    retq
entry:
  %ld = load i64, ptr %p, align 8
  %0 = add i64 %b, %ld
  %sub = sub i64 %c, %0
  %cond = icmp ule i64 %c, %0
  br i1 %cond, label %then, label %else

then:
  store i64 %sub, ptr %p, align 8
  br label %endif

else:
  store i64 0, ptr %p, align 8
  br label %endif

endif:
  %sub1 = sub i64 %ld, %b
  ret i64 %sub1
}

; PR50615
; The sub register usage of lea dest should block the transformation.
define void @test9(i64 %p, i64 %s) {
; CHECK-LABEL: test9:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    leaq (%rsi,%rdi), %rax
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    testl $4095, %eax # imm = 0xFFF
; CHECK-NEXT:    setne %cl
; CHECK-NEXT:    shll $12, %ecx
; CHECK-NEXT:    addq %rax, %rcx
; CHECK-NEXT:    andq $-4096, %rcx # imm = 0xF000
; CHECK-NEXT:    addq %rcx, %rdi
; CHECK-NEXT:    jmp bar@PLT # TAILCALL
entry:
  %add = add i64 %s, %p
  %rem = and i64 %add, 4095
  %cmp.not = icmp eq i64 %rem, 0
  %add18 = select i1 %cmp.not, i64 0, i64 4096
  %div9 = add i64 %add18, %add
  %mul = and i64 %div9, -4096
  %add2 = add i64 %mul, %p
  tail call void @bar(i64 %add2, i64 %s)
  ret void
}

define void @test10() {
; CHECK-LABEL: test10:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl (%rax), %eax
; CHECK-NEXT:    movzwl (%rax), %ecx
; CHECK-NEXT:    leal (%rcx,%rcx,2), %esi
; CHECK-NEXT:    movl %ecx, %edi
; CHECK-NEXT:    subl %ecx, %edi
; CHECK-NEXT:    subl %ecx, %edi
; CHECK-NEXT:    negl %esi
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    cmpl $4, %eax
; CHECK-NEXT:    movl %edi, (%rax)
; CHECK-NEXT:    movl %esi, (%rax)
; CHECK-NEXT:    cmovnel %eax, %ecx
; CHECK-NEXT:    # kill: def $cl killed $cl killed $ecx
; CHECK-NEXT:    sarl %cl, %esi
; CHECK-NEXT:    movl %esi, (%rax)
; CHECK-NEXT:    retq
entry:
  %tmp = load i32, ptr undef, align 4
  %tmp3 = sdiv i32 undef, 6
  %tmp4 = load i32, ptr undef, align 4
  %tmp5 = icmp eq i32 %tmp4, 4
  %tmp6 = select i1 %tmp5, i32 %tmp3, i32 %tmp
  %tmp10 = load i16, ptr undef, align 2
  %tmp11 = zext i16 %tmp10 to i32
  %tmp13 = zext i16 undef to i32
  %tmp15 = load i16, ptr undef, align 2
  %tmp16 = zext i16 %tmp15 to i32
  %tmp19 = shl nsw i32 undef, 1
  %tmp25 = shl nsw i32 undef, 1
  %tmp26 = add nsw i32 %tmp25, %tmp13
  %tmp28 = shl nsw i32 undef, 1
  %tmp29 = add nsw i32 %tmp28, %tmp16
  %tmp30 = sub nsw i32 %tmp19, %tmp29
  %tmp31 = sub nsw i32 %tmp11, %tmp26
  %tmp32 = shl nsw i32 %tmp30, 1
  %tmp33 = add nsw i32 %tmp32, %tmp31
  store i32 %tmp33, ptr undef, align 4
  %tmp34 = mul nsw i32 %tmp31, -2
  %tmp35 = add nsw i32 %tmp34, %tmp30
  store i32 %tmp35, ptr undef, align 4
  %tmp36 = select i1 %tmp5, i32 undef, i32 undef
  %tmp38 = load i32, ptr undef, align 4
  %tmp39 = ashr i32 %tmp38, %tmp6
  store i32 %tmp39, ptr undef, align 4
  ret void
}

declare void @bar(i64, i64)

