# RUN: llvm-mc -triple x86_64 -show-encoding -x86-asm-syntax=intel -output-asm-variant=1 %s | FileCheck %s

# CHECK: {evex}	shl	bl, 123
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xc0,0xe3,0x7b]
         {evex}	shl	bl, 123
# CHECK: {nf}	shl	bl, 123
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0xc0,0xe3,0x7b]
         {nf}	shl	bl, 123
# CHECK: shl	bl, bl, 123
# CHECK: encoding: [0x62,0xf4,0x64,0x18,0xc0,0xe3,0x7b]
         shl	bl, bl, 123
# CHECK: {nf}	shl	bl, bl, 123
# CHECK: encoding: [0x62,0xf4,0x64,0x1c,0xc0,0xe3,0x7b]
         {nf}	shl	bl, bl, 123
# CHECK: {evex}	shl	dx, 123
# CHECK: encoding: [0x62,0xf4,0x7d,0x08,0xc1,0xe2,0x7b]
         {evex}	shl	dx, 123
# CHECK: {nf}	shl	dx, 123
# CHECK: encoding: [0x62,0xf4,0x7d,0x0c,0xc1,0xe2,0x7b]
         {nf}	shl	dx, 123
# CHECK: shl	dx, dx, 123
# CHECK: encoding: [0x62,0xf4,0x6d,0x18,0xc1,0xe2,0x7b]
         shl	dx, dx, 123
# CHECK: {nf}	shl	dx, dx, 123
# CHECK: encoding: [0x62,0xf4,0x6d,0x1c,0xc1,0xe2,0x7b]
         {nf}	shl	dx, dx, 123
# CHECK: {evex}	shl	ecx, 123
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xc1,0xe1,0x7b]
         {evex}	shl	ecx, 123
# CHECK: {nf}	shl	ecx, 123
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0xc1,0xe1,0x7b]
         {nf}	shl	ecx, 123
# CHECK: shl	ecx, ecx, 123
# CHECK: encoding: [0x62,0xf4,0x74,0x18,0xc1,0xe1,0x7b]
         shl	ecx, ecx, 123
# CHECK: {nf}	shl	ecx, ecx, 123
# CHECK: encoding: [0x62,0xf4,0x74,0x1c,0xc1,0xe1,0x7b]
         {nf}	shl	ecx, ecx, 123
# CHECK: {evex}	shl	r9, 123
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xc1,0xe1,0x7b]
         {evex}	shl	r9, 123
# CHECK: {nf}	shl	r9, 123
# CHECK: encoding: [0x62,0xd4,0xfc,0x0c,0xc1,0xe1,0x7b]
         {nf}	shl	r9, 123
# CHECK: shl	r9, r9, 123
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0xc1,0xe1,0x7b]
         shl	r9, r9, 123
# CHECK: {nf}	shl	r9, r9, 123
# CHECK: encoding: [0x62,0xd4,0xb4,0x1c,0xc1,0xe1,0x7b]
         {nf}	shl	r9, r9, 123
# CHECK: {evex}	shl	byte ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xc0,0xa4,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	shl	byte ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	shl	byte ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0xc0,0xa4,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	shl	byte ptr [r8 + 4*rax + 291], 123
# CHECK: shl	bl, byte ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x64,0x18,0xc0,0xa4,0x80,0x23,0x01,0x00,0x00,0x7b]
         shl	bl, byte ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	shl	bl, byte ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x64,0x1c,0xc0,0xa4,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	shl	bl, byte ptr [r8 + 4*rax + 291], 123
# CHECK: {evex}	shl	word ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0xc1,0xa4,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	shl	word ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	shl	word ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7d,0x0c,0xc1,0xa4,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	shl	word ptr [r8 + 4*rax + 291], 123
# CHECK: shl	dx, word ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x6d,0x18,0xc1,0xa4,0x80,0x23,0x01,0x00,0x00,0x7b]
         shl	dx, word ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	shl	dx, word ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x6d,0x1c,0xc1,0xa4,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	shl	dx, word ptr [r8 + 4*rax + 291], 123
# CHECK: {evex}	shl	dword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xc1,0xa4,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	shl	dword ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	shl	dword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0xc1,0xa4,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	shl	dword ptr [r8 + 4*rax + 291], 123
# CHECK: shl	ecx, dword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x74,0x18,0xc1,0xa4,0x80,0x23,0x01,0x00,0x00,0x7b]
         shl	ecx, dword ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	shl	ecx, dword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x74,0x1c,0xc1,0xa4,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	shl	ecx, dword ptr [r8 + 4*rax + 291], 123
# CHECK: {evex}	shl	qword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xc1,0xa4,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	shl	qword ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	shl	qword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0xfc,0x0c,0xc1,0xa4,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	shl	qword ptr [r8 + 4*rax + 291], 123
# CHECK: shl	r9, qword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0xc1,0xa4,0x80,0x23,0x01,0x00,0x00,0x7b]
         shl	r9, qword ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	shl	r9, qword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0xb4,0x1c,0xc1,0xa4,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	shl	r9, qword ptr [r8 + 4*rax + 291], 123
# CHECK: {evex}	shl	bl
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xd0,0xe3]
         {evex}	shl	bl
# CHECK: {nf}	shl	bl
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0xd0,0xe3]
         {nf}	shl	bl
# CHECK: {evex}	shl	bl, cl
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xd2,0xe3]
         {evex}	shl	bl, cl
# CHECK: {nf}	shl	bl, cl
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0xd2,0xe3]
         {nf}	shl	bl, cl
# CHECK: shl	bl, bl, cl
# CHECK: encoding: [0x62,0xf4,0x64,0x18,0xd2,0xe3]
         shl	bl, bl, cl
# CHECK: {nf}	shl	bl, bl, cl
# CHECK: encoding: [0x62,0xf4,0x64,0x1c,0xd2,0xe3]
         {nf}	shl	bl, bl, cl
# CHECK: {evex}	shl	dx, cl
# CHECK: encoding: [0x62,0xf4,0x7d,0x08,0xd3,0xe2]
         {evex}	shl	dx, cl
# CHECK: {nf}	shl	dx, cl
# CHECK: encoding: [0x62,0xf4,0x7d,0x0c,0xd3,0xe2]
         {nf}	shl	dx, cl
# CHECK: shl	dx, dx, cl
# CHECK: encoding: [0x62,0xf4,0x6d,0x18,0xd3,0xe2]
         shl	dx, dx, cl
# CHECK: {nf}	shl	dx, dx, cl
# CHECK: encoding: [0x62,0xf4,0x6d,0x1c,0xd3,0xe2]
         {nf}	shl	dx, dx, cl
# CHECK: {evex}	shl	ecx, cl
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xd3,0xe1]
         {evex}	shl	ecx, cl
# CHECK: {nf}	shl	ecx, cl
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0xd3,0xe1]
         {nf}	shl	ecx, cl
# CHECK: shl	ecx, ecx, cl
# CHECK: encoding: [0x62,0xf4,0x74,0x18,0xd3,0xe1]
         shl	ecx, ecx, cl
# CHECK: {nf}	shl	ecx, ecx, cl
# CHECK: encoding: [0x62,0xf4,0x74,0x1c,0xd3,0xe1]
         {nf}	shl	ecx, ecx, cl
# CHECK: {evex}	shl	r9, cl
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xd3,0xe1]
         {evex}	shl	r9, cl
# CHECK: {nf}	shl	r9, cl
# CHECK: encoding: [0x62,0xd4,0xfc,0x0c,0xd3,0xe1]
         {nf}	shl	r9, cl
# CHECK: shl	r9, r9, cl
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0xd3,0xe1]
         shl	r9, r9, cl
# CHECK: {nf}	shl	r9, r9, cl
# CHECK: encoding: [0x62,0xd4,0xb4,0x1c,0xd3,0xe1]
         {nf}	shl	r9, r9, cl
# CHECK: {evex}	shl	byte ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xd2,0xa4,0x80,0x23,0x01,0x00,0x00]
         {evex}	shl	byte ptr [r8 + 4*rax + 291], cl
# CHECK: {nf}	shl	byte ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0xd2,0xa4,0x80,0x23,0x01,0x00,0x00]
         {nf}	shl	byte ptr [r8 + 4*rax + 291], cl
# CHECK: shl	bl, byte ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x64,0x18,0xd2,0xa4,0x80,0x23,0x01,0x00,0x00]
         shl	bl, byte ptr [r8 + 4*rax + 291], cl
# CHECK: {nf}	shl	bl, byte ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x64,0x1c,0xd2,0xa4,0x80,0x23,0x01,0x00,0x00]
         {nf}	shl	bl, byte ptr [r8 + 4*rax + 291], cl
# CHECK: {evex}	shl	word ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0xd3,0xa4,0x80,0x23,0x01,0x00,0x00]
         {evex}	shl	word ptr [r8 + 4*rax + 291], cl
# CHECK: {nf}	shl	word ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x7d,0x0c,0xd3,0xa4,0x80,0x23,0x01,0x00,0x00]
         {nf}	shl	word ptr [r8 + 4*rax + 291], cl
# CHECK: shl	dx, word ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x6d,0x18,0xd3,0xa4,0x80,0x23,0x01,0x00,0x00]
         shl	dx, word ptr [r8 + 4*rax + 291], cl
# CHECK: {nf}	shl	dx, word ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x6d,0x1c,0xd3,0xa4,0x80,0x23,0x01,0x00,0x00]
         {nf}	shl	dx, word ptr [r8 + 4*rax + 291], cl
# CHECK: {evex}	shl	dword ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xd3,0xa4,0x80,0x23,0x01,0x00,0x00]
         {evex}	shl	dword ptr [r8 + 4*rax + 291], cl
# CHECK: {nf}	shl	dword ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0xd3,0xa4,0x80,0x23,0x01,0x00,0x00]
         {nf}	shl	dword ptr [r8 + 4*rax + 291], cl
# CHECK: shl	ecx, dword ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x74,0x18,0xd3,0xa4,0x80,0x23,0x01,0x00,0x00]
         shl	ecx, dword ptr [r8 + 4*rax + 291], cl
# CHECK: {nf}	shl	ecx, dword ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0x74,0x1c,0xd3,0xa4,0x80,0x23,0x01,0x00,0x00]
         {nf}	shl	ecx, dword ptr [r8 + 4*rax + 291], cl
# CHECK: {evex}	shl	qword ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xd3,0xa4,0x80,0x23,0x01,0x00,0x00]
         {evex}	shl	qword ptr [r8 + 4*rax + 291], cl
# CHECK: {nf}	shl	qword ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0xfc,0x0c,0xd3,0xa4,0x80,0x23,0x01,0x00,0x00]
         {nf}	shl	qword ptr [r8 + 4*rax + 291], cl
# CHECK: shl	r9, qword ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0xd3,0xa4,0x80,0x23,0x01,0x00,0x00]
         shl	r9, qword ptr [r8 + 4*rax + 291], cl
# CHECK: {nf}	shl	r9, qword ptr [r8 + 4*rax + 291], cl
# CHECK: encoding: [0x62,0xd4,0xb4,0x1c,0xd3,0xa4,0x80,0x23,0x01,0x00,0x00]
         {nf}	shl	r9, qword ptr [r8 + 4*rax + 291], cl
# CHECK: {evex}	shl	dx
# CHECK: encoding: [0x62,0xf4,0x7d,0x08,0xd1,0xe2]
         {evex}	shl	dx
# CHECK: {nf}	shl	dx
# CHECK: encoding: [0x62,0xf4,0x7d,0x0c,0xd1,0xe2]
         {nf}	shl	dx
# CHECK: shl	dx, dx
# CHECK: encoding: [0x62,0xf4,0x6d,0x18,0xd1,0xe2]
         shl	dx, dx
# CHECK: {nf}	shl	dx, dx
# CHECK: encoding: [0x62,0xf4,0x6d,0x1c,0xd1,0xe2]
         {nf}	shl	dx, dx
# CHECK: {evex}	shl	ecx
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xd1,0xe1]
         {evex}	shl	ecx
# CHECK: {nf}	shl	ecx
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0xd1,0xe1]
         {nf}	shl	ecx
# CHECK: shl	ecx, ecx
# CHECK: encoding: [0x62,0xf4,0x74,0x18,0xd1,0xe1]
         shl	ecx, ecx
# CHECK: {nf}	shl	ecx, ecx
# CHECK: encoding: [0x62,0xf4,0x74,0x1c,0xd1,0xe1]
         {nf}	shl	ecx, ecx
# CHECK: {evex}	shl	r9
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xd1,0xe1]
         {evex}	shl	r9
# CHECK: {nf}	shl	r9
# CHECK: encoding: [0x62,0xd4,0xfc,0x0c,0xd1,0xe1]
         {nf}	shl	r9
# CHECK: shl	r9, r9
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0xd1,0xe1]
         shl	r9, r9
# CHECK: {nf}	shl	r9, r9
# CHECK: encoding: [0x62,0xd4,0xb4,0x1c,0xd1,0xe1]
         {nf}	shl	r9, r9
# CHECK: {evex}	shl	byte ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xd0,0xa4,0x80,0x23,0x01,0x00,0x00]
         {evex}	shl	byte ptr [r8 + 4*rax + 291]
# CHECK: {nf}	shl	byte ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0xd0,0xa4,0x80,0x23,0x01,0x00,0x00]
         {nf}	shl	byte ptr [r8 + 4*rax + 291]
# CHECK: shl	bl, byte ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x64,0x18,0xd0,0xa4,0x80,0x23,0x01,0x00,0x00]
         shl	bl, byte ptr [r8 + 4*rax + 291]
# CHECK: {nf}	shl	bl, byte ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x64,0x1c,0xd0,0xa4,0x80,0x23,0x01,0x00,0x00]
         {nf}	shl	bl, byte ptr [r8 + 4*rax + 291]
# CHECK: {evex}	shl	word ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0xd1,0xa4,0x80,0x23,0x01,0x00,0x00]
         {evex}	shl	word ptr [r8 + 4*rax + 291]
# CHECK: {nf}	shl	word ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7d,0x0c,0xd1,0xa4,0x80,0x23,0x01,0x00,0x00]
         {nf}	shl	word ptr [r8 + 4*rax + 291]
# CHECK: shl	dx, word ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x6d,0x18,0xd1,0xa4,0x80,0x23,0x01,0x00,0x00]
         shl	dx, word ptr [r8 + 4*rax + 291]
# CHECK: {nf}	shl	dx, word ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x6d,0x1c,0xd1,0xa4,0x80,0x23,0x01,0x00,0x00]
         {nf}	shl	dx, word ptr [r8 + 4*rax + 291]
# CHECK: {evex}	shl	dword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xd1,0xa4,0x80,0x23,0x01,0x00,0x00]
         {evex}	shl	dword ptr [r8 + 4*rax + 291]
# CHECK: {nf}	shl	dword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0xd1,0xa4,0x80,0x23,0x01,0x00,0x00]
         {nf}	shl	dword ptr [r8 + 4*rax + 291]
# CHECK: shl	ecx, dword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x74,0x18,0xd1,0xa4,0x80,0x23,0x01,0x00,0x00]
         shl	ecx, dword ptr [r8 + 4*rax + 291]
# CHECK: {nf}	shl	ecx, dword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x74,0x1c,0xd1,0xa4,0x80,0x23,0x01,0x00,0x00]
         {nf}	shl	ecx, dword ptr [r8 + 4*rax + 291]
# CHECK: {evex}	shl	qword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xd1,0xa4,0x80,0x23,0x01,0x00,0x00]
         {evex}	shl	qword ptr [r8 + 4*rax + 291]
# CHECK: {nf}	shl	qword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0xfc,0x0c,0xd1,0xa4,0x80,0x23,0x01,0x00,0x00]
         {nf}	shl	qword ptr [r8 + 4*rax + 291]
# CHECK: shl	r9, qword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0xd1,0xa4,0x80,0x23,0x01,0x00,0x00]
         shl	r9, qword ptr [r8 + 4*rax + 291]
# CHECK: {nf}	shl	r9, qword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0xb4,0x1c,0xd1,0xa4,0x80,0x23,0x01,0x00,0x00]
         {nf}	shl	r9, qword ptr [r8 + 4*rax + 291]
