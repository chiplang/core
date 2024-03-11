; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-unknown-unknown -mattr=avx512f,avx512bw,avx512vl < %s | FileCheck %s --check-prefix=AVX512
; RUN: llc -mtriple=x86_64-unknown-unknown -mattr=avx512f,avx512bw,avx512vl,-evex512 < %s | FileCheck %s --check-prefix=AVX256

define void @test1() {
; AVX512-LABEL: test1:
; AVX512:       # %bb.0:
; AVX512-NEXT:    movq 64, %rax
; AVX512-NEXT:    movq %rax, (%rax)
; AVX512-NEXT:    vmovups 0, %zmm0
; AVX512-NEXT:    vmovups %zmm0, (%rax)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
;
; AVX256-LABEL: test1:
; AVX256:       # %bb.0:
; AVX256-NEXT:    movq 64, %rax
; AVX256-NEXT:    movq %rax, (%rax)
; AVX256-NEXT:    vmovups 0, %ymm0
; AVX256-NEXT:    vmovups 32, %ymm1
; AVX256-NEXT:    vmovups %ymm1, (%rax)
; AVX256-NEXT:    vmovups %ymm0, (%rax)
; AVX256-NEXT:    vzeroupper
; AVX256-NEXT:    retq
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 poison, ptr align 8 null, i64 72, i1 false)
  ret void
}

declare void @llvm.memcpy.p0.p0.i64(ptr, ptr, i64, i1)
