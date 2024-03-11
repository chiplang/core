; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefixes=X86,X86-SSE
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avx | FileCheck %s --check-prefixes=X86,X86-AVX,X86-AVX1OR2,X86-AVX1
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefixes=X86,X86-AVX,X86-AVX1OR2,X86-AVX2
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avx512vl | FileCheck %s --check-prefixes=X86,X86-AVX,X86-AVX512,X86-AVX512VL
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avx512fp16 | FileCheck %s --check-prefixes=X86,X86-AVX,X86-AVX512,X86-AVX512FP16
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avx512dq,+avx512vl | FileCheck %s --check-prefixes=X86,X86-AVX,X86-AVX512,X86-AVX512VLDQ
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefixes=X64,X64-SSE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefixes=X64,X64-AVX,X64-AVX1OR2,X64-AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefixes=X64,X64-AVX,X64-AVX1OR2,X64-AVX2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vl | FileCheck %s --check-prefixes=X64,X64-AVX,X64-AVX512,X64-AVX512VL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512fp16 | FileCheck %s --check-prefixes=X64,X64-AVX,X64-AVX512,X64-AVX512FP16
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512dq,+avx512vl | FileCheck %s --check-prefixes=X64,X64-AVX,X64-AVX512,X64-AVX512VLDQ

;
; 128-bit Vectors
;

define <2 x double> @fcopysign_v2f64(<2 x double> %a0, <2 x double> %a1) nounwind {
; X86-SSE-LABEL: fcopysign_v2f64:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}, %xmm1
; X86-SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-SSE-NEXT:    orps %xmm1, %xmm0
; X86-SSE-NEXT:    retl
;
; X86-AVX1OR2-LABEL: fcopysign_v2f64:
; X86-AVX1OR2:       # %bb.0:
; X86-AVX1OR2-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}, %xmm1, %xmm1
; X86-AVX1OR2-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0, %xmm0
; X86-AVX1OR2-NEXT:    vorps %xmm1, %xmm0, %xmm0
; X86-AVX1OR2-NEXT:    retl
;
; X86-AVX512-LABEL: fcopysign_v2f64:
; X86-AVX512:       # %bb.0:
; X86-AVX512-NEXT:    vpternlogq $228, {{\.?LCPI[0-9]+_[0-9]+}}{1to2}, %xmm1, %xmm0
; X86-AVX512-NEXT:    retl
;
; X64-SSE-LABEL: fcopysign_v2f64:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; X64-SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; X64-SSE-NEXT:    orps %xmm1, %xmm0
; X64-SSE-NEXT:    retq
;
; X64-AVX1OR2-LABEL: fcopysign_v2f64:
; X64-AVX1OR2:       # %bb.0:
; X64-AVX1OR2-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1, %xmm1
; X64-AVX1OR2-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; X64-AVX1OR2-NEXT:    vorps %xmm1, %xmm0, %xmm0
; X64-AVX1OR2-NEXT:    retq
;
; X64-AVX512-LABEL: fcopysign_v2f64:
; X64-AVX512:       # %bb.0:
; X64-AVX512-NEXT:    vpternlogq $228, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to2}, %xmm1, %xmm0
; X64-AVX512-NEXT:    retq
  %t = call <2 x double> @llvm.copysign.v2f64(<2 x double> %a0, <2 x double> %a1)
  ret <2 x double> %t
}
declare <2 x double> @llvm.copysign.v2f64(<2 x double>, <2 x double>)

define <4 x float> @fcopysign_v4f32(<4 x float> %a0, <4 x float> %a1) nounwind {
; X86-SSE-LABEL: fcopysign_v4f32:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}, %xmm1
; X86-SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-SSE-NEXT:    orps %xmm1, %xmm0
; X86-SSE-NEXT:    retl
;
; X86-AVX1-LABEL: fcopysign_v4f32:
; X86-AVX1:       # %bb.0:
; X86-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}, %xmm1, %xmm1
; X86-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0, %xmm0
; X86-AVX1-NEXT:    vorps %xmm1, %xmm0, %xmm0
; X86-AVX1-NEXT:    retl
;
; X86-AVX2-LABEL: fcopysign_v4f32:
; X86-AVX2:       # %bb.0:
; X86-AVX2-NEXT:    vbroadcastss {{.*#+}} xmm2 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; X86-AVX2-NEXT:    vandps %xmm2, %xmm1, %xmm1
; X86-AVX2-NEXT:    vbroadcastss {{.*#+}} xmm2 = [NaN,NaN,NaN,NaN]
; X86-AVX2-NEXT:    vandps %xmm2, %xmm0, %xmm0
; X86-AVX2-NEXT:    vorps %xmm1, %xmm0, %xmm0
; X86-AVX2-NEXT:    retl
;
; X86-AVX512-LABEL: fcopysign_v4f32:
; X86-AVX512:       # %bb.0:
; X86-AVX512-NEXT:    vpternlogd $228, {{\.?LCPI[0-9]+_[0-9]+}}{1to4}, %xmm1, %xmm0
; X86-AVX512-NEXT:    retl
;
; X64-SSE-LABEL: fcopysign_v4f32:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; X64-SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; X64-SSE-NEXT:    orps %xmm1, %xmm0
; X64-SSE-NEXT:    retq
;
; X64-AVX1-LABEL: fcopysign_v4f32:
; X64-AVX1:       # %bb.0:
; X64-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1, %xmm1
; X64-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; X64-AVX1-NEXT:    vorps %xmm1, %xmm0, %xmm0
; X64-AVX1-NEXT:    retq
;
; X64-AVX2-LABEL: fcopysign_v4f32:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    vbroadcastss {{.*#+}} xmm2 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; X64-AVX2-NEXT:    vandps %xmm2, %xmm1, %xmm1
; X64-AVX2-NEXT:    vbroadcastss {{.*#+}} xmm2 = [NaN,NaN,NaN,NaN]
; X64-AVX2-NEXT:    vandps %xmm2, %xmm0, %xmm0
; X64-AVX2-NEXT:    vorps %xmm1, %xmm0, %xmm0
; X64-AVX2-NEXT:    retq
;
; X64-AVX512-LABEL: fcopysign_v4f32:
; X64-AVX512:       # %bb.0:
; X64-AVX512-NEXT:    vpternlogd $228, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to4}, %xmm1, %xmm0
; X64-AVX512-NEXT:    retq
  %t = call <4 x float> @llvm.copysign.v4f32(<4 x float> %a0, <4 x float> %a1)
  ret <4 x float> %t
}
declare <4 x float> @llvm.copysign.v4f32(<4 x float>, <4 x float>)

define <8 x half> @fcopysign_v8f16(ptr %p0, ptr %p1) nounwind {
; X86-SSE-LABEL: fcopysign_v8f16:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-SSE-NEXT:    movaps (%ecx), %xmm0
; X86-SSE-NEXT:    movaps (%eax), %xmm1
; X86-SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}, %xmm1
; X86-SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-SSE-NEXT:    orps %xmm1, %xmm0
; X86-SSE-NEXT:    retl
;
; X86-AVX1-LABEL: fcopysign_v8f16:
; X86-AVX1:       # %bb.0:
; X86-AVX1-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX1-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-AVX1-NEXT:    vmovaps (%ecx), %xmm0
; X86-AVX1-NEXT:    vmovaps (%eax), %xmm1
; X86-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}, %xmm1, %xmm1
; X86-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0, %xmm0
; X86-AVX1-NEXT:    vorps %xmm1, %xmm0, %xmm0
; X86-AVX1-NEXT:    retl
;
; X86-AVX2-LABEL: fcopysign_v8f16:
; X86-AVX2:       # %bb.0:
; X86-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-AVX2-NEXT:    vpbroadcastw {{.*#+}} xmm0 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; X86-AVX2-NEXT:    vpand (%ecx), %xmm0, %xmm0
; X86-AVX2-NEXT:    vpbroadcastw {{.*#+}} xmm1 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
; X86-AVX2-NEXT:    vpand (%eax), %xmm1, %xmm1
; X86-AVX2-NEXT:    vpor %xmm0, %xmm1, %xmm0
; X86-AVX2-NEXT:    retl
;
; X86-AVX512-LABEL: fcopysign_v8f16:
; X86-AVX512:       # %bb.0:
; X86-AVX512-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX512-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-AVX512-NEXT:    vmovdqa (%ecx), %xmm1
; X86-AVX512-NEXT:    vpbroadcastd {{.*#+}} xmm0 = [2147450879,2147450879,2147450879,2147450879]
; X86-AVX512-NEXT:    vpternlogd $202, (%eax), %xmm1, %xmm0
; X86-AVX512-NEXT:    retl
;
; X64-SSE-LABEL: fcopysign_v8f16:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movaps (%rdi), %xmm0
; X64-SSE-NEXT:    movaps (%rsi), %xmm1
; X64-SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; X64-SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; X64-SSE-NEXT:    orps %xmm1, %xmm0
; X64-SSE-NEXT:    retq
;
; X64-AVX1-LABEL: fcopysign_v8f16:
; X64-AVX1:       # %bb.0:
; X64-AVX1-NEXT:    vmovaps (%rdi), %xmm0
; X64-AVX1-NEXT:    vmovaps (%rsi), %xmm1
; X64-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1, %xmm1
; X64-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; X64-AVX1-NEXT:    vorps %xmm1, %xmm0, %xmm0
; X64-AVX1-NEXT:    retq
;
; X64-AVX2-LABEL: fcopysign_v8f16:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    vpbroadcastw {{.*#+}} xmm0 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; X64-AVX2-NEXT:    vpand (%rsi), %xmm0, %xmm0
; X64-AVX2-NEXT:    vpbroadcastw {{.*#+}} xmm1 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
; X64-AVX2-NEXT:    vpand (%rdi), %xmm1, %xmm1
; X64-AVX2-NEXT:    vpor %xmm0, %xmm1, %xmm0
; X64-AVX2-NEXT:    retq
;
; X64-AVX512-LABEL: fcopysign_v8f16:
; X64-AVX512:       # %bb.0:
; X64-AVX512-NEXT:    vmovdqa (%rdi), %xmm1
; X64-AVX512-NEXT:    vpbroadcastd {{.*#+}} xmm0 = [2147450879,2147450879,2147450879,2147450879]
; X64-AVX512-NEXT:    vpternlogd $202, (%rsi), %xmm1, %xmm0
; X64-AVX512-NEXT:    retq
  %a0 = load <8 x half>, ptr %p0, align 16
  %a1 = load <8 x half>, ptr %p1, align 16
  %t = call <8 x half> @llvm.copysign.v8f16(<8 x half> %a0, <8 x half> %a1)
  ret <8 x half> %t
}
declare <8 x half> @llvm.copysign.v8f16(<8 x half>, <8 x half>)

;
; 256-bit Vectors
;

define <4 x double> @fcopysign_v4f64(<4 x double> %a0, <4 x double> %a1) nounwind {
; X86-SSE-LABEL: fcopysign_v4f64:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    pushl %ebp
; X86-SSE-NEXT:    movl %esp, %ebp
; X86-SSE-NEXT:    andl $-16, %esp
; X86-SSE-NEXT:    subl $16, %esp
; X86-SSE-NEXT:    movaps {{.*#+}} xmm3 = [NaN,NaN]
; X86-SSE-NEXT:    movaps %xmm3, %xmm4
; X86-SSE-NEXT:    andnps %xmm2, %xmm4
; X86-SSE-NEXT:    andps %xmm3, %xmm0
; X86-SSE-NEXT:    orps %xmm4, %xmm0
; X86-SSE-NEXT:    andps %xmm3, %xmm1
; X86-SSE-NEXT:    andnps 8(%ebp), %xmm3
; X86-SSE-NEXT:    orps %xmm3, %xmm1
; X86-SSE-NEXT:    movl %ebp, %esp
; X86-SSE-NEXT:    popl %ebp
; X86-SSE-NEXT:    retl
;
; X86-AVX1-LABEL: fcopysign_v4f64:
; X86-AVX1:       # %bb.0:
; X86-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}, %ymm1, %ymm1
; X86-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}, %ymm0, %ymm0
; X86-AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; X86-AVX1-NEXT:    retl
;
; X86-AVX2-LABEL: fcopysign_v4f64:
; X86-AVX2:       # %bb.0:
; X86-AVX2-NEXT:    vbroadcastsd {{.*#+}} ymm2 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; X86-AVX2-NEXT:    vandps %ymm2, %ymm1, %ymm1
; X86-AVX2-NEXT:    vbroadcastsd {{.*#+}} ymm2 = [NaN,NaN,NaN,NaN]
; X86-AVX2-NEXT:    vandps %ymm2, %ymm0, %ymm0
; X86-AVX2-NEXT:    vorps %ymm1, %ymm0, %ymm0
; X86-AVX2-NEXT:    retl
;
; X86-AVX512-LABEL: fcopysign_v4f64:
; X86-AVX512:       # %bb.0:
; X86-AVX512-NEXT:    vpternlogq $228, {{\.?LCPI[0-9]+_[0-9]+}}{1to4}, %ymm1, %ymm0
; X86-AVX512-NEXT:    retl
;
; X64-SSE-LABEL: fcopysign_v4f64:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movaps {{.*#+}} xmm4 = [NaN,NaN]
; X64-SSE-NEXT:    movaps %xmm4, %xmm5
; X64-SSE-NEXT:    andnps %xmm2, %xmm5
; X64-SSE-NEXT:    andps %xmm4, %xmm0
; X64-SSE-NEXT:    orps %xmm5, %xmm0
; X64-SSE-NEXT:    andps %xmm4, %xmm1
; X64-SSE-NEXT:    andnps %xmm3, %xmm4
; X64-SSE-NEXT:    orps %xmm4, %xmm1
; X64-SSE-NEXT:    retq
;
; X64-AVX1-LABEL: fcopysign_v4f64:
; X64-AVX1:       # %bb.0:
; X64-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm1, %ymm1
; X64-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm0, %ymm0
; X64-AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; X64-AVX1-NEXT:    retq
;
; X64-AVX2-LABEL: fcopysign_v4f64:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    vbroadcastsd {{.*#+}} ymm2 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; X64-AVX2-NEXT:    vandps %ymm2, %ymm1, %ymm1
; X64-AVX2-NEXT:    vbroadcastsd {{.*#+}} ymm2 = [NaN,NaN,NaN,NaN]
; X64-AVX2-NEXT:    vandps %ymm2, %ymm0, %ymm0
; X64-AVX2-NEXT:    vorps %ymm1, %ymm0, %ymm0
; X64-AVX2-NEXT:    retq
;
; X64-AVX512-LABEL: fcopysign_v4f64:
; X64-AVX512:       # %bb.0:
; X64-AVX512-NEXT:    vpternlogq $228, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to4}, %ymm1, %ymm0
; X64-AVX512-NEXT:    retq
  %t = call <4 x double> @llvm.copysign.v4f64(<4 x double> %a0, <4 x double> %a1)
  ret <4 x double> %t
}
declare <4 x double> @llvm.copysign.v4f64(<4 x double>, <4 x double>)

define <8 x float> @fcopysign_v8f32(<8 x float> %a0, <8 x float> %a1) nounwind {
; X86-SSE-LABEL: fcopysign_v8f32:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    pushl %ebp
; X86-SSE-NEXT:    movl %esp, %ebp
; X86-SSE-NEXT:    andl $-16, %esp
; X86-SSE-NEXT:    subl $16, %esp
; X86-SSE-NEXT:    movaps {{.*#+}} xmm3 = [NaN,NaN,NaN,NaN]
; X86-SSE-NEXT:    movaps %xmm3, %xmm4
; X86-SSE-NEXT:    andnps %xmm2, %xmm4
; X86-SSE-NEXT:    andps %xmm3, %xmm0
; X86-SSE-NEXT:    orps %xmm4, %xmm0
; X86-SSE-NEXT:    andps %xmm3, %xmm1
; X86-SSE-NEXT:    andnps 8(%ebp), %xmm3
; X86-SSE-NEXT:    orps %xmm3, %xmm1
; X86-SSE-NEXT:    movl %ebp, %esp
; X86-SSE-NEXT:    popl %ebp
; X86-SSE-NEXT:    retl
;
; X86-AVX1-LABEL: fcopysign_v8f32:
; X86-AVX1:       # %bb.0:
; X86-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}, %ymm1, %ymm1
; X86-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}, %ymm0, %ymm0
; X86-AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; X86-AVX1-NEXT:    retl
;
; X86-AVX2-LABEL: fcopysign_v8f32:
; X86-AVX2:       # %bb.0:
; X86-AVX2-NEXT:    vbroadcastss {{.*#+}} ymm2 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; X86-AVX2-NEXT:    vandps %ymm2, %ymm1, %ymm1
; X86-AVX2-NEXT:    vbroadcastss {{.*#+}} ymm2 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
; X86-AVX2-NEXT:    vandps %ymm2, %ymm0, %ymm0
; X86-AVX2-NEXT:    vorps %ymm1, %ymm0, %ymm0
; X86-AVX2-NEXT:    retl
;
; X86-AVX512-LABEL: fcopysign_v8f32:
; X86-AVX512:       # %bb.0:
; X86-AVX512-NEXT:    vpternlogd $228, {{\.?LCPI[0-9]+_[0-9]+}}{1to8}, %ymm1, %ymm0
; X86-AVX512-NEXT:    retl
;
; X64-SSE-LABEL: fcopysign_v8f32:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movaps {{.*#+}} xmm4 = [NaN,NaN,NaN,NaN]
; X64-SSE-NEXT:    movaps %xmm4, %xmm5
; X64-SSE-NEXT:    andnps %xmm2, %xmm5
; X64-SSE-NEXT:    andps %xmm4, %xmm0
; X64-SSE-NEXT:    orps %xmm5, %xmm0
; X64-SSE-NEXT:    andps %xmm4, %xmm1
; X64-SSE-NEXT:    andnps %xmm3, %xmm4
; X64-SSE-NEXT:    orps %xmm4, %xmm1
; X64-SSE-NEXT:    retq
;
; X64-AVX1-LABEL: fcopysign_v8f32:
; X64-AVX1:       # %bb.0:
; X64-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm1, %ymm1
; X64-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm0, %ymm0
; X64-AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; X64-AVX1-NEXT:    retq
;
; X64-AVX2-LABEL: fcopysign_v8f32:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    vbroadcastss {{.*#+}} ymm2 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; X64-AVX2-NEXT:    vandps %ymm2, %ymm1, %ymm1
; X64-AVX2-NEXT:    vbroadcastss {{.*#+}} ymm2 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
; X64-AVX2-NEXT:    vandps %ymm2, %ymm0, %ymm0
; X64-AVX2-NEXT:    vorps %ymm1, %ymm0, %ymm0
; X64-AVX2-NEXT:    retq
;
; X64-AVX512-LABEL: fcopysign_v8f32:
; X64-AVX512:       # %bb.0:
; X64-AVX512-NEXT:    vpternlogd $228, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to8}, %ymm1, %ymm0
; X64-AVX512-NEXT:    retq
  %t = call <8 x float> @llvm.copysign.v8f32(<8 x float> %a0, <8 x float> %a1)
  ret <8 x float> %t
}
declare <8 x float> @llvm.copysign.v8f32(<8 x float>, <8 x float>)

define <16 x half> @fcopysign_v16f16(ptr %p0, ptr %p1) nounwind {
; X86-SSE-LABEL: fcopysign_v16f16:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-SSE-NEXT:    movaps {{.*#+}} xmm1 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
; X86-SSE-NEXT:    movaps %xmm1, %xmm2
; X86-SSE-NEXT:    andnps (%ecx), %xmm2
; X86-SSE-NEXT:    movaps (%eax), %xmm0
; X86-SSE-NEXT:    andps %xmm1, %xmm0
; X86-SSE-NEXT:    orps %xmm2, %xmm0
; X86-SSE-NEXT:    movaps %xmm1, %xmm2
; X86-SSE-NEXT:    andnps 16(%ecx), %xmm2
; X86-SSE-NEXT:    andps 16(%eax), %xmm1
; X86-SSE-NEXT:    orps %xmm2, %xmm1
; X86-SSE-NEXT:    retl
;
; X86-AVX1-LABEL: fcopysign_v16f16:
; X86-AVX1:       # %bb.0:
; X86-AVX1-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX1-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-AVX1-NEXT:    vmovups (%ecx), %ymm0
; X86-AVX1-NEXT:    vmovups (%eax), %ymm1
; X86-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}, %ymm1, %ymm1
; X86-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}, %ymm0, %ymm0
; X86-AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; X86-AVX1-NEXT:    retl
;
; X86-AVX2-LABEL: fcopysign_v16f16:
; X86-AVX2:       # %bb.0:
; X86-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-AVX2-NEXT:    vpbroadcastw {{.*#+}} ymm0 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; X86-AVX2-NEXT:    vpand (%ecx), %ymm0, %ymm0
; X86-AVX2-NEXT:    vpbroadcastw {{.*#+}} ymm1 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
; X86-AVX2-NEXT:    vpand (%eax), %ymm1, %ymm1
; X86-AVX2-NEXT:    vpor %ymm0, %ymm1, %ymm0
; X86-AVX2-NEXT:    retl
;
; X86-AVX512-LABEL: fcopysign_v16f16:
; X86-AVX512:       # %bb.0:
; X86-AVX512-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX512-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-AVX512-NEXT:    vmovdqu (%ecx), %ymm1
; X86-AVX512-NEXT:    vpbroadcastd {{.*#+}} ymm0 = [2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879]
; X86-AVX512-NEXT:    vpternlogd $202, (%eax), %ymm1, %ymm0
; X86-AVX512-NEXT:    retl
;
; X64-SSE-LABEL: fcopysign_v16f16:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movaps {{.*#+}} xmm1 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
; X64-SSE-NEXT:    movaps %xmm1, %xmm2
; X64-SSE-NEXT:    andnps (%rsi), %xmm2
; X64-SSE-NEXT:    movaps (%rdi), %xmm0
; X64-SSE-NEXT:    andps %xmm1, %xmm0
; X64-SSE-NEXT:    orps %xmm2, %xmm0
; X64-SSE-NEXT:    movaps %xmm1, %xmm2
; X64-SSE-NEXT:    andnps 16(%rsi), %xmm2
; X64-SSE-NEXT:    andps 16(%rdi), %xmm1
; X64-SSE-NEXT:    orps %xmm2, %xmm1
; X64-SSE-NEXT:    retq
;
; X64-AVX1-LABEL: fcopysign_v16f16:
; X64-AVX1:       # %bb.0:
; X64-AVX1-NEXT:    vmovups (%rdi), %ymm0
; X64-AVX1-NEXT:    vmovups (%rsi), %ymm1
; X64-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm1, %ymm1
; X64-AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm0, %ymm0
; X64-AVX1-NEXT:    vorps %ymm1, %ymm0, %ymm0
; X64-AVX1-NEXT:    retq
;
; X64-AVX2-LABEL: fcopysign_v16f16:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    vpbroadcastw {{.*#+}} ymm0 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; X64-AVX2-NEXT:    vpand (%rsi), %ymm0, %ymm0
; X64-AVX2-NEXT:    vpbroadcastw {{.*#+}} ymm1 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
; X64-AVX2-NEXT:    vpand (%rdi), %ymm1, %ymm1
; X64-AVX2-NEXT:    vpor %ymm0, %ymm1, %ymm0
; X64-AVX2-NEXT:    retq
;
; X64-AVX512-LABEL: fcopysign_v16f16:
; X64-AVX512:       # %bb.0:
; X64-AVX512-NEXT:    vmovdqu (%rdi), %ymm1
; X64-AVX512-NEXT:    vpbroadcastd {{.*#+}} ymm0 = [2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879]
; X64-AVX512-NEXT:    vpternlogd $202, (%rsi), %ymm1, %ymm0
; X64-AVX512-NEXT:    retq
  %a0 = load <16 x half>, ptr %p0, align 16
  %a1 = load <16 x half>, ptr %p1, align 16
  %t = call <16 x half> @llvm.copysign.v16f16(<16 x half> %a0, <16 x half> %a1)
  ret <16 x half> %t
}
declare <16 x half> @llvm.copysign.v16f16(<16 x half>, <16 x half>)

;
; 512-bit Vectors
;

define <8 x double> @fcopysign_v8f64(<8 x double> %a0, <8 x double> %a1) nounwind {
; X86-SSE-LABEL: fcopysign_v8f64:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    pushl %ebp
; X86-SSE-NEXT:    movl %esp, %ebp
; X86-SSE-NEXT:    andl $-16, %esp
; X86-SSE-NEXT:    subl $16, %esp
; X86-SSE-NEXT:    movaps {{.*#+}} xmm3 = [NaN,NaN]
; X86-SSE-NEXT:    andps %xmm3, %xmm0
; X86-SSE-NEXT:    movaps %xmm3, %xmm4
; X86-SSE-NEXT:    andnps 24(%ebp), %xmm4
; X86-SSE-NEXT:    orps %xmm4, %xmm0
; X86-SSE-NEXT:    andps %xmm3, %xmm1
; X86-SSE-NEXT:    movaps %xmm3, %xmm4
; X86-SSE-NEXT:    andnps 40(%ebp), %xmm4
; X86-SSE-NEXT:    orps %xmm4, %xmm1
; X86-SSE-NEXT:    andps %xmm3, %xmm2
; X86-SSE-NEXT:    movaps %xmm3, %xmm4
; X86-SSE-NEXT:    andnps 56(%ebp), %xmm4
; X86-SSE-NEXT:    orps %xmm4, %xmm2
; X86-SSE-NEXT:    movaps %xmm3, %xmm4
; X86-SSE-NEXT:    andnps 72(%ebp), %xmm4
; X86-SSE-NEXT:    andps 8(%ebp), %xmm3
; X86-SSE-NEXT:    orps %xmm4, %xmm3
; X86-SSE-NEXT:    movl %ebp, %esp
; X86-SSE-NEXT:    popl %ebp
; X86-SSE-NEXT:    retl
;
; X86-AVX1OR2-LABEL: fcopysign_v8f64:
; X86-AVX1OR2:       # %bb.0:
; X86-AVX1OR2-NEXT:    pushl %ebp
; X86-AVX1OR2-NEXT:    movl %esp, %ebp
; X86-AVX1OR2-NEXT:    andl $-32, %esp
; X86-AVX1OR2-NEXT:    subl $32, %esp
; X86-AVX1OR2-NEXT:    vbroadcastsd {{.*#+}} ymm3 = [NaN,NaN,NaN,NaN]
; X86-AVX1OR2-NEXT:    vandnps %ymm2, %ymm3, %ymm2
; X86-AVX1OR2-NEXT:    vandps %ymm3, %ymm0, %ymm0
; X86-AVX1OR2-NEXT:    vorps %ymm2, %ymm0, %ymm0
; X86-AVX1OR2-NEXT:    vandps %ymm3, %ymm1, %ymm1
; X86-AVX1OR2-NEXT:    vandnps 8(%ebp), %ymm3, %ymm2
; X86-AVX1OR2-NEXT:    vorps %ymm2, %ymm1, %ymm1
; X86-AVX1OR2-NEXT:    movl %ebp, %esp
; X86-AVX1OR2-NEXT:    popl %ebp
; X86-AVX1OR2-NEXT:    retl
;
; X86-AVX512-LABEL: fcopysign_v8f64:
; X86-AVX512:       # %bb.0:
; X86-AVX512-NEXT:    vpternlogq $228, {{\.?LCPI[0-9]+_[0-9]+}}{1to8}, %zmm1, %zmm0
; X86-AVX512-NEXT:    retl
;
; X64-SSE-LABEL: fcopysign_v8f64:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movaps {{.*#+}} xmm8 = [NaN,NaN]
; X64-SSE-NEXT:    movaps %xmm8, %xmm9
; X64-SSE-NEXT:    andnps %xmm4, %xmm9
; X64-SSE-NEXT:    andps %xmm8, %xmm0
; X64-SSE-NEXT:    orps %xmm9, %xmm0
; X64-SSE-NEXT:    movaps %xmm8, %xmm4
; X64-SSE-NEXT:    andnps %xmm5, %xmm4
; X64-SSE-NEXT:    andps %xmm8, %xmm1
; X64-SSE-NEXT:    orps %xmm4, %xmm1
; X64-SSE-NEXT:    movaps %xmm8, %xmm4
; X64-SSE-NEXT:    andnps %xmm6, %xmm4
; X64-SSE-NEXT:    andps %xmm8, %xmm2
; X64-SSE-NEXT:    orps %xmm4, %xmm2
; X64-SSE-NEXT:    andps %xmm8, %xmm3
; X64-SSE-NEXT:    andnps %xmm7, %xmm8
; X64-SSE-NEXT:    orps %xmm8, %xmm3
; X64-SSE-NEXT:    retq
;
; X64-AVX1OR2-LABEL: fcopysign_v8f64:
; X64-AVX1OR2:       # %bb.0:
; X64-AVX1OR2-NEXT:    vbroadcastsd {{.*#+}} ymm4 = [NaN,NaN,NaN,NaN]
; X64-AVX1OR2-NEXT:    vandnps %ymm2, %ymm4, %ymm2
; X64-AVX1OR2-NEXT:    vandps %ymm4, %ymm0, %ymm0
; X64-AVX1OR2-NEXT:    vorps %ymm2, %ymm0, %ymm0
; X64-AVX1OR2-NEXT:    vandnps %ymm3, %ymm4, %ymm2
; X64-AVX1OR2-NEXT:    vandps %ymm4, %ymm1, %ymm1
; X64-AVX1OR2-NEXT:    vorps %ymm2, %ymm1, %ymm1
; X64-AVX1OR2-NEXT:    retq
;
; X64-AVX512-LABEL: fcopysign_v8f64:
; X64-AVX512:       # %bb.0:
; X64-AVX512-NEXT:    vpternlogq $228, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to8}, %zmm1, %zmm0
; X64-AVX512-NEXT:    retq
  %t = call <8 x double> @llvm.copysign.v8f64(<8 x double> %a0, <8 x double> %a1)
  ret <8 x double> %t
}
declare <8 x double> @llvm.copysign.v8f64(<8 x double>, <8 x double>)

define <16 x float> @fcopysign_v16f32(<16 x float> %a0, <16 x float> %a1) nounwind {
; X86-SSE-LABEL: fcopysign_v16f32:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    pushl %ebp
; X86-SSE-NEXT:    movl %esp, %ebp
; X86-SSE-NEXT:    andl $-16, %esp
; X86-SSE-NEXT:    subl $16, %esp
; X86-SSE-NEXT:    movaps {{.*#+}} xmm3 = [NaN,NaN,NaN,NaN]
; X86-SSE-NEXT:    andps %xmm3, %xmm0
; X86-SSE-NEXT:    movaps %xmm3, %xmm4
; X86-SSE-NEXT:    andnps 24(%ebp), %xmm4
; X86-SSE-NEXT:    orps %xmm4, %xmm0
; X86-SSE-NEXT:    andps %xmm3, %xmm1
; X86-SSE-NEXT:    movaps %xmm3, %xmm4
; X86-SSE-NEXT:    andnps 40(%ebp), %xmm4
; X86-SSE-NEXT:    orps %xmm4, %xmm1
; X86-SSE-NEXT:    andps %xmm3, %xmm2
; X86-SSE-NEXT:    movaps %xmm3, %xmm4
; X86-SSE-NEXT:    andnps 56(%ebp), %xmm4
; X86-SSE-NEXT:    orps %xmm4, %xmm2
; X86-SSE-NEXT:    movaps %xmm3, %xmm4
; X86-SSE-NEXT:    andnps 72(%ebp), %xmm4
; X86-SSE-NEXT:    andps 8(%ebp), %xmm3
; X86-SSE-NEXT:    orps %xmm4, %xmm3
; X86-SSE-NEXT:    movl %ebp, %esp
; X86-SSE-NEXT:    popl %ebp
; X86-SSE-NEXT:    retl
;
; X86-AVX1OR2-LABEL: fcopysign_v16f32:
; X86-AVX1OR2:       # %bb.0:
; X86-AVX1OR2-NEXT:    pushl %ebp
; X86-AVX1OR2-NEXT:    movl %esp, %ebp
; X86-AVX1OR2-NEXT:    andl $-32, %esp
; X86-AVX1OR2-NEXT:    subl $32, %esp
; X86-AVX1OR2-NEXT:    vbroadcastss {{.*#+}} ymm3 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
; X86-AVX1OR2-NEXT:    vandnps %ymm2, %ymm3, %ymm2
; X86-AVX1OR2-NEXT:    vandps %ymm3, %ymm0, %ymm0
; X86-AVX1OR2-NEXT:    vorps %ymm2, %ymm0, %ymm0
; X86-AVX1OR2-NEXT:    vandps %ymm3, %ymm1, %ymm1
; X86-AVX1OR2-NEXT:    vandnps 8(%ebp), %ymm3, %ymm2
; X86-AVX1OR2-NEXT:    vorps %ymm2, %ymm1, %ymm1
; X86-AVX1OR2-NEXT:    movl %ebp, %esp
; X86-AVX1OR2-NEXT:    popl %ebp
; X86-AVX1OR2-NEXT:    retl
;
; X86-AVX512-LABEL: fcopysign_v16f32:
; X86-AVX512:       # %bb.0:
; X86-AVX512-NEXT:    vpternlogd $228, {{\.?LCPI[0-9]+_[0-9]+}}{1to16}, %zmm1, %zmm0
; X86-AVX512-NEXT:    retl
;
; X64-SSE-LABEL: fcopysign_v16f32:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movaps {{.*#+}} xmm8 = [NaN,NaN,NaN,NaN]
; X64-SSE-NEXT:    movaps %xmm8, %xmm9
; X64-SSE-NEXT:    andnps %xmm4, %xmm9
; X64-SSE-NEXT:    andps %xmm8, %xmm0
; X64-SSE-NEXT:    orps %xmm9, %xmm0
; X64-SSE-NEXT:    movaps %xmm8, %xmm4
; X64-SSE-NEXT:    andnps %xmm5, %xmm4
; X64-SSE-NEXT:    andps %xmm8, %xmm1
; X64-SSE-NEXT:    orps %xmm4, %xmm1
; X64-SSE-NEXT:    movaps %xmm8, %xmm4
; X64-SSE-NEXT:    andnps %xmm6, %xmm4
; X64-SSE-NEXT:    andps %xmm8, %xmm2
; X64-SSE-NEXT:    orps %xmm4, %xmm2
; X64-SSE-NEXT:    andps %xmm8, %xmm3
; X64-SSE-NEXT:    andnps %xmm7, %xmm8
; X64-SSE-NEXT:    orps %xmm8, %xmm3
; X64-SSE-NEXT:    retq
;
; X64-AVX1OR2-LABEL: fcopysign_v16f32:
; X64-AVX1OR2:       # %bb.0:
; X64-AVX1OR2-NEXT:    vbroadcastss {{.*#+}} ymm4 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
; X64-AVX1OR2-NEXT:    vandnps %ymm2, %ymm4, %ymm2
; X64-AVX1OR2-NEXT:    vandps %ymm4, %ymm0, %ymm0
; X64-AVX1OR2-NEXT:    vorps %ymm2, %ymm0, %ymm0
; X64-AVX1OR2-NEXT:    vandnps %ymm3, %ymm4, %ymm2
; X64-AVX1OR2-NEXT:    vandps %ymm4, %ymm1, %ymm1
; X64-AVX1OR2-NEXT:    vorps %ymm2, %ymm1, %ymm1
; X64-AVX1OR2-NEXT:    retq
;
; X64-AVX512-LABEL: fcopysign_v16f32:
; X64-AVX512:       # %bb.0:
; X64-AVX512-NEXT:    vpternlogd $228, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to16}, %zmm1, %zmm0
; X64-AVX512-NEXT:    retq
  %t = call <16 x float> @llvm.copysign.v16f32(<16 x float> %a0, <16 x float> %a1)
  ret <16 x float> %t
}
declare <16 x float> @llvm.copysign.v16f32(<16 x float>, <16 x float>)

define <32 x half> @fcopysign_v32f16(ptr %p0, ptr %p1) nounwind {
; X86-SSE-LABEL: fcopysign_v32f16:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-SSE-NEXT:    movaps {{.*#+}} xmm3 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
; X86-SSE-NEXT:    movaps %xmm3, %xmm1
; X86-SSE-NEXT:    andnps (%ecx), %xmm1
; X86-SSE-NEXT:    movaps (%eax), %xmm0
; X86-SSE-NEXT:    andps %xmm3, %xmm0
; X86-SSE-NEXT:    orps %xmm1, %xmm0
; X86-SSE-NEXT:    movaps %xmm3, %xmm2
; X86-SSE-NEXT:    andnps 16(%ecx), %xmm2
; X86-SSE-NEXT:    movaps 16(%eax), %xmm1
; X86-SSE-NEXT:    andps %xmm3, %xmm1
; X86-SSE-NEXT:    orps %xmm2, %xmm1
; X86-SSE-NEXT:    movaps %xmm3, %xmm4
; X86-SSE-NEXT:    andnps 32(%ecx), %xmm4
; X86-SSE-NEXT:    movaps 32(%eax), %xmm2
; X86-SSE-NEXT:    andps %xmm3, %xmm2
; X86-SSE-NEXT:    orps %xmm4, %xmm2
; X86-SSE-NEXT:    movaps %xmm3, %xmm4
; X86-SSE-NEXT:    andnps 48(%ecx), %xmm4
; X86-SSE-NEXT:    andps 48(%eax), %xmm3
; X86-SSE-NEXT:    orps %xmm4, %xmm3
; X86-SSE-NEXT:    retl
;
; X86-AVX1-LABEL: fcopysign_v32f16:
; X86-AVX1:       # %bb.0:
; X86-AVX1-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX1-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-AVX1-NEXT:    vbroadcastss {{.*#+}} ymm1 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
; X86-AVX1-NEXT:    vandnps (%ecx), %ymm1, %ymm0
; X86-AVX1-NEXT:    vandps (%eax), %ymm1, %ymm2
; X86-AVX1-NEXT:    vorps %ymm0, %ymm2, %ymm0
; X86-AVX1-NEXT:    vandnps 32(%ecx), %ymm1, %ymm2
; X86-AVX1-NEXT:    vandps 32(%eax), %ymm1, %ymm1
; X86-AVX1-NEXT:    vorps %ymm2, %ymm1, %ymm1
; X86-AVX1-NEXT:    retl
;
; X86-AVX2-LABEL: fcopysign_v32f16:
; X86-AVX2:       # %bb.0:
; X86-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-AVX2-NEXT:    vpbroadcastw {{.*#+}} ymm1 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
; X86-AVX2-NEXT:    vpandn (%ecx), %ymm1, %ymm0
; X86-AVX2-NEXT:    vpand (%eax), %ymm1, %ymm2
; X86-AVX2-NEXT:    vpor %ymm0, %ymm2, %ymm0
; X86-AVX2-NEXT:    vpandn 32(%ecx), %ymm1, %ymm2
; X86-AVX2-NEXT:    vpand 32(%eax), %ymm1, %ymm1
; X86-AVX2-NEXT:    vpor %ymm2, %ymm1, %ymm1
; X86-AVX2-NEXT:    retl
;
; X86-AVX512-LABEL: fcopysign_v32f16:
; X86-AVX512:       # %bb.0:
; X86-AVX512-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX512-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-AVX512-NEXT:    vmovdqu64 (%ecx), %zmm1
; X86-AVX512-NEXT:    vpbroadcastd {{.*#+}} zmm0 = [2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879]
; X86-AVX512-NEXT:    vpternlogd $202, (%eax), %zmm1, %zmm0
; X86-AVX512-NEXT:    retl
;
; X64-SSE-LABEL: fcopysign_v32f16:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movaps {{.*#+}} xmm3 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
; X64-SSE-NEXT:    movaps %xmm3, %xmm1
; X64-SSE-NEXT:    andnps (%rsi), %xmm1
; X64-SSE-NEXT:    movaps (%rdi), %xmm0
; X64-SSE-NEXT:    andps %xmm3, %xmm0
; X64-SSE-NEXT:    orps %xmm1, %xmm0
; X64-SSE-NEXT:    movaps %xmm3, %xmm2
; X64-SSE-NEXT:    andnps 16(%rsi), %xmm2
; X64-SSE-NEXT:    movaps 16(%rdi), %xmm1
; X64-SSE-NEXT:    andps %xmm3, %xmm1
; X64-SSE-NEXT:    orps %xmm2, %xmm1
; X64-SSE-NEXT:    movaps %xmm3, %xmm4
; X64-SSE-NEXT:    andnps 32(%rsi), %xmm4
; X64-SSE-NEXT:    movaps 32(%rdi), %xmm2
; X64-SSE-NEXT:    andps %xmm3, %xmm2
; X64-SSE-NEXT:    orps %xmm4, %xmm2
; X64-SSE-NEXT:    movaps %xmm3, %xmm4
; X64-SSE-NEXT:    andnps 48(%rsi), %xmm4
; X64-SSE-NEXT:    andps 48(%rdi), %xmm3
; X64-SSE-NEXT:    orps %xmm4, %xmm3
; X64-SSE-NEXT:    retq
;
; X64-AVX1-LABEL: fcopysign_v32f16:
; X64-AVX1:       # %bb.0:
; X64-AVX1-NEXT:    vbroadcastss {{.*#+}} ymm1 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
; X64-AVX1-NEXT:    vandnps (%rsi), %ymm1, %ymm0
; X64-AVX1-NEXT:    vandps (%rdi), %ymm1, %ymm2
; X64-AVX1-NEXT:    vorps %ymm0, %ymm2, %ymm0
; X64-AVX1-NEXT:    vandnps 32(%rsi), %ymm1, %ymm2
; X64-AVX1-NEXT:    vandps 32(%rdi), %ymm1, %ymm1
; X64-AVX1-NEXT:    vorps %ymm2, %ymm1, %ymm1
; X64-AVX1-NEXT:    retq
;
; X64-AVX2-LABEL: fcopysign_v32f16:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    vpbroadcastw {{.*#+}} ymm1 = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN]
; X64-AVX2-NEXT:    vpandn (%rsi), %ymm1, %ymm0
; X64-AVX2-NEXT:    vpand (%rdi), %ymm1, %ymm2
; X64-AVX2-NEXT:    vpor %ymm0, %ymm2, %ymm0
; X64-AVX2-NEXT:    vpandn 32(%rsi), %ymm1, %ymm2
; X64-AVX2-NEXT:    vpand 32(%rdi), %ymm1, %ymm1
; X64-AVX2-NEXT:    vpor %ymm2, %ymm1, %ymm1
; X64-AVX2-NEXT:    retq
;
; X64-AVX512-LABEL: fcopysign_v32f16:
; X64-AVX512:       # %bb.0:
; X64-AVX512-NEXT:    vmovdqu64 (%rdi), %zmm1
; X64-AVX512-NEXT:    vpbroadcastd {{.*#+}} zmm0 = [2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879,2147450879]
; X64-AVX512-NEXT:    vpternlogd $202, (%rsi), %zmm1, %zmm0
; X64-AVX512-NEXT:    retq
  %a0 = load <32 x half>, ptr %p0, align 16
  %a1 = load <32 x half>, ptr %p1, align 16
  %t = call <32 x half> @llvm.copysign.v32f16(<32 x half> %a0, <32 x half> %a1)
  ret <32 x half> %t
}
declare <32 x half> @llvm.copysign.v32f16(<32 x half>, <32 x half>)
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; X64: {{.*}}
; X64-AVX: {{.*}}
; X64-AVX512FP16: {{.*}}
; X64-AVX512VL: {{.*}}
; X64-AVX512VLDQ: {{.*}}
; X86: {{.*}}
; X86-AVX: {{.*}}
; X86-AVX512FP16: {{.*}}
; X86-AVX512VL: {{.*}}
; X86-AVX512VLDQ: {{.*}}
