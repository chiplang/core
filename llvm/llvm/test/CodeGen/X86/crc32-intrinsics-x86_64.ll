; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mattr=+crc32 -show-mc-encoding | FileCheck %s
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mattr=+crc32,+egpr -show-mc-encoding | FileCheck %s --check-prefixes=EGPR

declare i64 @llvm.x86.sse42.crc32.64.8(i64, i8) nounwind
declare i64 @llvm.x86.sse42.crc32.64.64(i64, i64) nounwind

define i64 @crc32_64_8(i64 %a, i8 %b) nounwind {
; CHECK-LABEL: crc32_64_8:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movq %rdi, %rax ## encoding: [0x48,0x89,0xf8]
; CHECK-NEXT:    crc32b %sil, %eax ## encoding: [0xf2,0x40,0x0f,0x38,0xf0,0xc6]
; CHECK-NEXT:    retq ## encoding: [0xc3]
;
; EGPR-LABEL: crc32_64_8:
; EGPR:       ## %bb.0:
; EGPR-NEXT:    movq %rdi, %rax ## encoding: [0x48,0x89,0xf8]
; EGPR-NEXT:    crc32b %sil, %eax ## EVEX TO LEGACY Compression encoding: [0xf2,0x40,0x0f,0x38,0xf0,0xc6]
; EGPR-NEXT:    retq ## encoding: [0xc3]
  %tmp = call i64 @llvm.x86.sse42.crc32.64.8(i64 %a, i8 %b)
  ret i64 %tmp
}

define i64 @crc32_64_64(i64 %a, i64 %b) nounwind {
; CHECK-LABEL: crc32_64_64:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movq %rdi, %rax ## encoding: [0x48,0x89,0xf8]
; CHECK-NEXT:    crc32q %rsi, %rax ## encoding: [0xf2,0x48,0x0f,0x38,0xf1,0xc6]
; CHECK-NEXT:    retq ## encoding: [0xc3]
;
; EGPR-LABEL: crc32_64_64:
; EGPR:       ## %bb.0:
; EGPR-NEXT:    movq %rdi, %rax ## encoding: [0x48,0x89,0xf8]
; EGPR-NEXT:    crc32q %rsi, %rax ## EVEX TO LEGACY Compression encoding: [0xf2,0x48,0x0f,0x38,0xf1,0xc6]
; EGPR-NEXT:    retq ## encoding: [0xc3]
  %tmp = call i64 @llvm.x86.sse42.crc32.64.64(i64 %a, i64 %b)
  ret i64 %tmp
}
