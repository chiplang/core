; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=aarch64 -mattr=+v8.9a -mattr=+sve -mattr=+rcpc3 < %s | FileCheck %s
; RUN: llc -mtriple=aarch64 -mattr=+v8.9a -mattr=+sve < %s | FileCheck %s

; Show what happens with RCPC3 for extract/insert into SVE vectors.
; Currently there is no RCPC3 codegen expected for this.

define hidden <vscale x 2 x i64> @test_load_sve_lane0(ptr nocapture noundef readonly %a, <vscale x 2 x i64> noundef %b) local_unnamed_addr {
; CHECK-LABEL: test_load_sve_lane0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl1
; CHECK-NEXT:    ldapr x8, [x0]
; CHECK-NEXT:    mov z0.d, p0/m, x8
; CHECK-NEXT:    ret
  %1 = load atomic i64, ptr %a acquire, align 8
  %vldap1_lane = insertelement <vscale x 2 x i64> %b, i64 %1, i64 0
  ret <vscale x 2 x i64> %vldap1_lane
}

define hidden <vscale x 2 x i64> @test_load_sve_lane1(ptr nocapture noundef readonly %a, <vscale x 2 x i64> noundef %b) local_unnamed_addr {
; CHECK-LABEL: test_load_sve_lane1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mov w8, #1 // =0x1
; CHECK-NEXT:    index z1.d, #0, #1
; CHECK-NEXT:    mov z2.d, x8
; CHECK-NEXT:    ldapr x8, [x0]
; CHECK-NEXT:    cmpeq p0.d, p0/z, z1.d, z2.d
; CHECK-NEXT:    mov z0.d, p0/m, x8
; CHECK-NEXT:    ret
  %1 = load atomic i64, ptr %a acquire, align 8
  %vldap1_lane = insertelement <vscale x 2 x i64> %b, i64 %1, i64 1
  ret <vscale x 2 x i64> %vldap1_lane
}

define hidden void @test_store_sve_lane0(ptr nocapture noundef writeonly %a, <vscale x 2 x i64> noundef %b) local_unnamed_addr {
; CHECK-LABEL: test_store_sve_lane0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov x8, d0
; CHECK-NEXT:    stlr x8, [x0]
; CHECK-NEXT:    ret
  %1 = extractelement <vscale x 2 x i64> %b, i64 0
  store atomic i64 %1, ptr %a release, align 8
  ret void
}

define hidden void @test_store_sve_lane1(ptr nocapture noundef writeonly %a, <vscale x 2 x i64> noundef %b) local_unnamed_addr {
; CHECK-LABEL: test_store_sve_lane1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, v0.d[1]
; CHECK-NEXT:    stlr x8, [x0]
; CHECK-NEXT:    ret
  %1 = extractelement <vscale x 2 x i64> %b, i64 1
  store atomic i64 %1, ptr %a release, align 8
  ret void
}
