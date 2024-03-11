; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vl,+prefer-256-bit | FileCheck %s --check-prefix=AVX256
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vl,-prefer-256-bit | FileCheck %s --check-prefix=AVX512VL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,+prefer-256-bit | FileCheck %s --check-prefix=AVX512F
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,-prefer-256-bit | FileCheck %s --check-prefix=AVX512F

define <8 x i16> @testv8i1_sext_v8i16(ptr %p) {
; AVX256-LABEL: testv8i1_sext_v8i16:
; AVX256:       # %bb.0:
; AVX256-NEXT:    vmovdqa (%rdi), %ymm0
; AVX256-NEXT:    vptestnmd %ymm0, %ymm0, %k1
; AVX256-NEXT:    vpcmpeqd %ymm0, %ymm0, %ymm0
; AVX256-NEXT:    vmovdqa32 %ymm0, %ymm0 {%k1} {z}
; AVX256-NEXT:    vpmovdw %ymm0, %xmm0
; AVX256-NEXT:    vzeroupper
; AVX256-NEXT:    retq
;
; AVX512VL-LABEL: testv8i1_sext_v8i16:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512VL-NEXT:    vptestnmd %ymm0, %ymm0, %k1
; AVX512VL-NEXT:    vpcmpeqd %ymm0, %ymm0, %ymm0
; AVX512VL-NEXT:    vmovdqa32 %ymm0, %ymm0 {%k1} {z}
; AVX512VL-NEXT:    vpmovdw %ymm0, %xmm0
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512F-LABEL: testv8i1_sext_v8i16:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpxor %xmm0, %xmm0, %xmm0
; AVX512F-NEXT:    vpcmpeqd (%rdi), %ymm0, %ymm0
; AVX512F-NEXT:    vpmovdw %zmm0, %ymm0
; AVX512F-NEXT:    # kill: def $xmm0 killed $xmm0 killed $ymm0
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
  %in = load <8 x i32>, ptr %p
  %cmp = icmp eq <8 x i32> %in, zeroinitializer
  %ext = sext <8 x i1> %cmp to <8 x i16>
  ret <8 x i16> %ext
}

define <16 x i8> @testv16i1_sext_v16i8(ptr %p, ptr %q) {
; AVX256-LABEL: testv16i1_sext_v16i8:
; AVX256:       # %bb.0:
; AVX256-NEXT:    vmovdqa (%rdi), %ymm0
; AVX256-NEXT:    vptestnmd %ymm0, %ymm0, %k1
; AVX256-NEXT:    vmovdqa (%rsi), %ymm0
; AVX256-NEXT:    vptestnmd %ymm0, %ymm0, %k2
; AVX256-NEXT:    vpcmpeqd %ymm0, %ymm0, %ymm0
; AVX256-NEXT:    vmovdqa32 %ymm0, %ymm1 {%k2} {z}
; AVX256-NEXT:    vpmovdw %ymm1, %xmm1
; AVX256-NEXT:    vmovdqa32 %ymm0, %ymm0 {%k1} {z}
; AVX256-NEXT:    vpmovdw %ymm0, %xmm0
; AVX256-NEXT:    vpacksswb %xmm1, %xmm0, %xmm0
; AVX256-NEXT:    vzeroupper
; AVX256-NEXT:    retq
;
; AVX512VL-LABEL: testv16i1_sext_v16i8:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512VL-NEXT:    vptestnmd %ymm0, %ymm0, %k0
; AVX512VL-NEXT:    vmovdqa (%rsi), %ymm0
; AVX512VL-NEXT:    vptestnmd %ymm0, %ymm0, %k1
; AVX512VL-NEXT:    kunpckbw %k0, %k1, %k1
; AVX512VL-NEXT:    vpternlogd $255, %zmm0, %zmm0, %zmm0 {%k1} {z}
; AVX512VL-NEXT:    vpmovdb %zmm0, %xmm0
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512F-LABEL: testv16i1_sext_v16i8:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vptestnmd %zmm0, %zmm0, %k0
; AVX512F-NEXT:    vmovdqa (%rsi), %ymm0
; AVX512F-NEXT:    vptestnmd %zmm0, %zmm0, %k1
; AVX512F-NEXT:    kunpckbw %k0, %k1, %k1
; AVX512F-NEXT:    vpternlogd $255, %zmm0, %zmm0, %zmm0 {%k1} {z}
; AVX512F-NEXT:    vpmovdb %zmm0, %xmm0
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
  %in = load <8 x i32>, ptr %p
  %cmp = icmp eq <8 x i32> %in, zeroinitializer
  %in2 = load <8 x i32>, ptr %q
  %cmp2 = icmp eq <8 x i32> %in2, zeroinitializer
  %concat = shufflevector <8 x i1> %cmp, <8 x i1> %cmp2, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %ext = sext <16 x i1> %concat to <16 x i8>
  ret <16 x i8> %ext
}

define <16 x i16> @testv16i1_sext_v16i16(ptr %p, ptr %q) {
; AVX256-LABEL: testv16i1_sext_v16i16:
; AVX256:       # %bb.0:
; AVX256-NEXT:    vmovdqa (%rdi), %ymm0
; AVX256-NEXT:    vptestnmd %ymm0, %ymm0, %k1
; AVX256-NEXT:    vmovdqa (%rsi), %ymm0
; AVX256-NEXT:    vptestnmd %ymm0, %ymm0, %k2
; AVX256-NEXT:    vpcmpeqd %ymm0, %ymm0, %ymm0
; AVX256-NEXT:    vmovdqa32 %ymm0, %ymm1 {%k1} {z}
; AVX256-NEXT:    vpmovdw %ymm1, %xmm1
; AVX256-NEXT:    vmovdqa32 %ymm0, %ymm0 {%k2} {z}
; AVX256-NEXT:    vpmovdw %ymm0, %xmm0
; AVX256-NEXT:    vinserti128 $1, %xmm0, %ymm1, %ymm0
; AVX256-NEXT:    retq
;
; AVX512VL-LABEL: testv16i1_sext_v16i16:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512VL-NEXT:    vptestnmd %ymm0, %ymm0, %k0
; AVX512VL-NEXT:    vmovdqa (%rsi), %ymm0
; AVX512VL-NEXT:    vptestnmd %ymm0, %ymm0, %k1
; AVX512VL-NEXT:    kunpckbw %k0, %k1, %k1
; AVX512VL-NEXT:    vpternlogd $255, %zmm0, %zmm0, %zmm0 {%k1} {z}
; AVX512VL-NEXT:    vpmovdw %zmm0, %ymm0
; AVX512VL-NEXT:    retq
;
; AVX512F-LABEL: testv16i1_sext_v16i16:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vptestnmd %zmm0, %zmm0, %k0
; AVX512F-NEXT:    vmovdqa (%rsi), %ymm0
; AVX512F-NEXT:    vptestnmd %zmm0, %zmm0, %k1
; AVX512F-NEXT:    kunpckbw %k0, %k1, %k1
; AVX512F-NEXT:    vpternlogd $255, %zmm0, %zmm0, %zmm0 {%k1} {z}
; AVX512F-NEXT:    vpmovdw %zmm0, %ymm0
; AVX512F-NEXT:    retq
  %in = load <8 x i32>, ptr %p
  %cmp = icmp eq <8 x i32> %in, zeroinitializer
  %in2 = load <8 x i32>, ptr %q
  %cmp2 = icmp eq <8 x i32> %in2, zeroinitializer
  %concat = shufflevector <8 x i1> %cmp, <8 x i1> %cmp2, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %ext = sext <16 x i1> %concat to <16 x i16>
  ret <16 x i16> %ext
}

define <8 x i16> @testv8i1_zext_v8i16(ptr %p) {
; AVX256-LABEL: testv8i1_zext_v8i16:
; AVX256:       # %bb.0:
; AVX256-NEXT:    vmovdqa (%rdi), %ymm0
; AVX256-NEXT:    vptestnmd %ymm0, %ymm0, %k1
; AVX256-NEXT:    vpcmpeqd %ymm0, %ymm0, %ymm0
; AVX256-NEXT:    vmovdqa32 %ymm0, %ymm0 {%k1} {z}
; AVX256-NEXT:    vpmovdw %ymm0, %xmm0
; AVX256-NEXT:    vpsrlw $15, %xmm0, %xmm0
; AVX256-NEXT:    vzeroupper
; AVX256-NEXT:    retq
;
; AVX512VL-LABEL: testv8i1_zext_v8i16:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512VL-NEXT:    vptestnmd %ymm0, %ymm0, %k1
; AVX512VL-NEXT:    vpcmpeqd %ymm0, %ymm0, %ymm0
; AVX512VL-NEXT:    vmovdqa32 %ymm0, %ymm0 {%k1} {z}
; AVX512VL-NEXT:    vpmovdw %ymm0, %xmm0
; AVX512VL-NEXT:    vpsrlw $15, %xmm0, %xmm0
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512F-LABEL: testv8i1_zext_v8i16:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpxor %xmm0, %xmm0, %xmm0
; AVX512F-NEXT:    vpcmpeqd (%rdi), %ymm0, %ymm0
; AVX512F-NEXT:    vpmovdw %zmm0, %ymm0
; AVX512F-NEXT:    vpsrlw $15, %xmm0, %xmm0
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
  %in = load <8 x i32>, ptr %p
  %cmp = icmp eq <8 x i32> %in, zeroinitializer
  %ext = zext <8 x i1> %cmp to <8 x i16>
  ret <8 x i16> %ext
}

define <16 x i8> @testv16i1_zext_v16i8(ptr %p, ptr %q) {
; AVX256-LABEL: testv16i1_zext_v16i8:
; AVX256:       # %bb.0:
; AVX256-NEXT:    vmovdqa (%rdi), %ymm0
; AVX256-NEXT:    vptestnmd %ymm0, %ymm0, %k1
; AVX256-NEXT:    vmovdqa (%rsi), %ymm0
; AVX256-NEXT:    vptestnmd %ymm0, %ymm0, %k2
; AVX256-NEXT:    vpcmpeqd %ymm0, %ymm0, %ymm0
; AVX256-NEXT:    vmovdqa32 %ymm0, %ymm1 {%k2} {z}
; AVX256-NEXT:    vpmovdw %ymm1, %xmm1
; AVX256-NEXT:    vpsrlw $15, %xmm1, %xmm1
; AVX256-NEXT:    vmovdqa32 %ymm0, %ymm0 {%k1} {z}
; AVX256-NEXT:    vpmovdw %ymm0, %xmm0
; AVX256-NEXT:    vpsrlw $15, %xmm0, %xmm0
; AVX256-NEXT:    vpackuswb %xmm1, %xmm0, %xmm0
; AVX256-NEXT:    vzeroupper
; AVX256-NEXT:    retq
;
; AVX512VL-LABEL: testv16i1_zext_v16i8:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512VL-NEXT:    vptestnmd %ymm0, %ymm0, %k0
; AVX512VL-NEXT:    vmovdqa (%rsi), %ymm0
; AVX512VL-NEXT:    vptestnmd %ymm0, %ymm0, %k1
; AVX512VL-NEXT:    kunpckbw %k0, %k1, %k1
; AVX512VL-NEXT:    vpbroadcastd {{.*#+}} zmm0 {%k1} {z} = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
; AVX512VL-NEXT:    vpmovdb %zmm0, %xmm0
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512F-LABEL: testv16i1_zext_v16i8:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vptestnmd %zmm0, %zmm0, %k0
; AVX512F-NEXT:    vmovdqa (%rsi), %ymm0
; AVX512F-NEXT:    vptestnmd %zmm0, %zmm0, %k1
; AVX512F-NEXT:    kunpckbw %k0, %k1, %k1
; AVX512F-NEXT:    vpbroadcastd {{.*#+}} zmm0 {%k1} {z} = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
; AVX512F-NEXT:    vpmovdb %zmm0, %xmm0
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
  %in = load <8 x i32>, ptr %p
  %cmp = icmp eq <8 x i32> %in, zeroinitializer
  %in2 = load <8 x i32>, ptr %q
  %cmp2 = icmp eq <8 x i32> %in2, zeroinitializer
  %concat = shufflevector <8 x i1> %cmp, <8 x i1> %cmp2, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %ext = zext <16 x i1> %concat to <16 x i8>
  ret <16 x i8> %ext
}

define <16 x i16> @testv16i1_zext_v16i16(ptr %p, ptr %q) {
; AVX256-LABEL: testv16i1_zext_v16i16:
; AVX256:       # %bb.0:
; AVX256-NEXT:    vmovdqa (%rdi), %ymm0
; AVX256-NEXT:    vptestnmd %ymm0, %ymm0, %k1
; AVX256-NEXT:    vmovdqa (%rsi), %ymm0
; AVX256-NEXT:    vptestnmd %ymm0, %ymm0, %k2
; AVX256-NEXT:    vpcmpeqd %ymm0, %ymm0, %ymm0
; AVX256-NEXT:    vmovdqa32 %ymm0, %ymm1 {%k1} {z}
; AVX256-NEXT:    vpmovdw %ymm1, %xmm1
; AVX256-NEXT:    vmovdqa32 %ymm0, %ymm0 {%k2} {z}
; AVX256-NEXT:    vpmovdw %ymm0, %xmm0
; AVX256-NEXT:    vinserti128 $1, %xmm0, %ymm1, %ymm0
; AVX256-NEXT:    vpsrlw $15, %ymm0, %ymm0
; AVX256-NEXT:    retq
;
; AVX512VL-LABEL: testv16i1_zext_v16i16:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512VL-NEXT:    vptestnmd %ymm0, %ymm0, %k0
; AVX512VL-NEXT:    vmovdqa (%rsi), %ymm0
; AVX512VL-NEXT:    vptestnmd %ymm0, %ymm0, %k1
; AVX512VL-NEXT:    kunpckbw %k0, %k1, %k1
; AVX512VL-NEXT:    vpternlogd $255, %zmm0, %zmm0, %zmm0 {%k1} {z}
; AVX512VL-NEXT:    vpmovdw %zmm0, %ymm0
; AVX512VL-NEXT:    vpsrlw $15, %ymm0, %ymm0
; AVX512VL-NEXT:    retq
;
; AVX512F-LABEL: testv16i1_zext_v16i16:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vptestnmd %zmm0, %zmm0, %k0
; AVX512F-NEXT:    vmovdqa (%rsi), %ymm0
; AVX512F-NEXT:    vptestnmd %zmm0, %zmm0, %k1
; AVX512F-NEXT:    kunpckbw %k0, %k1, %k1
; AVX512F-NEXT:    vpternlogd $255, %zmm0, %zmm0, %zmm0 {%k1} {z}
; AVX512F-NEXT:    vpmovdw %zmm0, %ymm0
; AVX512F-NEXT:    vpsrlw $15, %ymm0, %ymm0
; AVX512F-NEXT:    retq
  %in = load <8 x i32>, ptr %p
  %cmp = icmp eq <8 x i32> %in, zeroinitializer
  %in2 = load <8 x i32>, ptr %q
  %cmp2 = icmp eq <8 x i32> %in2, zeroinitializer
  %concat = shufflevector <8 x i1> %cmp, <8 x i1> %cmp2, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %ext = zext <16 x i1> %concat to <16 x i16>
  ret <16 x i16> %ext
}
