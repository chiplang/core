// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --function-signature --include-generated-funcs --replace-value-regex "__omp_offloading_[0-9a-z]+_[0-9a-z]+" "reduction_size[.].+[.]" "pl_cond[.].+[.|,]" --prefix-filecheck-ir-name _
// add -fopenmp-targets

// RUN: %clang_cc1 -verify -fopenmp -fopenmp-version=45 -x c++ -std=c++11 -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -emit-llvm %s -o - | FileCheck %s --check-prefix=CHECK1
// RUN: %clang_cc1 -fopenmp -x c++ -std=c++11 -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -emit-pch -o %t %s
// RUN: %clang_cc1 -fopenmp -x c++ -std=c++11 -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -include-pch %t -verify %s -emit-llvm -o - | FileCheck %s --check-prefix=CHECK1

// RUN: %clang_cc1 -verify -fopenmp-simd -fopenmp-version=45 -x c++ -std=c++11 -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -emit-llvm %s -o - | FileCheck %s --implicit-check-not="{{__kmpc|__tgt}}"
// RUN: %clang_cc1 -fopenmp-simd -x c++ -std=c++11 -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -emit-pch -o %t %s
// RUN: %clang_cc1 -fopenmp-simd -x c++ -std=c++11 -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -include-pch %t -verify %s -emit-llvm -o - | FileCheck %s --implicit-check-not="{{__kmpc|__tgt}}"
// expected-no-diagnostics
#ifndef HEADER
#define HEADER

typedef __INTPTR_TYPE__ intptr_t;


void foo();

struct S {
  intptr_t a, b, c;
  S(intptr_t a) : a(a) {}
  operator char() { return a; }
  ~S() {}
};

template <typename T>
T tmain() {
#pragma omp target
#pragma omp teams
#pragma omp distribute parallel for proc_bind(master)
  for(int i = 0; i < 1000; i++) {}
  return T();
}

int main() {
#pragma omp target
#pragma omp teams
#pragma omp distribute parallel for proc_bind(spread)
  for(int i = 0; i < 1000; i++) {}
#pragma omp target
#pragma omp teams
#pragma omp distribute parallel for proc_bind(close)
  for(int i = 0; i < 1000; i++) {}
  return tmain<int>();
}








#endif
// CHECK1-LABEL: define {{[^@]+}}@main
// CHECK1-SAME: () #[[ATTR0:[0-9]+]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[RETVAL:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[TMP:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[KERNEL_ARGS:%.*]] = alloca [[STRUCT___TGT_KERNEL_ARGUMENTS:%.*]], align 8
// CHECK1-NEXT:    [[_TMP1:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[KERNEL_ARGS2:%.*]] = alloca [[STRUCT___TGT_KERNEL_ARGUMENTS]], align 8
// CHECK1-NEXT:    store i32 0, ptr [[RETVAL]], align 4
// CHECK1-NEXT:    [[TMP0:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 0
// CHECK1-NEXT:    store i32 2, ptr [[TMP0]], align 4
// CHECK1-NEXT:    [[TMP1:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 1
// CHECK1-NEXT:    store i32 0, ptr [[TMP1]], align 4
// CHECK1-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 2
// CHECK1-NEXT:    store ptr null, ptr [[TMP2]], align 8
// CHECK1-NEXT:    [[TMP3:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 3
// CHECK1-NEXT:    store ptr null, ptr [[TMP3]], align 8
// CHECK1-NEXT:    [[TMP4:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 4
// CHECK1-NEXT:    store ptr null, ptr [[TMP4]], align 8
// CHECK1-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 5
// CHECK1-NEXT:    store ptr null, ptr [[TMP5]], align 8
// CHECK1-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 6
// CHECK1-NEXT:    store ptr null, ptr [[TMP6]], align 8
// CHECK1-NEXT:    [[TMP7:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 7
// CHECK1-NEXT:    store ptr null, ptr [[TMP7]], align 8
// CHECK1-NEXT:    [[TMP8:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 8
// CHECK1-NEXT:    store i64 1000, ptr [[TMP8]], align 8
// CHECK1-NEXT:    [[TMP9:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 9
// CHECK1-NEXT:    store i64 0, ptr [[TMP9]], align 8
// CHECK1-NEXT:    [[TMP10:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 10
// CHECK1-NEXT:    store [3 x i32] zeroinitializer, ptr [[TMP10]], align 4
// CHECK1-NEXT:    [[TMP11:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 11
// CHECK1-NEXT:    store [3 x i32] zeroinitializer, ptr [[TMP11]], align 4
// CHECK1-NEXT:    [[TMP12:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 12
// CHECK1-NEXT:    store i32 0, ptr [[TMP12]], align 4
// CHECK1-NEXT:    [[TMP13:%.*]] = call i32 @__tgt_target_kernel(ptr @[[GLOB3:[0-9]+]], i64 -1, i32 0, i32 0, ptr @.{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l37.region_id, ptr [[KERNEL_ARGS]])
// CHECK1-NEXT:    [[TMP14:%.*]] = icmp ne i32 [[TMP13]], 0
// CHECK1-NEXT:    br i1 [[TMP14]], label [[OMP_OFFLOAD_FAILED:%.*]], label [[OMP_OFFLOAD_CONT:%.*]]
// CHECK1:       omp_offload.failed:
// CHECK1-NEXT:    call void @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l37() #[[ATTR2:[0-9]+]]
// CHECK1-NEXT:    br label [[OMP_OFFLOAD_CONT]]
// CHECK1:       omp_offload.cont:
// CHECK1-NEXT:    [[TMP15:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS2]], i32 0, i32 0
// CHECK1-NEXT:    store i32 2, ptr [[TMP15]], align 4
// CHECK1-NEXT:    [[TMP16:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS2]], i32 0, i32 1
// CHECK1-NEXT:    store i32 0, ptr [[TMP16]], align 4
// CHECK1-NEXT:    [[TMP17:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS2]], i32 0, i32 2
// CHECK1-NEXT:    store ptr null, ptr [[TMP17]], align 8
// CHECK1-NEXT:    [[TMP18:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS2]], i32 0, i32 3
// CHECK1-NEXT:    store ptr null, ptr [[TMP18]], align 8
// CHECK1-NEXT:    [[TMP19:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS2]], i32 0, i32 4
// CHECK1-NEXT:    store ptr null, ptr [[TMP19]], align 8
// CHECK1-NEXT:    [[TMP20:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS2]], i32 0, i32 5
// CHECK1-NEXT:    store ptr null, ptr [[TMP20]], align 8
// CHECK1-NEXT:    [[TMP21:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS2]], i32 0, i32 6
// CHECK1-NEXT:    store ptr null, ptr [[TMP21]], align 8
// CHECK1-NEXT:    [[TMP22:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS2]], i32 0, i32 7
// CHECK1-NEXT:    store ptr null, ptr [[TMP22]], align 8
// CHECK1-NEXT:    [[TMP23:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS2]], i32 0, i32 8
// CHECK1-NEXT:    store i64 1000, ptr [[TMP23]], align 8
// CHECK1-NEXT:    [[TMP24:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS2]], i32 0, i32 9
// CHECK1-NEXT:    store i64 0, ptr [[TMP24]], align 8
// CHECK1-NEXT:    [[TMP25:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS2]], i32 0, i32 10
// CHECK1-NEXT:    store [3 x i32] zeroinitializer, ptr [[TMP25]], align 4
// CHECK1-NEXT:    [[TMP26:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS2]], i32 0, i32 11
// CHECK1-NEXT:    store [3 x i32] zeroinitializer, ptr [[TMP26]], align 4
// CHECK1-NEXT:    [[TMP27:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS2]], i32 0, i32 12
// CHECK1-NEXT:    store i32 0, ptr [[TMP27]], align 4
// CHECK1-NEXT:    [[TMP28:%.*]] = call i32 @__tgt_target_kernel(ptr @[[GLOB3]], i64 -1, i32 0, i32 0, ptr @.{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l41.region_id, ptr [[KERNEL_ARGS2]])
// CHECK1-NEXT:    [[TMP29:%.*]] = icmp ne i32 [[TMP28]], 0
// CHECK1-NEXT:    br i1 [[TMP29]], label [[OMP_OFFLOAD_FAILED3:%.*]], label [[OMP_OFFLOAD_CONT4:%.*]]
// CHECK1:       omp_offload.failed3:
// CHECK1-NEXT:    call void @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l41() #[[ATTR2]]
// CHECK1-NEXT:    br label [[OMP_OFFLOAD_CONT4]]
// CHECK1:       omp_offload.cont4:
// CHECK1-NEXT:    [[CALL:%.*]] = call noundef signext i32 @_Z5tmainIiET_v()
// CHECK1-NEXT:    ret i32 [[CALL]]
//
//
// CHECK1-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l37
// CHECK1-SAME: () #[[ATTR1:[0-9]+]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    call void (ptr, i32, ptr, ...) @__kmpc_fork_teams(ptr @[[GLOB3]], i32 0, ptr @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l37.omp_outlined)
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l37.omp_outlined
// CHECK1-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]]) #[[ATTR1]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTOMP_IV:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[TMP:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_COMB_LB:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_COMB_UB:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_STRIDE:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_IS_LAST:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[I:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 8
// CHECK1-NEXT:    store i32 0, ptr [[DOTOMP_COMB_LB]], align 4
// CHECK1-NEXT:    store i32 999, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK1-NEXT:    store i32 1, ptr [[DOTOMP_STRIDE]], align 4
// CHECK1-NEXT:    store i32 0, ptr [[DOTOMP_IS_LAST]], align 4
// CHECK1-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    [[TMP1:%.*]] = load i32, ptr [[TMP0]], align 4
// CHECK1-NEXT:    call void @__kmpc_for_static_init_4(ptr @[[GLOB1:[0-9]+]], i32 [[TMP1]], i32 92, ptr [[DOTOMP_IS_LAST]], ptr [[DOTOMP_COMB_LB]], ptr [[DOTOMP_COMB_UB]], ptr [[DOTOMP_STRIDE]], i32 1, i32 1)
// CHECK1-NEXT:    [[TMP2:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK1-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[TMP2]], 999
// CHECK1-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_FALSE:%.*]]
// CHECK1:       cond.true:
// CHECK1-NEXT:    br label [[COND_END:%.*]]
// CHECK1:       cond.false:
// CHECK1-NEXT:    [[TMP3:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK1-NEXT:    br label [[COND_END]]
// CHECK1:       cond.end:
// CHECK1-NEXT:    [[COND:%.*]] = phi i32 [ 999, [[COND_TRUE]] ], [ [[TMP3]], [[COND_FALSE]] ]
// CHECK1-NEXT:    store i32 [[COND]], ptr [[DOTOMP_COMB_UB]], align 4
// CHECK1-NEXT:    [[TMP4:%.*]] = load i32, ptr [[DOTOMP_COMB_LB]], align 4
// CHECK1-NEXT:    store i32 [[TMP4]], ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_COND:%.*]]
// CHECK1:       omp.inner.for.cond:
// CHECK1-NEXT:    [[TMP5:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    [[TMP6:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK1-NEXT:    [[CMP1:%.*]] = icmp sle i32 [[TMP5]], [[TMP6]]
// CHECK1-NEXT:    br i1 [[CMP1]], label [[OMP_INNER_FOR_BODY:%.*]], label [[OMP_INNER_FOR_END:%.*]]
// CHECK1:       omp.inner.for.body:
// CHECK1-NEXT:    call void @__kmpc_push_proc_bind(ptr @[[GLOB3]], i32 [[TMP1]], i32 4)
// CHECK1-NEXT:    [[TMP7:%.*]] = load i32, ptr [[DOTOMP_COMB_LB]], align 4
// CHECK1-NEXT:    [[TMP8:%.*]] = zext i32 [[TMP7]] to i64
// CHECK1-NEXT:    [[TMP9:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK1-NEXT:    [[TMP10:%.*]] = zext i32 [[TMP9]] to i64
// CHECK1-NEXT:    call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr @[[GLOB3]], i32 2, ptr @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l37.omp_outlined.omp_outlined, i64 [[TMP8]], i64 [[TMP10]])
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_INC:%.*]]
// CHECK1:       omp.inner.for.inc:
// CHECK1-NEXT:    [[TMP11:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    [[TMP12:%.*]] = load i32, ptr [[DOTOMP_STRIDE]], align 4
// CHECK1-NEXT:    [[ADD:%.*]] = add nsw i32 [[TMP11]], [[TMP12]]
// CHECK1-NEXT:    store i32 [[ADD]], ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_COND]]
// CHECK1:       omp.inner.for.end:
// CHECK1-NEXT:    br label [[OMP_LOOP_EXIT:%.*]]
// CHECK1:       omp.loop.exit:
// CHECK1-NEXT:    call void @__kmpc_for_static_fini(ptr @[[GLOB1]], i32 [[TMP1]])
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l37.omp_outlined.omp_outlined
// CHECK1-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]], i64 noundef [[DOTPREVIOUS_LB_:%.*]], i64 noundef [[DOTPREVIOUS_UB_:%.*]]) #[[ATTR1]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTPREVIOUS_LB__ADDR:%.*]] = alloca i64, align 8
// CHECK1-NEXT:    [[DOTPREVIOUS_UB__ADDR:%.*]] = alloca i64, align 8
// CHECK1-NEXT:    [[DOTOMP_IV:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[TMP:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_LB:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_UB:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_STRIDE:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_IS_LAST:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[I:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 8
// CHECK1-NEXT:    store i64 [[DOTPREVIOUS_LB_]], ptr [[DOTPREVIOUS_LB__ADDR]], align 8
// CHECK1-NEXT:    store i64 [[DOTPREVIOUS_UB_]], ptr [[DOTPREVIOUS_UB__ADDR]], align 8
// CHECK1-NEXT:    store i32 0, ptr [[DOTOMP_LB]], align 4
// CHECK1-NEXT:    store i32 999, ptr [[DOTOMP_UB]], align 4
// CHECK1-NEXT:    [[TMP0:%.*]] = load i64, ptr [[DOTPREVIOUS_LB__ADDR]], align 8
// CHECK1-NEXT:    [[CONV:%.*]] = trunc i64 [[TMP0]] to i32
// CHECK1-NEXT:    [[TMP1:%.*]] = load i64, ptr [[DOTPREVIOUS_UB__ADDR]], align 8
// CHECK1-NEXT:    [[CONV1:%.*]] = trunc i64 [[TMP1]] to i32
// CHECK1-NEXT:    store i32 [[CONV]], ptr [[DOTOMP_LB]], align 4
// CHECK1-NEXT:    store i32 [[CONV1]], ptr [[DOTOMP_UB]], align 4
// CHECK1-NEXT:    store i32 1, ptr [[DOTOMP_STRIDE]], align 4
// CHECK1-NEXT:    store i32 0, ptr [[DOTOMP_IS_LAST]], align 4
// CHECK1-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    [[TMP3:%.*]] = load i32, ptr [[TMP2]], align 4
// CHECK1-NEXT:    call void @__kmpc_for_static_init_4(ptr @[[GLOB2:[0-9]+]], i32 [[TMP3]], i32 34, ptr [[DOTOMP_IS_LAST]], ptr [[DOTOMP_LB]], ptr [[DOTOMP_UB]], ptr [[DOTOMP_STRIDE]], i32 1, i32 1)
// CHECK1-NEXT:    [[TMP4:%.*]] = load i32, ptr [[DOTOMP_UB]], align 4
// CHECK1-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[TMP4]], 999
// CHECK1-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_FALSE:%.*]]
// CHECK1:       cond.true:
// CHECK1-NEXT:    br label [[COND_END:%.*]]
// CHECK1:       cond.false:
// CHECK1-NEXT:    [[TMP5:%.*]] = load i32, ptr [[DOTOMP_UB]], align 4
// CHECK1-NEXT:    br label [[COND_END]]
// CHECK1:       cond.end:
// CHECK1-NEXT:    [[COND:%.*]] = phi i32 [ 999, [[COND_TRUE]] ], [ [[TMP5]], [[COND_FALSE]] ]
// CHECK1-NEXT:    store i32 [[COND]], ptr [[DOTOMP_UB]], align 4
// CHECK1-NEXT:    [[TMP6:%.*]] = load i32, ptr [[DOTOMP_LB]], align 4
// CHECK1-NEXT:    store i32 [[TMP6]], ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_COND:%.*]]
// CHECK1:       omp.inner.for.cond:
// CHECK1-NEXT:    [[TMP7:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    [[TMP8:%.*]] = load i32, ptr [[DOTOMP_UB]], align 4
// CHECK1-NEXT:    [[CMP2:%.*]] = icmp sle i32 [[TMP7]], [[TMP8]]
// CHECK1-NEXT:    br i1 [[CMP2]], label [[OMP_INNER_FOR_BODY:%.*]], label [[OMP_INNER_FOR_END:%.*]]
// CHECK1:       omp.inner.for.body:
// CHECK1-NEXT:    [[TMP9:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    [[MUL:%.*]] = mul nsw i32 [[TMP9]], 1
// CHECK1-NEXT:    [[ADD:%.*]] = add nsw i32 0, [[MUL]]
// CHECK1-NEXT:    store i32 [[ADD]], ptr [[I]], align 4
// CHECK1-NEXT:    br label [[OMP_BODY_CONTINUE:%.*]]
// CHECK1:       omp.body.continue:
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_INC:%.*]]
// CHECK1:       omp.inner.for.inc:
// CHECK1-NEXT:    [[TMP10:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    [[ADD3:%.*]] = add nsw i32 [[TMP10]], 1
// CHECK1-NEXT:    store i32 [[ADD3]], ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_COND]]
// CHECK1:       omp.inner.for.end:
// CHECK1-NEXT:    br label [[OMP_LOOP_EXIT:%.*]]
// CHECK1:       omp.loop.exit:
// CHECK1-NEXT:    call void @__kmpc_for_static_fini(ptr @[[GLOB1]], i32 [[TMP3]])
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l41
// CHECK1-SAME: () #[[ATTR1]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    call void (ptr, i32, ptr, ...) @__kmpc_fork_teams(ptr @[[GLOB3]], i32 0, ptr @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l41.omp_outlined)
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l41.omp_outlined
// CHECK1-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]]) #[[ATTR1]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTOMP_IV:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[TMP:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_COMB_LB:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_COMB_UB:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_STRIDE:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_IS_LAST:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[I:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 8
// CHECK1-NEXT:    store i32 0, ptr [[DOTOMP_COMB_LB]], align 4
// CHECK1-NEXT:    store i32 999, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK1-NEXT:    store i32 1, ptr [[DOTOMP_STRIDE]], align 4
// CHECK1-NEXT:    store i32 0, ptr [[DOTOMP_IS_LAST]], align 4
// CHECK1-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    [[TMP1:%.*]] = load i32, ptr [[TMP0]], align 4
// CHECK1-NEXT:    call void @__kmpc_for_static_init_4(ptr @[[GLOB1]], i32 [[TMP1]], i32 92, ptr [[DOTOMP_IS_LAST]], ptr [[DOTOMP_COMB_LB]], ptr [[DOTOMP_COMB_UB]], ptr [[DOTOMP_STRIDE]], i32 1, i32 1)
// CHECK1-NEXT:    [[TMP2:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK1-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[TMP2]], 999
// CHECK1-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_FALSE:%.*]]
// CHECK1:       cond.true:
// CHECK1-NEXT:    br label [[COND_END:%.*]]
// CHECK1:       cond.false:
// CHECK1-NEXT:    [[TMP3:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK1-NEXT:    br label [[COND_END]]
// CHECK1:       cond.end:
// CHECK1-NEXT:    [[COND:%.*]] = phi i32 [ 999, [[COND_TRUE]] ], [ [[TMP3]], [[COND_FALSE]] ]
// CHECK1-NEXT:    store i32 [[COND]], ptr [[DOTOMP_COMB_UB]], align 4
// CHECK1-NEXT:    [[TMP4:%.*]] = load i32, ptr [[DOTOMP_COMB_LB]], align 4
// CHECK1-NEXT:    store i32 [[TMP4]], ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_COND:%.*]]
// CHECK1:       omp.inner.for.cond:
// CHECK1-NEXT:    [[TMP5:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    [[TMP6:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK1-NEXT:    [[CMP1:%.*]] = icmp sle i32 [[TMP5]], [[TMP6]]
// CHECK1-NEXT:    br i1 [[CMP1]], label [[OMP_INNER_FOR_BODY:%.*]], label [[OMP_INNER_FOR_END:%.*]]
// CHECK1:       omp.inner.for.body:
// CHECK1-NEXT:    call void @__kmpc_push_proc_bind(ptr @[[GLOB3]], i32 [[TMP1]], i32 3)
// CHECK1-NEXT:    [[TMP7:%.*]] = load i32, ptr [[DOTOMP_COMB_LB]], align 4
// CHECK1-NEXT:    [[TMP8:%.*]] = zext i32 [[TMP7]] to i64
// CHECK1-NEXT:    [[TMP9:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK1-NEXT:    [[TMP10:%.*]] = zext i32 [[TMP9]] to i64
// CHECK1-NEXT:    call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr @[[GLOB3]], i32 2, ptr @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l41.omp_outlined.omp_outlined, i64 [[TMP8]], i64 [[TMP10]])
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_INC:%.*]]
// CHECK1:       omp.inner.for.inc:
// CHECK1-NEXT:    [[TMP11:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    [[TMP12:%.*]] = load i32, ptr [[DOTOMP_STRIDE]], align 4
// CHECK1-NEXT:    [[ADD:%.*]] = add nsw i32 [[TMP11]], [[TMP12]]
// CHECK1-NEXT:    store i32 [[ADD]], ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_COND]]
// CHECK1:       omp.inner.for.end:
// CHECK1-NEXT:    br label [[OMP_LOOP_EXIT:%.*]]
// CHECK1:       omp.loop.exit:
// CHECK1-NEXT:    call void @__kmpc_for_static_fini(ptr @[[GLOB1]], i32 [[TMP1]])
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l41.omp_outlined.omp_outlined
// CHECK1-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]], i64 noundef [[DOTPREVIOUS_LB_:%.*]], i64 noundef [[DOTPREVIOUS_UB_:%.*]]) #[[ATTR1]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTPREVIOUS_LB__ADDR:%.*]] = alloca i64, align 8
// CHECK1-NEXT:    [[DOTPREVIOUS_UB__ADDR:%.*]] = alloca i64, align 8
// CHECK1-NEXT:    [[DOTOMP_IV:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[TMP:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_LB:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_UB:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_STRIDE:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_IS_LAST:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[I:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 8
// CHECK1-NEXT:    store i64 [[DOTPREVIOUS_LB_]], ptr [[DOTPREVIOUS_LB__ADDR]], align 8
// CHECK1-NEXT:    store i64 [[DOTPREVIOUS_UB_]], ptr [[DOTPREVIOUS_UB__ADDR]], align 8
// CHECK1-NEXT:    store i32 0, ptr [[DOTOMP_LB]], align 4
// CHECK1-NEXT:    store i32 999, ptr [[DOTOMP_UB]], align 4
// CHECK1-NEXT:    [[TMP0:%.*]] = load i64, ptr [[DOTPREVIOUS_LB__ADDR]], align 8
// CHECK1-NEXT:    [[CONV:%.*]] = trunc i64 [[TMP0]] to i32
// CHECK1-NEXT:    [[TMP1:%.*]] = load i64, ptr [[DOTPREVIOUS_UB__ADDR]], align 8
// CHECK1-NEXT:    [[CONV1:%.*]] = trunc i64 [[TMP1]] to i32
// CHECK1-NEXT:    store i32 [[CONV]], ptr [[DOTOMP_LB]], align 4
// CHECK1-NEXT:    store i32 [[CONV1]], ptr [[DOTOMP_UB]], align 4
// CHECK1-NEXT:    store i32 1, ptr [[DOTOMP_STRIDE]], align 4
// CHECK1-NEXT:    store i32 0, ptr [[DOTOMP_IS_LAST]], align 4
// CHECK1-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    [[TMP3:%.*]] = load i32, ptr [[TMP2]], align 4
// CHECK1-NEXT:    call void @__kmpc_for_static_init_4(ptr @[[GLOB2]], i32 [[TMP3]], i32 34, ptr [[DOTOMP_IS_LAST]], ptr [[DOTOMP_LB]], ptr [[DOTOMP_UB]], ptr [[DOTOMP_STRIDE]], i32 1, i32 1)
// CHECK1-NEXT:    [[TMP4:%.*]] = load i32, ptr [[DOTOMP_UB]], align 4
// CHECK1-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[TMP4]], 999
// CHECK1-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_FALSE:%.*]]
// CHECK1:       cond.true:
// CHECK1-NEXT:    br label [[COND_END:%.*]]
// CHECK1:       cond.false:
// CHECK1-NEXT:    [[TMP5:%.*]] = load i32, ptr [[DOTOMP_UB]], align 4
// CHECK1-NEXT:    br label [[COND_END]]
// CHECK1:       cond.end:
// CHECK1-NEXT:    [[COND:%.*]] = phi i32 [ 999, [[COND_TRUE]] ], [ [[TMP5]], [[COND_FALSE]] ]
// CHECK1-NEXT:    store i32 [[COND]], ptr [[DOTOMP_UB]], align 4
// CHECK1-NEXT:    [[TMP6:%.*]] = load i32, ptr [[DOTOMP_LB]], align 4
// CHECK1-NEXT:    store i32 [[TMP6]], ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_COND:%.*]]
// CHECK1:       omp.inner.for.cond:
// CHECK1-NEXT:    [[TMP7:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    [[TMP8:%.*]] = load i32, ptr [[DOTOMP_UB]], align 4
// CHECK1-NEXT:    [[CMP2:%.*]] = icmp sle i32 [[TMP7]], [[TMP8]]
// CHECK1-NEXT:    br i1 [[CMP2]], label [[OMP_INNER_FOR_BODY:%.*]], label [[OMP_INNER_FOR_END:%.*]]
// CHECK1:       omp.inner.for.body:
// CHECK1-NEXT:    [[TMP9:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    [[MUL:%.*]] = mul nsw i32 [[TMP9]], 1
// CHECK1-NEXT:    [[ADD:%.*]] = add nsw i32 0, [[MUL]]
// CHECK1-NEXT:    store i32 [[ADD]], ptr [[I]], align 4
// CHECK1-NEXT:    br label [[OMP_BODY_CONTINUE:%.*]]
// CHECK1:       omp.body.continue:
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_INC:%.*]]
// CHECK1:       omp.inner.for.inc:
// CHECK1-NEXT:    [[TMP10:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    [[ADD3:%.*]] = add nsw i32 [[TMP10]], 1
// CHECK1-NEXT:    store i32 [[ADD3]], ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_COND]]
// CHECK1:       omp.inner.for.end:
// CHECK1-NEXT:    br label [[OMP_LOOP_EXIT:%.*]]
// CHECK1:       omp.loop.exit:
// CHECK1-NEXT:    call void @__kmpc_for_static_fini(ptr @[[GLOB1]], i32 [[TMP3]])
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@_Z5tmainIiET_v
// CHECK1-SAME: () #[[ATTR3:[0-9]+]] comdat {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[TMP:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[KERNEL_ARGS:%.*]] = alloca [[STRUCT___TGT_KERNEL_ARGUMENTS:%.*]], align 8
// CHECK1-NEXT:    [[TMP0:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 0
// CHECK1-NEXT:    store i32 2, ptr [[TMP0]], align 4
// CHECK1-NEXT:    [[TMP1:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 1
// CHECK1-NEXT:    store i32 0, ptr [[TMP1]], align 4
// CHECK1-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 2
// CHECK1-NEXT:    store ptr null, ptr [[TMP2]], align 8
// CHECK1-NEXT:    [[TMP3:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 3
// CHECK1-NEXT:    store ptr null, ptr [[TMP3]], align 8
// CHECK1-NEXT:    [[TMP4:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 4
// CHECK1-NEXT:    store ptr null, ptr [[TMP4]], align 8
// CHECK1-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 5
// CHECK1-NEXT:    store ptr null, ptr [[TMP5]], align 8
// CHECK1-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 6
// CHECK1-NEXT:    store ptr null, ptr [[TMP6]], align 8
// CHECK1-NEXT:    [[TMP7:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 7
// CHECK1-NEXT:    store ptr null, ptr [[TMP7]], align 8
// CHECK1-NEXT:    [[TMP8:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 8
// CHECK1-NEXT:    store i64 1000, ptr [[TMP8]], align 8
// CHECK1-NEXT:    [[TMP9:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 9
// CHECK1-NEXT:    store i64 0, ptr [[TMP9]], align 8
// CHECK1-NEXT:    [[TMP10:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 10
// CHECK1-NEXT:    store [3 x i32] zeroinitializer, ptr [[TMP10]], align 4
// CHECK1-NEXT:    [[TMP11:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 11
// CHECK1-NEXT:    store [3 x i32] zeroinitializer, ptr [[TMP11]], align 4
// CHECK1-NEXT:    [[TMP12:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 12
// CHECK1-NEXT:    store i32 0, ptr [[TMP12]], align 4
// CHECK1-NEXT:    [[TMP13:%.*]] = call i32 @__tgt_target_kernel(ptr @[[GLOB3]], i64 -1, i32 0, i32 0, ptr @.{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIiET_v_l29.region_id, ptr [[KERNEL_ARGS]])
// CHECK1-NEXT:    [[TMP14:%.*]] = icmp ne i32 [[TMP13]], 0
// CHECK1-NEXT:    br i1 [[TMP14]], label [[OMP_OFFLOAD_FAILED:%.*]], label [[OMP_OFFLOAD_CONT:%.*]]
// CHECK1:       omp_offload.failed:
// CHECK1-NEXT:    call void @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIiET_v_l29() #[[ATTR2]]
// CHECK1-NEXT:    br label [[OMP_OFFLOAD_CONT]]
// CHECK1:       omp_offload.cont:
// CHECK1-NEXT:    ret i32 0
//
//
// CHECK1-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIiET_v_l29
// CHECK1-SAME: () #[[ATTR1]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    call void (ptr, i32, ptr, ...) @__kmpc_fork_teams(ptr @[[GLOB3]], i32 0, ptr @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIiET_v_l29.omp_outlined)
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIiET_v_l29.omp_outlined
// CHECK1-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]]) #[[ATTR1]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTOMP_IV:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[TMP:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_COMB_LB:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_COMB_UB:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_STRIDE:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_IS_LAST:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[I:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 8
// CHECK1-NEXT:    store i32 0, ptr [[DOTOMP_COMB_LB]], align 4
// CHECK1-NEXT:    store i32 999, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK1-NEXT:    store i32 1, ptr [[DOTOMP_STRIDE]], align 4
// CHECK1-NEXT:    store i32 0, ptr [[DOTOMP_IS_LAST]], align 4
// CHECK1-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    [[TMP1:%.*]] = load i32, ptr [[TMP0]], align 4
// CHECK1-NEXT:    call void @__kmpc_for_static_init_4(ptr @[[GLOB1]], i32 [[TMP1]], i32 92, ptr [[DOTOMP_IS_LAST]], ptr [[DOTOMP_COMB_LB]], ptr [[DOTOMP_COMB_UB]], ptr [[DOTOMP_STRIDE]], i32 1, i32 1)
// CHECK1-NEXT:    [[TMP2:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK1-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[TMP2]], 999
// CHECK1-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_FALSE:%.*]]
// CHECK1:       cond.true:
// CHECK1-NEXT:    br label [[COND_END:%.*]]
// CHECK1:       cond.false:
// CHECK1-NEXT:    [[TMP3:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK1-NEXT:    br label [[COND_END]]
// CHECK1:       cond.end:
// CHECK1-NEXT:    [[COND:%.*]] = phi i32 [ 999, [[COND_TRUE]] ], [ [[TMP3]], [[COND_FALSE]] ]
// CHECK1-NEXT:    store i32 [[COND]], ptr [[DOTOMP_COMB_UB]], align 4
// CHECK1-NEXT:    [[TMP4:%.*]] = load i32, ptr [[DOTOMP_COMB_LB]], align 4
// CHECK1-NEXT:    store i32 [[TMP4]], ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_COND:%.*]]
// CHECK1:       omp.inner.for.cond:
// CHECK1-NEXT:    [[TMP5:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    [[TMP6:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK1-NEXT:    [[CMP1:%.*]] = icmp sle i32 [[TMP5]], [[TMP6]]
// CHECK1-NEXT:    br i1 [[CMP1]], label [[OMP_INNER_FOR_BODY:%.*]], label [[OMP_INNER_FOR_END:%.*]]
// CHECK1:       omp.inner.for.body:
// CHECK1-NEXT:    call void @__kmpc_push_proc_bind(ptr @[[GLOB3]], i32 [[TMP1]], i32 2)
// CHECK1-NEXT:    [[TMP7:%.*]] = load i32, ptr [[DOTOMP_COMB_LB]], align 4
// CHECK1-NEXT:    [[TMP8:%.*]] = zext i32 [[TMP7]] to i64
// CHECK1-NEXT:    [[TMP9:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK1-NEXT:    [[TMP10:%.*]] = zext i32 [[TMP9]] to i64
// CHECK1-NEXT:    call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr @[[GLOB3]], i32 2, ptr @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIiET_v_l29.omp_outlined.omp_outlined, i64 [[TMP8]], i64 [[TMP10]])
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_INC:%.*]]
// CHECK1:       omp.inner.for.inc:
// CHECK1-NEXT:    [[TMP11:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    [[TMP12:%.*]] = load i32, ptr [[DOTOMP_STRIDE]], align 4
// CHECK1-NEXT:    [[ADD:%.*]] = add nsw i32 [[TMP11]], [[TMP12]]
// CHECK1-NEXT:    store i32 [[ADD]], ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_COND]]
// CHECK1:       omp.inner.for.end:
// CHECK1-NEXT:    br label [[OMP_LOOP_EXIT:%.*]]
// CHECK1:       omp.loop.exit:
// CHECK1-NEXT:    call void @__kmpc_for_static_fini(ptr @[[GLOB1]], i32 [[TMP1]])
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIiET_v_l29.omp_outlined.omp_outlined
// CHECK1-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]], i64 noundef [[DOTPREVIOUS_LB_:%.*]], i64 noundef [[DOTPREVIOUS_UB_:%.*]]) #[[ATTR1]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTPREVIOUS_LB__ADDR:%.*]] = alloca i64, align 8
// CHECK1-NEXT:    [[DOTPREVIOUS_UB__ADDR:%.*]] = alloca i64, align 8
// CHECK1-NEXT:    [[DOTOMP_IV:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[TMP:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_LB:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_UB:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_STRIDE:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_IS_LAST:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[I:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 8
// CHECK1-NEXT:    store i64 [[DOTPREVIOUS_LB_]], ptr [[DOTPREVIOUS_LB__ADDR]], align 8
// CHECK1-NEXT:    store i64 [[DOTPREVIOUS_UB_]], ptr [[DOTPREVIOUS_UB__ADDR]], align 8
// CHECK1-NEXT:    store i32 0, ptr [[DOTOMP_LB]], align 4
// CHECK1-NEXT:    store i32 999, ptr [[DOTOMP_UB]], align 4
// CHECK1-NEXT:    [[TMP0:%.*]] = load i64, ptr [[DOTPREVIOUS_LB__ADDR]], align 8
// CHECK1-NEXT:    [[CONV:%.*]] = trunc i64 [[TMP0]] to i32
// CHECK1-NEXT:    [[TMP1:%.*]] = load i64, ptr [[DOTPREVIOUS_UB__ADDR]], align 8
// CHECK1-NEXT:    [[CONV1:%.*]] = trunc i64 [[TMP1]] to i32
// CHECK1-NEXT:    store i32 [[CONV]], ptr [[DOTOMP_LB]], align 4
// CHECK1-NEXT:    store i32 [[CONV1]], ptr [[DOTOMP_UB]], align 4
// CHECK1-NEXT:    store i32 1, ptr [[DOTOMP_STRIDE]], align 4
// CHECK1-NEXT:    store i32 0, ptr [[DOTOMP_IS_LAST]], align 4
// CHECK1-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    [[TMP3:%.*]] = load i32, ptr [[TMP2]], align 4
// CHECK1-NEXT:    call void @__kmpc_for_static_init_4(ptr @[[GLOB2]], i32 [[TMP3]], i32 34, ptr [[DOTOMP_IS_LAST]], ptr [[DOTOMP_LB]], ptr [[DOTOMP_UB]], ptr [[DOTOMP_STRIDE]], i32 1, i32 1)
// CHECK1-NEXT:    [[TMP4:%.*]] = load i32, ptr [[DOTOMP_UB]], align 4
// CHECK1-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[TMP4]], 999
// CHECK1-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_FALSE:%.*]]
// CHECK1:       cond.true:
// CHECK1-NEXT:    br label [[COND_END:%.*]]
// CHECK1:       cond.false:
// CHECK1-NEXT:    [[TMP5:%.*]] = load i32, ptr [[DOTOMP_UB]], align 4
// CHECK1-NEXT:    br label [[COND_END]]
// CHECK1:       cond.end:
// CHECK1-NEXT:    [[COND:%.*]] = phi i32 [ 999, [[COND_TRUE]] ], [ [[TMP5]], [[COND_FALSE]] ]
// CHECK1-NEXT:    store i32 [[COND]], ptr [[DOTOMP_UB]], align 4
// CHECK1-NEXT:    [[TMP6:%.*]] = load i32, ptr [[DOTOMP_LB]], align 4
// CHECK1-NEXT:    store i32 [[TMP6]], ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_COND:%.*]]
// CHECK1:       omp.inner.for.cond:
// CHECK1-NEXT:    [[TMP7:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    [[TMP8:%.*]] = load i32, ptr [[DOTOMP_UB]], align 4
// CHECK1-NEXT:    [[CMP2:%.*]] = icmp sle i32 [[TMP7]], [[TMP8]]
// CHECK1-NEXT:    br i1 [[CMP2]], label [[OMP_INNER_FOR_BODY:%.*]], label [[OMP_INNER_FOR_END:%.*]]
// CHECK1:       omp.inner.for.body:
// CHECK1-NEXT:    [[TMP9:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    [[MUL:%.*]] = mul nsw i32 [[TMP9]], 1
// CHECK1-NEXT:    [[ADD:%.*]] = add nsw i32 0, [[MUL]]
// CHECK1-NEXT:    store i32 [[ADD]], ptr [[I]], align 4
// CHECK1-NEXT:    br label [[OMP_BODY_CONTINUE:%.*]]
// CHECK1:       omp.body.continue:
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_INC:%.*]]
// CHECK1:       omp.inner.for.inc:
// CHECK1-NEXT:    [[TMP10:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    [[ADD3:%.*]] = add nsw i32 [[TMP10]], 1
// CHECK1-NEXT:    store i32 [[ADD3]], ptr [[DOTOMP_IV]], align 4
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_COND]]
// CHECK1:       omp.inner.for.end:
// CHECK1-NEXT:    br label [[OMP_LOOP_EXIT:%.*]]
// CHECK1:       omp.loop.exit:
// CHECK1-NEXT:    call void @__kmpc_for_static_fini(ptr @[[GLOB1]], i32 [[TMP3]])
// CHECK1-NEXT:    ret void
//
