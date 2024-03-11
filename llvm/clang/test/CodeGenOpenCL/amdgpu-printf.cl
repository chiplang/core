// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -cl-std=CL1.2 -triple amdgcn-amd-amdhsa -disable-llvm-passes -emit-llvm -o - %s | FileCheck %s

int printf(__constant const char* st, ...) __attribute__((format(printf, 1, 2)));

// CHECK-LABEL: @test_printf_noargs(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[CALL:%.*]] = call i32 (ptr addrspace(4), ...) @printf(ptr addrspace(4) noundef @.str) #[[ATTR4:[0-9]+]]
// CHECK-NEXT:    ret void
//
__kernel void test_printf_noargs() {
    printf("");
}

// CHECK-LABEL: @test_printf_int(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[I_ADDR:%.*]] = alloca i32, align 4, addrspace(5)
// CHECK-NEXT:    store i32 [[I:%.*]], ptr addrspace(5) [[I_ADDR]], align 4, !tbaa [[TBAA8:![0-9]+]]
// CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr addrspace(5) [[I_ADDR]], align 4, !tbaa [[TBAA8]]
// CHECK-NEXT:    [[CALL:%.*]] = call i32 (ptr addrspace(4), ...) @printf(ptr addrspace(4) noundef @.str.1, i32 noundef [[TMP0]]) #[[ATTR4]]
// CHECK-NEXT:    ret void
//
__kernel void test_printf_int(int i) {
    printf("%d", i);
}

// CHECK-LABEL: @test_printf_str_int(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[I_ADDR:%.*]] = alloca i32, align 4, addrspace(5)
// CHECK-NEXT:    [[S:%.*]] = alloca [4 x i8], align 1, addrspace(5)
// CHECK-NEXT:    store i32 [[I:%.*]], ptr addrspace(5) [[I_ADDR]], align 4, !tbaa [[TBAA8]]
// CHECK-NEXT:    call void @llvm.lifetime.start.p5(i64 4, ptr addrspace(5) [[S]]) #[[ATTR5:[0-9]+]]
// CHECK-NEXT:    [[LOC0:%.*]] = getelementptr i8, ptr addrspace(5) [[S]], i64 0
// CHECK-NEXT:    store i8 102, ptr addrspace(5) [[LOC0]], align 1
// CHECK-NEXT:    [[LOC1:%.*]] = getelementptr i8, ptr addrspace(5) [[S]], i64 1
// CHECK-NEXT:    store i8 111, ptr addrspace(5) [[LOC1]], align 1
// CHECK-NEXT:    [[LOC2:%.*]] = getelementptr i8, ptr addrspace(5) [[S]], i64 2
// CHECK-NEXT:    store i8 111, ptr addrspace(5) [[LOC2]], align 1
// CHECK-NEXT:    [[LOC3:%.*]] = getelementptr i8, ptr addrspace(5) [[S]], i64 3
// CHECK-NEXT:    store i8 0, ptr addrspace(5) [[LOC3]], align 1
// CHECK-NEXT:    [[ARRAYDECAY:%.*]] = getelementptr inbounds [4 x i8], ptr addrspace(5) [[S]], i64 0, i64 0
// CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr addrspace(5) [[I_ADDR]], align 4, !tbaa [[TBAA8]]
// CHECK-NEXT:    [[CALL:%.*]] = call i32 (ptr addrspace(4), ...) @printf(ptr addrspace(4) noundef @.str.2, ptr addrspace(5) noundef [[ARRAYDECAY]], i32 noundef [[TMP2]]) #[[ATTR4]]
// CHECK-NEXT:    call void @llvm.lifetime.end.p5(i64 4, ptr addrspace(5) [[S]]) #[[ATTR5]]
// CHECK-NEXT:    ret void
//
__kernel void test_printf_str_int(int i) {
    char s[] = "foo";
    printf("%s:%d", s, i);
}
