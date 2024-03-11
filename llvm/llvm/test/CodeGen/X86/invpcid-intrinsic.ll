; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i386-unknown-unknown -mattr=+invpcid | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+invpcid --show-mc-encoding | FileCheck %s --check-prefix=X86_64
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+invpcid,+egpr --show-mc-encoding | FileCheck %s --check-prefix=EGPR

define void @test_invpcid(i32 %type, ptr %descriptor) {
; X86-LABEL: test_invpcid:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    invpcid (%eax), %ecx
; X86-NEXT:    retl
;
; X86_64-LABEL: test_invpcid:
; X86_64:       # %bb.0: # %entry
; X86_64-NEXT:    movl %edi, %eax # encoding: [0x89,0xf8]
; X86_64-NEXT:    invpcid (%rsi), %rax # encoding: [0x66,0x0f,0x38,0x82,0x06]
; X86_64-NEXT:    retq # encoding: [0xc3]
;
; EGPR-LABEL: test_invpcid:
; EGPR:       # %bb.0: # %entry
; EGPR-NEXT:    movl %edi, %eax # encoding: [0x89,0xf8]
; EGPR-NEXT:    invpcid (%rsi), %rax # EVEX TO LEGACY Compression encoding: [0x66,0x0f,0x38,0x82,0x06]
; EGPR-NEXT:    retq # encoding: [0xc3]
entry:
  call void @llvm.x86.invpcid(i32 %type, ptr %descriptor)
  ret void
}

define void @test_invpcid2(ptr readonly %type, ptr %descriptor) {
; X86-LABEL: test_invpcid2:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl (%ecx), %ecx
; X86-NEXT:    invpcid (%eax), %ecx
; X86-NEXT:    retl
;
; X86_64-LABEL: test_invpcid2:
; X86_64:       # %bb.0: # %entry
; X86_64-NEXT:    movl (%rdi), %eax # encoding: [0x8b,0x07]
; X86_64-NEXT:    invpcid (%rsi), %rax # encoding: [0x66,0x0f,0x38,0x82,0x06]
; X86_64-NEXT:    retq # encoding: [0xc3]
;
; EGPR-LABEL: test_invpcid2:
; EGPR:       # %bb.0: # %entry
; EGPR-NEXT:    movl (%rdi), %eax # encoding: [0x8b,0x07]
; EGPR-NEXT:    invpcid (%rsi), %rax # EVEX TO LEGACY Compression encoding: [0x66,0x0f,0x38,0x82,0x06]
; EGPR-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = load i32, ptr %type, align 4
  tail call void @llvm.x86.invpcid(i32 %0, ptr %descriptor) #1
  ret void
}

declare void @llvm.x86.invpcid(i32, ptr)
