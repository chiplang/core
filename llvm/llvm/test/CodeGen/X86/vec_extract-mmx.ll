; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown -mattr=+mmx,+sse2 | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+mmx,+sse2 | FileCheck %s --check-prefix=X64

define i32 @test0(ptr %v4) nounwind {
; X86-LABEL: test0:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    pshufw $238, (%eax), %mm0 # mm0 = mem[2,3,2,3]
; X86-NEXT:    movd %mm0, %eax
; X86-NEXT:    addl $32, %eax
; X86-NEXT:    retl
;
; X64-LABEL: test0:
; X64:       # %bb.0: # %entry
; X64-NEXT:    pshufw $238, (%rdi), %mm0 # mm0 = mem[2,3,2,3]
; X64-NEXT:    movd %mm0, %eax
; X64-NEXT:    addl $32, %eax
; X64-NEXT:    retq
entry:
  %v5 = load <1 x i64>, ptr %v4, align 8
  %v12 = bitcast <1 x i64> %v5 to <4 x i16>
  %v13 = bitcast <4 x i16> %v12 to x86_mmx
  %v14 = tail call x86_mmx @llvm.x86.sse.pshuf.w(x86_mmx %v13, i8 -18)
  %v15 = bitcast x86_mmx %v14 to <4 x i16>
  %v16 = bitcast <4 x i16> %v15 to <1 x i64>
  %v17 = extractelement <1 x i64> %v16, i32 0
  %v18 = bitcast i64 %v17 to <2 x i32>
  %v19 = extractelement <2 x i32> %v18, i32 0
  %v20 = add i32 %v19, 32
  ret i32 %v20
}

define i32 @test1(ptr nocapture readonly %ptr) nounwind {
; X86-LABEL: test1:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movd (%eax), %mm0
; X86-NEXT:    pshufw $232, %mm0, %mm0 # mm0 = mm0[0,2,2,3]
; X86-NEXT:    movd %mm0, %eax
; X86-NEXT:    emms
; X86-NEXT:    retl
;
; X64-LABEL: test1:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movd (%rdi), %mm0
; X64-NEXT:    pshufw $232, %mm0, %mm0 # mm0 = mm0[0,2,2,3]
; X64-NEXT:    movd %mm0, %eax
; X64-NEXT:    emms
; X64-NEXT:    retq
entry:
  %0 = load i32, ptr %ptr, align 4
  %1 = insertelement <2 x i32> undef, i32 %0, i32 0
  %2 = insertelement <2 x i32> %1, i32 0, i32 1
  %3 = bitcast <2 x i32> %2 to x86_mmx
  %4 = bitcast x86_mmx %3 to i64
  %5 = bitcast i64 %4 to <4 x i16>
  %6 = bitcast <4 x i16> %5 to x86_mmx
  %7 = tail call x86_mmx @llvm.x86.sse.pshuf.w(x86_mmx %6, i8 -24)
  %8 = bitcast x86_mmx %7 to <4 x i16>
  %9 = bitcast <4 x i16> %8 to <1 x i64>
  %10 = extractelement <1 x i64> %9, i32 0
  %11 = bitcast i64 %10 to <2 x i32>
  %12 = extractelement <2 x i32> %11, i32 0
  tail call void @llvm.x86.mmx.emms()
  ret i32 %12
}

define i32 @test2(ptr nocapture readonly %ptr) nounwind {
; X86-LABEL: test2:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    pshufw $232, (%eax), %mm0 # mm0 = mem[0,2,2,3]
; X86-NEXT:    movd %mm0, %eax
; X86-NEXT:    emms
; X86-NEXT:    retl
;
; X64-LABEL: test2:
; X64:       # %bb.0: # %entry
; X64-NEXT:    pshufw $232, (%rdi), %mm0 # mm0 = mem[0,2,2,3]
; X64-NEXT:    movd %mm0, %eax
; X64-NEXT:    emms
; X64-NEXT:    retq
entry:
  %0 = load x86_mmx, ptr %ptr, align 8
  %1 = tail call x86_mmx @llvm.x86.sse.pshuf.w(x86_mmx %0, i8 -24)
  %2 = bitcast x86_mmx %1 to <4 x i16>
  %3 = bitcast <4 x i16> %2 to <1 x i64>
  %4 = extractelement <1 x i64> %3, i32 0
  %5 = bitcast i64 %4 to <2 x i32>
  %6 = extractelement <2 x i32> %5, i32 0
  tail call void @llvm.x86.mmx.emms()
  ret i32 %6
}

define i32 @test3(x86_mmx %a) nounwind {
; X86-LABEL: test3:
; X86:       # %bb.0:
; X86-NEXT:    movd %mm0, %eax
; X86-NEXT:    retl
;
; X64-LABEL: test3:
; X64:       # %bb.0:
; X64-NEXT:    movd %mm0, %eax
; X64-NEXT:    retq
  %tmp0 = bitcast x86_mmx %a to <2 x i32>
  %tmp1 = extractelement <2 x i32> %tmp0, i32 0
  ret i32 %tmp1
}

; Verify we don't muck with extractelts from the upper lane.
define i32 @test4(x86_mmx %a) nounwind {
; X86-LABEL: test4:
; X86:       # %bb.0:
; X86-NEXT:    movq2dq %mm0, %xmm0
; X86-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,1,1]
; X86-NEXT:    movd %xmm0, %eax
; X86-NEXT:    retl
;
; X64-LABEL: test4:
; X64:       # %bb.0:
; X64-NEXT:    movq2dq %mm0, %xmm0
; X64-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,1,1]
; X64-NEXT:    movd %xmm0, %eax
; X64-NEXT:    retq
  %tmp0 = bitcast x86_mmx %a to <2 x i32>
  %tmp1 = extractelement <2 x i32> %tmp0, i32 1
  ret i32 %tmp1
}

declare x86_mmx @llvm.x86.sse.pshuf.w(x86_mmx, i8)
declare void @llvm.x86.mmx.emms()
