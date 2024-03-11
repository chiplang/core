; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc --mtriple=loongarch32 --mattr=+d --relocation-model=static < %s | FileCheck %s --check-prefixes=ALL,LA32NOPIC
; RUN: llc --mtriple=loongarch32 --mattr=+d --relocation-model=pic < %s | FileCheck %s --check-prefixes=ALL,LA32PIC
; RUN: llc --mtriple=loongarch64 --mattr=+d --relocation-model=static < %s | FileCheck %s --check-prefixes=ALL,LA64NOPIC
; RUN: llc --mtriple=loongarch64 --mattr=+d --relocation-model=pic < %s | FileCheck %s --check-prefixes=ALL,LA64PIC

;; Check load from and store to global variables.
@G = dso_local global i32 zeroinitializer, align 4
@arr = dso_local global [10 x i32] zeroinitializer, align 4

define i32 @load_store_global() nounwind {
; LA32NOPIC-LABEL: load_store_global:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    pcalau12i $a0, %pc_hi20(G)
; LA32NOPIC-NEXT:    addi.w $a1, $a0, %pc_lo12(G)
; LA32NOPIC-NEXT:    ld.w $a0, $a1, 0
; LA32NOPIC-NEXT:    addi.w $a0, $a0, 1
; LA32NOPIC-NEXT:    st.w $a0, $a1, 0
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: load_store_global:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    pcalau12i $a0, %pc_hi20(.LG$local)
; LA32PIC-NEXT:    addi.w $a1, $a0, %pc_lo12(.LG$local)
; LA32PIC-NEXT:    ld.w $a0, $a1, 0
; LA32PIC-NEXT:    addi.w $a0, $a0, 1
; LA32PIC-NEXT:    st.w $a0, $a1, 0
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: load_store_global:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    pcalau12i $a0, %pc_hi20(G)
; LA64NOPIC-NEXT:    addi.d $a1, $a0, %pc_lo12(G)
; LA64NOPIC-NEXT:    ld.w $a0, $a1, 0
; LA64NOPIC-NEXT:    addi.d $a0, $a0, 1
; LA64NOPIC-NEXT:    st.w $a0, $a1, 0
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: load_store_global:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    pcalau12i $a0, %pc_hi20(.LG$local)
; LA64PIC-NEXT:    addi.d $a1, $a0, %pc_lo12(.LG$local)
; LA64PIC-NEXT:    ld.w $a0, $a1, 0
; LA64PIC-NEXT:    addi.d $a0, $a0, 1
; LA64PIC-NEXT:    st.w $a0, $a1, 0
; LA64PIC-NEXT:    ret
  %v = load i32, ptr @G
  %sum = add i32 %v, 1
  store i32 %sum, ptr @G
  ret i32 %sum
}

define i32 @load_store_global_array(i32 %a) nounwind {
; LA32NOPIC-LABEL: load_store_global_array:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    pcalau12i $a1, %pc_hi20(arr)
; LA32NOPIC-NEXT:    addi.w $a2, $a1, %pc_lo12(arr)
; LA32NOPIC-NEXT:    ld.w $a1, $a2, 0
; LA32NOPIC-NEXT:    st.w $a0, $a2, 0
; LA32NOPIC-NEXT:    ld.w $a3, $a2, 36
; LA32NOPIC-NEXT:    st.w $a0, $a2, 36
; LA32NOPIC-NEXT:    move $a0, $a1
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: load_store_global_array:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    pcalau12i $a1, %pc_hi20(.Larr$local)
; LA32PIC-NEXT:    addi.w $a2, $a1, %pc_lo12(.Larr$local)
; LA32PIC-NEXT:    ld.w $a1, $a2, 0
; LA32PIC-NEXT:    st.w $a0, $a2, 0
; LA32PIC-NEXT:    ld.w $a3, $a2, 36
; LA32PIC-NEXT:    st.w $a0, $a2, 36
; LA32PIC-NEXT:    move $a0, $a1
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: load_store_global_array:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    pcalau12i $a1, %pc_hi20(arr)
; LA64NOPIC-NEXT:    addi.d $a2, $a1, %pc_lo12(arr)
; LA64NOPIC-NEXT:    ld.w $a1, $a2, 0
; LA64NOPIC-NEXT:    st.w $a0, $a2, 0
; LA64NOPIC-NEXT:    ld.w $a3, $a2, 36
; LA64NOPIC-NEXT:    st.w $a0, $a2, 36
; LA64NOPIC-NEXT:    move $a0, $a1
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: load_store_global_array:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    pcalau12i $a1, %pc_hi20(.Larr$local)
; LA64PIC-NEXT:    addi.d $a2, $a1, %pc_lo12(.Larr$local)
; LA64PIC-NEXT:    ld.w $a1, $a2, 0
; LA64PIC-NEXT:    st.w $a0, $a2, 0
; LA64PIC-NEXT:    ld.w $a3, $a2, 36
; LA64PIC-NEXT:    st.w $a0, $a2, 36
; LA64PIC-NEXT:    move $a0, $a1
; LA64PIC-NEXT:    ret
  %1 = load volatile i32, ptr @arr, align 4
  store i32 %a, ptr @arr, align 4
  %2 = getelementptr [10 x i32], ptr @arr, i32 0, i32 9
  %3 = load volatile i32, ptr %2, align 4
  store i32 %a, ptr %2, align 4
  ret i32 %1
}

;; Check indexed and unindexed, sext, zext and anyext loads.

define i64 @ld_b(ptr %a) nounwind {
; LA32NOPIC-LABEL: ld_b:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    ld.b $a2, $a0, 1
; LA32NOPIC-NEXT:    ld.b $a0, $a0, 0
; LA32NOPIC-NEXT:    srai.w $a1, $a2, 31
; LA32NOPIC-NEXT:    move $a0, $a2
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: ld_b:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    ld.b $a2, $a0, 1
; LA32PIC-NEXT:    ld.b $a0, $a0, 0
; LA32PIC-NEXT:    srai.w $a1, $a2, 31
; LA32PIC-NEXT:    move $a0, $a2
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: ld_b:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    ld.b $a1, $a0, 1
; LA64NOPIC-NEXT:    ld.b $a0, $a0, 0
; LA64NOPIC-NEXT:    move $a0, $a1
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: ld_b:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    ld.b $a1, $a0, 1
; LA64PIC-NEXT:    ld.b $a0, $a0, 0
; LA64PIC-NEXT:    move $a0, $a1
; LA64PIC-NEXT:    ret
  %1 = getelementptr i8, ptr %a, i64 1
  %2 = load i8, ptr %1
  %3 = sext i8 %2 to i64
  %4 = load volatile i8, ptr %a
  ret i64 %3
}

define i64 @ld_h(ptr %a) nounwind {
; LA32NOPIC-LABEL: ld_h:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    ld.h $a2, $a0, 4
; LA32NOPIC-NEXT:    ld.h $a0, $a0, 0
; LA32NOPIC-NEXT:    srai.w $a1, $a2, 31
; LA32NOPIC-NEXT:    move $a0, $a2
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: ld_h:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    ld.h $a2, $a0, 4
; LA32PIC-NEXT:    ld.h $a0, $a0, 0
; LA32PIC-NEXT:    srai.w $a1, $a2, 31
; LA32PIC-NEXT:    move $a0, $a2
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: ld_h:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    ld.h $a1, $a0, 4
; LA64NOPIC-NEXT:    ld.h $a0, $a0, 0
; LA64NOPIC-NEXT:    move $a0, $a1
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: ld_h:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    ld.h $a1, $a0, 4
; LA64PIC-NEXT:    ld.h $a0, $a0, 0
; LA64PIC-NEXT:    move $a0, $a1
; LA64PIC-NEXT:    ret
  %1 = getelementptr i16, ptr %a, i64 2
  %2 = load i16, ptr %1
  %3 = sext i16 %2 to i64
  %4 = load volatile i16, ptr %a
  ret i64 %3
}

define i64 @ld_w(ptr %a) nounwind {
; LA32NOPIC-LABEL: ld_w:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    ld.w $a2, $a0, 12
; LA32NOPIC-NEXT:    ld.w $a0, $a0, 0
; LA32NOPIC-NEXT:    srai.w $a1, $a2, 31
; LA32NOPIC-NEXT:    move $a0, $a2
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: ld_w:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    ld.w $a2, $a0, 12
; LA32PIC-NEXT:    ld.w $a0, $a0, 0
; LA32PIC-NEXT:    srai.w $a1, $a2, 31
; LA32PIC-NEXT:    move $a0, $a2
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: ld_w:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    ld.w $a1, $a0, 12
; LA64NOPIC-NEXT:    ld.w $a0, $a0, 0
; LA64NOPIC-NEXT:    move $a0, $a1
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: ld_w:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    ld.w $a1, $a0, 12
; LA64PIC-NEXT:    ld.w $a0, $a0, 0
; LA64PIC-NEXT:    move $a0, $a1
; LA64PIC-NEXT:    ret
  %1 = getelementptr i32, ptr %a, i64 3
  %2 = load i32, ptr %1
  %3 = sext i32 %2 to i64
  %4 = load volatile i32, ptr %a
  ret i64 %3
}

define i64 @ld_d(ptr %a) nounwind {
; LA32NOPIC-LABEL: ld_d:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    ld.w $a1, $a0, 28
; LA32NOPIC-NEXT:    ld.w $a2, $a0, 24
; LA32NOPIC-NEXT:    ld.w $a3, $a0, 4
; LA32NOPIC-NEXT:    ld.w $a0, $a0, 0
; LA32NOPIC-NEXT:    move $a0, $a2
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: ld_d:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    ld.w $a1, $a0, 28
; LA32PIC-NEXT:    ld.w $a2, $a0, 24
; LA32PIC-NEXT:    ld.w $a3, $a0, 4
; LA32PIC-NEXT:    ld.w $a0, $a0, 0
; LA32PIC-NEXT:    move $a0, $a2
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: ld_d:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    ld.d $a1, $a0, 24
; LA64NOPIC-NEXT:    ld.d $a0, $a0, 0
; LA64NOPIC-NEXT:    move $a0, $a1
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: ld_d:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    ld.d $a1, $a0, 24
; LA64PIC-NEXT:    ld.d $a0, $a0, 0
; LA64PIC-NEXT:    move $a0, $a1
; LA64PIC-NEXT:    ret
  %1 = getelementptr i64, ptr %a, i64 3
  %2 = load i64, ptr %1
  %3 = load volatile i64, ptr %a
  ret i64 %2
}

define i64 @ld_bu(ptr %a) nounwind {
; LA32NOPIC-LABEL: ld_bu:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    ld.bu $a1, $a0, 4
; LA32NOPIC-NEXT:    ld.bu $a0, $a0, 0
; LA32NOPIC-NEXT:    add.w $a0, $a1, $a0
; LA32NOPIC-NEXT:    sltu $a1, $a0, $a1
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: ld_bu:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    ld.bu $a1, $a0, 4
; LA32PIC-NEXT:    ld.bu $a0, $a0, 0
; LA32PIC-NEXT:    add.w $a0, $a1, $a0
; LA32PIC-NEXT:    sltu $a1, $a0, $a1
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: ld_bu:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    ld.bu $a1, $a0, 4
; LA64NOPIC-NEXT:    ld.bu $a0, $a0, 0
; LA64NOPIC-NEXT:    add.d $a0, $a1, $a0
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: ld_bu:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    ld.bu $a1, $a0, 4
; LA64PIC-NEXT:    ld.bu $a0, $a0, 0
; LA64PIC-NEXT:    add.d $a0, $a1, $a0
; LA64PIC-NEXT:    ret
  %1 = getelementptr i8, ptr %a, i64 4
  %2 = load i8, ptr %1
  %3 = zext i8 %2 to i64
  %4 = load volatile i8, ptr %a
  %5 = zext i8 %4 to i64
  %6 = add i64 %3, %5
  ret i64 %6
}

define i64 @ld_hu(ptr %a) nounwind {
; LA32NOPIC-LABEL: ld_hu:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    ld.hu $a1, $a0, 10
; LA32NOPIC-NEXT:    ld.hu $a0, $a0, 0
; LA32NOPIC-NEXT:    add.w $a0, $a1, $a0
; LA32NOPIC-NEXT:    sltu $a1, $a0, $a1
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: ld_hu:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    ld.hu $a1, $a0, 10
; LA32PIC-NEXT:    ld.hu $a0, $a0, 0
; LA32PIC-NEXT:    add.w $a0, $a1, $a0
; LA32PIC-NEXT:    sltu $a1, $a0, $a1
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: ld_hu:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    ld.hu $a1, $a0, 10
; LA64NOPIC-NEXT:    ld.hu $a0, $a0, 0
; LA64NOPIC-NEXT:    add.d $a0, $a1, $a0
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: ld_hu:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    ld.hu $a1, $a0, 10
; LA64PIC-NEXT:    ld.hu $a0, $a0, 0
; LA64PIC-NEXT:    add.d $a0, $a1, $a0
; LA64PIC-NEXT:    ret
  %1 = getelementptr i16, ptr %a, i64 5
  %2 = load i16, ptr %1
  %3 = zext i16 %2 to i64
  %4 = load volatile i16, ptr %a
  %5 = zext i16 %4 to i64
  %6 = add i64 %3, %5
  ret i64 %6
}

define i64 @ld_wu(ptr %a) nounwind {
; LA32NOPIC-LABEL: ld_wu:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    ld.w $a1, $a0, 20
; LA32NOPIC-NEXT:    ld.w $a0, $a0, 0
; LA32NOPIC-NEXT:    add.w $a0, $a1, $a0
; LA32NOPIC-NEXT:    sltu $a1, $a0, $a1
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: ld_wu:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    ld.w $a1, $a0, 20
; LA32PIC-NEXT:    ld.w $a0, $a0, 0
; LA32PIC-NEXT:    add.w $a0, $a1, $a0
; LA32PIC-NEXT:    sltu $a1, $a0, $a1
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: ld_wu:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    ld.wu $a1, $a0, 20
; LA64NOPIC-NEXT:    ld.wu $a0, $a0, 0
; LA64NOPIC-NEXT:    add.d $a0, $a1, $a0
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: ld_wu:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    ld.wu $a1, $a0, 20
; LA64PIC-NEXT:    ld.wu $a0, $a0, 0
; LA64PIC-NEXT:    add.d $a0, $a1, $a0
; LA64PIC-NEXT:    ret
  %1 = getelementptr i32, ptr %a, i64 5
  %2 = load i32, ptr %1
  %3 = zext i32 %2 to i64
  %4 = load volatile i32, ptr %a
  %5 = zext i32 %4 to i64
  %6 = add i64 %3, %5
  ret i64 %6
}

define i64 @ldx_b(ptr %a, i64 %idx) nounwind {
; LA32NOPIC-LABEL: ldx_b:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    add.w $a1, $a0, $a1
; LA32NOPIC-NEXT:    ld.b $a2, $a1, 0
; LA32NOPIC-NEXT:    ld.b $a0, $a0, 0
; LA32NOPIC-NEXT:    srai.w $a1, $a2, 31
; LA32NOPIC-NEXT:    move $a0, $a2
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: ldx_b:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    add.w $a1, $a0, $a1
; LA32PIC-NEXT:    ld.b $a2, $a1, 0
; LA32PIC-NEXT:    ld.b $a0, $a0, 0
; LA32PIC-NEXT:    srai.w $a1, $a2, 31
; LA32PIC-NEXT:    move $a0, $a2
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: ldx_b:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    ldx.b $a1, $a0, $a1
; LA64NOPIC-NEXT:    ld.b $a0, $a0, 0
; LA64NOPIC-NEXT:    move $a0, $a1
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: ldx_b:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    ldx.b $a1, $a0, $a1
; LA64PIC-NEXT:    ld.b $a0, $a0, 0
; LA64PIC-NEXT:    move $a0, $a1
; LA64PIC-NEXT:    ret
  %1 = getelementptr i8, ptr %a, i64 %idx
  %2 = load i8, ptr %1
  %3 = sext i8 %2 to i64
  %4 = load volatile i8, ptr %a
  ret i64 %3
}

define i64 @ldx_h(ptr %a, i64 %idx) nounwind {
; LA32NOPIC-LABEL: ldx_h:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    alsl.w $a1, $a1, $a0, 1
; LA32NOPIC-NEXT:    ld.h $a2, $a1, 0
; LA32NOPIC-NEXT:    ld.h $a0, $a0, 0
; LA32NOPIC-NEXT:    srai.w $a1, $a2, 31
; LA32NOPIC-NEXT:    move $a0, $a2
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: ldx_h:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    alsl.w $a1, $a1, $a0, 1
; LA32PIC-NEXT:    ld.h $a2, $a1, 0
; LA32PIC-NEXT:    ld.h $a0, $a0, 0
; LA32PIC-NEXT:    srai.w $a1, $a2, 31
; LA32PIC-NEXT:    move $a0, $a2
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: ldx_h:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    slli.d $a1, $a1, 1
; LA64NOPIC-NEXT:    ldx.h $a1, $a0, $a1
; LA64NOPIC-NEXT:    ld.h $a0, $a0, 0
; LA64NOPIC-NEXT:    move $a0, $a1
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: ldx_h:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    slli.d $a1, $a1, 1
; LA64PIC-NEXT:    ldx.h $a1, $a0, $a1
; LA64PIC-NEXT:    ld.h $a0, $a0, 0
; LA64PIC-NEXT:    move $a0, $a1
; LA64PIC-NEXT:    ret
  %1 = getelementptr i16, ptr %a, i64 %idx
  %2 = load i16, ptr %1
  %3 = sext i16 %2 to i64
  %4 = load volatile i16, ptr %a
  ret i64 %3
}

define i64 @ldx_w(ptr %a, i64 %idx) nounwind {
; LA32NOPIC-LABEL: ldx_w:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    alsl.w $a1, $a1, $a0, 2
; LA32NOPIC-NEXT:    ld.w $a2, $a1, 0
; LA32NOPIC-NEXT:    ld.w $a0, $a0, 0
; LA32NOPIC-NEXT:    srai.w $a1, $a2, 31
; LA32NOPIC-NEXT:    move $a0, $a2
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: ldx_w:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    alsl.w $a1, $a1, $a0, 2
; LA32PIC-NEXT:    ld.w $a2, $a1, 0
; LA32PIC-NEXT:    ld.w $a0, $a0, 0
; LA32PIC-NEXT:    srai.w $a1, $a2, 31
; LA32PIC-NEXT:    move $a0, $a2
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: ldx_w:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    slli.d $a1, $a1, 2
; LA64NOPIC-NEXT:    ldx.w $a1, $a0, $a1
; LA64NOPIC-NEXT:    ld.w $a0, $a0, 0
; LA64NOPIC-NEXT:    move $a0, $a1
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: ldx_w:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    slli.d $a1, $a1, 2
; LA64PIC-NEXT:    ldx.w $a1, $a0, $a1
; LA64PIC-NEXT:    ld.w $a0, $a0, 0
; LA64PIC-NEXT:    move $a0, $a1
; LA64PIC-NEXT:    ret
  %1 = getelementptr i32, ptr %a, i64 %idx
  %2 = load i32, ptr %1
  %3 = sext i32 %2 to i64
  %4 = load volatile i32, ptr %a
  ret i64 %3
}

define i64 @ldx_d(ptr %a, i64 %idx) nounwind {
; LA32NOPIC-LABEL: ldx_d:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    alsl.w $a1, $a1, $a0, 3
; LA32NOPIC-NEXT:    ld.w $a2, $a1, 0
; LA32NOPIC-NEXT:    ld.w $a1, $a1, 4
; LA32NOPIC-NEXT:    ld.w $a3, $a0, 0
; LA32NOPIC-NEXT:    ld.w $a0, $a0, 4
; LA32NOPIC-NEXT:    move $a0, $a2
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: ldx_d:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    alsl.w $a1, $a1, $a0, 3
; LA32PIC-NEXT:    ld.w $a2, $a1, 0
; LA32PIC-NEXT:    ld.w $a1, $a1, 4
; LA32PIC-NEXT:    ld.w $a3, $a0, 0
; LA32PIC-NEXT:    ld.w $a0, $a0, 4
; LA32PIC-NEXT:    move $a0, $a2
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: ldx_d:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    slli.d $a1, $a1, 3
; LA64NOPIC-NEXT:    ldx.d $a1, $a0, $a1
; LA64NOPIC-NEXT:    ld.d $a0, $a0, 0
; LA64NOPIC-NEXT:    move $a0, $a1
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: ldx_d:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    slli.d $a1, $a1, 3
; LA64PIC-NEXT:    ldx.d $a1, $a0, $a1
; LA64PIC-NEXT:    ld.d $a0, $a0, 0
; LA64PIC-NEXT:    move $a0, $a1
; LA64PIC-NEXT:    ret
  %1 = getelementptr i64, ptr %a, i64 %idx
  %2 = load i64, ptr %1
  %3 = load volatile i64, ptr %a
  ret i64 %2
}

define i64 @ldx_bu(ptr %a, i64 %idx) nounwind {
; LA32NOPIC-LABEL: ldx_bu:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    add.w $a1, $a0, $a1
; LA32NOPIC-NEXT:    ld.bu $a1, $a1, 0
; LA32NOPIC-NEXT:    ld.bu $a0, $a0, 0
; LA32NOPIC-NEXT:    add.w $a0, $a1, $a0
; LA32NOPIC-NEXT:    sltu $a1, $a0, $a1
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: ldx_bu:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    add.w $a1, $a0, $a1
; LA32PIC-NEXT:    ld.bu $a1, $a1, 0
; LA32PIC-NEXT:    ld.bu $a0, $a0, 0
; LA32PIC-NEXT:    add.w $a0, $a1, $a0
; LA32PIC-NEXT:    sltu $a1, $a0, $a1
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: ldx_bu:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    ldx.bu $a1, $a0, $a1
; LA64NOPIC-NEXT:    ld.bu $a0, $a0, 0
; LA64NOPIC-NEXT:    add.d $a0, $a1, $a0
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: ldx_bu:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    ldx.bu $a1, $a0, $a1
; LA64PIC-NEXT:    ld.bu $a0, $a0, 0
; LA64PIC-NEXT:    add.d $a0, $a1, $a0
; LA64PIC-NEXT:    ret
  %1 = getelementptr i8, ptr %a, i64 %idx
  %2 = load i8, ptr %1
  %3 = zext i8 %2 to i64
  %4 = load volatile i8, ptr %a
  %5 = zext i8 %4 to i64
  %6 = add i64 %3, %5
  ret i64 %6
}

define i64 @ldx_hu(ptr %a, i64 %idx) nounwind {
; LA32NOPIC-LABEL: ldx_hu:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    alsl.w $a1, $a1, $a0, 1
; LA32NOPIC-NEXT:    ld.hu $a1, $a1, 0
; LA32NOPIC-NEXT:    ld.hu $a0, $a0, 0
; LA32NOPIC-NEXT:    add.w $a0, $a1, $a0
; LA32NOPIC-NEXT:    sltu $a1, $a0, $a1
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: ldx_hu:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    alsl.w $a1, $a1, $a0, 1
; LA32PIC-NEXT:    ld.hu $a1, $a1, 0
; LA32PIC-NEXT:    ld.hu $a0, $a0, 0
; LA32PIC-NEXT:    add.w $a0, $a1, $a0
; LA32PIC-NEXT:    sltu $a1, $a0, $a1
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: ldx_hu:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    slli.d $a1, $a1, 1
; LA64NOPIC-NEXT:    ldx.hu $a1, $a0, $a1
; LA64NOPIC-NEXT:    ld.hu $a0, $a0, 0
; LA64NOPIC-NEXT:    add.d $a0, $a1, $a0
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: ldx_hu:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    slli.d $a1, $a1, 1
; LA64PIC-NEXT:    ldx.hu $a1, $a0, $a1
; LA64PIC-NEXT:    ld.hu $a0, $a0, 0
; LA64PIC-NEXT:    add.d $a0, $a1, $a0
; LA64PIC-NEXT:    ret
  %1 = getelementptr i16, ptr %a, i64 %idx
  %2 = load i16, ptr %1
  %3 = zext i16 %2 to i64
  %4 = load volatile i16, ptr %a
  %5 = zext i16 %4 to i64
  %6 = add i64 %3, %5
  ret i64 %6
}

define i64 @ldx_wu(ptr %a, i64 %idx) nounwind {
; LA32NOPIC-LABEL: ldx_wu:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    alsl.w $a1, $a1, $a0, 2
; LA32NOPIC-NEXT:    ld.w $a1, $a1, 0
; LA32NOPIC-NEXT:    ld.w $a0, $a0, 0
; LA32NOPIC-NEXT:    add.w $a0, $a1, $a0
; LA32NOPIC-NEXT:    sltu $a1, $a0, $a1
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: ldx_wu:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    alsl.w $a1, $a1, $a0, 2
; LA32PIC-NEXT:    ld.w $a1, $a1, 0
; LA32PIC-NEXT:    ld.w $a0, $a0, 0
; LA32PIC-NEXT:    add.w $a0, $a1, $a0
; LA32PIC-NEXT:    sltu $a1, $a0, $a1
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: ldx_wu:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    slli.d $a1, $a1, 2
; LA64NOPIC-NEXT:    ldx.wu $a1, $a0, $a1
; LA64NOPIC-NEXT:    ld.wu $a0, $a0, 0
; LA64NOPIC-NEXT:    add.d $a0, $a1, $a0
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: ldx_wu:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    slli.d $a1, $a1, 2
; LA64PIC-NEXT:    ldx.wu $a1, $a0, $a1
; LA64PIC-NEXT:    ld.wu $a0, $a0, 0
; LA64PIC-NEXT:    add.d $a0, $a1, $a0
; LA64PIC-NEXT:    ret
  %1 = getelementptr i32, ptr %a, i64 %idx
  %2 = load i32, ptr %1
  %3 = zext i32 %2 to i64
  %4 = load volatile i32, ptr %a
  %5 = zext i32 %4 to i64
  %6 = add i64 %3, %5
  ret i64 %6
}

;; Check indexed and unindexed stores.

define void @st_b(ptr %a, i8 %b) nounwind {
; ALL-LABEL: st_b:
; ALL:       # %bb.0:
; ALL-NEXT:    st.b $a1, $a0, 0
; ALL-NEXT:    st.b $a1, $a0, 6
; ALL-NEXT:    ret
  store i8 %b, ptr %a
  %1 = getelementptr i8, ptr %a, i64 6
  store i8 %b, ptr %1
  ret void
}

define void @st_h(ptr %a, i16 %b) nounwind {
; ALL-LABEL: st_h:
; ALL:       # %bb.0:
; ALL-NEXT:    st.h $a1, $a0, 0
; ALL-NEXT:    st.h $a1, $a0, 14
; ALL-NEXT:    ret
  store i16 %b, ptr %a
  %1 = getelementptr i16, ptr %a, i64 7
  store i16 %b, ptr %1
  ret void
}

define void @st_w(ptr %a, i32 %b) nounwind {
; ALL-LABEL: st_w:
; ALL:       # %bb.0:
; ALL-NEXT:    st.w $a1, $a0, 0
; ALL-NEXT:    st.w $a1, $a0, 28
; ALL-NEXT:    ret
  store i32 %b, ptr %a
  %1 = getelementptr i32, ptr %a, i64 7
  store i32 %b, ptr %1
  ret void
}

define void @st_d(ptr %a, i64 %b) nounwind {
; LA32NOPIC-LABEL: st_d:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    st.w $a2, $a0, 4
; LA32NOPIC-NEXT:    st.w $a1, $a0, 0
; LA32NOPIC-NEXT:    st.w $a2, $a0, 68
; LA32NOPIC-NEXT:    st.w $a1, $a0, 64
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: st_d:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    st.w $a2, $a0, 4
; LA32PIC-NEXT:    st.w $a1, $a0, 0
; LA32PIC-NEXT:    st.w $a2, $a0, 68
; LA32PIC-NEXT:    st.w $a1, $a0, 64
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: st_d:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    st.d $a1, $a0, 0
; LA64NOPIC-NEXT:    st.d $a1, $a0, 64
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: st_d:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    st.d $a1, $a0, 0
; LA64PIC-NEXT:    st.d $a1, $a0, 64
; LA64PIC-NEXT:    ret
  store i64 %b, ptr %a
  %1 = getelementptr i64, ptr %a, i64 8
  store i64 %b, ptr %1
  ret void
}

define void @stx_b(ptr %dst, i64 %idx, i8 %val) nounwind {
; LA32NOPIC-LABEL: stx_b:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    add.w $a0, $a0, $a1
; LA32NOPIC-NEXT:    st.b $a3, $a0, 0
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: stx_b:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    add.w $a0, $a0, $a1
; LA32PIC-NEXT:    st.b $a3, $a0, 0
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: stx_b:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    stx.b $a2, $a0, $a1
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: stx_b:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    stx.b $a2, $a0, $a1
; LA64PIC-NEXT:    ret
  %1 = getelementptr i8, ptr %dst, i64 %idx
  store i8 %val, ptr %1
  ret void
}

define void @stx_h(ptr %dst, i64 %idx, i16 %val) nounwind {
; LA32NOPIC-LABEL: stx_h:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    alsl.w $a0, $a1, $a0, 1
; LA32NOPIC-NEXT:    st.h $a3, $a0, 0
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: stx_h:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    alsl.w $a0, $a1, $a0, 1
; LA32PIC-NEXT:    st.h $a3, $a0, 0
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: stx_h:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    slli.d $a1, $a1, 1
; LA64NOPIC-NEXT:    stx.h $a2, $a0, $a1
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: stx_h:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    slli.d $a1, $a1, 1
; LA64PIC-NEXT:    stx.h $a2, $a0, $a1
; LA64PIC-NEXT:    ret
  %1 = getelementptr i16, ptr %dst, i64 %idx
  store i16 %val, ptr %1
  ret void
}

define void @stx_w(ptr %dst, i64 %idx, i32 %val) nounwind {
; LA32NOPIC-LABEL: stx_w:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    alsl.w $a0, $a1, $a0, 2
; LA32NOPIC-NEXT:    st.w $a3, $a0, 0
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: stx_w:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    alsl.w $a0, $a1, $a0, 2
; LA32PIC-NEXT:    st.w $a3, $a0, 0
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: stx_w:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    slli.d $a1, $a1, 2
; LA64NOPIC-NEXT:    stx.w $a2, $a0, $a1
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: stx_w:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    slli.d $a1, $a1, 2
; LA64PIC-NEXT:    stx.w $a2, $a0, $a1
; LA64PIC-NEXT:    ret
  %1 = getelementptr i32, ptr %dst, i64 %idx
  store i32 %val, ptr %1
  ret void
}

define void @stx_d(ptr %dst, i64 %idx, i64 %val) nounwind {
; LA32NOPIC-LABEL: stx_d:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    alsl.w $a0, $a1, $a0, 3
; LA32NOPIC-NEXT:    st.w $a4, $a0, 4
; LA32NOPIC-NEXT:    st.w $a3, $a0, 0
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: stx_d:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    alsl.w $a0, $a1, $a0, 3
; LA32PIC-NEXT:    st.w $a4, $a0, 4
; LA32PIC-NEXT:    st.w $a3, $a0, 0
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: stx_d:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    slli.d $a1, $a1, 3
; LA64NOPIC-NEXT:    stx.d $a2, $a0, $a1
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: stx_d:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    slli.d $a1, $a1, 3
; LA64PIC-NEXT:    stx.d $a2, $a0, $a1
; LA64PIC-NEXT:    ret
  %1 = getelementptr i64, ptr %dst, i64 %idx
  store i64 %val, ptr %1
  ret void
}

;; Check load from and store to an i1 location.
define i64 @load_sext_zext_anyext_i1(ptr %a) nounwind {
; LA32NOPIC-LABEL: load_sext_zext_anyext_i1:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    ld.bu $a1, $a0, 1
; LA32NOPIC-NEXT:    ld.bu $a3, $a0, 2
; LA32NOPIC-NEXT:    sub.w $a2, $a3, $a1
; LA32NOPIC-NEXT:    ld.b $a0, $a0, 0
; LA32NOPIC-NEXT:    sltu $a0, $a3, $a1
; LA32NOPIC-NEXT:    sub.w $a1, $zero, $a0
; LA32NOPIC-NEXT:    move $a0, $a2
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: load_sext_zext_anyext_i1:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    ld.bu $a1, $a0, 1
; LA32PIC-NEXT:    ld.bu $a3, $a0, 2
; LA32PIC-NEXT:    sub.w $a2, $a3, $a1
; LA32PIC-NEXT:    ld.b $a0, $a0, 0
; LA32PIC-NEXT:    sltu $a0, $a3, $a1
; LA32PIC-NEXT:    sub.w $a1, $zero, $a0
; LA32PIC-NEXT:    move $a0, $a2
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: load_sext_zext_anyext_i1:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    ld.bu $a1, $a0, 1
; LA64NOPIC-NEXT:    ld.bu $a2, $a0, 2
; LA64NOPIC-NEXT:    ld.b $a0, $a0, 0
; LA64NOPIC-NEXT:    sub.d $a0, $a2, $a1
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: load_sext_zext_anyext_i1:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    ld.bu $a1, $a0, 1
; LA64PIC-NEXT:    ld.bu $a2, $a0, 2
; LA64PIC-NEXT:    ld.b $a0, $a0, 0
; LA64PIC-NEXT:    sub.d $a0, $a2, $a1
; LA64PIC-NEXT:    ret
  ;; sextload i1
  %1 = getelementptr i1, ptr %a, i64 1
  %2 = load i1, ptr %1
  %3 = sext i1 %2 to i64
  ;; zextload i1
  %4 = getelementptr i1, ptr %a, i64 2
  %5 = load i1, ptr %4
  %6 = zext i1 %5 to i64
  %7 = add i64 %3, %6
  ;; extload i1 (anyext). Produced as the load is unused.
  %8 = load volatile i1, ptr %a
  ret i64 %7
}

define i16 @load_sext_zext_anyext_i1_i16(ptr %a) nounwind {
; LA32NOPIC-LABEL: load_sext_zext_anyext_i1_i16:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    ld.bu $a1, $a0, 1
; LA32NOPIC-NEXT:    ld.bu $a2, $a0, 2
; LA32NOPIC-NEXT:    ld.b $a0, $a0, 0
; LA32NOPIC-NEXT:    sub.w $a0, $a2, $a1
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: load_sext_zext_anyext_i1_i16:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    ld.bu $a1, $a0, 1
; LA32PIC-NEXT:    ld.bu $a2, $a0, 2
; LA32PIC-NEXT:    ld.b $a0, $a0, 0
; LA32PIC-NEXT:    sub.w $a0, $a2, $a1
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: load_sext_zext_anyext_i1_i16:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    ld.bu $a1, $a0, 1
; LA64NOPIC-NEXT:    ld.bu $a2, $a0, 2
; LA64NOPIC-NEXT:    ld.b $a0, $a0, 0
; LA64NOPIC-NEXT:    sub.d $a0, $a2, $a1
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: load_sext_zext_anyext_i1_i16:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    ld.bu $a1, $a0, 1
; LA64PIC-NEXT:    ld.bu $a2, $a0, 2
; LA64PIC-NEXT:    ld.b $a0, $a0, 0
; LA64PIC-NEXT:    sub.d $a0, $a2, $a1
; LA64PIC-NEXT:    ret
  ;; sextload i1
  %1 = getelementptr i1, ptr %a, i64 1
  %2 = load i1, ptr %1
  %3 = sext i1 %2 to i16
  ;; zextload i1
  %4 = getelementptr i1, ptr %a, i64 2
  %5 = load i1, ptr %4
  %6 = zext i1 %5 to i16
  %7 = add i16 %3, %6
  ;; extload i1 (anyext). Produced as the load is unused.
  %8 = load volatile i1, ptr %a
  ret i16 %7
}

define i64 @ld_sd_constant(i64 %a) nounwind {
; LA32NOPIC-LABEL: ld_sd_constant:
; LA32NOPIC:       # %bb.0:
; LA32NOPIC-NEXT:    lu12i.w $a3, -136485
; LA32NOPIC-NEXT:    ori $a4, $a3, 3823
; LA32NOPIC-NEXT:    ld.w $a2, $a4, 0
; LA32NOPIC-NEXT:    ori $a5, $a3, 3827
; LA32NOPIC-NEXT:    ld.w $a3, $a5, 0
; LA32NOPIC-NEXT:    st.w $a0, $a4, 0
; LA32NOPIC-NEXT:    st.w $a1, $a5, 0
; LA32NOPIC-NEXT:    move $a0, $a2
; LA32NOPIC-NEXT:    move $a1, $a3
; LA32NOPIC-NEXT:    ret
;
; LA32PIC-LABEL: ld_sd_constant:
; LA32PIC:       # %bb.0:
; LA32PIC-NEXT:    lu12i.w $a3, -136485
; LA32PIC-NEXT:    ori $a4, $a3, 3823
; LA32PIC-NEXT:    ld.w $a2, $a4, 0
; LA32PIC-NEXT:    ori $a5, $a3, 3827
; LA32PIC-NEXT:    ld.w $a3, $a5, 0
; LA32PIC-NEXT:    st.w $a0, $a4, 0
; LA32PIC-NEXT:    st.w $a1, $a5, 0
; LA32PIC-NEXT:    move $a0, $a2
; LA32PIC-NEXT:    move $a1, $a3
; LA32PIC-NEXT:    ret
;
; LA64NOPIC-LABEL: ld_sd_constant:
; LA64NOPIC:       # %bb.0:
; LA64NOPIC-NEXT:    lu12i.w $a1, -136485
; LA64NOPIC-NEXT:    ori $a1, $a1, 3823
; LA64NOPIC-NEXT:    lu32i.d $a1, -147729
; LA64NOPIC-NEXT:    lu52i.d $a2, $a1, -534
; LA64NOPIC-NEXT:    ld.d $a1, $a2, 0
; LA64NOPIC-NEXT:    st.d $a0, $a2, 0
; LA64NOPIC-NEXT:    move $a0, $a1
; LA64NOPIC-NEXT:    ret
;
; LA64PIC-LABEL: ld_sd_constant:
; LA64PIC:       # %bb.0:
; LA64PIC-NEXT:    lu12i.w $a1, -136485
; LA64PIC-NEXT:    ori $a1, $a1, 3823
; LA64PIC-NEXT:    lu32i.d $a1, -147729
; LA64PIC-NEXT:    lu52i.d $a2, $a1, -534
; LA64PIC-NEXT:    ld.d $a1, $a2, 0
; LA64PIC-NEXT:    st.d $a0, $a2, 0
; LA64PIC-NEXT:    move $a0, $a1
; LA64PIC-NEXT:    ret
  %1 = inttoptr i64 16045690984833335023 to ptr
  %2 = load volatile i64, ptr %1
  store i64 %a, ptr %1
  ret i64 %2
}

;; Check load from and store to a float location.
define float @load_store_float(ptr %a, float %b) nounwind {
; ALL-LABEL: load_store_float:
; ALL:       # %bb.0:
; ALL-NEXT:    fld.s $fa1, $a0, 4
; ALL-NEXT:    fst.s $fa0, $a0, 4
; ALL-NEXT:    fmov.s $fa0, $fa1
; ALL-NEXT:    ret
  %1 = getelementptr float, ptr %a, i64 1
  %2 = load float, ptr %1
  store float %b, ptr %1
  ret float %2
}

;; Check load from and store to a double location.
define double @load_store_double(ptr %a, double %b) nounwind {
; ALL-LABEL: load_store_double:
; ALL:       # %bb.0:
; ALL-NEXT:    fld.d $fa1, $a0, 8
; ALL-NEXT:    fst.d $fa0, $a0, 8
; ALL-NEXT:    fmov.d $fa0, $fa1
; ALL-NEXT:    ret
  %1 = getelementptr double, ptr %a, i64 1
  %2 = load double, ptr %1
  store double %b, ptr %1
  ret double %2
}
