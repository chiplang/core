; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+ndd -verify-machineinstrs --show-mc-encoding | FileCheck %s

define i8 @or8rr(i8 noundef %a, i8 noundef %b) {
; CHECK-LABEL: or8rr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orl %esi, %edi, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x09,0xf7]
; CHECK-NEXT:    # kill: def $al killed $al killed $eax
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
    %or = or i8 %a, %b
    ret i8 %or
}

define i16 @or16rr(i16 noundef %a, i16 noundef %b) {
; CHECK-LABEL: or16rr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orl %esi, %edi, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x09,0xf7]
; CHECK-NEXT:    # kill: def $ax killed $ax killed $eax
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
    %or = or i16 %a, %b
    ret i16 %or
}

define i32 @or32rr(i32 noundef %a, i32 noundef %b) {
; CHECK-LABEL: or32rr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orl %esi, %edi, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x09,0xf7]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
    %or = or i32 %a, %b
    ret i32 %or
}

define i64 @or64rr(i64 noundef %a, i64 noundef %b) {
; CHECK-LABEL: or64rr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orq %rsi, %rdi, %rax # encoding: [0x62,0xf4,0xfc,0x18,0x09,0xf7]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
    %or = or i64 %a, %b
    ret i64 %or
}

define i8 @or8rm(i8 noundef %a, ptr %b) {
; CHECK-LABEL: or8rm:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orb (%rsi), %dil, %al # encoding: [0x62,0xf4,0x7c,0x18,0x0a,0x3e]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
    %t = load i8, ptr %b
    %or = or i8 %a, %t
    ret i8 %or
}

define i16 @or16rm(i16 noundef %a, ptr %b) {
; CHECK-LABEL: or16rm:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orw (%rsi), %di, %ax # encoding: [0x62,0xf4,0x7d,0x18,0x0b,0x3e]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
    %t = load i16, ptr %b
    %or = or i16 %a, %t
    ret i16 %or
}

define i32 @or32rm(i32 noundef %a, ptr %b) {
; CHECK-LABEL: or32rm:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orl (%rsi), %edi, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x0b,0x3e]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
    %t = load i32, ptr %b
    %or = or i32 %a, %t
    ret i32 %or
}

define i64 @or64rm(i64 noundef %a, ptr %b) {
; CHECK-LABEL: or64rm:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orq (%rsi), %rdi, %rax # encoding: [0x62,0xf4,0xfc,0x18,0x0b,0x3e]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
    %t = load i64, ptr %b
    %or = or i64 %a, %t
    ret i64 %or
}

define i16 @or16ri8(i16 noundef %a) {
; CHECK-LABEL: or16ri8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orl $123, %edi, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x83,0xcf,0x7b]
; CHECK-NEXT:    # kill: def $ax killed $ax killed $eax
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
    %or = or i16 %a, 123
    ret i16 %or
}

define i32 @or32ri8(i32 noundef %a) {
; CHECK-LABEL: or32ri8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orl $123, %edi, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x83,0xcf,0x7b]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
    %or = or i32 %a, 123
    ret i32 %or
}

define i64 @or64ri8(i64 noundef %a) {
; CHECK-LABEL: or64ri8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orq $123, %rdi, %rax # encoding: [0x62,0xf4,0xfc,0x18,0x83,0xcf,0x7b]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
    %or = or i64 %a, 123
    ret i64 %or
}

define i8 @or8ri(i8 noundef %a) {
; CHECK-LABEL: or8ri:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orb $123, %dil, %al # encoding: [0x62,0xf4,0x7c,0x18,0x80,0xcf,0x7b]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
    %or = or i8 %a, 123
    ret i8 %or
}

define i16 @or16ri(i16 noundef %a) {
; CHECK-LABEL: or16ri:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orl $1234, %edi, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x81,0xcf,0xd2,0x04,0x00,0x00]
; CHECK-NEXT:    # imm = 0x4D2
; CHECK-NEXT:    # kill: def $ax killed $ax killed $eax
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
    %or = or i16 %a, 1234
    ret i16 %or
}

define i32 @or32ri(i32 noundef %a) {
; CHECK-LABEL: or32ri:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orl $123456, %edi, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x81,0xcf,0x40,0xe2,0x01,0x00]
; CHECK-NEXT:    # imm = 0x1E240
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
    %or = or i32 %a, 123456
    ret i32 %or
}

define i64 @or64ri(i64 noundef %a) {
; CHECK-LABEL: or64ri:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orq $123456, %rdi, %rax # encoding: [0x62,0xf4,0xfc,0x18,0x81,0xcf,0x40,0xe2,0x01,0x00]
; CHECK-NEXT:    # imm = 0x1E240
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
    %or = or i64 %a, 123456
    ret i64 %or
}

define i8 @or8mr(ptr %a, i8 noundef %b) {
; CHECK-LABEL: or8mr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orb %sil, (%rdi), %al # encoding: [0x62,0xf4,0x7c,0x18,0x08,0x37]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i8, ptr %a
  %or = or i8 %t, %b
  ret i8 %or
}

define i16 @or16mr(ptr %a, i16 noundef %b) {
; CHECK-LABEL: or16mr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orw %si, (%rdi), %ax # encoding: [0x62,0xf4,0x7d,0x18,0x09,0x37]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i16, ptr %a
  %or = or i16 %t, %b
  ret i16 %or
}

define i32 @or32mr(ptr %a, i32 noundef %b) {
; CHECK-LABEL: or32mr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orl %esi, (%rdi), %eax # encoding: [0x62,0xf4,0x7c,0x18,0x09,0x37]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i32, ptr %a
  %or = or i32 %t, %b
  ret i32 %or
}

define i64 @or64mr(ptr %a, i64 noundef %b) {
; CHECK-LABEL: or64mr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orq %rsi, (%rdi), %rax # encoding: [0x62,0xf4,0xfc,0x18,0x09,0x37]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i64, ptr %a
  %or = or i64 %t, %b
  ret i64 %or
}

define i16 @or16mi8(ptr %a) {
; CHECK-LABEL: or16mi8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movzwl (%rdi), %eax # encoding: [0x0f,0xb7,0x07]
; CHECK-NEXT:    orl $123, %eax # EVEX TO LEGACY Compression encoding: [0x83,0xc8,0x7b]
; CHECK-NEXT:    # kill: def $ax killed $ax killed $eax
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i16, ptr %a
  %or = or i16 %t, 123
  ret i16 %or
}

define i32 @or32mi8(ptr %a) {
; CHECK-LABEL: or32mi8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orl $123, (%rdi), %eax # encoding: [0x62,0xf4,0x7c,0x18,0x83,0x0f,0x7b]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i32, ptr %a
  %or = or i32 %t, 123
  ret i32 %or
}

define i64 @or64mi8(ptr %a) {
; CHECK-LABEL: or64mi8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orq $123, (%rdi), %rax # encoding: [0x62,0xf4,0xfc,0x18,0x83,0x0f,0x7b]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i64, ptr %a
  %or = or i64 %t, 123
  ret i64 %or
}

define i8 @or8mi(ptr %a) {
; CHECK-LABEL: or8mi:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orb $123, (%rdi), %al # encoding: [0x62,0xf4,0x7c,0x18,0x80,0x0f,0x7b]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i8, ptr %a
  %or = or i8 %t, 123
  ret i8 %or
}

define i16 @or16mi(ptr %a) {
; CHECK-LABEL: or16mi:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movzwl (%rdi), %eax # encoding: [0x0f,0xb7,0x07]
; CHECK-NEXT:    orl $1234, %eax # EVEX TO LEGACY Compression encoding: [0x0d,0xd2,0x04,0x00,0x00]
; CHECK-NEXT:    # imm = 0x4D2
; CHECK-NEXT:    # kill: def $ax killed $ax killed $eax
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i16, ptr %a
  %or = or i16 %t, 1234
  ret i16 %or
}

define i32 @or32mi(ptr %a) {
; CHECK-LABEL: or32mi:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orl $123456, (%rdi), %eax # encoding: [0x62,0xf4,0x7c,0x18,0x81,0x0f,0x40,0xe2,0x01,0x00]
; CHECK-NEXT:    # imm = 0x1E240
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i32, ptr %a
  %or = or i32 %t, 123456
  ret i32 %or
}

define i64 @or64mi(ptr %a) {
; CHECK-LABEL: or64mi:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orq $123456, (%rdi), %rax # encoding: [0x62,0xf4,0xfc,0x18,0x81,0x0f,0x40,0xe2,0x01,0x00]
; CHECK-NEXT:    # imm = 0x1E240
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i64, ptr %a
  %or = or i64 %t, 123456
  ret i64 %or
}

@d64 = dso_local global i64 0

define i1 @orflag8rr(i8 %a, i8 %b) {
; CHECK-LABEL: orflag8rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    notb %sil, %al # encoding: [0x62,0xf4,0x7c,0x18,0xf6,0xd6]
; CHECK-NEXT:    orb %al, %dil, %cl # encoding: [0x62,0xf4,0x74,0x18,0x08,0xc7]
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    movb %cl, d64(%rip) # encoding: [0x88,0x0d,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 2, value: d64-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    retq # encoding: [0xc3]
  %xor = xor i8 %b, -1
  %v0 = or i8 %a, %xor  ; 0xff << 50
  %v1 = icmp eq i8 %v0, 0
  store i8 %v0, ptr @d64
  ret i1 %v1
}

define i1 @orflag16rr(i16 %a, i16 %b) {
; CHECK-LABEL: orflag16rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    notl %esi, %eax # encoding: [0x62,0xf4,0x7c,0x18,0xf7,0xd6]
; CHECK-NEXT:    orw %ax, %di, %cx # encoding: [0x62,0xf4,0x75,0x18,0x09,0xc7]
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    movw %cx, d64(%rip) # encoding: [0x66,0x89,0x0d,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 3, value: d64-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    retq # encoding: [0xc3]
  %xor = xor i16 %b, -1
  %v0 = or i16 %a, %xor  ; 0xff << 50
  %v1 = icmp eq i16 %v0, 0
  store i16 %v0, ptr @d64
  ret i1 %v1
}

define i1 @orflag32rr(i32 %a, i32 %b) {
; CHECK-LABEL: orflag32rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orl %esi, %edi, %ecx # encoding: [0x62,0xf4,0x74,0x18,0x09,0xf7]
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    movl %ecx, d64(%rip) # encoding: [0x89,0x0d,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 2, value: d64-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    retq # encoding: [0xc3]
  %v0 = or i32 %a, %b  ; 0xff << 50
  %v1 = icmp eq i32 %v0, 0
  store i32 %v0, ptr @d64
  ret i1 %v1
}

define i1 @orflag64rr(i64 %a, i64 %b) {
; CHECK-LABEL: orflag64rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orq %rsi, %rdi, %rcx # encoding: [0x62,0xf4,0xf4,0x18,0x09,0xf7]
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    movq %rcx, d64(%rip) # encoding: [0x48,0x89,0x0d,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 3, value: d64-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    retq # encoding: [0xc3]
  %v0 = or i64 %a, %b  ; 0xff << 50
  %v1 = icmp eq i64 %v0, 0
  store i64 %v0, ptr @d64
  ret i1 %v1
}

define i1 @orflag8rm(ptr %ptr, i8 %b) {
; CHECK-LABEL: orflag8rm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    notb %sil, %al # encoding: [0x62,0xf4,0x7c,0x18,0xf6,0xd6]
; CHECK-NEXT:    orb (%rdi), %al, %cl # encoding: [0x62,0xf4,0x74,0x18,0x0a,0x07]
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    movb %cl, d64(%rip) # encoding: [0x88,0x0d,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 2, value: d64-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i8, ptr %ptr
  %xor = xor i8 %b, -1
  %v0 = or i8 %a, %xor  ; 0xff << 50
  %v1 = icmp eq i8 %v0, 0
  store i8 %v0, ptr @d64
  ret i1 %v1
}

define i1 @orflag16rm(ptr %ptr, i16 %b) {
; CHECK-LABEL: orflag16rm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    notl %esi, %eax # encoding: [0x62,0xf4,0x7c,0x18,0xf7,0xd6]
; CHECK-NEXT:    orw (%rdi), %ax, %cx # encoding: [0x62,0xf4,0x75,0x18,0x0b,0x07]
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    movw %cx, d64(%rip) # encoding: [0x66,0x89,0x0d,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 3, value: d64-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i16, ptr %ptr
  %xor = xor i16 %b, -1
  %v0 = or i16 %a, %xor  ; 0xff << 50
  %v1 = icmp eq i16 %v0, 0
  store i16 %v0, ptr @d64
  ret i1 %v1
}

define i1 @orflag32rm(ptr %ptr, i32 %b) {
; CHECK-LABEL: orflag32rm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orl (%rdi), %esi, %ecx # encoding: [0x62,0xf4,0x74,0x18,0x0b,0x37]
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    movl %ecx, d64(%rip) # encoding: [0x89,0x0d,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 2, value: d64-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i32, ptr %ptr
  %v0 = or i32 %a, %b  ; 0xff << 50
  %v1 = icmp eq i32 %v0, 0
  store i32 %v0, ptr @d64
  ret i1 %v1
}

define i1 @orflag64rm(ptr %ptr, i64 %b) {
; CHECK-LABEL: orflag64rm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orq (%rdi), %rsi, %rcx # encoding: [0x62,0xf4,0xf4,0x18,0x0b,0x37]
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    movq %rcx, d64(%rip) # encoding: [0x48,0x89,0x0d,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 3, value: d64-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i64, ptr %ptr
  %v0 = or i64 %a, %b  ; 0xff << 50
  %v1 = icmp eq i64 %v0, 0
  store i64 %v0, ptr @d64
  ret i1 %v1
}

define i1 @orflag8ri(i8 %a) {
; CHECK-LABEL: orflag8ri:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orb $-124, %dil, %cl # encoding: [0x62,0xf4,0x74,0x18,0x80,0xcf,0x84]
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    movb %cl, d64(%rip) # encoding: [0x88,0x0d,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 2, value: d64-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    retq # encoding: [0xc3]
  %xor = xor i8 123, -1
  %v0 = or i8 %a, %xor  ; 0xff << 50
  %v1 = icmp eq i8 %v0, 0
  store i8 %v0, ptr @d64
  ret i1 %v1
}

define i1 @orflag16ri(i16 %a) {
; CHECK-LABEL: orflag16ri:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orw $-1235, %di, %cx # encoding: [0x62,0xf4,0x75,0x18,0x81,0xcf,0x2d,0xfb]
; CHECK-NEXT:    # imm = 0xFB2D
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    movw %cx, d64(%rip) # encoding: [0x66,0x89,0x0d,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 3, value: d64-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    retq # encoding: [0xc3]
  %xor = xor i16 1234, -1
  %v0 = or i16 %a, %xor  ; 0xff << 50
  %v1 = icmp eq i16 %v0, 0
  store i16 %v0, ptr @d64
  ret i1 %v1
}

define i1 @orflag32ri(i32 %a) {
; CHECK-LABEL: orflag32ri:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orl $123456, %edi, %ecx # encoding: [0x62,0xf4,0x74,0x18,0x81,0xcf,0x40,0xe2,0x01,0x00]
; CHECK-NEXT:    # imm = 0x1E240
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    movl %ecx, d64(%rip) # encoding: [0x89,0x0d,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 2, value: d64-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    retq # encoding: [0xc3]
  %v0 = or i32 %a, 123456  ; 0xff << 50
  %v1 = icmp eq i32 %v0, 0
  store i32 %v0, ptr @d64
  ret i1 %v1
}

define i1 @orflag64ri(i64 %a) {
; CHECK-LABEL: orflag64ri:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orq $123456, %rdi, %rcx # encoding: [0x62,0xf4,0xf4,0x18,0x81,0xcf,0x40,0xe2,0x01,0x00]
; CHECK-NEXT:    # imm = 0x1E240
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    movq %rcx, d64(%rip) # encoding: [0x48,0x89,0x0d,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 3, value: d64-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    retq # encoding: [0xc3]
  %v0 = or i64 %a, 123456  ; 0xff << 50
  %v1 = icmp eq i64 %v0, 0
  store i64 %v0, ptr @d64
  ret i1 %v1
}

define i1 @orflag16ri8(i16 %a) {
; CHECK-LABEL: orflag16ri8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orw $-124, %di, %cx # encoding: [0x62,0xf4,0x75,0x18,0x83,0xcf,0x84]
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    movw %cx, d64(%rip) # encoding: [0x66,0x89,0x0d,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 3, value: d64-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    retq # encoding: [0xc3]
  %xor = xor i16 123, -1
  %v0 = or i16 %a, %xor  ; 0xff << 50
  %v1 = icmp eq i16 %v0, 0
  store i16 %v0, ptr @d64
  ret i1 %v1
}

define i1 @orflag32ri8(i32 %a) {
; CHECK-LABEL: orflag32ri8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orl $123, %edi, %ecx # encoding: [0x62,0xf4,0x74,0x18,0x83,0xcf,0x7b]
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    movl %ecx, d64(%rip) # encoding: [0x89,0x0d,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 2, value: d64-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    retq # encoding: [0xc3]
  %v0 = or i32 %a, 123  ; 0xff << 50
  %v1 = icmp eq i32 %v0, 0
  store i32 %v0, ptr @d64
  ret i1 %v1
}

define i1 @orflag64ri8(i64 %a) {
; CHECK-LABEL: orflag64ri8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orq $123, %rdi, %rcx # encoding: [0x62,0xf4,0xf4,0x18,0x83,0xcf,0x7b]
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    movq %rcx, d64(%rip) # encoding: [0x48,0x89,0x0d,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 3, value: d64-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    retq # encoding: [0xc3]
  %v0 = or i64 %a, 123  ; 0xff << 50
  %v1 = icmp eq i64 %v0, 0
  store i64 %v0, ptr @d64
  ret i1 %v1
}

define void @or8mr_legacy(ptr %a, i8 noundef %b) {
; CHECK-LABEL: or8mr_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orb %sil, (%rdi) # encoding: [0x40,0x08,0x37]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i8, ptr %a
  %or = or i8 %t, %b
  store i8 %or, ptr %a
  ret void
}

define void @or16mr_legacy(ptr %a, i16 noundef %b) {
; CHECK-LABEL: or16mr_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orw %si, (%rdi) # encoding: [0x66,0x09,0x37]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i16, ptr %a
  %or = or i16 %t, %b
  store i16 %or, ptr %a
  ret void
}

define void @or32mr_legacy(ptr %a, i32 noundef %b) {
; CHECK-LABEL: or32mr_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orl %esi, (%rdi) # encoding: [0x09,0x37]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i32, ptr %a
  %or = or i32 %t, %b
  store i32 %or, ptr %a
  ret void
}

define void @or64mr_legacy(ptr %a, i64 noundef %b) {
; CHECK-LABEL: or64mr_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orq %rsi, (%rdi) # encoding: [0x48,0x09,0x37]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i64, ptr %a
  %or = or i64 %t, %b
  store i64 %or, ptr %a
  ret void
}

define void @or8mi_legacy(ptr %a) {
; CHECK-LABEL: or8mi_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orb $123, (%rdi) # encoding: [0x80,0x0f,0x7b]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i8, ptr %a
  %or = or i8 %t, 123
  store i8 %or, ptr %a
  ret void
}

define void @or16mi_legacy(ptr %a) {
; CHECK-LABEL: or16mi_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orw $1234, (%rdi) # encoding: [0x66,0x81,0x0f,0xd2,0x04]
; CHECK-NEXT:    # imm = 0x4D2
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i16, ptr %a
  %or = or i16 %t, 1234
  store i16 %or, ptr %a
  ret void
}

define void @or32mi_legacy(ptr %a) {
; CHECK-LABEL: or32mi_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orl $123456, (%rdi) # encoding: [0x81,0x0f,0x40,0xe2,0x01,0x00]
; CHECK-NEXT:    # imm = 0x1E240
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i32, ptr %a
  %or = or i32 %t, 123456
  store i32 %or, ptr %a
  ret void
}

define void @or64mi_legacy(ptr %a) {
; CHECK-LABEL: or64mi_legacy:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orq $123456, (%rdi) # encoding: [0x48,0x81,0x0f,0x40,0xe2,0x01,0x00]
; CHECK-NEXT:    # imm = 0x1E240
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t= load i64, ptr %a
  %or = or i64 %t, 123456
  store i64 %or, ptr %a
  ret void
}
