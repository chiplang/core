// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 2
// REQUIRES: amdgpu-registered-target

// RUN: %clang_cc1 -triple amdgcn-unknown-unknown -target-cpu gfx803 -S -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple amdgcn-unknown-unknown -target-cpu gfx906 -S -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple amdgcn-unknown-unknown -target-cpu gfx90a -S -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple amdgcn-unknown-unknown -target-cpu gfx90c -S -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple amdgcn-unknown-unknown -target-cpu gfx940 -S -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple amdgcn-unknown-unknown -target-cpu gfx1010 -S -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple amdgcn-unknown-unknown -target-cpu gfx1030 -S -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple amdgcn-unknown-unknown -target-cpu gfx1100 -S -emit-llvm -o - %s | FileCheck %s

typedef unsigned int uint;

// CHECK-LABEL: define dso_local amdgpu_kernel void @test_builtins_amdgcn_gws_insts
// CHECK-SAME: (i32 noundef [[A:%.*]], i32 noundef [[B:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    tail call void @llvm.amdgcn.ds.gws.init(i32 [[A]], i32 [[B]])
// CHECK-NEXT:    tail call void @llvm.amdgcn.ds.gws.barrier(i32 [[A]], i32 [[B]])
// CHECK-NEXT:    tail call void @llvm.amdgcn.ds.gws.sema.v(i32 [[A]])
// CHECK-NEXT:    tail call void @llvm.amdgcn.ds.gws.sema.br(i32 [[A]], i32 [[B]])
// CHECK-NEXT:    tail call void @llvm.amdgcn.ds.gws.sema.p(i32 [[A]])
// CHECK-NEXT:    ret void
//
kernel void test_builtins_amdgcn_gws_insts(uint a, uint b) {
  __builtin_amdgcn_ds_gws_init(a, b);
  __builtin_amdgcn_ds_gws_barrier(a, b);
  __builtin_amdgcn_ds_gws_sema_v(a);
  __builtin_amdgcn_ds_gws_sema_br(a, b);
  __builtin_amdgcn_ds_gws_sema_p(a);
}
