; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -mcpu=znver1 | FileCheck %s

define win64cc void @opaque() {
; CHECK-LABEL: opaque:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  ret void
}

; We need xmm6 to be live from the loop header across all iterations of the loop.
; We shouldn't clobber ymm6 inside the loop.
define i32 @main() {
; CHECK-LABEL: main:
; CHECK:       # %bb.0: # %start
; CHECK-NEXT:    subq $584, %rsp # imm = 0x248
; CHECK-NEXT:    .cfi_def_cfa_offset 592
; CHECK-NEXT:    vmovaps {{.*#+}} xmm6 = [1010101010101010101,2020202020202020202]
; CHECK-NEXT:    xorl %esi, %esi
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB1_1: # %fake-loop
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vmovups {{[0-9]+}}(%rsp), %ymm0
; CHECK-NEXT:    vmovups {{[0-9]+}}(%rsp), %ymm1
; CHECK-NEXT:    vmovups {{[0-9]+}}(%rsp), %ymm7
; CHECK-NEXT:    vmovups {{[0-9]+}}(%rsp), %ymm2
; CHECK-NEXT:    vmovups {{[0-9]+}}(%rsp), %ymm3
; CHECK-NEXT:    vmovups %ymm0, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    vmovups %ymm1, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    vmovups {{[0-9]+}}(%rsp), %ymm1
; CHECK-NEXT:    vmovups %ymm3, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    vmovups %ymm2, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    vmovups %ymm7, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    vmovups %ymm3, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    vmovups %ymm2, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    vmovups %ymm7, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    vmovups %ymm1, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    vmovups %ymm1, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    vmovups {{[0-9]+}}(%rsp), %ymm5
; CHECK-NEXT:    vmovups {{[0-9]+}}(%rsp), %ymm4
; CHECK-NEXT:    vmovups %ymm5, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    vmovups %ymm4, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq opaque@PLT
; CHECK-NEXT:    vmovaps %xmm6, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    testb %sil, %sil
; CHECK-NEXT:    jne .LBB1_1
; CHECK-NEXT:  # %bb.2: # %exit
; CHECK-NEXT:    movabsq $1010101010101010101, %rcx # imm = 0xE04998456557EB5
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    cmpq %rcx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    negl %eax
; CHECK-NEXT:    addq $584, %rsp # imm = 0x248
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
start:
  %dummy0 = alloca [22 x i64], align 8
  %dummy1 = alloca [22 x i64], align 8
  %dummy2 = alloca [22 x i64], align 8

  %data = alloca <2 x i64>, align 16

  br label %fake-loop

fake-loop:                                        ; preds = %fake-loop, %start
  %dummy0.cast = bitcast ptr %dummy0 to ptr
  %dummy1.cast = bitcast ptr %dummy1 to ptr
  call void @llvm.memcpy.p0.p0.i64(ptr nonnull align 8 %dummy1.cast, ptr nonnull align 8 %dummy0.cast, i64 176, i1 false)

  %dummy1.cast.copy = bitcast ptr %dummy1 to ptr
  %dummy2.cast = bitcast ptr %dummy2 to ptr
  call void @llvm.lifetime.start.p0(i64 176, ptr nonnull %dummy2.cast)
  call void @llvm.memcpy.p0.p0.i64(ptr nonnull align 8 %dummy2.cast, ptr nonnull align 8 %dummy1.cast.copy, i64 176, i1 false)

  call win64cc void @opaque()

  store <2 x i64> <i64 1010101010101010101, i64 2020202020202020202>, ptr %data, align 8

  %opaque-false = icmp eq i8 0, 1
  br i1 %opaque-false, label %fake-loop, label %exit

exit:                                             ; preds = %fake-loop
  %data.cast = bitcast ptr %data to ptr
  %0 = load i64, ptr %data.cast, align 8
  %1 = icmp eq i64 %0, 1010101010101010101
  %2 = select i1 %1, i32 0, i32 -1
  ret i32 %2
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0.p0.i64(ptr nocapture writeonly, ptr nocapture readonly, i64, i1 immarg) #0

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #0

attributes #0 = { argmemonly nounwind }
