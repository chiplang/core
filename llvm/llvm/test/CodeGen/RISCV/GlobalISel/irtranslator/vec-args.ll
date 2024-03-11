; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v,+experimental-zvfbfmin,+zvfh -global-isel -stop-after=irtranslator \
; RUN:   -verify-machineinstrs < %s | FileCheck -check-prefixes=RV32 %s
; RUN: llc -mtriple=riscv64 -mattr=+v,+experimental-zvfbfmin,+zvfh -global-isel -stop-after=irtranslator \
; RUN:   -verify-machineinstrs < %s | FileCheck -check-prefixes=RV64 %s

; ==========================================================================
; ============================= Scalable Types =============================
; ==========================================================================

define void @test_args_nxv1i8(<vscale x 1 x i8> %a) {
  ; RV32-LABEL: name: test_args_nxv1i8
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s8>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv1i8
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s8>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv2i8(<vscale x 2 x i8> %a) {
  ; RV32-LABEL: name: test_args_nxv2i8
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s8>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv2i8
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s8>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv4i8(<vscale x 4 x i8> %a) {
  ; RV32-LABEL: name: test_args_nxv4i8
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s8>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv4i8
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s8>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv8i8(<vscale x 8 x i8> %a) {
  ; RV32-LABEL: name: test_args_nxv8i8
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 8 x s8>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv8i8
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 8 x s8>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv16i8(<vscale x 16 x i8> %a) {
  ; RV32-LABEL: name: test_args_nxv16i8
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m2
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 16 x s8>) = COPY $v8m2
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv16i8
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m2
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 16 x s8>) = COPY $v8m2
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv32i8(<vscale x 32 x i8> %a) {
  ; RV32-LABEL: name: test_args_nxv32i8
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m4
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 32 x s8>) = COPY $v8m4
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv32i8
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m4
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 32 x s8>) = COPY $v8m4
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv64i8(<vscale x 64 x i8> %a) {
  ; RV32-LABEL: name: test_args_nxv64i8
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 64 x s8>) = COPY $v8m8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv64i8
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 64 x s8>) = COPY $v8m8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv1i16(<vscale x 1 x i16> %a) {
  ; RV32-LABEL: name: test_args_nxv1i16
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s16>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv1i16
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s16>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv2i16(<vscale x 2 x i16> %a) {
  ; RV32-LABEL: name: test_args_nxv2i16
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s16>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv2i16
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s16>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv4i16(<vscale x 4 x i16> %a) {
  ; RV32-LABEL: name: test_args_nxv4i16
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s16>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv4i16
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s16>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv8i16(<vscale x 8 x i16> %a) {
  ; RV32-LABEL: name: test_args_nxv8i16
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m2
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 8 x s16>) = COPY $v8m2
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv8i16
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m2
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 8 x s16>) = COPY $v8m2
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv16i16(<vscale x 16 x i16> %a) {
  ; RV32-LABEL: name: test_args_nxv16i16
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m4
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 16 x s16>) = COPY $v8m4
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv16i16
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m4
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 16 x s16>) = COPY $v8m4
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv32i16(<vscale x 32 x i16> %a) {
  ; RV32-LABEL: name: test_args_nxv32i16
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 32 x s16>) = COPY $v8m8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv32i16
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 32 x s16>) = COPY $v8m8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv1i32(<vscale x 1 x i32> %a) {
  ; RV32-LABEL: name: test_args_nxv1i32
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s32>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv1i32
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s32>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv2i32(<vscale x 2 x i32> %a) {
  ; RV32-LABEL: name: test_args_nxv2i32
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s32>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv2i32
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s32>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv4i32(<vscale x 4 x i32> %a) {
  ; RV32-LABEL: name: test_args_nxv4i32
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m2
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s32>) = COPY $v8m2
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv4i32
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m2
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s32>) = COPY $v8m2
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv8i32(<vscale x 8 x i32> %a) {
  ; RV32-LABEL: name: test_args_nxv8i32
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m4
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 8 x s32>) = COPY $v8m4
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv8i32
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m4
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 8 x s32>) = COPY $v8m4
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv16i32(<vscale x 16 x i32> %a) {
  ; RV32-LABEL: name: test_args_nxv16i32
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 16 x s32>) = COPY $v8m8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv16i32
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 16 x s32>) = COPY $v8m8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv1i64(<vscale x 1 x i64> %a) {
  ; RV32-LABEL: name: test_args_nxv1i64
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s64>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv1i64
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s64>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv2i64(<vscale x 2 x i64> %a) {
  ; RV32-LABEL: name: test_args_nxv2i64
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m2
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s64>) = COPY $v8m2
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv2i64
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m2
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s64>) = COPY $v8m2
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv4i64(<vscale x 4 x i64> %a) {
  ; RV32-LABEL: name: test_args_nxv4i64
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m4
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s64>) = COPY $v8m4
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv4i64
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m4
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s64>) = COPY $v8m4
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv8i64(<vscale x 8 x i64> %a) {
  ; RV32-LABEL: name: test_args_nxv8i64
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 8 x s64>) = COPY $v8m8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv8i64
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 8 x s64>) = COPY $v8m8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv64i1(<vscale x 64 x i1> %a) {
  ; RV32-LABEL: name: test_args_nxv64i1
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v0
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 64 x s1>) = COPY $v0
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv64i1
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v0
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 64 x s1>) = COPY $v0
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv32i1(<vscale x 32 x i1> %a) {
  ; RV32-LABEL: name: test_args_nxv32i1
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v0
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 32 x s1>) = COPY $v0
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv32i1
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v0
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 32 x s1>) = COPY $v0
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv16i1(<vscale x 16 x i1> %a) {
  ; RV32-LABEL: name: test_args_nxv16i1
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v0
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 16 x s1>) = COPY $v0
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv16i1
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v0
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 16 x s1>) = COPY $v0
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv8i1(<vscale x 8 x i1> %a) {
  ; RV32-LABEL: name: test_args_nxv8i1
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v0
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 8 x s1>) = COPY $v0
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv8i1
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v0
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 8 x s1>) = COPY $v0
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv4i1(<vscale x 4 x i1> %a) {
  ; RV32-LABEL: name: test_args_nxv4i1
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v0
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s1>) = COPY $v0
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv4i1
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v0
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s1>) = COPY $v0
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv2i1(<vscale x 2 x i1> %a) {
  ; RV32-LABEL: name: test_args_nxv2i1
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v0
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s1>) = COPY $v0
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv2i1
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v0
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s1>) = COPY $v0
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv1i1(<vscale x 1 x i1> %a) {
  ; RV32-LABEL: name: test_args_nxv1i1
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v0
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s1>) = COPY $v0
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv1i1
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v0
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s1>) = COPY $v0
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv1f32(<vscale x 1 x float> %a) {
  ; RV32-LABEL: name: test_args_nxv1f32
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s32>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv1f32
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s32>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv2f32(<vscale x 2 x float> %a) {
  ; RV32-LABEL: name: test_args_nxv2f32
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s32>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv2f32
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s32>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv4f32(<vscale x 4 x float> %a) {
  ; RV32-LABEL: name: test_args_nxv4f32
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m2
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s32>) = COPY $v8m2
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv4f32
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m2
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s32>) = COPY $v8m2
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv8f32(<vscale x 8 x float> %a) {
  ; RV32-LABEL: name: test_args_nxv8f32
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m4
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 8 x s32>) = COPY $v8m4
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv8f32
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m4
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 8 x s32>) = COPY $v8m4
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv16f32(<vscale x 16 x float> %a) {
  ; RV32-LABEL: name: test_args_nxv16f32
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 16 x s32>) = COPY $v8m8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv16f32
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 16 x s32>) = COPY $v8m8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv1f64(<vscale x 1 x double> %a) {
  ; RV32-LABEL: name: test_args_nxv1f64
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s64>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv1f64
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s64>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv2f64(<vscale x 2 x double> %a) {
  ; RV32-LABEL: name: test_args_nxv2f64
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m2
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s64>) = COPY $v8m2
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv2f64
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m2
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s64>) = COPY $v8m2
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv4f64(<vscale x 4 x double> %a) {
  ; RV32-LABEL: name: test_args_nxv4f64
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m4
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s64>) = COPY $v8m4
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv4f64
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m4
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s64>) = COPY $v8m4
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv8f64(<vscale x 8 x double> %a) {
  ; RV32-LABEL: name: test_args_nxv8f64
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 8 x s64>) = COPY $v8m8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv8f64
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 8 x s64>) = COPY $v8m8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv1f16(<vscale x 1 x half> %a) {
  ; RV32-LABEL: name: test_args_nxv1f16
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s16>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv1f16
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s16>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv2f16(<vscale x 2 x half> %a) {
  ; RV32-LABEL: name: test_args_nxv2f16
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s16>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv2f16
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s16>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv4f16(<vscale x 4 x half> %a) {
  ; RV32-LABEL: name: test_args_nxv4f16
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s16>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv4f16
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s16>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv8f16(<vscale x 8 x half> %a) {
  ; RV32-LABEL: name: test_args_nxv8f16
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m2
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 8 x s16>) = COPY $v8m2
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv8f16
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m2
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 8 x s16>) = COPY $v8m2
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv16f16(<vscale x 16 x half> %a) {
  ; RV32-LABEL: name: test_args_nxv16f16
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m4
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 16 x s16>) = COPY $v8m4
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv16f16
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m4
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 16 x s16>) = COPY $v8m4
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv32f16(<vscale x 32 x half> %a) {
  ; RV32-LABEL: name: test_args_nxv32f16
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 32 x s16>) = COPY $v8m8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv32f16
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 32 x s16>) = COPY $v8m8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv1b16(<vscale x 1 x bfloat> %a) {
  ; RV32-LABEL: name: test_args_nxv1b16
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s16>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv1b16
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s16>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv2b16(<vscale x 2 x bfloat> %a) {
  ; RV32-LABEL: name: test_args_nxv2b16
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s16>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv2b16
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 2 x s16>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv4b16(<vscale x 4 x bfloat> %a) {
  ; RV32-LABEL: name: test_args_nxv4b16
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s16>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv4b16
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 4 x s16>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv8b16(<vscale x 8 x bfloat> %a) {
  ; RV32-LABEL: name: test_args_nxv8b16
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m2
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 8 x s16>) = COPY $v8m2
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv8b16
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m2
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 8 x s16>) = COPY $v8m2
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv16b16(<vscale x 16 x bfloat> %a) {
  ; RV32-LABEL: name: test_args_nxv16b16
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m4
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 16 x s16>) = COPY $v8m4
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv16b16
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m4
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 16 x s16>) = COPY $v8m4
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv32b16(<vscale x 32 x bfloat> %a) {
  ; RV32-LABEL: name: test_args_nxv32b16
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v8m8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 32 x s16>) = COPY $v8m8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv32b16
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v8m8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 32 x s16>) = COPY $v8m8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv1i1_nxv1i1(<vscale x 1 x i1> %a, <vscale x 1 x i1> %b) {
  ; RV32-LABEL: name: test_args_nxv1i1_nxv1i1
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v0, $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s1>) = COPY $v0
  ; RV32-NEXT:   [[COPY1:%[0-9]+]]:_(<vscale x 1 x s1>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv1i1_nxv1i1
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v0, $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s1>) = COPY $v0
  ; RV64-NEXT:   [[COPY1:%[0-9]+]]:_(<vscale x 1 x s1>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv1i1_nxv1i32(<vscale x 1 x i1> %a, <vscale x 1 x i32> %b) {
  ; RV32-LABEL: name: test_args_nxv1i1_nxv1i32
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v0, $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s1>) = COPY $v0
  ; RV32-NEXT:   [[COPY1:%[0-9]+]]:_(<vscale x 1 x s32>) = COPY $v8
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv1i1_nxv1i32
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v0, $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s1>) = COPY $v0
  ; RV64-NEXT:   [[COPY1:%[0-9]+]]:_(<vscale x 1 x s32>) = COPY $v8
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}

define void @test_args_nxv1i32_nxv1i1(<vscale x 1 x i32> %a, <vscale x 1 x i1> %b) {
  ; RV32-LABEL: name: test_args_nxv1i32_nxv1i1
  ; RV32: bb.1.entry:
  ; RV32-NEXT:   liveins: $v0, $v8
  ; RV32-NEXT: {{  $}}
  ; RV32-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s32>) = COPY $v8
  ; RV32-NEXT:   [[COPY1:%[0-9]+]]:_(<vscale x 1 x s1>) = COPY $v0
  ; RV32-NEXT:   PseudoRET
  ;
  ; RV64-LABEL: name: test_args_nxv1i32_nxv1i1
  ; RV64: bb.1.entry:
  ; RV64-NEXT:   liveins: $v0, $v8
  ; RV64-NEXT: {{  $}}
  ; RV64-NEXT:   [[COPY:%[0-9]+]]:_(<vscale x 1 x s32>) = COPY $v8
  ; RV64-NEXT:   [[COPY1:%[0-9]+]]:_(<vscale x 1 x s1>) = COPY $v0
  ; RV64-NEXT:   PseudoRET
entry:
  ret void
}
