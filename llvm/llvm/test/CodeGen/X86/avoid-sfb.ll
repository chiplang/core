; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-linux -mcpu=x86-64 -verify-machineinstrs | FileCheck %s -check-prefixes=SSE,CHECK
; RUN: llc < %s -mtriple=x86_64-linux -mcpu=x86-64 --x86-disable-avoid-SFB -verify-machineinstrs | FileCheck %s --check-prefixes=SSE,DISABLED
; RUN: llc < %s -mtriple=x86_64-linux -mcpu=core-avx2 -verify-machineinstrs | FileCheck %s -check-prefixes=AVX
; RUN: llc < %s -mtriple=x86_64-linux -mcpu=skx -verify-machineinstrs | FileCheck %s -check-prefixes=AVX

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.S = type { i32, i32, i32, i32 }

; Function Attrs: nounwind uwtable
define void @test_conditional_block(ptr nocapture noalias %s1 , ptr nocapture noalias %s2, i32 %x, ptr nocapture noalias  %s3, ptr nocapture noalias readonly %s4) local_unnamed_addr #0 {
; CHECK-LABEL: test_conditional_block:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpl $18, %edx
; CHECK-NEXT:    jl .LBB0_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    movl %edx, 4(%rdi)
; CHECK-NEXT:  .LBB0_2: # %if.end
; CHECK-NEXT:    movups (%r8), %xmm0
; CHECK-NEXT:    movups %xmm0, (%rcx)
; CHECK-NEXT:    movl (%rdi), %eax
; CHECK-NEXT:    movl %eax, (%rsi)
; CHECK-NEXT:    movl 4(%rdi), %eax
; CHECK-NEXT:    movl %eax, 4(%rsi)
; CHECK-NEXT:    movq 8(%rdi), %rax
; CHECK-NEXT:    movq %rax, 8(%rsi)
; CHECK-NEXT:    retq
;
; DISABLED-LABEL: test_conditional_block:
; DISABLED:       # %bb.0: # %entry
; DISABLED-NEXT:    cmpl $18, %edx
; DISABLED-NEXT:    jl .LBB0_2
; DISABLED-NEXT:  # %bb.1: # %if.then
; DISABLED-NEXT:    movl %edx, 4(%rdi)
; DISABLED-NEXT:  .LBB0_2: # %if.end
; DISABLED-NEXT:    movups (%r8), %xmm0
; DISABLED-NEXT:    movups %xmm0, (%rcx)
; DISABLED-NEXT:    movups (%rdi), %xmm0
; DISABLED-NEXT:    movups %xmm0, (%rsi)
; DISABLED-NEXT:    retq
;
; AVX-LABEL: test_conditional_block:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    cmpl $18, %edx
; AVX-NEXT:    jl .LBB0_2
; AVX-NEXT:  # %bb.1: # %if.then
; AVX-NEXT:    movl %edx, 4(%rdi)
; AVX-NEXT:  .LBB0_2: # %if.end
; AVX-NEXT:    vmovups (%r8), %xmm0
; AVX-NEXT:    vmovups %xmm0, (%rcx)
; AVX-NEXT:    movl (%rdi), %eax
; AVX-NEXT:    movl %eax, (%rsi)
; AVX-NEXT:    movl 4(%rdi), %eax
; AVX-NEXT:    movl %eax, 4(%rsi)
; AVX-NEXT:    movq 8(%rdi), %rax
; AVX-NEXT:    movq %rax, 8(%rsi)
; AVX-NEXT:    retq
entry:
  %cmp = icmp sgt i32 %x, 17
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %b = getelementptr inbounds %struct.S, ptr %s1, i64 0, i32 1
  store i32 %x, ptr %b, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s3, ptr %s4, i64 16, i32 4, i1 false)
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s2, ptr %s1, i64 16, i32 4, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @test_imm_store(ptr nocapture noalias %s1, ptr nocapture %s2, i32 %x, ptr nocapture %s3) local_unnamed_addr #0 {
; CHECK-LABEL: test_imm_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl $0, (%rdi)
; CHECK-NEXT:    movl $1, (%rcx)
; CHECK-NEXT:    movl (%rdi), %eax
; CHECK-NEXT:    movl %eax, (%rsi)
; CHECK-NEXT:    movq 4(%rdi), %rax
; CHECK-NEXT:    movq %rax, 4(%rsi)
; CHECK-NEXT:    movl 12(%rdi), %eax
; CHECK-NEXT:    movl %eax, 12(%rsi)
; CHECK-NEXT:    retq
;
; DISABLED-LABEL: test_imm_store:
; DISABLED:       # %bb.0: # %entry
; DISABLED-NEXT:    movl $0, (%rdi)
; DISABLED-NEXT:    movl $1, (%rcx)
; DISABLED-NEXT:    movups (%rdi), %xmm0
; DISABLED-NEXT:    movups %xmm0, (%rsi)
; DISABLED-NEXT:    retq
;
; AVX-LABEL: test_imm_store:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    movl $0, (%rdi)
; AVX-NEXT:    movl $1, (%rcx)
; AVX-NEXT:    movl (%rdi), %eax
; AVX-NEXT:    movl %eax, (%rsi)
; AVX-NEXT:    movq 4(%rdi), %rax
; AVX-NEXT:    movq %rax, 4(%rsi)
; AVX-NEXT:    movl 12(%rdi), %eax
; AVX-NEXT:    movl %eax, 12(%rsi)
; AVX-NEXT:    retq
entry:
  store i32 0, ptr %s1, align 4
  store i32 1, ptr %s3, align 4
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s2, ptr %s1, i64 16, i32 4, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @test_nondirect_br(ptr nocapture noalias %s1, ptr nocapture %s2, i32 %x, ptr nocapture %s3, ptr nocapture readonly %s4, i32 %x2) local_unnamed_addr #0 {
; CHECK-LABEL: test_nondirect_br:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpl $18, %edx
; CHECK-NEXT:    jl .LBB2_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    movl %edx, 4(%rdi)
; CHECK-NEXT:  .LBB2_2: # %if.end
; CHECK-NEXT:    cmpl $14, %r9d
; CHECK-NEXT:    jl .LBB2_4
; CHECK-NEXT:  # %bb.3: # %if.then2
; CHECK-NEXT:    movl %r9d, 12(%rdi)
; CHECK-NEXT:  .LBB2_4: # %if.end3
; CHECK-NEXT:    movups (%r8), %xmm0
; CHECK-NEXT:    movups %xmm0, (%rcx)
; CHECK-NEXT:    movq (%rdi), %rax
; CHECK-NEXT:    movq %rax, (%rsi)
; CHECK-NEXT:    movl 8(%rdi), %eax
; CHECK-NEXT:    movl %eax, 8(%rsi)
; CHECK-NEXT:    movl 12(%rdi), %eax
; CHECK-NEXT:    movl %eax, 12(%rsi)
; CHECK-NEXT:    retq
;
; DISABLED-LABEL: test_nondirect_br:
; DISABLED:       # %bb.0: # %entry
; DISABLED-NEXT:    cmpl $18, %edx
; DISABLED-NEXT:    jl .LBB2_2
; DISABLED-NEXT:  # %bb.1: # %if.then
; DISABLED-NEXT:    movl %edx, 4(%rdi)
; DISABLED-NEXT:  .LBB2_2: # %if.end
; DISABLED-NEXT:    cmpl $14, %r9d
; DISABLED-NEXT:    jl .LBB2_4
; DISABLED-NEXT:  # %bb.3: # %if.then2
; DISABLED-NEXT:    movl %r9d, 12(%rdi)
; DISABLED-NEXT:  .LBB2_4: # %if.end3
; DISABLED-NEXT:    movups (%r8), %xmm0
; DISABLED-NEXT:    movups %xmm0, (%rcx)
; DISABLED-NEXT:    movups (%rdi), %xmm0
; DISABLED-NEXT:    movups %xmm0, (%rsi)
; DISABLED-NEXT:    retq
;
; AVX-LABEL: test_nondirect_br:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    cmpl $18, %edx
; AVX-NEXT:    jl .LBB2_2
; AVX-NEXT:  # %bb.1: # %if.then
; AVX-NEXT:    movl %edx, 4(%rdi)
; AVX-NEXT:  .LBB2_2: # %if.end
; AVX-NEXT:    cmpl $14, %r9d
; AVX-NEXT:    jl .LBB2_4
; AVX-NEXT:  # %bb.3: # %if.then2
; AVX-NEXT:    movl %r9d, 12(%rdi)
; AVX-NEXT:  .LBB2_4: # %if.end3
; AVX-NEXT:    vmovups (%r8), %xmm0
; AVX-NEXT:    vmovups %xmm0, (%rcx)
; AVX-NEXT:    movq (%rdi), %rax
; AVX-NEXT:    movq %rax, (%rsi)
; AVX-NEXT:    movl 8(%rdi), %eax
; AVX-NEXT:    movl %eax, 8(%rsi)
; AVX-NEXT:    movl 12(%rdi), %eax
; AVX-NEXT:    movl %eax, 12(%rsi)
; AVX-NEXT:    retq
entry:
  %cmp = icmp sgt i32 %x, 17
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %b = getelementptr inbounds %struct.S, ptr %s1, i64 0, i32 1
  store i32 %x, ptr %b, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %cmp1 = icmp sgt i32 %x2, 13
  br i1 %cmp1, label %if.then2, label %if.end3

if.then2:                                         ; preds = %if.end
  %d = getelementptr inbounds %struct.S, ptr %s1, i64 0, i32 3
  store i32 %x2, ptr %d, align 4
  br label %if.end3

if.end3:                                          ; preds = %if.then2, %if.end
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s3, ptr %s4, i64 16, i32 4, i1 false)
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s2, ptr %s1, i64 16, i32 4, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @test_2preds_block(ptr nocapture noalias %s1, ptr nocapture %s2, i32 %x, ptr nocapture %s3, ptr nocapture readonly %s4, i32 %x2) local_unnamed_addr #0 {
; CHECK-LABEL: test_2preds_block:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %r9d, 12(%rdi)
; CHECK-NEXT:    cmpl $18, %edx
; CHECK-NEXT:    jl .LBB3_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    movl %edx, 4(%rdi)
; CHECK-NEXT:  .LBB3_2: # %if.end
; CHECK-NEXT:    movups (%r8), %xmm0
; CHECK-NEXT:    movups %xmm0, (%rcx)
; CHECK-NEXT:    movl (%rdi), %eax
; CHECK-NEXT:    movl %eax, (%rsi)
; CHECK-NEXT:    movl 4(%rdi), %eax
; CHECK-NEXT:    movl %eax, 4(%rsi)
; CHECK-NEXT:    movl 8(%rdi), %eax
; CHECK-NEXT:    movl %eax, 8(%rsi)
; CHECK-NEXT:    movl 12(%rdi), %eax
; CHECK-NEXT:    movl %eax, 12(%rsi)
; CHECK-NEXT:    retq
;
; DISABLED-LABEL: test_2preds_block:
; DISABLED:       # %bb.0: # %entry
; DISABLED-NEXT:    movl %r9d, 12(%rdi)
; DISABLED-NEXT:    cmpl $18, %edx
; DISABLED-NEXT:    jl .LBB3_2
; DISABLED-NEXT:  # %bb.1: # %if.then
; DISABLED-NEXT:    movl %edx, 4(%rdi)
; DISABLED-NEXT:  .LBB3_2: # %if.end
; DISABLED-NEXT:    movups (%r8), %xmm0
; DISABLED-NEXT:    movups %xmm0, (%rcx)
; DISABLED-NEXT:    movups (%rdi), %xmm0
; DISABLED-NEXT:    movups %xmm0, (%rsi)
; DISABLED-NEXT:    retq
;
; AVX-LABEL: test_2preds_block:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    movl %r9d, 12(%rdi)
; AVX-NEXT:    cmpl $18, %edx
; AVX-NEXT:    jl .LBB3_2
; AVX-NEXT:  # %bb.1: # %if.then
; AVX-NEXT:    movl %edx, 4(%rdi)
; AVX-NEXT:  .LBB3_2: # %if.end
; AVX-NEXT:    vmovups (%r8), %xmm0
; AVX-NEXT:    vmovups %xmm0, (%rcx)
; AVX-NEXT:    movl (%rdi), %eax
; AVX-NEXT:    movl %eax, (%rsi)
; AVX-NEXT:    movl 4(%rdi), %eax
; AVX-NEXT:    movl %eax, 4(%rsi)
; AVX-NEXT:    movl 8(%rdi), %eax
; AVX-NEXT:    movl %eax, 8(%rsi)
; AVX-NEXT:    movl 12(%rdi), %eax
; AVX-NEXT:    movl %eax, 12(%rsi)
; AVX-NEXT:    retq
entry:
  %d = getelementptr inbounds %struct.S, ptr %s1, i64 0, i32 3
  store i32 %x2, ptr %d, align 4
  %cmp = icmp sgt i32 %x, 17
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %b = getelementptr inbounds %struct.S, ptr %s1, i64 0, i32 1
  store i32 %x, ptr %b, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s3, ptr %s4, i64 16, i32 4, i1 false)
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s2, ptr %s1, i64 16, i32 4, i1 false)
  ret void
}
%struct.S2 = type { i64, i64 }

; Function Attrs: nounwind uwtable
define void @test_type64(ptr nocapture noalias %s1, ptr nocapture %s2, i32 %x, ptr nocapture %s3, ptr nocapture readonly %s4) local_unnamed_addr #0 {
; CHECK-LABEL: test_type64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpl $18, %edx
; CHECK-NEXT:    jl .LBB4_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    movslq %edx, %rax
; CHECK-NEXT:    movq %rax, 8(%rdi)
; CHECK-NEXT:  .LBB4_2: # %if.end
; CHECK-NEXT:    movups (%r8), %xmm0
; CHECK-NEXT:    movups %xmm0, (%rcx)
; CHECK-NEXT:    movq (%rdi), %rax
; CHECK-NEXT:    movq %rax, (%rsi)
; CHECK-NEXT:    movq 8(%rdi), %rax
; CHECK-NEXT:    movq %rax, 8(%rsi)
; CHECK-NEXT:    retq
;
; DISABLED-LABEL: test_type64:
; DISABLED:       # %bb.0: # %entry
; DISABLED-NEXT:    cmpl $18, %edx
; DISABLED-NEXT:    jl .LBB4_2
; DISABLED-NEXT:  # %bb.1: # %if.then
; DISABLED-NEXT:    movslq %edx, %rax
; DISABLED-NEXT:    movq %rax, 8(%rdi)
; DISABLED-NEXT:  .LBB4_2: # %if.end
; DISABLED-NEXT:    movups (%r8), %xmm0
; DISABLED-NEXT:    movups %xmm0, (%rcx)
; DISABLED-NEXT:    movups (%rdi), %xmm0
; DISABLED-NEXT:    movups %xmm0, (%rsi)
; DISABLED-NEXT:    retq
;
; AVX-LABEL: test_type64:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    cmpl $18, %edx
; AVX-NEXT:    jl .LBB4_2
; AVX-NEXT:  # %bb.1: # %if.then
; AVX-NEXT:    movslq %edx, %rax
; AVX-NEXT:    movq %rax, 8(%rdi)
; AVX-NEXT:  .LBB4_2: # %if.end
; AVX-NEXT:    vmovups (%r8), %xmm0
; AVX-NEXT:    vmovups %xmm0, (%rcx)
; AVX-NEXT:    movq (%rdi), %rax
; AVX-NEXT:    movq %rax, (%rsi)
; AVX-NEXT:    movq 8(%rdi), %rax
; AVX-NEXT:    movq %rax, 8(%rsi)
; AVX-NEXT:    retq
entry:
  %cmp = icmp sgt i32 %x, 17
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %conv = sext i32 %x to i64
  %b = getelementptr inbounds %struct.S2, ptr %s1, i64 0, i32 1
  store i64 %conv, ptr %b, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s3, ptr %s4, i64 16, i32 8, i1 false)
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s2, ptr %s1, i64 16, i32 8, i1 false)
  ret void
}
%struct.S3 = type { i64, i8, i8, i16, i32 }

; Function Attrs: noinline nounwind uwtable
define void @test_mixed_type(ptr nocapture noalias %s1, ptr nocapture %s2, i32 %x, ptr nocapture readnone %s3, ptr nocapture readnone %s4) local_unnamed_addr #0 {
; CHECK-LABEL: test_mixed_type:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpl $18, %edx
; CHECK-NEXT:    jl .LBB5_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    movslq %edx, %rax
; CHECK-NEXT:    movq %rax, (%rdi)
; CHECK-NEXT:    movb %dl, 8(%rdi)
; CHECK-NEXT:  .LBB5_2: # %if.end
; CHECK-NEXT:    movq (%rdi), %rax
; CHECK-NEXT:    movq %rax, (%rsi)
; CHECK-NEXT:    movzbl 8(%rdi), %eax
; CHECK-NEXT:    movb %al, 8(%rsi)
; CHECK-NEXT:    movl 9(%rdi), %eax
; CHECK-NEXT:    movl %eax, 9(%rsi)
; CHECK-NEXT:    movzwl 13(%rdi), %eax
; CHECK-NEXT:    movw %ax, 13(%rsi)
; CHECK-NEXT:    movzbl 15(%rdi), %eax
; CHECK-NEXT:    movb %al, 15(%rsi)
; CHECK-NEXT:    retq
;
; DISABLED-LABEL: test_mixed_type:
; DISABLED:       # %bb.0: # %entry
; DISABLED-NEXT:    cmpl $18, %edx
; DISABLED-NEXT:    jl .LBB5_2
; DISABLED-NEXT:  # %bb.1: # %if.then
; DISABLED-NEXT:    movslq %edx, %rax
; DISABLED-NEXT:    movq %rax, (%rdi)
; DISABLED-NEXT:    movb %dl, 8(%rdi)
; DISABLED-NEXT:  .LBB5_2: # %if.end
; DISABLED-NEXT:    movups (%rdi), %xmm0
; DISABLED-NEXT:    movups %xmm0, (%rsi)
; DISABLED-NEXT:    retq
;
; AVX-LABEL: test_mixed_type:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    cmpl $18, %edx
; AVX-NEXT:    jl .LBB5_2
; AVX-NEXT:  # %bb.1: # %if.then
; AVX-NEXT:    movslq %edx, %rax
; AVX-NEXT:    movq %rax, (%rdi)
; AVX-NEXT:    movb %dl, 8(%rdi)
; AVX-NEXT:  .LBB5_2: # %if.end
; AVX-NEXT:    movq (%rdi), %rax
; AVX-NEXT:    movq %rax, (%rsi)
; AVX-NEXT:    movzbl 8(%rdi), %eax
; AVX-NEXT:    movb %al, 8(%rsi)
; AVX-NEXT:    movl 9(%rdi), %eax
; AVX-NEXT:    movl %eax, 9(%rsi)
; AVX-NEXT:    movzwl 13(%rdi), %eax
; AVX-NEXT:    movw %ax, 13(%rsi)
; AVX-NEXT:    movzbl 15(%rdi), %eax
; AVX-NEXT:    movb %al, 15(%rsi)
; AVX-NEXT:    retq
entry:
  %cmp = icmp sgt i32 %x, 17
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %conv = sext i32 %x to i64
  store i64 %conv, ptr %s1, align 8
  %conv1 = trunc i32 %x to i8
  %b = getelementptr inbounds %struct.S3, ptr %s1, i64 0, i32 1
  store i8 %conv1, ptr %b, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s2, ptr %s1, i64 16, i32 8, i1 false)
  ret void
}
%struct.S4 = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 }

; Function Attrs: nounwind uwtable
define void @test_multiple_blocks(ptr nocapture noalias %s1, ptr nocapture %s2) local_unnamed_addr #0 {
; CHECK-LABEL: test_multiple_blocks:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl $0, 4(%rdi)
; CHECK-NEXT:    movl $0, 36(%rdi)
; CHECK-NEXT:    movups 16(%rdi), %xmm0
; CHECK-NEXT:    movups %xmm0, 16(%rsi)
; CHECK-NEXT:    movl 32(%rdi), %eax
; CHECK-NEXT:    movl %eax, 32(%rsi)
; CHECK-NEXT:    movl 36(%rdi), %eax
; CHECK-NEXT:    movl %eax, 36(%rsi)
; CHECK-NEXT:    movq 40(%rdi), %rax
; CHECK-NEXT:    movq %rax, 40(%rsi)
; CHECK-NEXT:    movl (%rdi), %eax
; CHECK-NEXT:    movl %eax, (%rsi)
; CHECK-NEXT:    movl 4(%rdi), %eax
; CHECK-NEXT:    movl %eax, 4(%rsi)
; CHECK-NEXT:    movq 8(%rdi), %rax
; CHECK-NEXT:    movq %rax, 8(%rsi)
; CHECK-NEXT:    retq
;
; DISABLED-LABEL: test_multiple_blocks:
; DISABLED:       # %bb.0: # %entry
; DISABLED-NEXT:    movl $0, 4(%rdi)
; DISABLED-NEXT:    movl $0, 36(%rdi)
; DISABLED-NEXT:    movups 16(%rdi), %xmm0
; DISABLED-NEXT:    movups %xmm0, 16(%rsi)
; DISABLED-NEXT:    movups 32(%rdi), %xmm0
; DISABLED-NEXT:    movups %xmm0, 32(%rsi)
; DISABLED-NEXT:    movups (%rdi), %xmm0
; DISABLED-NEXT:    movups %xmm0, (%rsi)
; DISABLED-NEXT:    retq
;
; AVX-LABEL: test_multiple_blocks:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    movl $0, 4(%rdi)
; AVX-NEXT:    movl $0, 36(%rdi)
; AVX-NEXT:    vmovups 16(%rdi), %xmm0
; AVX-NEXT:    vmovups %xmm0, 16(%rsi)
; AVX-NEXT:    movl 32(%rdi), %eax
; AVX-NEXT:    movl %eax, 32(%rsi)
; AVX-NEXT:    movl 36(%rdi), %eax
; AVX-NEXT:    movl %eax, 36(%rsi)
; AVX-NEXT:    movq 40(%rdi), %rax
; AVX-NEXT:    movq %rax, 40(%rsi)
; AVX-NEXT:    movl (%rdi), %eax
; AVX-NEXT:    movl %eax, (%rsi)
; AVX-NEXT:    movl 4(%rdi), %eax
; AVX-NEXT:    movl %eax, 4(%rsi)
; AVX-NEXT:    vmovups 8(%rdi), %xmm0
; AVX-NEXT:    vmovups %xmm0, 8(%rsi)
; AVX-NEXT:    movq 24(%rdi), %rax
; AVX-NEXT:    movq %rax, 24(%rsi)
; AVX-NEXT:    retq
entry:
  %b = getelementptr inbounds %struct.S4, ptr %s1, i64 0, i32 1
  store i32 0, ptr %b, align 4
  %b3 = getelementptr inbounds %struct.S4, ptr %s1, i64 0, i32 9
  store i32 0, ptr %b3, align 4
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s2, ptr %s1, i64 48, i32 4, i1 false)
  ret void
}
%struct.S5 = type { i16, i16, i16, i16, i16, i16, i16, i16 }

; Function Attrs: nounwind uwtable
define void @test_type16(ptr nocapture noalias %s1, ptr nocapture %s2, i32 %x, ptr nocapture %s3, ptr nocapture readonly %s4) local_unnamed_addr #0 {
; CHECK-LABEL: test_type16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpl $18, %edx
; CHECK-NEXT:    jl .LBB7_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    movw %dx, 2(%rdi)
; CHECK-NEXT:  .LBB7_2: # %if.end
; CHECK-NEXT:    movups (%r8), %xmm0
; CHECK-NEXT:    movups %xmm0, (%rcx)
; CHECK-NEXT:    movzwl (%rdi), %eax
; CHECK-NEXT:    movw %ax, (%rsi)
; CHECK-NEXT:    movzwl 2(%rdi), %eax
; CHECK-NEXT:    movw %ax, 2(%rsi)
; CHECK-NEXT:    movq 4(%rdi), %rax
; CHECK-NEXT:    movq %rax, 4(%rsi)
; CHECK-NEXT:    movl 12(%rdi), %eax
; CHECK-NEXT:    movl %eax, 12(%rsi)
; CHECK-NEXT:    retq
;
; DISABLED-LABEL: test_type16:
; DISABLED:       # %bb.0: # %entry
; DISABLED-NEXT:    cmpl $18, %edx
; DISABLED-NEXT:    jl .LBB7_2
; DISABLED-NEXT:  # %bb.1: # %if.then
; DISABLED-NEXT:    movw %dx, 2(%rdi)
; DISABLED-NEXT:  .LBB7_2: # %if.end
; DISABLED-NEXT:    movups (%r8), %xmm0
; DISABLED-NEXT:    movups %xmm0, (%rcx)
; DISABLED-NEXT:    movups (%rdi), %xmm0
; DISABLED-NEXT:    movups %xmm0, (%rsi)
; DISABLED-NEXT:    retq
;
; AVX-LABEL: test_type16:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    cmpl $18, %edx
; AVX-NEXT:    jl .LBB7_2
; AVX-NEXT:  # %bb.1: # %if.then
; AVX-NEXT:    movw %dx, 2(%rdi)
; AVX-NEXT:  .LBB7_2: # %if.end
; AVX-NEXT:    vmovups (%r8), %xmm0
; AVX-NEXT:    vmovups %xmm0, (%rcx)
; AVX-NEXT:    movzwl (%rdi), %eax
; AVX-NEXT:    movw %ax, (%rsi)
; AVX-NEXT:    movzwl 2(%rdi), %eax
; AVX-NEXT:    movw %ax, 2(%rsi)
; AVX-NEXT:    movq 4(%rdi), %rax
; AVX-NEXT:    movq %rax, 4(%rsi)
; AVX-NEXT:    movl 12(%rdi), %eax
; AVX-NEXT:    movl %eax, 12(%rsi)
; AVX-NEXT:    retq
entry:
  %cmp = icmp sgt i32 %x, 17
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %conv = trunc i32 %x to i16
  %b = getelementptr inbounds %struct.S5, ptr %s1, i64 0, i32 1
  store i16 %conv, ptr %b, align 2
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s3, ptr %s4, i64 16, i32 2, i1 false)
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s2, ptr %s1, i64 16, i32 2, i1 false)
  ret void
}

%struct.S6 = type { [4 x i32], i32, i32, i32, i32 }

; Function Attrs: nounwind uwtable
define void @test_stack(ptr noalias nocapture sret(%struct.S6) %agg.result, ptr byval(%struct.S6) nocapture readnone align 8 %s1, ptr byval(%struct.S6) nocapture align 8 %s2, i32 %x) local_unnamed_addr #0 {
; CHECK-LABEL: test_stack:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    movl %esi, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movaps {{[0-9]+}}(%rsp), %xmm0
; CHECK-NEXT:    movups %xmm0, (%rdi)
; CHECK-NEXT:    movq {{[0-9]+}}(%rsp), %rcx
; CHECK-NEXT:    movq %rcx, 16(%rdi)
; CHECK-NEXT:    movl {{[0-9]+}}(%rsp), %ecx
; CHECK-NEXT:    movl %ecx, 24(%rdi)
; CHECK-NEXT:    movl {{[0-9]+}}(%rsp), %ecx
; CHECK-NEXT:    movl %ecx, 28(%rdi)
; CHECK-NEXT:    movaps {{[0-9]+}}(%rsp), %xmm0
; CHECK-NEXT:    movq {{[0-9]+}}(%rsp), %rcx
; CHECK-NEXT:    movl {{[0-9]+}}(%rsp), %edx
; CHECK-NEXT:    movl {{[0-9]+}}(%rsp), %esi
; CHECK-NEXT:    movaps %xmm0, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq %rcx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movl %edx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movl %esi, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    retq
;
; DISABLED-LABEL: test_stack:
; DISABLED:       # %bb.0: # %entry
; DISABLED-NEXT:    movq %rdi, %rax
; DISABLED-NEXT:    movl %esi, {{[0-9]+}}(%rsp)
; DISABLED-NEXT:    movaps {{[0-9]+}}(%rsp), %xmm0
; DISABLED-NEXT:    movups %xmm0, (%rdi)
; DISABLED-NEXT:    movaps {{[0-9]+}}(%rsp), %xmm0
; DISABLED-NEXT:    movups %xmm0, 16(%rdi)
; DISABLED-NEXT:    movaps {{[0-9]+}}(%rsp), %xmm0
; DISABLED-NEXT:    movaps {{[0-9]+}}(%rsp), %xmm1
; DISABLED-NEXT:    movaps %xmm0, {{[0-9]+}}(%rsp)
; DISABLED-NEXT:    movaps %xmm1, {{[0-9]+}}(%rsp)
; DISABLED-NEXT:    retq
;
; AVX-LABEL: test_stack:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    movq %rdi, %rax
; AVX-NEXT:    movl %esi, {{[0-9]+}}(%rsp)
; AVX-NEXT:    vmovups {{[0-9]+}}(%rsp), %xmm0
; AVX-NEXT:    vmovups %xmm0, (%rdi)
; AVX-NEXT:    movq {{[0-9]+}}(%rsp), %rcx
; AVX-NEXT:    movq %rcx, 16(%rdi)
; AVX-NEXT:    movl {{[0-9]+}}(%rsp), %ecx
; AVX-NEXT:    movl %ecx, 24(%rdi)
; AVX-NEXT:    movl {{[0-9]+}}(%rsp), %ecx
; AVX-NEXT:    movl %ecx, 28(%rdi)
; AVX-NEXT:    vmovups {{[0-9]+}}(%rsp), %xmm0
; AVX-NEXT:    vmovups %xmm0, {{[0-9]+}}(%rsp)
; AVX-NEXT:    movq {{[0-9]+}}(%rsp), %rcx
; AVX-NEXT:    movq %rcx, {{[0-9]+}}(%rsp)
; AVX-NEXT:    movl {{[0-9]+}}(%rsp), %ecx
; AVX-NEXT:    movl %ecx, {{[0-9]+}}(%rsp)
; AVX-NEXT:    movl {{[0-9]+}}(%rsp), %ecx
; AVX-NEXT:    movl %ecx, {{[0-9]+}}(%rsp)
; AVX-NEXT:    retq
entry:
  %s6.sroa.3.0..sroa_idx4 = getelementptr inbounds %struct.S6, ptr %s2, i64 0, i32 3
  store i32 %x, ptr %s6.sroa.3.0..sroa_idx4, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr %agg.result, ptr nonnull %s2, i64 32, i32 4, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr nonnull %s1, ptr nonnull %s2, i64 32, i32 4, i1 false)

  ret void
}

; Function Attrs: nounwind uwtable
define void @test_limit_all(ptr noalias  %s1, ptr nocapture %s2, i32 %x, ptr nocapture %s3, ptr nocapture readonly %s4, i32 %x2) local_unnamed_addr #0 {
; SSE-LABEL: test_limit_all:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    pushq %rbp
; SSE-NEXT:    .cfi_def_cfa_offset 16
; SSE-NEXT:    pushq %r15
; SSE-NEXT:    .cfi_def_cfa_offset 24
; SSE-NEXT:    pushq %r14
; SSE-NEXT:    .cfi_def_cfa_offset 32
; SSE-NEXT:    pushq %r12
; SSE-NEXT:    .cfi_def_cfa_offset 40
; SSE-NEXT:    pushq %rbx
; SSE-NEXT:    .cfi_def_cfa_offset 48
; SSE-NEXT:    .cfi_offset %rbx, -48
; SSE-NEXT:    .cfi_offset %r12, -40
; SSE-NEXT:    .cfi_offset %r14, -32
; SSE-NEXT:    .cfi_offset %r15, -24
; SSE-NEXT:    .cfi_offset %rbp, -16
; SSE-NEXT:    movq %r8, %r15
; SSE-NEXT:    movq %rcx, %r14
; SSE-NEXT:    movl %edx, %ebp
; SSE-NEXT:    movq %rsi, %rbx
; SSE-NEXT:    movq %rdi, %r12
; SSE-NEXT:    movl %r9d, 12(%rdi)
; SSE-NEXT:    callq bar@PLT
; SSE-NEXT:    cmpl $18, %ebp
; SSE-NEXT:    jl .LBB9_2
; SSE-NEXT:  # %bb.1: # %if.then
; SSE-NEXT:    movl %ebp, 4(%r12)
; SSE-NEXT:    movq %r12, %rdi
; SSE-NEXT:    callq bar@PLT
; SSE-NEXT:  .LBB9_2: # %if.end
; SSE-NEXT:    movups (%r15), %xmm0
; SSE-NEXT:    movups %xmm0, (%r14)
; SSE-NEXT:    movups (%r12), %xmm0
; SSE-NEXT:    movups %xmm0, (%rbx)
; SSE-NEXT:    popq %rbx
; SSE-NEXT:    .cfi_def_cfa_offset 40
; SSE-NEXT:    popq %r12
; SSE-NEXT:    .cfi_def_cfa_offset 32
; SSE-NEXT:    popq %r14
; SSE-NEXT:    .cfi_def_cfa_offset 24
; SSE-NEXT:    popq %r15
; SSE-NEXT:    .cfi_def_cfa_offset 16
; SSE-NEXT:    popq %rbp
; SSE-NEXT:    .cfi_def_cfa_offset 8
; SSE-NEXT:    retq
;
; AVX-LABEL: test_limit_all:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    pushq %rbp
; AVX-NEXT:    .cfi_def_cfa_offset 16
; AVX-NEXT:    pushq %r15
; AVX-NEXT:    .cfi_def_cfa_offset 24
; AVX-NEXT:    pushq %r14
; AVX-NEXT:    .cfi_def_cfa_offset 32
; AVX-NEXT:    pushq %r12
; AVX-NEXT:    .cfi_def_cfa_offset 40
; AVX-NEXT:    pushq %rbx
; AVX-NEXT:    .cfi_def_cfa_offset 48
; AVX-NEXT:    .cfi_offset %rbx, -48
; AVX-NEXT:    .cfi_offset %r12, -40
; AVX-NEXT:    .cfi_offset %r14, -32
; AVX-NEXT:    .cfi_offset %r15, -24
; AVX-NEXT:    .cfi_offset %rbp, -16
; AVX-NEXT:    movq %r8, %r15
; AVX-NEXT:    movq %rcx, %r14
; AVX-NEXT:    movl %edx, %ebp
; AVX-NEXT:    movq %rsi, %rbx
; AVX-NEXT:    movq %rdi, %r12
; AVX-NEXT:    movl %r9d, 12(%rdi)
; AVX-NEXT:    callq bar@PLT
; AVX-NEXT:    cmpl $18, %ebp
; AVX-NEXT:    jl .LBB9_2
; AVX-NEXT:  # %bb.1: # %if.then
; AVX-NEXT:    movl %ebp, 4(%r12)
; AVX-NEXT:    movq %r12, %rdi
; AVX-NEXT:    callq bar@PLT
; AVX-NEXT:  .LBB9_2: # %if.end
; AVX-NEXT:    vmovups (%r15), %xmm0
; AVX-NEXT:    vmovups %xmm0, (%r14)
; AVX-NEXT:    vmovups (%r12), %xmm0
; AVX-NEXT:    vmovups %xmm0, (%rbx)
; AVX-NEXT:    popq %rbx
; AVX-NEXT:    .cfi_def_cfa_offset 40
; AVX-NEXT:    popq %r12
; AVX-NEXT:    .cfi_def_cfa_offset 32
; AVX-NEXT:    popq %r14
; AVX-NEXT:    .cfi_def_cfa_offset 24
; AVX-NEXT:    popq %r15
; AVX-NEXT:    .cfi_def_cfa_offset 16
; AVX-NEXT:    popq %rbp
; AVX-NEXT:    .cfi_def_cfa_offset 8
; AVX-NEXT:    retq
entry:
  %d = getelementptr inbounds %struct.S, ptr %s1, i64 0, i32 3
  store i32 %x2, ptr %d, align 4
  tail call void @bar(ptr %s1) #3
  %cmp = icmp sgt i32 %x, 17
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %b = getelementptr inbounds %struct.S, ptr %s1, i64 0, i32 1
  store i32 %x, ptr %b, align 4
  tail call void @bar(ptr nonnull %s1) #3
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s3, ptr %s4, i64 16, i32 4, i1 false)
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s2, ptr %s1, i64 16, i32 4, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @test_limit_one_pred(ptr noalias %s1, ptr nocapture %s2, i32 %x, ptr nocapture %s3, ptr nocapture readonly %s4, i32 %x2) local_unnamed_addr #0 {
; CHECK-LABEL: test_limit_one_pred:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %r15
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    pushq %r14
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    pushq %r12
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 40
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    .cfi_offset %rbx, -40
; CHECK-NEXT:    .cfi_offset %r12, -32
; CHECK-NEXT:    .cfi_offset %r14, -24
; CHECK-NEXT:    .cfi_offset %r15, -16
; CHECK-NEXT:    movq %r8, %r12
; CHECK-NEXT:    movq %rcx, %r15
; CHECK-NEXT:    movq %rsi, %rbx
; CHECK-NEXT:    movq %rdi, %r14
; CHECK-NEXT:    movl %r9d, 12(%rdi)
; CHECK-NEXT:    cmpl $18, %edx
; CHECK-NEXT:    jl .LBB10_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    movl %edx, 4(%r14)
; CHECK-NEXT:    movq %r14, %rdi
; CHECK-NEXT:    callq bar@PLT
; CHECK-NEXT:  .LBB10_2: # %if.end
; CHECK-NEXT:    movups (%r12), %xmm0
; CHECK-NEXT:    movups %xmm0, (%r15)
; CHECK-NEXT:    movq (%r14), %rax
; CHECK-NEXT:    movq %rax, (%rbx)
; CHECK-NEXT:    movl 8(%r14), %eax
; CHECK-NEXT:    movl %eax, 8(%rbx)
; CHECK-NEXT:    movl 12(%r14), %eax
; CHECK-NEXT:    movl %eax, 12(%rbx)
; CHECK-NEXT:    addq $8, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 40
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    popq %r12
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    popq %r14
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    popq %r15
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
;
; DISABLED-LABEL: test_limit_one_pred:
; DISABLED:       # %bb.0: # %entry
; DISABLED-NEXT:    pushq %r15
; DISABLED-NEXT:    .cfi_def_cfa_offset 16
; DISABLED-NEXT:    pushq %r14
; DISABLED-NEXT:    .cfi_def_cfa_offset 24
; DISABLED-NEXT:    pushq %r12
; DISABLED-NEXT:    .cfi_def_cfa_offset 32
; DISABLED-NEXT:    pushq %rbx
; DISABLED-NEXT:    .cfi_def_cfa_offset 40
; DISABLED-NEXT:    pushq %rax
; DISABLED-NEXT:    .cfi_def_cfa_offset 48
; DISABLED-NEXT:    .cfi_offset %rbx, -40
; DISABLED-NEXT:    .cfi_offset %r12, -32
; DISABLED-NEXT:    .cfi_offset %r14, -24
; DISABLED-NEXT:    .cfi_offset %r15, -16
; DISABLED-NEXT:    movq %r8, %r15
; DISABLED-NEXT:    movq %rcx, %r14
; DISABLED-NEXT:    movq %rsi, %rbx
; DISABLED-NEXT:    movq %rdi, %r12
; DISABLED-NEXT:    movl %r9d, 12(%rdi)
; DISABLED-NEXT:    cmpl $18, %edx
; DISABLED-NEXT:    jl .LBB10_2
; DISABLED-NEXT:  # %bb.1: # %if.then
; DISABLED-NEXT:    movl %edx, 4(%r12)
; DISABLED-NEXT:    movq %r12, %rdi
; DISABLED-NEXT:    callq bar@PLT
; DISABLED-NEXT:  .LBB10_2: # %if.end
; DISABLED-NEXT:    movups (%r15), %xmm0
; DISABLED-NEXT:    movups %xmm0, (%r14)
; DISABLED-NEXT:    movups (%r12), %xmm0
; DISABLED-NEXT:    movups %xmm0, (%rbx)
; DISABLED-NEXT:    addq $8, %rsp
; DISABLED-NEXT:    .cfi_def_cfa_offset 40
; DISABLED-NEXT:    popq %rbx
; DISABLED-NEXT:    .cfi_def_cfa_offset 32
; DISABLED-NEXT:    popq %r12
; DISABLED-NEXT:    .cfi_def_cfa_offset 24
; DISABLED-NEXT:    popq %r14
; DISABLED-NEXT:    .cfi_def_cfa_offset 16
; DISABLED-NEXT:    popq %r15
; DISABLED-NEXT:    .cfi_def_cfa_offset 8
; DISABLED-NEXT:    retq
;
; AVX-LABEL: test_limit_one_pred:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    pushq %r15
; AVX-NEXT:    .cfi_def_cfa_offset 16
; AVX-NEXT:    pushq %r14
; AVX-NEXT:    .cfi_def_cfa_offset 24
; AVX-NEXT:    pushq %r12
; AVX-NEXT:    .cfi_def_cfa_offset 32
; AVX-NEXT:    pushq %rbx
; AVX-NEXT:    .cfi_def_cfa_offset 40
; AVX-NEXT:    pushq %rax
; AVX-NEXT:    .cfi_def_cfa_offset 48
; AVX-NEXT:    .cfi_offset %rbx, -40
; AVX-NEXT:    .cfi_offset %r12, -32
; AVX-NEXT:    .cfi_offset %r14, -24
; AVX-NEXT:    .cfi_offset %r15, -16
; AVX-NEXT:    movq %r8, %r12
; AVX-NEXT:    movq %rcx, %r15
; AVX-NEXT:    movq %rsi, %rbx
; AVX-NEXT:    movq %rdi, %r14
; AVX-NEXT:    movl %r9d, 12(%rdi)
; AVX-NEXT:    cmpl $18, %edx
; AVX-NEXT:    jl .LBB10_2
; AVX-NEXT:  # %bb.1: # %if.then
; AVX-NEXT:    movl %edx, 4(%r14)
; AVX-NEXT:    movq %r14, %rdi
; AVX-NEXT:    callq bar@PLT
; AVX-NEXT:  .LBB10_2: # %if.end
; AVX-NEXT:    vmovups (%r12), %xmm0
; AVX-NEXT:    vmovups %xmm0, (%r15)
; AVX-NEXT:    movq (%r14), %rax
; AVX-NEXT:    movq %rax, (%rbx)
; AVX-NEXT:    movl 8(%r14), %eax
; AVX-NEXT:    movl %eax, 8(%rbx)
; AVX-NEXT:    movl 12(%r14), %eax
; AVX-NEXT:    movl %eax, 12(%rbx)
; AVX-NEXT:    addq $8, %rsp
; AVX-NEXT:    .cfi_def_cfa_offset 40
; AVX-NEXT:    popq %rbx
; AVX-NEXT:    .cfi_def_cfa_offset 32
; AVX-NEXT:    popq %r12
; AVX-NEXT:    .cfi_def_cfa_offset 24
; AVX-NEXT:    popq %r14
; AVX-NEXT:    .cfi_def_cfa_offset 16
; AVX-NEXT:    popq %r15
; AVX-NEXT:    .cfi_def_cfa_offset 8
; AVX-NEXT:    retq
entry:
  %d = getelementptr inbounds %struct.S, ptr %s1, i64 0, i32 3
  store i32 %x2, ptr %d, align 4
  %cmp = icmp sgt i32 %x, 17
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %b = getelementptr inbounds %struct.S, ptr %s1, i64 0, i32 1
  store i32 %x, ptr %b, align 4
  tail call void @bar(ptr nonnull %s1) #3
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s3, ptr %s4, i64 16, i32 4, i1 false)
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s2, ptr %s1, i64 16, i32 4, i1 false)
  ret void
}


declare void @bar(ptr) local_unnamed_addr #1


%struct.S7 = type { float, float, float , float, float, float, float, float }

; Function Attrs: nounwind uwtable
define void @test_conditional_block_float(ptr nocapture noalias %s1, ptr nocapture %s2, i32 %x, ptr nocapture %s3, ptr nocapture readonly %s4, float %y) local_unnamed_addr #0 {
; CHECK-LABEL: test_conditional_block_float:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpl $18, %edx
; CHECK-NEXT:    jl .LBB11_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    movl $1065353216, 4(%rdi) # imm = 0x3F800000
; CHECK-NEXT:  .LBB11_2: # %if.end
; CHECK-NEXT:    movups (%r8), %xmm0
; CHECK-NEXT:    movups 16(%r8), %xmm1
; CHECK-NEXT:    movups %xmm1, 16(%rcx)
; CHECK-NEXT:    movups %xmm0, (%rcx)
; CHECK-NEXT:    movl (%rdi), %eax
; CHECK-NEXT:    movl 4(%rdi), %ecx
; CHECK-NEXT:    movq 8(%rdi), %rdx
; CHECK-NEXT:    movups 16(%rdi), %xmm0
; CHECK-NEXT:    movups %xmm0, 16(%rsi)
; CHECK-NEXT:    movl %eax, (%rsi)
; CHECK-NEXT:    movl %ecx, 4(%rsi)
; CHECK-NEXT:    movq %rdx, 8(%rsi)
; CHECK-NEXT:    retq
;
; DISABLED-LABEL: test_conditional_block_float:
; DISABLED:       # %bb.0: # %entry
; DISABLED-NEXT:    cmpl $18, %edx
; DISABLED-NEXT:    jl .LBB11_2
; DISABLED-NEXT:  # %bb.1: # %if.then
; DISABLED-NEXT:    movl $1065353216, 4(%rdi) # imm = 0x3F800000
; DISABLED-NEXT:  .LBB11_2: # %if.end
; DISABLED-NEXT:    movups (%r8), %xmm0
; DISABLED-NEXT:    movups 16(%r8), %xmm1
; DISABLED-NEXT:    movups %xmm1, 16(%rcx)
; DISABLED-NEXT:    movups %xmm0, (%rcx)
; DISABLED-NEXT:    movups (%rdi), %xmm0
; DISABLED-NEXT:    movups 16(%rdi), %xmm1
; DISABLED-NEXT:    movups %xmm1, 16(%rsi)
; DISABLED-NEXT:    movups %xmm0, (%rsi)
; DISABLED-NEXT:    retq
;
; AVX-LABEL: test_conditional_block_float:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    cmpl $18, %edx
; AVX-NEXT:    jl .LBB11_2
; AVX-NEXT:  # %bb.1: # %if.then
; AVX-NEXT:    movl $1065353216, 4(%rdi) # imm = 0x3F800000
; AVX-NEXT:  .LBB11_2: # %if.end
; AVX-NEXT:    vmovups (%r8), %ymm0
; AVX-NEXT:    vmovups %ymm0, (%rcx)
; AVX-NEXT:    movl (%rdi), %eax
; AVX-NEXT:    movl %eax, (%rsi)
; AVX-NEXT:    movl 4(%rdi), %eax
; AVX-NEXT:    movl %eax, 4(%rsi)
; AVX-NEXT:    vmovups 8(%rdi), %xmm0
; AVX-NEXT:    vmovups %xmm0, 8(%rsi)
; AVX-NEXT:    movq 24(%rdi), %rax
; AVX-NEXT:    movq %rax, 24(%rsi)
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
entry:
  %cmp = icmp sgt i32 %x, 17
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %b = getelementptr inbounds %struct.S7, ptr %s1, i64 0, i32 1
  store float 1.0, ptr %b, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s3, ptr %s4, i64 32, i32 4, i1 false)
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s2, ptr %s1, i64 32, i32 4, i1 false)
  ret void
}

%struct.S8 = type { i64, i64, i64, i64, i64, i64 }

; Function Attrs: nounwind uwtable
define void @test_conditional_block_ymm(ptr nocapture noalias %s1, ptr nocapture %s2, i32 %x, ptr nocapture %s3, ptr nocapture readonly %s4) local_unnamed_addr #0 {
; CHECK-LABEL: test_conditional_block_ymm:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpl $18, %edx
; CHECK-NEXT:    jl .LBB12_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    movq $1, 8(%rdi)
; CHECK-NEXT:  .LBB12_2: # %if.end
; CHECK-NEXT:    movups (%r8), %xmm0
; CHECK-NEXT:    movups 16(%r8), %xmm1
; CHECK-NEXT:    movups %xmm1, 16(%rcx)
; CHECK-NEXT:    movups %xmm0, (%rcx)
; CHECK-NEXT:    movq (%rdi), %rax
; CHECK-NEXT:    movq 8(%rdi), %rcx
; CHECK-NEXT:    movups 16(%rdi), %xmm0
; CHECK-NEXT:    movups %xmm0, 16(%rsi)
; CHECK-NEXT:    movq %rax, (%rsi)
; CHECK-NEXT:    movq %rcx, 8(%rsi)
; CHECK-NEXT:    retq
;
; DISABLED-LABEL: test_conditional_block_ymm:
; DISABLED:       # %bb.0: # %entry
; DISABLED-NEXT:    cmpl $18, %edx
; DISABLED-NEXT:    jl .LBB12_2
; DISABLED-NEXT:  # %bb.1: # %if.then
; DISABLED-NEXT:    movq $1, 8(%rdi)
; DISABLED-NEXT:  .LBB12_2: # %if.end
; DISABLED-NEXT:    movups (%r8), %xmm0
; DISABLED-NEXT:    movups 16(%r8), %xmm1
; DISABLED-NEXT:    movups %xmm1, 16(%rcx)
; DISABLED-NEXT:    movups %xmm0, (%rcx)
; DISABLED-NEXT:    movups (%rdi), %xmm0
; DISABLED-NEXT:    movups 16(%rdi), %xmm1
; DISABLED-NEXT:    movups %xmm1, 16(%rsi)
; DISABLED-NEXT:    movups %xmm0, (%rsi)
; DISABLED-NEXT:    retq
;
; AVX-LABEL: test_conditional_block_ymm:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    cmpl $18, %edx
; AVX-NEXT:    jl .LBB12_2
; AVX-NEXT:  # %bb.1: # %if.then
; AVX-NEXT:    movq $1, 8(%rdi)
; AVX-NEXT:  .LBB12_2: # %if.end
; AVX-NEXT:    vmovups (%r8), %ymm0
; AVX-NEXT:    vmovups %ymm0, (%rcx)
; AVX-NEXT:    movq (%rdi), %rax
; AVX-NEXT:    movq %rax, (%rsi)
; AVX-NEXT:    movq 8(%rdi), %rax
; AVX-NEXT:    movq %rax, 8(%rsi)
; AVX-NEXT:    vmovups 16(%rdi), %xmm0
; AVX-NEXT:    vmovups %xmm0, 16(%rsi)
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
entry:
  %cmp = icmp sgt i32 %x, 17
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %b = getelementptr inbounds %struct.S8, ptr %s1, i64 0, i32 1
  store i64 1, ptr %b, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s3, ptr %s4, i64 32, i32 4, i1 false)
  tail call void @llvm.memcpy.p0.p0.i64(ptr %s2, ptr %s1, i64 32, i32 4, i1 false)
  ret void
}

define dso_local void @test_alias(ptr nocapture %A, i32 %x) local_unnamed_addr #0 {
; SSE-LABEL: test_alias:
; SSE:       # %bb.0: # %entry
; SSE-NEXT:    movl %esi, (%rdi)
; SSE-NEXT:    movups (%rdi), %xmm0
; SSE-NEXT:    movups %xmm0, 4(%rdi)
; SSE-NEXT:    retq
;
; AVX-LABEL: test_alias:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    movl %esi, (%rdi)
; AVX-NEXT:    vmovups (%rdi), %xmm0
; AVX-NEXT:    vmovups %xmm0, 4(%rdi)
; AVX-NEXT:    retq
entry:
  store i32 %x, ptr %A, align 4
  %add.ptr = getelementptr inbounds i8, ptr %A, i64 4
  tail call void @llvm.memcpy.p0.p0.i64(ptr nonnull align 4 %add.ptr, ptr align 4 %A, i64 16, i32 4, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local void @test_noalias(ptr nocapture %A, i32 %x) local_unnamed_addr #0 {
; CHECK-LABEL: test_noalias:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl %esi, (%rdi)
; CHECK-NEXT:    movl (%rdi), %eax
; CHECK-NEXT:    movl %eax, 20(%rdi)
; CHECK-NEXT:    movq 4(%rdi), %rax
; CHECK-NEXT:    movq %rax, 24(%rdi)
; CHECK-NEXT:    movl 12(%rdi), %eax
; CHECK-NEXT:    movl %eax, 32(%rdi)
; CHECK-NEXT:    retq
;
; DISABLED-LABEL: test_noalias:
; DISABLED:       # %bb.0: # %entry
; DISABLED-NEXT:    movl %esi, (%rdi)
; DISABLED-NEXT:    movups (%rdi), %xmm0
; DISABLED-NEXT:    movups %xmm0, 20(%rdi)
; DISABLED-NEXT:    retq
;
; AVX-LABEL: test_noalias:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    movl %esi, (%rdi)
; AVX-NEXT:    movl (%rdi), %eax
; AVX-NEXT:    movl %eax, 20(%rdi)
; AVX-NEXT:    movq 4(%rdi), %rax
; AVX-NEXT:    movq %rax, 24(%rdi)
; AVX-NEXT:    movl 12(%rdi), %eax
; AVX-NEXT:    movl %eax, 32(%rdi)
; AVX-NEXT:    retq
entry:
  store i32 %x, ptr %A, align 4
  %add.ptr = getelementptr inbounds i8, ptr %A, i64 20
  tail call void @llvm.memcpy.p0.p0.i64(ptr nonnull align 4 %add.ptr, ptr align 4 %A, i64 16, i32 4, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0.p0.i64(ptr nocapture writeonly, ptr nocapture readonly, i64, i32, i1) #1

attributes #0 = { nounwind uwtable }
