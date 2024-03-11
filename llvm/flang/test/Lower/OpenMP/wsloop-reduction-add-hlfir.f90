! RUN: bbc -emit-hlfir -fopenmp %s -o - | FileCheck %s
! RUN: %flang_fc1 -emit-hlfir -fopenmp %s -o - | FileCheck %s

! NOTE: Assertions have been autogenerated by utils/generate-test-checks.py

! CHECK-LABEL:   omp.reduction.declare @add_reduction_i_32 : i32 init {
! CHECK:         ^bb0(%[[VAL_0:.*]]: i32):
! CHECK:           %[[VAL_1:.*]] = arith.constant 0 : i32
! CHECK:           omp.yield(%[[VAL_1]] : i32)

! CHECK-LABEL:   } combiner {
! CHECK:         ^bb0(%[[VAL_0:.*]]: i32, %[[VAL_1:.*]]: i32):
! CHECK:           %[[VAL_2:.*]] = arith.addi %[[VAL_0]], %[[VAL_1]] : i32
! CHECK:           omp.yield(%[[VAL_2]] : i32)
! CHECK:         }

! CHECK-LABEL:   func.func @_QPsimple_int_reduction()
! CHECK:           %[[VAL_0:.*]] = fir.alloca i32 {bindc_name = "i", uniq_name = "_QFsimple_int_reductionEi"}
! CHECK:           %[[VAL_1:.*]]:2 = hlfir.declare %[[VAL_0]] {uniq_name = "_QFsimple_int_reductionEi"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           %[[VAL_2:.*]] = fir.alloca i32 {bindc_name = "x", uniq_name = "_QFsimple_int_reductionEx"}
! CHECK:           %[[VAL_3:.*]]:2 = hlfir.declare %[[VAL_2]] {uniq_name = "_QFsimple_int_reductionEx"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           %[[VAL_4:.*]] = arith.constant 0 : i32
! CHECK:           hlfir.assign %[[VAL_4]] to %[[VAL_3]]#0 : i32, !fir.ref<i32>
! CHECK:           omp.parallel {
! CHECK:             %[[VAL_5:.*]] = fir.alloca i32 {adapt.valuebyref, pinned}
! CHECK:             %[[VAL_6:.*]]:2 = hlfir.declare %[[VAL_5]] {uniq_name = "_QFsimple_int_reductionEi"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:             %[[VAL_7:.*]] = arith.constant 1 : i32
! CHECK:             %[[VAL_8:.*]] = arith.constant 100 : i32
! CHECK:             %[[VAL_9:.*]] = arith.constant 1 : i32
! CHECK:             omp.wsloop reduction(@add_reduction_i_32 %[[VAL_3]]#0 -> %[[VAL_10:.*]] : !fir.ref<i32>)  for  (%[[VAL_11:.*]]) : i32 = (%[[VAL_7]]) to (%[[VAL_8]]) inclusive step (%[[VAL_9]])
! CHECK:               fir.store %[[VAL_11]] to %[[VAL_6]]#1 : !fir.ref<i32>
! CHECK:               %[[VAL_12:.*]]:2 = hlfir.declare %[[VAL_10]] {uniq_name = "_QFsimple_int_reductionEx"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:               %[[VAL_13:.*]] = fir.load %[[VAL_12]]#0 : !fir.ref<i32>
! CHECK:               %[[VAL_14:.*]] = fir.load %[[VAL_6]]#0 : !fir.ref<i32>
! CHECK:               %[[VAL_15:.*]] = arith.addi %[[VAL_13]], %[[VAL_14]] : i32
! CHECK:               hlfir.assign %[[VAL_15]] to %[[VAL_12]]#0 : i32, !fir.ref<i32>
! CHECK:               omp.yield
! CHECK:             omp.terminator
! CHECK:           return


subroutine simple_int_reduction
  integer :: x
  x = 0
  !$omp parallel
  !$omp do reduction(+:x)
  do i=1, 100
    x = x + i
  end do
  !$omp end do
  !$omp end parallel
end subroutine
