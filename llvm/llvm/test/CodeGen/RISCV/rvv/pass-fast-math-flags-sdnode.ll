; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc < %s -mtriple=riscv64 -mattr=+v -stop-after=finalize-isel | FileCheck %s

declare <vscale x 1 x double> @llvm.vp.fmul.nxv1f64(<vscale x 1 x double> %x, <vscale x 1 x double> %y, <vscale x 1 x i1> %m, i32 %vl)

define <vscale x 1 x double> @foo(<vscale x 1 x double> %x, <vscale x 1 x double> %y, <vscale x 1 x double> %z, <vscale x 1 x i1> %m, i32 %vl) {
  ; CHECK-LABEL: name: foo
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $v8, $v9, $v0, $x10
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:gpr = COPY $x10
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:vr = COPY $v0
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:vr = COPY $v9
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:vr = COPY $v8
  ; CHECK-NEXT:   [[SLLI:%[0-9]+]]:gpr = SLLI [[COPY]], 32
  ; CHECK-NEXT:   [[SRLI:%[0-9]+]]:gprnox0 = SRLI killed [[SLLI]], 32
  ; CHECK-NEXT:   $v0 = COPY [[COPY1]]
  ; CHECK-NEXT:   [[PseudoVFMUL_VV_M1_MASK:%[0-9]+]]:vrnov0 = nnan ninf nsz arcp contract afn reassoc nofpexcept PseudoVFMUL_VV_M1_MASK $noreg, [[COPY3]], [[COPY2]], $v0, 7, killed [[SRLI]], 6 /* e64 */, 1 /* ta, mu */, implicit $frm
  ; CHECK-NEXT:   $v8 = COPY [[PseudoVFMUL_VV_M1_MASK]]
  ; CHECK-NEXT:   PseudoRET implicit $v8
  %1 = call fast <vscale x 1 x double> @llvm.vp.fmul.nxv1f64(<vscale x 1 x double> %x, <vscale x 1 x double> %y, <vscale x 1 x i1> %m, i32 %vl)
  ret <vscale x 1 x double> %1
}
