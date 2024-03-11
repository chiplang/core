// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --include-generated-funcs
// RUN: %clang_cc1 -verify -triple x86_64-unknown-linux -fopenmp -x c++ -emit-llvm %s -o - | FileCheck %s

// expected-no-diagnostics
typedef void *omp_interop_t;

void test1() {

  int device_id = 4;
  int D0, D1, D2;
  omp_interop_t interop;

#pragma omp interop init(target : interop)

#pragma omp interop init(targetsync : interop)

#pragma omp interop init(target : interop) device(device_id)

#pragma omp interop init(targetsync : interop) device(device_id)

#pragma omp interop use(interop) depend(in : D0, D1) nowait

#pragma omp interop use(interop) depend(in : D0) depend(inout : D1) \
    depend(out : D2) nowait

#pragma omp interop destroy(interop) depend(in : D0, D1)
}

struct S {
  omp_interop_t interop;
  void member_test();
};

void S::member_test() {

  int device_id = 4;
  int D0, D1, D2;

#pragma omp interop init(target : interop)

#pragma omp interop init(targetsync : interop)

#pragma omp interop init(target : interop) device(device_id)

#pragma omp interop init(targetsync : interop) device(device_id)

#pragma omp interop use(interop) depend(in : D0, D1) nowait

#pragma omp interop use(interop) depend(in : D0) depend(inout : D1) \
    depend(out : D2) nowait

#pragma omp interop destroy(interop) depend(in : D0, D1)
}
// CHECK-LABEL: @_Z5test1v(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DEVICE_ID:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[D0:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[D1:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[D2:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[INTEROP:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[DOTDEP_ARR_ADDR:%.*]] = alloca [2 x %struct.kmp_depend_info], align 8
// CHECK-NEXT:    [[DEP_COUNTER_ADDR:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[DOTDEP_ARR_ADDR5:%.*]] = alloca [3 x %struct.kmp_depend_info], align 8
// CHECK-NEXT:    [[DEP_COUNTER_ADDR6:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[DOTDEP_ARR_ADDR8:%.*]] = alloca [2 x %struct.kmp_depend_info], align 8
// CHECK-NEXT:    [[DEP_COUNTER_ADDR9:%.*]] = alloca i64, align 8
// CHECK-NEXT:    store i32 4, ptr [[DEVICE_ID]], align 4
// CHECK-NEXT:    [[OMP_GLOBAL_THREAD_NUM:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1:[0-9]+]])
// CHECK-NEXT:    call void @__tgt_interop_init(ptr @[[GLOB1]], i32 [[OMP_GLOBAL_THREAD_NUM]], ptr [[INTEROP]], i32 1, i32 -1, i32 0, ptr null, i32 0)
// CHECK-NEXT:    [[OMP_GLOBAL_THREAD_NUM1:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK-NEXT:    call void @__tgt_interop_init(ptr @[[GLOB1]], i32 [[OMP_GLOBAL_THREAD_NUM1]], ptr [[INTEROP]], i32 2, i32 -1, i32 0, ptr null, i32 0)
// CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[DEVICE_ID]], align 4
// CHECK-NEXT:    [[OMP_GLOBAL_THREAD_NUM2:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK-NEXT:    call void @__tgt_interop_init(ptr @[[GLOB1]], i32 [[OMP_GLOBAL_THREAD_NUM2]], ptr [[INTEROP]], i32 1, i32 [[TMP0]], i32 0, ptr null, i32 0)
// CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[DEVICE_ID]], align 4
// CHECK-NEXT:    [[OMP_GLOBAL_THREAD_NUM3:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK-NEXT:    call void @__tgt_interop_init(ptr @[[GLOB1]], i32 [[OMP_GLOBAL_THREAD_NUM3]], ptr [[INTEROP]], i32 2, i32 [[TMP1]], i32 0, ptr null, i32 0)
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [2 x %struct.kmp_depend_info], ptr [[DOTDEP_ARR_ADDR]], i64 0, i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = ptrtoint ptr [[D0]] to i64
// CHECK-NEXT:    [[TMP4:%.*]] = getelementptr [[STRUCT_KMP_DEPEND_INFO:%.*]], ptr [[TMP2]], i64 0
// CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP4]], i32 0, i32 0
// CHECK-NEXT:    store i64 [[TMP3]], ptr [[TMP5]], align 8
// CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP4]], i32 0, i32 1
// CHECK-NEXT:    store i64 4, ptr [[TMP6]], align 8
// CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP4]], i32 0, i32 2
// CHECK-NEXT:    store i8 1, ptr [[TMP7]], align 8
// CHECK-NEXT:    [[TMP8:%.*]] = ptrtoint ptr [[D1]] to i64
// CHECK-NEXT:    [[TMP9:%.*]] = getelementptr [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP2]], i64 1
// CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP9]], i32 0, i32 0
// CHECK-NEXT:    store i64 [[TMP8]], ptr [[TMP10]], align 8
// CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP9]], i32 0, i32 1
// CHECK-NEXT:    store i64 4, ptr [[TMP11]], align 8
// CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP9]], i32 0, i32 2
// CHECK-NEXT:    store i8 1, ptr [[TMP12]], align 8
// CHECK-NEXT:    store i64 2, ptr [[DEP_COUNTER_ADDR]], align 8
// CHECK-NEXT:    [[OMP_GLOBAL_THREAD_NUM4:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK-NEXT:    call void @__tgt_interop_use(ptr @[[GLOB1]], i32 [[OMP_GLOBAL_THREAD_NUM4]], ptr [[INTEROP]], i32 -1, i32 2, ptr [[TMP2]], i32 1)
// CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds [3 x %struct.kmp_depend_info], ptr [[DOTDEP_ARR_ADDR5]], i64 0, i64 0
// CHECK-NEXT:    [[TMP14:%.*]] = ptrtoint ptr [[D0]] to i64
// CHECK-NEXT:    [[TMP15:%.*]] = getelementptr [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP13]], i64 0
// CHECK-NEXT:    [[TMP16:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP15]], i32 0, i32 0
// CHECK-NEXT:    store i64 [[TMP14]], ptr [[TMP16]], align 8
// CHECK-NEXT:    [[TMP17:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP15]], i32 0, i32 1
// CHECK-NEXT:    store i64 4, ptr [[TMP17]], align 8
// CHECK-NEXT:    [[TMP18:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP15]], i32 0, i32 2
// CHECK-NEXT:    store i8 1, ptr [[TMP18]], align 8
// CHECK-NEXT:    [[TMP19:%.*]] = ptrtoint ptr [[D1]] to i64
// CHECK-NEXT:    [[TMP20:%.*]] = getelementptr [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP13]], i64 1
// CHECK-NEXT:    [[TMP21:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP20]], i32 0, i32 0
// CHECK-NEXT:    store i64 [[TMP19]], ptr [[TMP21]], align 8
// CHECK-NEXT:    [[TMP22:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP20]], i32 0, i32 1
// CHECK-NEXT:    store i64 4, ptr [[TMP22]], align 8
// CHECK-NEXT:    [[TMP23:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP20]], i32 0, i32 2
// CHECK-NEXT:    store i8 3, ptr [[TMP23]], align 8
// CHECK-NEXT:    [[TMP24:%.*]] = ptrtoint ptr [[D2]] to i64
// CHECK-NEXT:    [[TMP25:%.*]] = getelementptr [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP13]], i64 2
// CHECK-NEXT:    [[TMP26:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP25]], i32 0, i32 0
// CHECK-NEXT:    store i64 [[TMP24]], ptr [[TMP26]], align 8
// CHECK-NEXT:    [[TMP27:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP25]], i32 0, i32 1
// CHECK-NEXT:    store i64 4, ptr [[TMP27]], align 8
// CHECK-NEXT:    [[TMP28:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP25]], i32 0, i32 2
// CHECK-NEXT:    store i8 3, ptr [[TMP28]], align 8
// CHECK-NEXT:    store i64 3, ptr [[DEP_COUNTER_ADDR6]], align 8
// CHECK-NEXT:    [[OMP_GLOBAL_THREAD_NUM7:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK-NEXT:    call void @__tgt_interop_use(ptr @[[GLOB1]], i32 [[OMP_GLOBAL_THREAD_NUM7]], ptr [[INTEROP]], i32 -1, i32 3, ptr [[TMP13]], i32 1)
// CHECK-NEXT:    [[TMP29:%.*]] = getelementptr inbounds [2 x %struct.kmp_depend_info], ptr [[DOTDEP_ARR_ADDR8]], i64 0, i64 0
// CHECK-NEXT:    [[TMP30:%.*]] = ptrtoint ptr [[D0]] to i64
// CHECK-NEXT:    [[TMP31:%.*]] = getelementptr [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP29]], i64 0
// CHECK-NEXT:    [[TMP32:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP31]], i32 0, i32 0
// CHECK-NEXT:    store i64 [[TMP30]], ptr [[TMP32]], align 8
// CHECK-NEXT:    [[TMP33:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP31]], i32 0, i32 1
// CHECK-NEXT:    store i64 4, ptr [[TMP33]], align 8
// CHECK-NEXT:    [[TMP34:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP31]], i32 0, i32 2
// CHECK-NEXT:    store i8 1, ptr [[TMP34]], align 8
// CHECK-NEXT:    [[TMP35:%.*]] = ptrtoint ptr [[D1]] to i64
// CHECK-NEXT:    [[TMP36:%.*]] = getelementptr [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP29]], i64 1
// CHECK-NEXT:    [[TMP37:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP36]], i32 0, i32 0
// CHECK-NEXT:    store i64 [[TMP35]], ptr [[TMP37]], align 8
// CHECK-NEXT:    [[TMP38:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP36]], i32 0, i32 1
// CHECK-NEXT:    store i64 4, ptr [[TMP38]], align 8
// CHECK-NEXT:    [[TMP39:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP36]], i32 0, i32 2
// CHECK-NEXT:    store i8 1, ptr [[TMP39]], align 8
// CHECK-NEXT:    store i64 2, ptr [[DEP_COUNTER_ADDR9]], align 8
// CHECK-NEXT:    [[OMP_GLOBAL_THREAD_NUM10:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK-NEXT:    call void @__tgt_interop_destroy(ptr @[[GLOB1]], i32 [[OMP_GLOBAL_THREAD_NUM10]], ptr [[INTEROP]], i32 -1, i32 2, ptr [[TMP29]], i32 0)
// CHECK-NEXT:    ret void
//
//
// CHECK-LABEL: @_ZN1S11member_testEv(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[DEVICE_ID:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[D0:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[D1:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[D2:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[DOTDEP_ARR_ADDR:%.*]] = alloca [2 x %struct.kmp_depend_info], align 8
// CHECK-NEXT:    [[DEP_COUNTER_ADDR:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[DOTDEP_ARR_ADDR10:%.*]] = alloca [3 x %struct.kmp_depend_info], align 8
// CHECK-NEXT:    [[DEP_COUNTER_ADDR11:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[DOTDEP_ARR_ADDR14:%.*]] = alloca [2 x %struct.kmp_depend_info], align 8
// CHECK-NEXT:    [[DEP_COUNTER_ADDR15:%.*]] = alloca i64, align 8
// CHECK-NEXT:    store ptr [[THIS:%.*]], ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    [[THIS1:%.*]] = load ptr, ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    store i32 4, ptr [[DEVICE_ID]], align 4
// CHECK-NEXT:    [[INTEROP:%.*]] = getelementptr inbounds [[STRUCT_S:%.*]], ptr [[THIS1]], i32 0, i32 0
// CHECK-NEXT:    [[OMP_GLOBAL_THREAD_NUM:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK-NEXT:    call void @__tgt_interop_init(ptr @[[GLOB1]], i32 [[OMP_GLOBAL_THREAD_NUM]], ptr [[INTEROP]], i32 1, i32 -1, i32 0, ptr null, i32 0)
// CHECK-NEXT:    [[INTEROP2:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[THIS1]], i32 0, i32 0
// CHECK-NEXT:    [[OMP_GLOBAL_THREAD_NUM3:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK-NEXT:    call void @__tgt_interop_init(ptr @[[GLOB1]], i32 [[OMP_GLOBAL_THREAD_NUM3]], ptr [[INTEROP2]], i32 2, i32 -1, i32 0, ptr null, i32 0)
// CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[DEVICE_ID]], align 4
// CHECK-NEXT:    [[INTEROP4:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[THIS1]], i32 0, i32 0
// CHECK-NEXT:    [[OMP_GLOBAL_THREAD_NUM5:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK-NEXT:    call void @__tgt_interop_init(ptr @[[GLOB1]], i32 [[OMP_GLOBAL_THREAD_NUM5]], ptr [[INTEROP4]], i32 1, i32 [[TMP0]], i32 0, ptr null, i32 0)
// CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[DEVICE_ID]], align 4
// CHECK-NEXT:    [[INTEROP6:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[THIS1]], i32 0, i32 0
// CHECK-NEXT:    [[OMP_GLOBAL_THREAD_NUM7:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK-NEXT:    call void @__tgt_interop_init(ptr @[[GLOB1]], i32 [[OMP_GLOBAL_THREAD_NUM7]], ptr [[INTEROP6]], i32 2, i32 [[TMP1]], i32 0, ptr null, i32 0)
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [2 x %struct.kmp_depend_info], ptr [[DOTDEP_ARR_ADDR]], i64 0, i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = ptrtoint ptr [[D0]] to i64
// CHECK-NEXT:    [[TMP4:%.*]] = getelementptr [[STRUCT_KMP_DEPEND_INFO:%.*]], ptr [[TMP2]], i64 0
// CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP4]], i32 0, i32 0
// CHECK-NEXT:    store i64 [[TMP3]], ptr [[TMP5]], align 8
// CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP4]], i32 0, i32 1
// CHECK-NEXT:    store i64 4, ptr [[TMP6]], align 8
// CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP4]], i32 0, i32 2
// CHECK-NEXT:    store i8 1, ptr [[TMP7]], align 8
// CHECK-NEXT:    [[TMP8:%.*]] = ptrtoint ptr [[D1]] to i64
// CHECK-NEXT:    [[TMP9:%.*]] = getelementptr [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP2]], i64 1
// CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP9]], i32 0, i32 0
// CHECK-NEXT:    store i64 [[TMP8]], ptr [[TMP10]], align 8
// CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP9]], i32 0, i32 1
// CHECK-NEXT:    store i64 4, ptr [[TMP11]], align 8
// CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP9]], i32 0, i32 2
// CHECK-NEXT:    store i8 1, ptr [[TMP12]], align 8
// CHECK-NEXT:    store i64 2, ptr [[DEP_COUNTER_ADDR]], align 8
// CHECK-NEXT:    [[INTEROP8:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[THIS1]], i32 0, i32 0
// CHECK-NEXT:    [[OMP_GLOBAL_THREAD_NUM9:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK-NEXT:    call void @__tgt_interop_use(ptr @[[GLOB1]], i32 [[OMP_GLOBAL_THREAD_NUM9]], ptr [[INTEROP8]], i32 -1, i32 2, ptr [[TMP2]], i32 1)
// CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds [3 x %struct.kmp_depend_info], ptr [[DOTDEP_ARR_ADDR10]], i64 0, i64 0
// CHECK-NEXT:    [[TMP14:%.*]] = ptrtoint ptr [[D0]] to i64
// CHECK-NEXT:    [[TMP15:%.*]] = getelementptr [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP13]], i64 0
// CHECK-NEXT:    [[TMP16:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP15]], i32 0, i32 0
// CHECK-NEXT:    store i64 [[TMP14]], ptr [[TMP16]], align 8
// CHECK-NEXT:    [[TMP17:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP15]], i32 0, i32 1
// CHECK-NEXT:    store i64 4, ptr [[TMP17]], align 8
// CHECK-NEXT:    [[TMP18:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP15]], i32 0, i32 2
// CHECK-NEXT:    store i8 1, ptr [[TMP18]], align 8
// CHECK-NEXT:    [[TMP19:%.*]] = ptrtoint ptr [[D1]] to i64
// CHECK-NEXT:    [[TMP20:%.*]] = getelementptr [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP13]], i64 1
// CHECK-NEXT:    [[TMP21:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP20]], i32 0, i32 0
// CHECK-NEXT:    store i64 [[TMP19]], ptr [[TMP21]], align 8
// CHECK-NEXT:    [[TMP22:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP20]], i32 0, i32 1
// CHECK-NEXT:    store i64 4, ptr [[TMP22]], align 8
// CHECK-NEXT:    [[TMP23:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP20]], i32 0, i32 2
// CHECK-NEXT:    store i8 3, ptr [[TMP23]], align 8
// CHECK-NEXT:    [[TMP24:%.*]] = ptrtoint ptr [[D2]] to i64
// CHECK-NEXT:    [[TMP25:%.*]] = getelementptr [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP13]], i64 2
// CHECK-NEXT:    [[TMP26:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP25]], i32 0, i32 0
// CHECK-NEXT:    store i64 [[TMP24]], ptr [[TMP26]], align 8
// CHECK-NEXT:    [[TMP27:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP25]], i32 0, i32 1
// CHECK-NEXT:    store i64 4, ptr [[TMP27]], align 8
// CHECK-NEXT:    [[TMP28:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP25]], i32 0, i32 2
// CHECK-NEXT:    store i8 3, ptr [[TMP28]], align 8
// CHECK-NEXT:    store i64 3, ptr [[DEP_COUNTER_ADDR11]], align 8
// CHECK-NEXT:    [[INTEROP12:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[THIS1]], i32 0, i32 0
// CHECK-NEXT:    [[OMP_GLOBAL_THREAD_NUM13:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK-NEXT:    call void @__tgt_interop_use(ptr @[[GLOB1]], i32 [[OMP_GLOBAL_THREAD_NUM13]], ptr [[INTEROP12]], i32 -1, i32 3, ptr [[TMP13]], i32 1)
// CHECK-NEXT:    [[TMP29:%.*]] = getelementptr inbounds [2 x %struct.kmp_depend_info], ptr [[DOTDEP_ARR_ADDR14]], i64 0, i64 0
// CHECK-NEXT:    [[TMP30:%.*]] = ptrtoint ptr [[D0]] to i64
// CHECK-NEXT:    [[TMP31:%.*]] = getelementptr [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP29]], i64 0
// CHECK-NEXT:    [[TMP32:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP31]], i32 0, i32 0
// CHECK-NEXT:    store i64 [[TMP30]], ptr [[TMP32]], align 8
// CHECK-NEXT:    [[TMP33:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP31]], i32 0, i32 1
// CHECK-NEXT:    store i64 4, ptr [[TMP33]], align 8
// CHECK-NEXT:    [[TMP34:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP31]], i32 0, i32 2
// CHECK-NEXT:    store i8 1, ptr [[TMP34]], align 8
// CHECK-NEXT:    [[TMP35:%.*]] = ptrtoint ptr [[D1]] to i64
// CHECK-NEXT:    [[TMP36:%.*]] = getelementptr [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP29]], i64 1
// CHECK-NEXT:    [[TMP37:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP36]], i32 0, i32 0
// CHECK-NEXT:    store i64 [[TMP35]], ptr [[TMP37]], align 8
// CHECK-NEXT:    [[TMP38:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP36]], i32 0, i32 1
// CHECK-NEXT:    store i64 4, ptr [[TMP38]], align 8
// CHECK-NEXT:    [[TMP39:%.*]] = getelementptr inbounds [[STRUCT_KMP_DEPEND_INFO]], ptr [[TMP36]], i32 0, i32 2
// CHECK-NEXT:    store i8 1, ptr [[TMP39]], align 8
// CHECK-NEXT:    store i64 2, ptr [[DEP_COUNTER_ADDR15]], align 8
// CHECK-NEXT:    [[INTEROP16:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[THIS1]], i32 0, i32 0
// CHECK-NEXT:    [[OMP_GLOBAL_THREAD_NUM17:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK-NEXT:    call void @__tgt_interop_destroy(ptr @[[GLOB1]], i32 [[OMP_GLOBAL_THREAD_NUM17]], ptr [[INTEROP16]], i32 -1, i32 2, ptr [[TMP29]], i32 0)
// CHECK-NEXT:    ret void
//
