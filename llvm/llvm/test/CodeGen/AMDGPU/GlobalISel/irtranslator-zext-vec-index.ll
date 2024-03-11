; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -mtriple=amdgcn -O0 -stop-after=irtranslator -global-isel -verify-machineinstrs %s -o - | FileCheck %s

define i8 @f_i1_1() {
  ; CHECK-LABEL: name: f_i1_1
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:_(<256 x s8>) = G_IMPLICIT_DEF
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 1
  ; CHECK-NEXT:   [[EVEC:%[0-9]+]]:_(s8) = G_EXTRACT_VECTOR_ELT [[DEF]](<256 x s8>), [[C]](s32)
  ; CHECK-NEXT:   [[ANYEXT:%[0-9]+]]:_(s32) = G_ANYEXT [[EVEC]](s8)
  ; CHECK-NEXT:   $vgpr0 = COPY [[ANYEXT]](s32)
  ; CHECK-NEXT:   SI_RETURN implicit $vgpr0
  %E1 = extractelement <256 x i8> undef, i1 true
  ret i8 %E1
}

define i8 @f_i8_255() {
  ; CHECK-LABEL: name: f_i8_255
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:_(<256 x s8>) = G_IMPLICIT_DEF
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 255
  ; CHECK-NEXT:   [[EVEC:%[0-9]+]]:_(s8) = G_EXTRACT_VECTOR_ELT [[DEF]](<256 x s8>), [[C]](s32)
  ; CHECK-NEXT:   [[ANYEXT:%[0-9]+]]:_(s32) = G_ANYEXT [[EVEC]](s8)
  ; CHECK-NEXT:   $vgpr0 = COPY [[ANYEXT]](s32)
  ; CHECK-NEXT:   SI_RETURN implicit $vgpr0
  %E1 = extractelement <256 x i8> undef, i8 255
  ret i8 %E1
}
