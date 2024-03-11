; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch32 --mattr=+f,-d < %s | FileCheck %s --check-prefix=LA32F
; RUN: llc --mtriple=loongarch32 --mattr=+d < %s | FileCheck %s --check-prefix=LA32D
; RUN: llc --mtriple=loongarch64 --mattr=+f,-d < %s | FileCheck %s --check-prefix=LA64F
; RUN: llc --mtriple=loongarch64 --mattr=+d < %s | FileCheck %s --check-prefix=LA64D

declare float @llvm.sqrt.f32(float)
declare double @llvm.sqrt.f64(double)

define float @fsqrt_f32(float %a) nounwind {
; LA32F-LABEL: fsqrt_f32:
; LA32F:       # %bb.0:
; LA32F-NEXT:    fsqrt.s $fa0, $fa0
; LA32F-NEXT:    ret
;
; LA32D-LABEL: fsqrt_f32:
; LA32D:       # %bb.0:
; LA32D-NEXT:    fsqrt.s $fa0, $fa0
; LA32D-NEXT:    ret
;
; LA64F-LABEL: fsqrt_f32:
; LA64F:       # %bb.0:
; LA64F-NEXT:    fsqrt.s $fa0, $fa0
; LA64F-NEXT:    ret
;
; LA64D-LABEL: fsqrt_f32:
; LA64D:       # %bb.0:
; LA64D-NEXT:    fsqrt.s $fa0, $fa0
; LA64D-NEXT:    ret
  %1 = call float @llvm.sqrt.f32(float %a)
  ret float %1
}

define double @fsqrt_f64(double %a) nounwind {
; LA32F-LABEL: fsqrt_f64:
; LA32F:       # %bb.0:
; LA32F-NEXT:    addi.w $sp, $sp, -16
; LA32F-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32F-NEXT:    bl %plt(sqrt)
; LA32F-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32F-NEXT:    addi.w $sp, $sp, 16
; LA32F-NEXT:    ret
;
; LA32D-LABEL: fsqrt_f64:
; LA32D:       # %bb.0:
; LA32D-NEXT:    fsqrt.d $fa0, $fa0
; LA32D-NEXT:    ret
;
; LA64F-LABEL: fsqrt_f64:
; LA64F:       # %bb.0:
; LA64F-NEXT:    addi.d $sp, $sp, -16
; LA64F-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; LA64F-NEXT:    bl %plt(sqrt)
; LA64F-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; LA64F-NEXT:    addi.d $sp, $sp, 16
; LA64F-NEXT:    ret
;
; LA64D-LABEL: fsqrt_f64:
; LA64D:       # %bb.0:
; LA64D-NEXT:    fsqrt.d $fa0, $fa0
; LA64D-NEXT:    ret
  %1 = call double @llvm.sqrt.f64(double %a)
  ret double %1
}

define float @frsqrt_f32(float %a) nounwind {
; LA32F-LABEL: frsqrt_f32:
; LA32F:       # %bb.0:
; LA32F-NEXT:    frsqrt.s $fa0, $fa0
; LA32F-NEXT:    ret
;
; LA32D-LABEL: frsqrt_f32:
; LA32D:       # %bb.0:
; LA32D-NEXT:    frsqrt.s $fa0, $fa0
; LA32D-NEXT:    ret
;
; LA64F-LABEL: frsqrt_f32:
; LA64F:       # %bb.0:
; LA64F-NEXT:    frsqrt.s $fa0, $fa0
; LA64F-NEXT:    ret
;
; LA64D-LABEL: frsqrt_f32:
; LA64D:       # %bb.0:
; LA64D-NEXT:    frsqrt.s $fa0, $fa0
; LA64D-NEXT:    ret
  %1 = call float @llvm.sqrt.f32(float %a)
  %2 = fdiv float 1.0, %1
  ret float %2
}

define double @frsqrt_f64(double %a) nounwind {
; LA32F-LABEL: frsqrt_f64:
; LA32F:       # %bb.0:
; LA32F-NEXT:    addi.w $sp, $sp, -16
; LA32F-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32F-NEXT:    bl %plt(sqrt)
; LA32F-NEXT:    move $a2, $a0
; LA32F-NEXT:    move $a3, $a1
; LA32F-NEXT:    lu12i.w $a1, 261888
; LA32F-NEXT:    move $a0, $zero
; LA32F-NEXT:    bl %plt(__divdf3)
; LA32F-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32F-NEXT:    addi.w $sp, $sp, 16
; LA32F-NEXT:    ret
;
; LA32D-LABEL: frsqrt_f64:
; LA32D:       # %bb.0:
; LA32D-NEXT:    frsqrt.d $fa0, $fa0
; LA32D-NEXT:    ret
;
; LA64F-LABEL: frsqrt_f64:
; LA64F:       # %bb.0:
; LA64F-NEXT:    addi.d $sp, $sp, -16
; LA64F-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; LA64F-NEXT:    bl %plt(sqrt)
; LA64F-NEXT:    move $a1, $a0
; LA64F-NEXT:    lu52i.d $a0, $zero, 1023
; LA64F-NEXT:    bl %plt(__divdf3)
; LA64F-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; LA64F-NEXT:    addi.d $sp, $sp, 16
; LA64F-NEXT:    ret
;
; LA64D-LABEL: frsqrt_f64:
; LA64D:       # %bb.0:
; LA64D-NEXT:    frsqrt.d $fa0, $fa0
; LA64D-NEXT:    ret
  %1 = call double @llvm.sqrt.f64(double %a)
  %2 = fdiv double 1.0, %1
  ret double %2
}
