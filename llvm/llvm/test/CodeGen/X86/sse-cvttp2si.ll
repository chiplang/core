; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- -mattr=sse4.1           | FileCheck %s --check-prefix=SSE
; RUN: llc < %s -mtriple=x86_64-- -mattr=avx              | FileCheck %s --check-prefix=AVX
; RUN: llc < %s -mtriple=x86_64-- -mattr=avx512f,avx512vl | FileCheck %s --check-prefix=AVX

; PR37751 - https://bugs.llvm.org/show_bug.cgi?id=37751
; We can't combine into 'round' instructions because the behavior is different for out-of-range values.

declare <4 x i32> @llvm.x86.sse2.cvttps2dq(<4 x float>)
declare <4 x i32> @llvm.x86.sse2.cvttpd2dq(<2 x double>)
declare i32 @llvm.x86.sse.cvttss2si(<4 x float>)
declare i64 @llvm.x86.sse.cvttss2si64(<4 x float>)
declare i32 @llvm.x86.sse2.cvttsd2si(<2 x double>)
declare i64 @llvm.x86.sse2.cvttsd2si64(<2 x double>)

define float @float_to_int_to_float_mem_f32_i32(ptr %p) #0 {
; SSE-LABEL: float_to_int_to_float_mem_f32_i32:
; SSE:       # %bb.0:
; SSE-NEXT:    cvttss2si (%rdi), %eax
; SSE-NEXT:    cvtsi2ss %eax, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: float_to_int_to_float_mem_f32_i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvttss2si (%rdi), %eax
; AVX-NEXT:    vcvtsi2ss %eax, %xmm0, %xmm0
; AVX-NEXT:    retq
  %x = load <4 x float>, ptr %p, align 16
  %fptosi = tail call i32 @llvm.x86.sse.cvttss2si(<4 x float> %x)
  %sitofp = sitofp i32 %fptosi to float
  ret float %sitofp
}

define float @float_to_int_to_float_reg_f32_i32(<4 x float> %x) #0 {
; SSE-LABEL: float_to_int_to_float_reg_f32_i32:
; SSE:       # %bb.0:
; SSE-NEXT:    cvttss2si %xmm0, %eax
; SSE-NEXT:    xorps %xmm0, %xmm0
; SSE-NEXT:    cvtsi2ss %eax, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: float_to_int_to_float_reg_f32_i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvttss2si %xmm0, %eax
; AVX-NEXT:    vcvtsi2ss %eax, %xmm1, %xmm0
; AVX-NEXT:    retq
  %fptosi = tail call i32 @llvm.x86.sse.cvttss2si(<4 x float> %x)
  %sitofp = sitofp i32 %fptosi to float
  ret float %sitofp
}

define float @float_to_int_to_float_mem_f32_i64(ptr %p) #0 {
; SSE-LABEL: float_to_int_to_float_mem_f32_i64:
; SSE:       # %bb.0:
; SSE-NEXT:    cvttss2si (%rdi), %rax
; SSE-NEXT:    cvtsi2ss %rax, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: float_to_int_to_float_mem_f32_i64:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvttss2si (%rdi), %rax
; AVX-NEXT:    vcvtsi2ss %rax, %xmm0, %xmm0
; AVX-NEXT:    retq
  %x = load <4 x float>, ptr %p, align 16
  %fptosi = tail call i64 @llvm.x86.sse.cvttss2si64(<4 x float> %x)
  %sitofp = sitofp i64 %fptosi to float
  ret float %sitofp
}

define float @float_to_int_to_float_reg_f32_i64(<4 x float> %x) #0 {
; SSE-LABEL: float_to_int_to_float_reg_f32_i64:
; SSE:       # %bb.0:
; SSE-NEXT:    cvttss2si %xmm0, %rax
; SSE-NEXT:    xorps %xmm0, %xmm0
; SSE-NEXT:    cvtsi2ss %rax, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: float_to_int_to_float_reg_f32_i64:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvttss2si %xmm0, %rax
; AVX-NEXT:    vcvtsi2ss %rax, %xmm1, %xmm0
; AVX-NEXT:    retq
  %fptosi = tail call i64 @llvm.x86.sse.cvttss2si64(<4 x float> %x)
  %sitofp = sitofp i64 %fptosi to float
  ret float %sitofp
}

define double @float_to_int_to_float_mem_f64_i32(ptr %p) #0 {
; SSE-LABEL: float_to_int_to_float_mem_f64_i32:
; SSE:       # %bb.0:
; SSE-NEXT:    cvttsd2si (%rdi), %eax
; SSE-NEXT:    cvtsi2sd %eax, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: float_to_int_to_float_mem_f64_i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvttsd2si (%rdi), %eax
; AVX-NEXT:    vcvtsi2sd %eax, %xmm0, %xmm0
; AVX-NEXT:    retq
  %x = load <2 x double>, ptr %p, align 16
  %fptosi = tail call i32 @llvm.x86.sse2.cvttsd2si(<2 x double> %x)
  %sitofp = sitofp i32 %fptosi to double
  ret double %sitofp
}

define double @float_to_int_to_float_reg_f64_i32(<2 x double> %x) #0 {
; SSE-LABEL: float_to_int_to_float_reg_f64_i32:
; SSE:       # %bb.0:
; SSE-NEXT:    cvttsd2si %xmm0, %eax
; SSE-NEXT:    xorps %xmm0, %xmm0
; SSE-NEXT:    cvtsi2sd %eax, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: float_to_int_to_float_reg_f64_i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvttsd2si %xmm0, %eax
; AVX-NEXT:    vcvtsi2sd %eax, %xmm1, %xmm0
; AVX-NEXT:    retq
  %fptosi = tail call i32 @llvm.x86.sse2.cvttsd2si(<2 x double> %x)
  %sitofp = sitofp i32 %fptosi to double
  ret double %sitofp
}

define double @float_to_int_to_float_mem_f64_i64(ptr %p) #0 {
; SSE-LABEL: float_to_int_to_float_mem_f64_i64:
; SSE:       # %bb.0:
; SSE-NEXT:    cvttsd2si (%rdi), %rax
; SSE-NEXT:    cvtsi2sd %rax, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: float_to_int_to_float_mem_f64_i64:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvttsd2si (%rdi), %rax
; AVX-NEXT:    vcvtsi2sd %rax, %xmm0, %xmm0
; AVX-NEXT:    retq
  %x = load <2 x double>, ptr %p, align 16
  %fptosi = tail call i64 @llvm.x86.sse2.cvttsd2si64(<2 x double> %x)
  %sitofp = sitofp i64 %fptosi to double
  ret double %sitofp
}

define double @float_to_int_to_float_reg_f64_i64(<2 x double> %x) #0 {
; SSE-LABEL: float_to_int_to_float_reg_f64_i64:
; SSE:       # %bb.0:
; SSE-NEXT:    cvttsd2si %xmm0, %rax
; SSE-NEXT:    xorps %xmm0, %xmm0
; SSE-NEXT:    cvtsi2sd %rax, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: float_to_int_to_float_reg_f64_i64:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvttsd2si %xmm0, %rax
; AVX-NEXT:    vcvtsi2sd %rax, %xmm1, %xmm0
; AVX-NEXT:    retq
  %fptosi = tail call i64 @llvm.x86.sse2.cvttsd2si64(<2 x double> %x)
  %sitofp = sitofp i64 %fptosi to double
  ret double %sitofp
}

define <4 x float> @float_to_int_to_float_mem_v4f32(ptr %p) #0 {
; SSE-LABEL: float_to_int_to_float_mem_v4f32:
; SSE:       # %bb.0:
; SSE-NEXT:    cvttps2dq (%rdi), %xmm0
; SSE-NEXT:    cvtdq2ps %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: float_to_int_to_float_mem_v4f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvttps2dq (%rdi), %xmm0
; AVX-NEXT:    vcvtdq2ps %xmm0, %xmm0
; AVX-NEXT:    retq
  %x = load <4 x float>, ptr %p, align 16
  %fptosi = tail call <4 x i32> @llvm.x86.sse2.cvttps2dq(<4 x float> %x)
  %sitofp = sitofp <4 x i32> %fptosi to <4 x float>
  ret <4 x float> %sitofp
}

define <4 x float> @float_to_int_to_float_reg_v4f32(<4 x float> %x) #0 {
; SSE-LABEL: float_to_int_to_float_reg_v4f32:
; SSE:       # %bb.0:
; SSE-NEXT:    cvttps2dq %xmm0, %xmm0
; SSE-NEXT:    cvtdq2ps %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: float_to_int_to_float_reg_v4f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvttps2dq %xmm0, %xmm0
; AVX-NEXT:    vcvtdq2ps %xmm0, %xmm0
; AVX-NEXT:    retq
  %fptosi = tail call <4 x i32> @llvm.x86.sse2.cvttps2dq(<4 x float> %x)
  %sitofp = sitofp <4 x i32> %fptosi to <4 x float>
  ret <4 x float> %sitofp
}

define <2 x double> @float_to_int_to_float_mem_v2f64(ptr %p) #0 {
; SSE-LABEL: float_to_int_to_float_mem_v2f64:
; SSE:       # %bb.0:
; SSE-NEXT:    cvttpd2dq (%rdi), %xmm0
; SSE-NEXT:    cvtdq2pd %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: float_to_int_to_float_mem_v2f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvttpd2dqx (%rdi), %xmm0
; AVX-NEXT:    vcvtdq2pd %xmm0, %xmm0
; AVX-NEXT:    retq
  %x = load <2 x double>, ptr %p, align 16
  %fptosi = tail call <4 x i32> @llvm.x86.sse2.cvttpd2dq(<2 x double> %x)
  %concat = shufflevector <4 x i32> %fptosi, <4 x i32> undef, <2 x i32> <i32 0, i32 1>
  %sitofp = sitofp <2 x i32> %concat to <2 x double>
  ret <2 x double> %sitofp
}

define <2 x double> @float_to_int_to_float_reg_v2f64(<2 x double> %x) #0 {
; SSE-LABEL: float_to_int_to_float_reg_v2f64:
; SSE:       # %bb.0:
; SSE-NEXT:    cvttpd2dq %xmm0, %xmm0
; SSE-NEXT:    cvtdq2pd %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: float_to_int_to_float_reg_v2f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvttpd2dq %xmm0, %xmm0
; AVX-NEXT:    vcvtdq2pd %xmm0, %xmm0
; AVX-NEXT:    retq
  %fptosi = tail call <4 x i32> @llvm.x86.sse2.cvttpd2dq(<2 x double> %x)
  %concat = shufflevector <4 x i32> %fptosi, <4 x i32> undef, <2 x i32> <i32 0, i32 1>
  %sitofp = sitofp <2 x i32> %concat to <2 x double>
  ret <2 x double> %sitofp
}

attributes #0 = { "no-signed-zeros-fp-math"="true" }

