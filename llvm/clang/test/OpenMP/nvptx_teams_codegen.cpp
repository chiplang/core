// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --function-signature --include-generated-funcs --replace-value-regex "__omp_offloading_[0-9a-z]+_[0-9a-z]+" "reduction_size[.].+[.]" "pl_cond[.].+[.|,]" --prefix-filecheck-ir-name _
// Test target codegen - host bc file has to be created first.
// RUN: %clang_cc1 -DCK1 -verify -fopenmp -x c++ -triple powerpc64le-unknown-unknown -fopenmp-targets=nvptx64-nvidia-cuda -emit-llvm-bc %s -o %t-ppc-host.bc
// RUN: %clang_cc1 -DCK1 -verify -fopenmp -x c++ -triple nvptx64-unknown-unknown -fopenmp-targets=nvptx64-nvidia-cuda -emit-llvm %s -fopenmp-is-target-device -fopenmp-host-ir-file-path %t-ppc-host.bc -o - | FileCheck %s --check-prefix=CHECK1
// RUN: %clang_cc1 -DCK1 -verify -fopenmp -x c++ -triple i386-unknown-unknown -fopenmp-targets=nvptx-nvidia-cuda -emit-llvm-bc %s -o %t-x86-host.bc
// RUN: %clang_cc1 -DCK1 -verify -fopenmp -x c++ -triple nvptx-unknown-unknown -fopenmp-targets=nvptx-nvidia-cuda -emit-llvm %s -fopenmp-is-target-device -fopenmp-host-ir-file-path %t-x86-host.bc -o - | FileCheck %s --check-prefix=CHECK2
// expected-no-diagnostics
#ifndef HEADER
#define HEADER

#ifdef CK1

template <typename T>
int tmain(T argc) {
#pragma omp target
#pragma omp teams
  argc = 0;
  return 0;
}


int main (int argc, char **argv) {
#pragma omp target
#pragma omp teams
  {
  argc = 0;
  }
  return tmain(argv);
}


// only nvptx side: do not outline teams region and do not call fork_teams


// target region in template



#endif // CK1

// Test target codegen - host bc file has to be created first.
// RUN: %clang_cc1 -DCK2 -verify -fopenmp -x c++ -triple powerpc64le-unknown-unknown -fopenmp-targets=nvptx64-nvidia-cuda -emit-llvm-bc %s -o %t-ppc-host.bc
// RUN: %clang_cc1 -DCK2 -verify -fopenmp -x c++ -triple nvptx64-unknown-unknown -fopenmp-targets=nvptx64-nvidia-cuda -emit-llvm %s -fopenmp-is-target-device -fopenmp-host-ir-file-path %t-ppc-host.bc -o - | FileCheck %s --check-prefix=CHECK3
// RUN: %clang_cc1 -DCK2 -verify -fopenmp -x c++ -triple i386-unknown-unknown -fopenmp-targets=nvptx-nvidia-cuda -emit-llvm-bc %s -o %t-x86-host.bc
// RUN: %clang_cc1 -DCK2 -verify -fopenmp -x c++ -triple nvptx-unknown-unknown -fopenmp-targets=nvptx-nvidia-cuda -emit-llvm %s -fopenmp-is-target-device -fopenmp-host-ir-file-path %t-x86-host.bc -o - | FileCheck %s --check-prefix=CHECK4
// expected-no-diagnostics
#ifdef CK2

template <typename T>
int tmain(T argc) {
  int a = 10;
  int b = 5;
#pragma omp target
#pragma omp teams num_teams(a) thread_limit(b)
  {
  argc = 0;
  }
  return 0;
}

int main (int argc, char **argv) {
  int a = 20;
  int b = 5;
#pragma omp target
#pragma omp teams num_teams(a) thread_limit(b)
  {
  argc = 0;
  }
  return tmain(argv);
}






#endif // CK2
#endif
// CHECK1-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l23
// CHECK1-SAME: (ptr noalias noundef [[DYN_PTR:%.*]], i64 noundef [[ARGC:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DYN_PTR_ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[ARGC_ADDR:%.*]] = alloca i64, align 8
// CHECK1-NEXT:    [[DOTZERO_ADDR:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTTHREADID_TEMP_:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    store ptr [[DYN_PTR]], ptr [[DYN_PTR_ADDR]], align 8
// CHECK1-NEXT:    store i64 [[ARGC]], ptr [[ARGC_ADDR]], align 8
// CHECK1-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_target_init(ptr @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l23_kernel_environment, ptr [[DYN_PTR]])
// CHECK1-NEXT:    [[EXEC_USER_CODE:%.*]] = icmp eq i32 [[TMP0]], -1
// CHECK1-NEXT:    br i1 [[EXEC_USER_CODE]], label [[USER_CODE_ENTRY:%.*]], label [[WORKER_EXIT:%.*]]
// CHECK1:       user_code.entry:
// CHECK1-NEXT:    [[TMP1:%.*]] = load i32, ptr [[ARGC_ADDR]], align 4
// CHECK1-NEXT:    [[ARGC1:%.*]] = call align 8 ptr @__kmpc_alloc_shared(i64 4)
// CHECK1-NEXT:    store i32 [[TMP1]], ptr [[ARGC1]], align 4
// CHECK1-NEXT:    [[TMP2:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1:[0-9]+]])
// CHECK1-NEXT:    store i32 0, ptr [[DOTZERO_ADDR]], align 4
// CHECK1-NEXT:    store i32 [[TMP2]], ptr [[DOTTHREADID_TEMP_]], align 4
// CHECK1-NEXT:    call void @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l23_omp_outlined(ptr [[DOTTHREADID_TEMP_]], ptr [[DOTZERO_ADDR]], ptr [[ARGC1]]) #[[ATTR3:[0-9]+]]
// CHECK1-NEXT:    call void @__kmpc_free_shared(ptr [[ARGC1]], i64 4)
// CHECK1-NEXT:    call void @__kmpc_target_deinit()
// CHECK1-NEXT:    ret void
// CHECK1:       worker.exit:
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l23_omp_outlined
// CHECK1-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]], ptr noundef nonnull align 4 dereferenceable(4) [[ARGC:%.*]]) #[[ATTR2:[0-9]+]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[ARGC_ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 8
// CHECK1-NEXT:    store ptr [[ARGC]], ptr [[ARGC_ADDR]], align 8
// CHECK1-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[ARGC_ADDR]], align 8
// CHECK1-NEXT:    store i32 0, ptr [[TMP0]], align 4
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIPPcEiT__l15
// CHECK1-SAME: (ptr noalias noundef [[DYN_PTR:%.*]], ptr noundef [[ARGC:%.*]]) #[[ATTR0]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DYN_PTR_ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[ARGC_ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTZERO_ADDR:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTTHREADID_TEMP_:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    store ptr [[DYN_PTR]], ptr [[DYN_PTR_ADDR]], align 8
// CHECK1-NEXT:    store ptr [[ARGC]], ptr [[ARGC_ADDR]], align 8
// CHECK1-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_target_init(ptr @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIPPcEiT__l15_kernel_environment, ptr [[DYN_PTR]])
// CHECK1-NEXT:    [[EXEC_USER_CODE:%.*]] = icmp eq i32 [[TMP0]], -1
// CHECK1-NEXT:    br i1 [[EXEC_USER_CODE]], label [[USER_CODE_ENTRY:%.*]], label [[WORKER_EXIT:%.*]]
// CHECK1:       user_code.entry:
// CHECK1-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[ARGC_ADDR]], align 8
// CHECK1-NEXT:    [[ARGC1:%.*]] = call align 8 ptr @__kmpc_alloc_shared(i64 8)
// CHECK1-NEXT:    store ptr [[TMP1]], ptr [[ARGC1]], align 8
// CHECK1-NEXT:    [[TMP2:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK1-NEXT:    store i32 0, ptr [[DOTZERO_ADDR]], align 4
// CHECK1-NEXT:    store i32 [[TMP2]], ptr [[DOTTHREADID_TEMP_]], align 4
// CHECK1-NEXT:    call void @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIPPcEiT__l15_omp_outlined(ptr [[DOTTHREADID_TEMP_]], ptr [[DOTZERO_ADDR]], ptr [[ARGC1]]) #[[ATTR3]]
// CHECK1-NEXT:    call void @__kmpc_free_shared(ptr [[ARGC1]], i64 8)
// CHECK1-NEXT:    call void @__kmpc_target_deinit()
// CHECK1-NEXT:    ret void
// CHECK1:       worker.exit:
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIPPcEiT__l15_omp_outlined
// CHECK1-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]], ptr noundef nonnull align 8 dereferenceable(8) [[ARGC:%.*]]) #[[ATTR2]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[ARGC_ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 8
// CHECK1-NEXT:    store ptr [[ARGC]], ptr [[ARGC_ADDR]], align 8
// CHECK1-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[ARGC_ADDR]], align 8
// CHECK1-NEXT:    store ptr null, ptr [[TMP0]], align 8
// CHECK1-NEXT:    ret void
//
//
// CHECK2-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l23
// CHECK2-SAME: (ptr noalias noundef [[DYN_PTR:%.*]], i32 noundef [[ARGC:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK2-NEXT:  entry:
// CHECK2-NEXT:    [[DYN_PTR_ADDR:%.*]] = alloca ptr, align 4
// CHECK2-NEXT:    [[ARGC_ADDR:%.*]] = alloca i32, align 4
// CHECK2-NEXT:    [[DOTZERO_ADDR:%.*]] = alloca i32, align 4
// CHECK2-NEXT:    [[DOTTHREADID_TEMP_:%.*]] = alloca i32, align 4
// CHECK2-NEXT:    store ptr [[DYN_PTR]], ptr [[DYN_PTR_ADDR]], align 4
// CHECK2-NEXT:    store i32 [[ARGC]], ptr [[ARGC_ADDR]], align 4
// CHECK2-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_target_init(ptr @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l23_kernel_environment, ptr [[DYN_PTR]])
// CHECK2-NEXT:    [[EXEC_USER_CODE:%.*]] = icmp eq i32 [[TMP0]], -1
// CHECK2-NEXT:    br i1 [[EXEC_USER_CODE]], label [[USER_CODE_ENTRY:%.*]], label [[WORKER_EXIT:%.*]]
// CHECK2:       user_code.entry:
// CHECK2-NEXT:    [[TMP1:%.*]] = load i32, ptr [[ARGC_ADDR]], align 4
// CHECK2-NEXT:    [[ARGC1:%.*]] = call align 8 ptr @__kmpc_alloc_shared(i32 4)
// CHECK2-NEXT:    store i32 [[TMP1]], ptr [[ARGC1]], align 4
// CHECK2-NEXT:    [[TMP2:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1:[0-9]+]])
// CHECK2-NEXT:    store i32 0, ptr [[DOTZERO_ADDR]], align 4
// CHECK2-NEXT:    store i32 [[TMP2]], ptr [[DOTTHREADID_TEMP_]], align 4
// CHECK2-NEXT:    call void @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l23_omp_outlined(ptr [[DOTTHREADID_TEMP_]], ptr [[DOTZERO_ADDR]], ptr [[ARGC1]]) #[[ATTR3:[0-9]+]]
// CHECK2-NEXT:    call void @__kmpc_free_shared(ptr [[ARGC1]], i32 4)
// CHECK2-NEXT:    call void @__kmpc_target_deinit()
// CHECK2-NEXT:    ret void
// CHECK2:       worker.exit:
// CHECK2-NEXT:    ret void
//
//
// CHECK2-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l23_omp_outlined
// CHECK2-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]], ptr noundef nonnull align 4 dereferenceable(4) [[ARGC:%.*]]) #[[ATTR2:[0-9]+]] {
// CHECK2-NEXT:  entry:
// CHECK2-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 4
// CHECK2-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 4
// CHECK2-NEXT:    [[ARGC_ADDR:%.*]] = alloca ptr, align 4
// CHECK2-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 4
// CHECK2-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 4
// CHECK2-NEXT:    store ptr [[ARGC]], ptr [[ARGC_ADDR]], align 4
// CHECK2-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[ARGC_ADDR]], align 4
// CHECK2-NEXT:    store i32 0, ptr [[TMP0]], align 4
// CHECK2-NEXT:    ret void
//
//
// CHECK2-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIPPcEiT__l15
// CHECK2-SAME: (ptr noalias noundef [[DYN_PTR:%.*]], ptr noundef [[ARGC:%.*]]) #[[ATTR0]] {
// CHECK2-NEXT:  entry:
// CHECK2-NEXT:    [[DYN_PTR_ADDR:%.*]] = alloca ptr, align 4
// CHECK2-NEXT:    [[ARGC_ADDR:%.*]] = alloca ptr, align 4
// CHECK2-NEXT:    [[DOTZERO_ADDR:%.*]] = alloca i32, align 4
// CHECK2-NEXT:    [[DOTTHREADID_TEMP_:%.*]] = alloca i32, align 4
// CHECK2-NEXT:    store ptr [[DYN_PTR]], ptr [[DYN_PTR_ADDR]], align 4
// CHECK2-NEXT:    store ptr [[ARGC]], ptr [[ARGC_ADDR]], align 4
// CHECK2-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_target_init(ptr @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIPPcEiT__l15_kernel_environment, ptr [[DYN_PTR]])
// CHECK2-NEXT:    [[EXEC_USER_CODE:%.*]] = icmp eq i32 [[TMP0]], -1
// CHECK2-NEXT:    br i1 [[EXEC_USER_CODE]], label [[USER_CODE_ENTRY:%.*]], label [[WORKER_EXIT:%.*]]
// CHECK2:       user_code.entry:
// CHECK2-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[ARGC_ADDR]], align 4
// CHECK2-NEXT:    [[ARGC1:%.*]] = call align 8 ptr @__kmpc_alloc_shared(i32 4)
// CHECK2-NEXT:    store ptr [[TMP1]], ptr [[ARGC1]], align 4
// CHECK2-NEXT:    [[TMP2:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK2-NEXT:    store i32 0, ptr [[DOTZERO_ADDR]], align 4
// CHECK2-NEXT:    store i32 [[TMP2]], ptr [[DOTTHREADID_TEMP_]], align 4
// CHECK2-NEXT:    call void @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIPPcEiT__l15_omp_outlined(ptr [[DOTTHREADID_TEMP_]], ptr [[DOTZERO_ADDR]], ptr [[ARGC1]]) #[[ATTR3]]
// CHECK2-NEXT:    call void @__kmpc_free_shared(ptr [[ARGC1]], i32 4)
// CHECK2-NEXT:    call void @__kmpc_target_deinit()
// CHECK2-NEXT:    ret void
// CHECK2:       worker.exit:
// CHECK2-NEXT:    ret void
//
//
// CHECK2-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIPPcEiT__l15_omp_outlined
// CHECK2-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]], ptr noundef nonnull align 4 dereferenceable(4) [[ARGC:%.*]]) #[[ATTR2]] {
// CHECK2-NEXT:  entry:
// CHECK2-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 4
// CHECK2-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 4
// CHECK2-NEXT:    [[ARGC_ADDR:%.*]] = alloca ptr, align 4
// CHECK2-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 4
// CHECK2-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 4
// CHECK2-NEXT:    store ptr [[ARGC]], ptr [[ARGC_ADDR]], align 4
// CHECK2-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[ARGC_ADDR]], align 4
// CHECK2-NEXT:    store ptr null, ptr [[TMP0]], align 4
// CHECK2-NEXT:    ret void
//
//
// CHECK3-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l64
// CHECK3-SAME: (ptr noalias noundef [[DYN_PTR:%.*]], i64 noundef [[A:%.*]], i64 noundef [[B:%.*]], i64 noundef [[ARGC:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK3-NEXT:  entry:
// CHECK3-NEXT:    [[DYN_PTR_ADDR:%.*]] = alloca ptr, align 8
// CHECK3-NEXT:    [[A_ADDR:%.*]] = alloca i64, align 8
// CHECK3-NEXT:    [[B_ADDR:%.*]] = alloca i64, align 8
// CHECK3-NEXT:    [[ARGC_ADDR:%.*]] = alloca i64, align 8
// CHECK3-NEXT:    [[DOTZERO_ADDR:%.*]] = alloca i32, align 4
// CHECK3-NEXT:    [[DOTTHREADID_TEMP_:%.*]] = alloca i32, align 4
// CHECK3-NEXT:    store ptr [[DYN_PTR]], ptr [[DYN_PTR_ADDR]], align 8
// CHECK3-NEXT:    store i64 [[A]], ptr [[A_ADDR]], align 8
// CHECK3-NEXT:    store i64 [[B]], ptr [[B_ADDR]], align 8
// CHECK3-NEXT:    store i64 [[ARGC]], ptr [[ARGC_ADDR]], align 8
// CHECK3-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_target_init(ptr @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l64_kernel_environment, ptr [[DYN_PTR]])
// CHECK3-NEXT:    [[EXEC_USER_CODE:%.*]] = icmp eq i32 [[TMP0]], -1
// CHECK3-NEXT:    br i1 [[EXEC_USER_CODE]], label [[USER_CODE_ENTRY:%.*]], label [[WORKER_EXIT:%.*]]
// CHECK3:       user_code.entry:
// CHECK3-NEXT:    [[TMP1:%.*]] = load i32, ptr [[ARGC_ADDR]], align 4
// CHECK3-NEXT:    [[ARGC1:%.*]] = call align 8 ptr @__kmpc_alloc_shared(i64 4)
// CHECK3-NEXT:    store i32 [[TMP1]], ptr [[ARGC1]], align 4
// CHECK3-NEXT:    [[TMP2:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1:[0-9]+]])
// CHECK3-NEXT:    store i32 0, ptr [[DOTZERO_ADDR]], align 4
// CHECK3-NEXT:    store i32 [[TMP2]], ptr [[DOTTHREADID_TEMP_]], align 4
// CHECK3-NEXT:    call void @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l64_omp_outlined(ptr [[DOTTHREADID_TEMP_]], ptr [[DOTZERO_ADDR]], ptr [[ARGC1]]) #[[ATTR3:[0-9]+]]
// CHECK3-NEXT:    call void @__kmpc_free_shared(ptr [[ARGC1]], i64 4)
// CHECK3-NEXT:    call void @__kmpc_target_deinit()
// CHECK3-NEXT:    ret void
// CHECK3:       worker.exit:
// CHECK3-NEXT:    ret void
//
//
// CHECK3-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l64_omp_outlined
// CHECK3-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]], ptr noundef nonnull align 4 dereferenceable(4) [[ARGC:%.*]]) #[[ATTR2:[0-9]+]] {
// CHECK3-NEXT:  entry:
// CHECK3-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK3-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK3-NEXT:    [[ARGC_ADDR:%.*]] = alloca ptr, align 8
// CHECK3-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK3-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 8
// CHECK3-NEXT:    store ptr [[ARGC]], ptr [[ARGC_ADDR]], align 8
// CHECK3-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[ARGC_ADDR]], align 8
// CHECK3-NEXT:    store i32 0, ptr [[TMP0]], align 4
// CHECK3-NEXT:    ret void
//
//
// CHECK3-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIPPcEiT__l53
// CHECK3-SAME: (ptr noalias noundef [[DYN_PTR:%.*]], i64 noundef [[A:%.*]], i64 noundef [[B:%.*]], ptr noundef [[ARGC:%.*]]) #[[ATTR0]] {
// CHECK3-NEXT:  entry:
// CHECK3-NEXT:    [[DYN_PTR_ADDR:%.*]] = alloca ptr, align 8
// CHECK3-NEXT:    [[A_ADDR:%.*]] = alloca i64, align 8
// CHECK3-NEXT:    [[B_ADDR:%.*]] = alloca i64, align 8
// CHECK3-NEXT:    [[ARGC_ADDR:%.*]] = alloca ptr, align 8
// CHECK3-NEXT:    [[DOTZERO_ADDR:%.*]] = alloca i32, align 4
// CHECK3-NEXT:    [[DOTTHREADID_TEMP_:%.*]] = alloca i32, align 4
// CHECK3-NEXT:    store ptr [[DYN_PTR]], ptr [[DYN_PTR_ADDR]], align 8
// CHECK3-NEXT:    store i64 [[A]], ptr [[A_ADDR]], align 8
// CHECK3-NEXT:    store i64 [[B]], ptr [[B_ADDR]], align 8
// CHECK3-NEXT:    store ptr [[ARGC]], ptr [[ARGC_ADDR]], align 8
// CHECK3-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_target_init(ptr @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIPPcEiT__l53_kernel_environment, ptr [[DYN_PTR]])
// CHECK3-NEXT:    [[EXEC_USER_CODE:%.*]] = icmp eq i32 [[TMP0]], -1
// CHECK3-NEXT:    br i1 [[EXEC_USER_CODE]], label [[USER_CODE_ENTRY:%.*]], label [[WORKER_EXIT:%.*]]
// CHECK3:       user_code.entry:
// CHECK3-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[ARGC_ADDR]], align 8
// CHECK3-NEXT:    [[ARGC1:%.*]] = call align 8 ptr @__kmpc_alloc_shared(i64 8)
// CHECK3-NEXT:    store ptr [[TMP1]], ptr [[ARGC1]], align 8
// CHECK3-NEXT:    [[TMP2:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK3-NEXT:    store i32 0, ptr [[DOTZERO_ADDR]], align 4
// CHECK3-NEXT:    store i32 [[TMP2]], ptr [[DOTTHREADID_TEMP_]], align 4
// CHECK3-NEXT:    call void @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIPPcEiT__l53_omp_outlined(ptr [[DOTTHREADID_TEMP_]], ptr [[DOTZERO_ADDR]], ptr [[ARGC1]]) #[[ATTR3]]
// CHECK3-NEXT:    call void @__kmpc_free_shared(ptr [[ARGC1]], i64 8)
// CHECK3-NEXT:    call void @__kmpc_target_deinit()
// CHECK3-NEXT:    ret void
// CHECK3:       worker.exit:
// CHECK3-NEXT:    ret void
//
//
// CHECK3-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIPPcEiT__l53_omp_outlined
// CHECK3-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]], ptr noundef nonnull align 8 dereferenceable(8) [[ARGC:%.*]]) #[[ATTR2]] {
// CHECK3-NEXT:  entry:
// CHECK3-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK3-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK3-NEXT:    [[ARGC_ADDR:%.*]] = alloca ptr, align 8
// CHECK3-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK3-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 8
// CHECK3-NEXT:    store ptr [[ARGC]], ptr [[ARGC_ADDR]], align 8
// CHECK3-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[ARGC_ADDR]], align 8
// CHECK3-NEXT:    store ptr null, ptr [[TMP0]], align 8
// CHECK3-NEXT:    ret void
//
//
// CHECK4-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l64
// CHECK4-SAME: (ptr noalias noundef [[DYN_PTR:%.*]], i32 noundef [[A:%.*]], i32 noundef [[B:%.*]], i32 noundef [[ARGC:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK4-NEXT:  entry:
// CHECK4-NEXT:    [[DYN_PTR_ADDR:%.*]] = alloca ptr, align 4
// CHECK4-NEXT:    [[A_ADDR:%.*]] = alloca i32, align 4
// CHECK4-NEXT:    [[B_ADDR:%.*]] = alloca i32, align 4
// CHECK4-NEXT:    [[ARGC_ADDR:%.*]] = alloca i32, align 4
// CHECK4-NEXT:    [[DOTZERO_ADDR:%.*]] = alloca i32, align 4
// CHECK4-NEXT:    [[DOTTHREADID_TEMP_:%.*]] = alloca i32, align 4
// CHECK4-NEXT:    store ptr [[DYN_PTR]], ptr [[DYN_PTR_ADDR]], align 4
// CHECK4-NEXT:    store i32 [[A]], ptr [[A_ADDR]], align 4
// CHECK4-NEXT:    store i32 [[B]], ptr [[B_ADDR]], align 4
// CHECK4-NEXT:    store i32 [[ARGC]], ptr [[ARGC_ADDR]], align 4
// CHECK4-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_target_init(ptr @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l64_kernel_environment, ptr [[DYN_PTR]])
// CHECK4-NEXT:    [[EXEC_USER_CODE:%.*]] = icmp eq i32 [[TMP0]], -1
// CHECK4-NEXT:    br i1 [[EXEC_USER_CODE]], label [[USER_CODE_ENTRY:%.*]], label [[WORKER_EXIT:%.*]]
// CHECK4:       user_code.entry:
// CHECK4-NEXT:    [[TMP1:%.*]] = load i32, ptr [[ARGC_ADDR]], align 4
// CHECK4-NEXT:    [[ARGC1:%.*]] = call align 8 ptr @__kmpc_alloc_shared(i32 4)
// CHECK4-NEXT:    store i32 [[TMP1]], ptr [[ARGC1]], align 4
// CHECK4-NEXT:    [[TMP2:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1:[0-9]+]])
// CHECK4-NEXT:    store i32 0, ptr [[DOTZERO_ADDR]], align 4
// CHECK4-NEXT:    store i32 [[TMP2]], ptr [[DOTTHREADID_TEMP_]], align 4
// CHECK4-NEXT:    call void @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l64_omp_outlined(ptr [[DOTTHREADID_TEMP_]], ptr [[DOTZERO_ADDR]], ptr [[ARGC1]]) #[[ATTR3:[0-9]+]]
// CHECK4-NEXT:    call void @__kmpc_free_shared(ptr [[ARGC1]], i32 4)
// CHECK4-NEXT:    call void @__kmpc_target_deinit()
// CHECK4-NEXT:    ret void
// CHECK4:       worker.exit:
// CHECK4-NEXT:    ret void
//
//
// CHECK4-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l64_omp_outlined
// CHECK4-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]], ptr noundef nonnull align 4 dereferenceable(4) [[ARGC:%.*]]) #[[ATTR2:[0-9]+]] {
// CHECK4-NEXT:  entry:
// CHECK4-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 4
// CHECK4-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 4
// CHECK4-NEXT:    [[ARGC_ADDR:%.*]] = alloca ptr, align 4
// CHECK4-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 4
// CHECK4-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 4
// CHECK4-NEXT:    store ptr [[ARGC]], ptr [[ARGC_ADDR]], align 4
// CHECK4-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[ARGC_ADDR]], align 4
// CHECK4-NEXT:    store i32 0, ptr [[TMP0]], align 4
// CHECK4-NEXT:    ret void
//
//
// CHECK4-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIPPcEiT__l53
// CHECK4-SAME: (ptr noalias noundef [[DYN_PTR:%.*]], i32 noundef [[A:%.*]], i32 noundef [[B:%.*]], ptr noundef [[ARGC:%.*]]) #[[ATTR0]] {
// CHECK4-NEXT:  entry:
// CHECK4-NEXT:    [[DYN_PTR_ADDR:%.*]] = alloca ptr, align 4
// CHECK4-NEXT:    [[A_ADDR:%.*]] = alloca i32, align 4
// CHECK4-NEXT:    [[B_ADDR:%.*]] = alloca i32, align 4
// CHECK4-NEXT:    [[ARGC_ADDR:%.*]] = alloca ptr, align 4
// CHECK4-NEXT:    [[DOTZERO_ADDR:%.*]] = alloca i32, align 4
// CHECK4-NEXT:    [[DOTTHREADID_TEMP_:%.*]] = alloca i32, align 4
// CHECK4-NEXT:    store ptr [[DYN_PTR]], ptr [[DYN_PTR_ADDR]], align 4
// CHECK4-NEXT:    store i32 [[A]], ptr [[A_ADDR]], align 4
// CHECK4-NEXT:    store i32 [[B]], ptr [[B_ADDR]], align 4
// CHECK4-NEXT:    store ptr [[ARGC]], ptr [[ARGC_ADDR]], align 4
// CHECK4-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_target_init(ptr @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIPPcEiT__l53_kernel_environment, ptr [[DYN_PTR]])
// CHECK4-NEXT:    [[EXEC_USER_CODE:%.*]] = icmp eq i32 [[TMP0]], -1
// CHECK4-NEXT:    br i1 [[EXEC_USER_CODE]], label [[USER_CODE_ENTRY:%.*]], label [[WORKER_EXIT:%.*]]
// CHECK4:       user_code.entry:
// CHECK4-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[ARGC_ADDR]], align 4
// CHECK4-NEXT:    [[ARGC1:%.*]] = call align 8 ptr @__kmpc_alloc_shared(i32 4)
// CHECK4-NEXT:    store ptr [[TMP1]], ptr [[ARGC1]], align 4
// CHECK4-NEXT:    [[TMP2:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK4-NEXT:    store i32 0, ptr [[DOTZERO_ADDR]], align 4
// CHECK4-NEXT:    store i32 [[TMP2]], ptr [[DOTTHREADID_TEMP_]], align 4
// CHECK4-NEXT:    call void @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIPPcEiT__l53_omp_outlined(ptr [[DOTTHREADID_TEMP_]], ptr [[DOTZERO_ADDR]], ptr [[ARGC1]]) #[[ATTR3]]
// CHECK4-NEXT:    call void @__kmpc_free_shared(ptr [[ARGC1]], i32 4)
// CHECK4-NEXT:    call void @__kmpc_target_deinit()
// CHECK4-NEXT:    ret void
// CHECK4:       worker.exit:
// CHECK4-NEXT:    ret void
//
//
// CHECK4-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z5tmainIPPcEiT__l53_omp_outlined
// CHECK4-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]], ptr noundef nonnull align 4 dereferenceable(4) [[ARGC:%.*]]) #[[ATTR2]] {
// CHECK4-NEXT:  entry:
// CHECK4-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 4
// CHECK4-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 4
// CHECK4-NEXT:    [[ARGC_ADDR:%.*]] = alloca ptr, align 4
// CHECK4-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 4
// CHECK4-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 4
// CHECK4-NEXT:    store ptr [[ARGC]], ptr [[ARGC_ADDR]], align 4
// CHECK4-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[ARGC_ADDR]], align 4
// CHECK4-NEXT:    store ptr null, ptr [[TMP0]], align 4
// CHECK4-NEXT:    ret void
//
