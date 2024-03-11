// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --check-globals --version 3
// RUN: %clang_cc1 -fsycl-is-device -emit-llvm -disable-llvm-passes \
// RUN:  -triple spir64 -fexceptions -emit-llvm -fno-ident %s -o - | FileCheck %s

int foo();

// CHECK-LABEL: define dso_local spir_func void @_Z3barv(
// CHECK-SAME: ) #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[A_ASCAST:%.*]] = addrspacecast ptr [[A]] to ptr addrspace(4)
// CHECK-NEXT:    [[CALL:%.*]] = call spir_func noundef i32 @_Z3foov() #[[ATTR1:[0-9]+]]
// CHECK-NEXT:    store i32 [[CALL]], ptr addrspace(4) [[A_ASCAST]], align 4
// CHECK-NEXT:    ret void
//
void bar() {
  int a = foo();
}

// CHECK-LABEL: define dso_local spir_func noundef i32 @_Z3foov(
// CHECK-SAME: ) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[RETVAL:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[RETVAL_ASCAST:%.*]] = addrspacecast ptr [[RETVAL]] to ptr addrspace(4)
// CHECK-NEXT:    ret i32 1
//
int foo() {
  return 1;
}

template <typename Name, typename Func>
__attribute__((sycl_kernel)) void kernel_single_task(const Func &kernelFunc) {
  kernelFunc();
}

// CHECK-LABEL: define dso_local noundef i32 @main(
// CHECK-SAME: ) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[RETVAL:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[REF_TMP:%.*]] = alloca [[CLASS_ANON:%.*]], align 1
// CHECK-NEXT:    [[RETVAL_ASCAST:%.*]] = addrspacecast ptr [[RETVAL]] to ptr addrspace(4)
// CHECK-NEXT:    [[REF_TMP_ASCAST:%.*]] = addrspacecast ptr [[REF_TMP]] to ptr addrspace(4)
// CHECK-NEXT:    store i32 0, ptr addrspace(4) [[RETVAL_ASCAST]], align 4
// CHECK-NEXT:    call spir_func void @_Z18kernel_single_taskIZ4mainE11fake_kernelZ4mainEUlvE_EvRKT0_(ptr addrspace(4) noundef align 1 dereferenceable(1) [[REF_TMP_ASCAST]]) #[[ATTR1]]
// CHECK-NEXT:    ret i32 0
//
int main() {
  kernel_single_task<class fake_kernel>([] { bar(); });
  return 0;
}
//.
// CHECK: attributes #0 = { convergent mustprogress noinline norecurse nounwind optnone "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
// CHECK: attributes #1 = { convergent nounwind }
//.
// CHECK: !0 = !{i32 1, !"wchar_size", i32 4}
//.
