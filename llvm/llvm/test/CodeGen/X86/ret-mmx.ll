; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-apple-darwin11 -mcpu=core2 -mattr=+mmx,+sse2 | FileCheck %s
; rdar://6602459

@g_v1di = external global <1 x i64>

define void @t1() nounwind {
; CHECK-LABEL: t1:
; CHECK:       ## %bb.0: ## %entry
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    callq _return_v1di
; CHECK-NEXT:    movq _g_v1di@GOTPCREL(%rip), %rcx
; CHECK-NEXT:    movq %rax, (%rcx)
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    retq
entry:
  %call = call <1 x i64> @return_v1di()		; <<1 x i64>> [#uses=0]
  store <1 x i64> %call, ptr @g_v1di
  ret void
}

declare <1 x i64> @return_v1di()

define <1 x i64> @t2() nounwind {
; CHECK-LABEL: t2:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movl $1, %eax
; CHECK-NEXT:    retq
  ret <1 x i64> <i64 1>
}

define <2 x i32> @t3() nounwind {
; CHECK-LABEL: t3:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movss {{.*#+}} xmm0 = [1,0,0,0]
; CHECK-NEXT:    retq
  ret <2 x i32> <i32 1, i32 0>
}

define double @t4() nounwind {
; CHECK-LABEL: t4:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movsd {{.*#+}} xmm0 = [1,0,0,0]
; CHECK-NEXT:    retq
  ret double bitcast (<2 x i32> <i32 1, i32 0> to double)
}

