# RUN: llvm-mc -triple x86_64 --show-encoding %s | FileCheck %s
# RUN: not llvm-mc -triple i386 -show-encoding %s 2>&1 | FileCheck %s --check-prefix=ERROR

# ERROR-COUNT-8: error:
# ERROR-NOT: error:

## wrssd

# CHECK: {evex}	wrssd	%ecx, 123(%rax,%rbx,4)
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0x66,0x4c,0x98,0x7b]
         {evex}	wrssd	%ecx, 123(%rax,%rbx,4)

# CHECK: wrssd	%r18d, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x78,0x08,0x66,0x94,0xac,0x23,0x01,0x00,0x00]
         wrssd	%r18d, 291(%r28,%r29,4)

## wrssq

# CHECK: {evex}	wrssq	%r9, 123(%rax,%rbx,4)
# CHECK: encoding: [0x62,0x74,0xfc,0x08,0x66,0x4c,0x98,0x7b]
         {evex}	wrssq	%r9, 123(%rax,%rbx,4)

# CHECK: wrssq	%r19, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0xf8,0x08,0x66,0x9c,0xac,0x23,0x01,0x00,0x00]
         wrssq	%r19, 291(%r28,%r29,4)

## wrussd

# CHECK: {evex}	wrussd	%ecx, 123(%rax,%rbx,4)
# CHECK: encoding: [0x62,0xf4,0x7d,0x08,0x65,0x4c,0x98,0x7b]
         {evex}	wrussd	%ecx, 123(%rax,%rbx,4)

# CHECK: wrussd	%r18d, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0x79,0x08,0x65,0x94,0xac,0x23,0x01,0x00,0x00]
         wrussd	%r18d, 291(%r28,%r29,4)

## wrussq

# CHECK: {evex}	wrussq	%r9, 123(%rax,%rbx,4)
# CHECK: encoding: [0x62,0x74,0xfd,0x08,0x65,0x4c,0x98,0x7b]
         {evex}	wrussq	%r9, 123(%rax,%rbx,4)

# CHECK: wrussq	%r19, 291(%r28,%r29,4)
# CHECK: encoding: [0x62,0x8c,0xf9,0x08,0x65,0x9c,0xac,0x23,0x01,0x00,0x00]
         wrussq	%r19, 291(%r28,%r29,4)
