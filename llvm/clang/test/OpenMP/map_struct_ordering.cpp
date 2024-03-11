// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --include-generated-funcs --replace-value-regex "__omp_offloading_[0-9a-z]+_[0-9a-z]+" --prefix-filecheck-ir-name _ --version 4

// RUN: %clang_cc1  -verify -fopenmp -x c++ -std=c++11 -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -emit-llvm %s -o - -Wno-openmp-mapping | FileCheck %s --check-prefix=CHECK

// expected-no-diagnostics
#ifndef HEADER
#define HEADER

struct Descriptor {
  int *datum;
  long int x;
  int xi;
  long int arr[1][30];
};

int map_struct() {
  Descriptor dat = Descriptor();
  dat.xi = 3;
  dat.arr[0][0] = 1;

  #pragma omp target enter data map(to: dat.datum[:10]) map(to: dat)

  #pragma omp target
  {
    dat.xi = 4;
    dat.datum[dat.arr[0][0]] = dat.xi;
  }

  #pragma omp target exit data map(from: dat)

  return dat.xi;
}

#endif
// CHECK-LABEL: define dso_local noundef signext i32 @_Z10map_structv(
// CHECK-SAME: ) #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DAT:%.*]] = alloca [[STRUCT_DESCRIPTOR:%.*]], align 8
// CHECK-NEXT:    [[DOTOFFLOAD_BASEPTRS:%.*]] = alloca [3 x ptr], align 8
// CHECK-NEXT:    [[DOTOFFLOAD_PTRS:%.*]] = alloca [3 x ptr], align 8
// CHECK-NEXT:    [[DOTOFFLOAD_MAPPERS:%.*]] = alloca [3 x ptr], align 8
// CHECK-NEXT:    [[DOTOFFLOAD_SIZES:%.*]] = alloca [3 x i64], align 8
// CHECK-NEXT:    [[DOTOFFLOAD_BASEPTRS4:%.*]] = alloca [1 x ptr], align 8
// CHECK-NEXT:    [[DOTOFFLOAD_PTRS5:%.*]] = alloca [1 x ptr], align 8
// CHECK-NEXT:    [[DOTOFFLOAD_MAPPERS6:%.*]] = alloca [1 x ptr], align 8
// CHECK-NEXT:    [[KERNEL_ARGS:%.*]] = alloca [[STRUCT___TGT_KERNEL_ARGUMENTS:%.*]], align 8
// CHECK-NEXT:    [[DOTOFFLOAD_BASEPTRS7:%.*]] = alloca [1 x ptr], align 8
// CHECK-NEXT:    [[DOTOFFLOAD_PTRS8:%.*]] = alloca [1 x ptr], align 8
// CHECK-NEXT:    [[DOTOFFLOAD_MAPPERS9:%.*]] = alloca [1 x ptr], align 8
// CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 8 [[DAT]], i8 0, i64 264, i1 false)
// CHECK-NEXT:    [[XI:%.*]] = getelementptr inbounds [[STRUCT_DESCRIPTOR]], ptr [[DAT]], i32 0, i32 2
// CHECK-NEXT:    store i32 3, ptr [[XI]], align 8
// CHECK-NEXT:    [[ARR:%.*]] = getelementptr inbounds [[STRUCT_DESCRIPTOR]], ptr [[DAT]], i32 0, i32 3
// CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [1 x [30 x i64]], ptr [[ARR]], i64 0, i64 0
// CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds [30 x i64], ptr [[ARRAYIDX]], i64 0, i64 0
// CHECK-NEXT:    store i64 1, ptr [[ARRAYIDX1]], align 8
// CHECK-NEXT:    [[DATUM:%.*]] = getelementptr inbounds [[STRUCT_DESCRIPTOR]], ptr [[DAT]], i32 0, i32 0
// CHECK-NEXT:    [[DATUM2:%.*]] = getelementptr inbounds [[STRUCT_DESCRIPTOR]], ptr [[DAT]], i32 0, i32 0
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[DATUM2]], align 8
// CHECK-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds i32, ptr [[TMP0]], i64 0
// CHECK-NEXT:    [[TMP1:%.*]] = getelementptr [[STRUCT_DESCRIPTOR]], ptr [[DAT]], i32 1
// CHECK-NEXT:    [[TMP2:%.*]] = ptrtoint ptr [[TMP1]] to i64
// CHECK-NEXT:    [[TMP3:%.*]] = ptrtoint ptr [[DAT]] to i64
// CHECK-NEXT:    [[TMP4:%.*]] = sub i64 [[TMP2]], [[TMP3]]
// CHECK-NEXT:    [[TMP5:%.*]] = sdiv exact i64 [[TMP4]], ptrtoint (ptr getelementptr (i8, ptr null, i32 1) to i64)
// CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 8 [[DOTOFFLOAD_SIZES]], ptr align 8 @.offload_sizes, i64 24, i1 false)
// CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [3 x ptr], ptr [[DOTOFFLOAD_BASEPTRS]], i32 0, i32 0
// CHECK-NEXT:    store ptr [[DAT]], ptr [[TMP6]], align 8
// CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds [3 x ptr], ptr [[DOTOFFLOAD_PTRS]], i32 0, i32 0
// CHECK-NEXT:    store ptr [[DAT]], ptr [[TMP7]], align 8
// CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds [3 x i64], ptr [[DOTOFFLOAD_SIZES]], i32 0, i32 0
// CHECK-NEXT:    store i64 [[TMP5]], ptr [[TMP8]], align 8
// CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds [3 x ptr], ptr [[DOTOFFLOAD_MAPPERS]], i64 0, i64 0
// CHECK-NEXT:    store ptr null, ptr [[TMP9]], align 8
// CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds [3 x ptr], ptr [[DOTOFFLOAD_BASEPTRS]], i32 0, i32 1
// CHECK-NEXT:    store ptr [[DAT]], ptr [[TMP10]], align 8
// CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds [3 x ptr], ptr [[DOTOFFLOAD_PTRS]], i32 0, i32 1
// CHECK-NEXT:    store ptr [[DAT]], ptr [[TMP11]], align 8
// CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds [3 x ptr], ptr [[DOTOFFLOAD_MAPPERS]], i64 0, i64 1
// CHECK-NEXT:    store ptr null, ptr [[TMP12]], align 8
// CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds [3 x ptr], ptr [[DOTOFFLOAD_BASEPTRS]], i32 0, i32 2
// CHECK-NEXT:    store ptr [[DATUM]], ptr [[TMP13]], align 8
// CHECK-NEXT:    [[TMP14:%.*]] = getelementptr inbounds [3 x ptr], ptr [[DOTOFFLOAD_PTRS]], i32 0, i32 2
// CHECK-NEXT:    store ptr [[ARRAYIDX3]], ptr [[TMP14]], align 8
// CHECK-NEXT:    [[TMP15:%.*]] = getelementptr inbounds [3 x ptr], ptr [[DOTOFFLOAD_MAPPERS]], i64 0, i64 2
// CHECK-NEXT:    store ptr null, ptr [[TMP15]], align 8
// CHECK-NEXT:    [[TMP16:%.*]] = getelementptr inbounds [3 x ptr], ptr [[DOTOFFLOAD_BASEPTRS]], i32 0, i32 0
// CHECK-NEXT:    [[TMP17:%.*]] = getelementptr inbounds [3 x ptr], ptr [[DOTOFFLOAD_PTRS]], i32 0, i32 0
// CHECK-NEXT:    [[TMP18:%.*]] = getelementptr inbounds [3 x i64], ptr [[DOTOFFLOAD_SIZES]], i32 0, i32 0
// CHECK-NEXT:    call void @__tgt_target_data_begin_mapper(ptr @[[GLOB1:[0-9]+]], i64 -1, i32 3, ptr [[TMP16]], ptr [[TMP17]], ptr [[TMP18]], ptr @.offload_maptypes, ptr null, ptr null)
// CHECK-NEXT:    [[TMP19:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_BASEPTRS4]], i32 0, i32 0
// CHECK-NEXT:    store ptr [[DAT]], ptr [[TMP19]], align 8
// CHECK-NEXT:    [[TMP20:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_PTRS5]], i32 0, i32 0
// CHECK-NEXT:    store ptr [[DAT]], ptr [[TMP20]], align 8
// CHECK-NEXT:    [[TMP21:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_MAPPERS6]], i64 0, i64 0
// CHECK-NEXT:    store ptr null, ptr [[TMP21]], align 8
// CHECK-NEXT:    [[TMP22:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_BASEPTRS4]], i32 0, i32 0
// CHECK-NEXT:    [[TMP23:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_PTRS5]], i32 0, i32 0
// CHECK-NEXT:    [[TMP24:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 0
// CHECK-NEXT:    store i32 2, ptr [[TMP24]], align 4
// CHECK-NEXT:    [[TMP25:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 1
// CHECK-NEXT:    store i32 1, ptr [[TMP25]], align 4
// CHECK-NEXT:    [[TMP26:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 2
// CHECK-NEXT:    store ptr [[TMP22]], ptr [[TMP26]], align 8
// CHECK-NEXT:    [[TMP27:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 3
// CHECK-NEXT:    store ptr [[TMP23]], ptr [[TMP27]], align 8
// CHECK-NEXT:    [[TMP28:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 4
// CHECK-NEXT:    store ptr @.offload_sizes.1, ptr [[TMP28]], align 8
// CHECK-NEXT:    [[TMP29:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 5
// CHECK-NEXT:    store ptr @.offload_maptypes.2, ptr [[TMP29]], align 8
// CHECK-NEXT:    [[TMP30:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 6
// CHECK-NEXT:    store ptr null, ptr [[TMP30]], align 8
// CHECK-NEXT:    [[TMP31:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 7
// CHECK-NEXT:    store ptr null, ptr [[TMP31]], align 8
// CHECK-NEXT:    [[TMP32:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 8
// CHECK-NEXT:    store i64 0, ptr [[TMP32]], align 8
// CHECK-NEXT:    [[TMP33:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 9
// CHECK-NEXT:    store i64 0, ptr [[TMP33]], align 8
// CHECK-NEXT:    [[TMP34:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 10
// CHECK-NEXT:    store [3 x i32] [i32 -1, i32 0, i32 0], ptr [[TMP34]], align 4
// CHECK-NEXT:    [[TMP35:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 11
// CHECK-NEXT:    store [3 x i32] zeroinitializer, ptr [[TMP35]], align 4
// CHECK-NEXT:    [[TMP36:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 12
// CHECK-NEXT:    store i32 0, ptr [[TMP36]], align 4
// CHECK-NEXT:    [[TMP37:%.*]] = call i32 @__tgt_target_kernel(ptr @[[GLOB1]], i64 -1, i32 -1, i32 0, ptr @.{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z10map_structv_l23.region_id, ptr [[KERNEL_ARGS]])
// CHECK-NEXT:    [[TMP38:%.*]] = icmp ne i32 [[TMP37]], 0
// CHECK-NEXT:    br i1 [[TMP38]], label [[OMP_OFFLOAD_FAILED:%.*]], label [[OMP_OFFLOAD_CONT:%.*]]
// CHECK:       omp_offload.failed:
// CHECK-NEXT:    call void @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z10map_structv_l23(ptr [[DAT]]) #[[ATTR3:[0-9]+]]
// CHECK-NEXT:    br label [[OMP_OFFLOAD_CONT]]
// CHECK:       omp_offload.cont:
// CHECK-NEXT:    [[TMP39:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_BASEPTRS7]], i32 0, i32 0
// CHECK-NEXT:    store ptr [[DAT]], ptr [[TMP39]], align 8
// CHECK-NEXT:    [[TMP40:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_PTRS8]], i32 0, i32 0
// CHECK-NEXT:    store ptr [[DAT]], ptr [[TMP40]], align 8
// CHECK-NEXT:    [[TMP41:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_MAPPERS9]], i64 0, i64 0
// CHECK-NEXT:    store ptr null, ptr [[TMP41]], align 8
// CHECK-NEXT:    [[TMP42:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_BASEPTRS7]], i32 0, i32 0
// CHECK-NEXT:    [[TMP43:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_PTRS8]], i32 0, i32 0
// CHECK-NEXT:    call void @__tgt_target_data_end_mapper(ptr @[[GLOB1]], i64 -1, i32 1, ptr [[TMP42]], ptr [[TMP43]], ptr @.offload_sizes.3, ptr @.offload_maptypes.4, ptr null, ptr null)
// CHECK-NEXT:    [[XI10:%.*]] = getelementptr inbounds [[STRUCT_DESCRIPTOR]], ptr [[DAT]], i32 0, i32 2
// CHECK-NEXT:    [[TMP44:%.*]] = load i32, ptr [[XI10]], align 8
// CHECK-NEXT:    ret i32 [[TMP44]]
//
//
// CHECK-LABEL: define internal void @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z10map_structv_l23(
// CHECK-SAME: ptr noundef nonnull align 8 dereferenceable(264) [[DAT:%.*]]) #[[ATTR4:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DAT_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[DAT]], ptr [[DAT_ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[DAT_ADDR]], align 8
// CHECK-NEXT:    [[XI:%.*]] = getelementptr inbounds [[STRUCT_DESCRIPTOR:%.*]], ptr [[TMP0]], i32 0, i32 2
// CHECK-NEXT:    store i32 4, ptr [[XI]], align 8
// CHECK-NEXT:    [[XI1:%.*]] = getelementptr inbounds [[STRUCT_DESCRIPTOR]], ptr [[TMP0]], i32 0, i32 2
// CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[XI1]], align 8
// CHECK-NEXT:    [[DATUM:%.*]] = getelementptr inbounds [[STRUCT_DESCRIPTOR]], ptr [[TMP0]], i32 0, i32 0
// CHECK-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[DATUM]], align 8
// CHECK-NEXT:    [[ARR:%.*]] = getelementptr inbounds [[STRUCT_DESCRIPTOR]], ptr [[TMP0]], i32 0, i32 3
// CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [1 x [30 x i64]], ptr [[ARR]], i64 0, i64 0
// CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds [30 x i64], ptr [[ARRAYIDX]], i64 0, i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = load i64, ptr [[ARRAYIDX2]], align 8
// CHECK-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds i32, ptr [[TMP2]], i64 [[TMP3]]
// CHECK-NEXT:    store i32 [[TMP1]], ptr [[ARRAYIDX3]], align 4
// CHECK-NEXT:    ret void
//
