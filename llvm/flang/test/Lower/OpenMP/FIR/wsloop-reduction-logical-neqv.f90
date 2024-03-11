! RUN: bbc -emit-fir -hlfir=false -fopenmp %s -o - | FileCheck %s
! RUN: %flang_fc1 -emit-fir -flang-deprecated-no-hlfir -fopenmp %s -o - | FileCheck %s

! NOTE: Assertions have been autogenerated by utils/generate-test-checks.py


! CHECK-LABEL:   omp.reduction.declare @neqv_reduction : !fir.logical<4> init {
! CHECK:         ^bb0(%[[VAL_0:.*]]: !fir.logical<4>):
! CHECK:           %[[VAL_1:.*]] = arith.constant false
! CHECK:           %[[VAL_2:.*]] = fir.convert %[[VAL_1]] : (i1) -> !fir.logical<4>
! CHECK:           omp.yield(%[[VAL_2]] : !fir.logical<4>)

! CHECK-LABEL:   } combiner {
! CHECK:         ^bb0(%[[VAL_0:.*]]: !fir.logical<4>, %[[VAL_1:.*]]: !fir.logical<4>):
! CHECK:           %[[VAL_2:.*]] = fir.convert %[[VAL_0]] : (!fir.logical<4>) -> i1
! CHECK:           %[[VAL_3:.*]] = fir.convert %[[VAL_1]] : (!fir.logical<4>) -> i1
! CHECK:           %[[VAL_4:.*]] = arith.cmpi ne, %[[VAL_2]], %[[VAL_3]] : i1
! CHECK:           %[[VAL_5:.*]] = fir.convert %[[VAL_4]] : (i1) -> !fir.logical<4>
! CHECK:           omp.yield(%[[VAL_5]] : !fir.logical<4>)
! CHECK:         }

! CHECK-LABEL:   func.func @_QPsimple_reduction(
! CHECK-SAME:                                   %[[VAL_0:.*]]: !fir.ref<!fir.array<100x!fir.logical<4>>> {fir.bindc_name = "y"}) {
! CHECK:           %[[VAL_1:.*]] = fir.alloca i32 {bindc_name = "i", uniq_name = "_QFsimple_reductionEi"}
! CHECK:           %[[VAL_2:.*]] = fir.alloca !fir.logical<4> {bindc_name = "x", uniq_name = "_QFsimple_reductionEx"}
! CHECK:           %[[VAL_3:.*]] = arith.constant true
! CHECK:           %[[VAL_4:.*]] = fir.convert %[[VAL_3]] : (i1) -> !fir.logical<4>
! CHECK:           fir.store %[[VAL_4]] to %[[VAL_2]] : !fir.ref<!fir.logical<4>>
! CHECK:           omp.parallel {
! CHECK:             %[[VAL_5:.*]] = fir.alloca i32 {adapt.valuebyref, pinned}
! CHECK:             %[[VAL_6:.*]] = arith.constant 1 : i32
! CHECK:             %[[VAL_7:.*]] = arith.constant 100 : i32
! CHECK:             %[[VAL_8:.*]] = arith.constant 1 : i32
! CHECK:             omp.wsloop reduction(@neqv_reduction %[[VAL_2]] -> %[[VAL_9:.*]] : !fir.ref<!fir.logical<4>>)  for  (%[[VAL_10:.*]]) : i32 = (%[[VAL_6]]) to (%[[VAL_7]]) inclusive step (%[[VAL_8]]) {
! CHECK:               fir.store %[[VAL_10]] to %[[VAL_5]] : !fir.ref<i32>
! CHECK:               %[[VAL_11:.*]] = fir.load %[[VAL_9]] : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_12:.*]] = fir.load %[[VAL_5]] : !fir.ref<i32>
! CHECK:               %[[VAL_13:.*]] = fir.convert %[[VAL_12]] : (i32) -> i64
! CHECK:               %[[VAL_14:.*]] = arith.constant 1 : i64
! CHECK:               %[[VAL_15:.*]] = arith.subi %[[VAL_13]], %[[VAL_14]] : i64
! CHECK:               %[[VAL_16:.*]] = fir.coordinate_of %[[VAL_0]], %[[VAL_15]] : (!fir.ref<!fir.array<100x!fir.logical<4>>>, i64) -> !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_17:.*]] = fir.load %[[VAL_16]] : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_18:.*]] = fir.convert %[[VAL_11]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_19:.*]] = fir.convert %[[VAL_17]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_20:.*]] = arith.cmpi ne, %[[VAL_18]], %[[VAL_19]] : i1
! CHECK:               %[[VAL_21:.*]] = fir.convert %[[VAL_20]] : (i1) -> !fir.logical<4>
! CHECK:               fir.store %[[VAL_21]] to %[[VAL_9]] : !fir.ref<!fir.logical<4>>
! CHECK:               omp.yield
! CHECK:             omp.terminator
! CHECK:           return

subroutine simple_reduction(y)
  logical :: x, y(100)
  x = .true.
  !$omp parallel
  !$omp do reduction(.neqv.:x)
  do i=1, 100
    x = x .neqv. y(i)
  end do
  !$omp end do
  !$omp end parallel
end subroutine

! CHECK-LABEL:   func.func @_QPsimple_reduction_switch_order(
! CHECK-SAME:                                                %[[VAL_0:.*]]: !fir.ref<!fir.array<100x!fir.logical<4>>> {fir.bindc_name = "y"}) {
! CHECK:           %[[VAL_1:.*]] = fir.alloca i32 {bindc_name = "i", uniq_name = "_QFsimple_reduction_switch_orderEi"}
! CHECK:           %[[VAL_2:.*]] = fir.alloca !fir.logical<4> {bindc_name = "x", uniq_name = "_QFsimple_reduction_switch_orderEx"}
! CHECK:           %[[VAL_3:.*]] = arith.constant true
! CHECK:           %[[VAL_4:.*]] = fir.convert %[[VAL_3]] : (i1) -> !fir.logical<4>
! CHECK:           fir.store %[[VAL_4]] to %[[VAL_2]] : !fir.ref<!fir.logical<4>>
! CHECK:           omp.parallel {
! CHECK:             %[[VAL_5:.*]] = fir.alloca i32 {adapt.valuebyref, pinned}
! CHECK:             %[[VAL_6:.*]] = arith.constant 1 : i32
! CHECK:             %[[VAL_7:.*]] = arith.constant 100 : i32
! CHECK:             %[[VAL_8:.*]] = arith.constant 1 : i32
! CHECK:             omp.wsloop reduction(@neqv_reduction %[[VAL_2]] -> %[[VAL_9:.*]] : !fir.ref<!fir.logical<4>>)  for  (%[[VAL_10:.*]]) : i32 = (%[[VAL_6]]) to (%[[VAL_7]]) inclusive step (%[[VAL_8]]) {
! CHECK:               fir.store %[[VAL_10]] to %[[VAL_5]] : !fir.ref<i32>
! CHECK:               %[[VAL_11:.*]] = fir.load %[[VAL_5]] : !fir.ref<i32>
! CHECK:               %[[VAL_12:.*]] = fir.convert %[[VAL_11]] : (i32) -> i64
! CHECK:               %[[VAL_13:.*]] = arith.constant 1 : i64
! CHECK:               %[[VAL_14:.*]] = arith.subi %[[VAL_12]], %[[VAL_13]] : i64
! CHECK:               %[[VAL_15:.*]] = fir.coordinate_of %[[VAL_0]], %[[VAL_14]] : (!fir.ref<!fir.array<100x!fir.logical<4>>>, i64) -> !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_16:.*]] = fir.load %[[VAL_15]] : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_17:.*]] = fir.load %[[VAL_9]] : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_18:.*]] = fir.convert %[[VAL_16]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_19:.*]] = fir.convert %[[VAL_17]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_20:.*]] = arith.cmpi ne, %[[VAL_18]], %[[VAL_19]] : i1
! CHECK:               %[[VAL_21:.*]] = fir.convert %[[VAL_20]] : (i1) -> !fir.logical<4>
! CHECK:               fir.store %[[VAL_21]] to %[[VAL_9]] : !fir.ref<!fir.logical<4>>
! CHECK:               omp.yield
! CHECK:             omp.terminator
! CHECK:           return

subroutine simple_reduction_switch_order(y)
  logical :: x, y(100)
  x = .true.
  !$omp parallel
  !$omp do reduction(.neqv.:x)
  do i=1, 100
  x = y(i) .neqv. x
  end do
  !$omp end do
  !$omp end parallel
end subroutine

! CHECK-LABEL:   func.func @_QPmultiple_reductions(
! CHECK-SAME:                                      %[[VAL_0:.*]]: !fir.ref<!fir.array<100x!fir.logical<4>>> {fir.bindc_name = "w"}) {
! CHECK:           %[[VAL_1:.*]] = fir.alloca i32 {bindc_name = "i", uniq_name = "_QFmultiple_reductionsEi"}
! CHECK:           %[[VAL_2:.*]] = fir.alloca !fir.logical<4> {bindc_name = "x", uniq_name = "_QFmultiple_reductionsEx"}
! CHECK:           %[[VAL_3:.*]] = fir.alloca !fir.logical<4> {bindc_name = "y", uniq_name = "_QFmultiple_reductionsEy"}
! CHECK:           %[[VAL_4:.*]] = fir.alloca !fir.logical<4> {bindc_name = "z", uniq_name = "_QFmultiple_reductionsEz"}
! CHECK:           %[[VAL_5:.*]] = arith.constant true
! CHECK:           %[[VAL_6:.*]] = fir.convert %[[VAL_5]] : (i1) -> !fir.logical<4>
! CHECK:           fir.store %[[VAL_6]] to %[[VAL_2]] : !fir.ref<!fir.logical<4>>
! CHECK:           %[[VAL_7:.*]] = arith.constant true
! CHECK:           %[[VAL_8:.*]] = fir.convert %[[VAL_7]] : (i1) -> !fir.logical<4>
! CHECK:           fir.store %[[VAL_8]] to %[[VAL_3]] : !fir.ref<!fir.logical<4>>
! CHECK:           %[[VAL_9:.*]] = arith.constant true
! CHECK:           %[[VAL_10:.*]] = fir.convert %[[VAL_9]] : (i1) -> !fir.logical<4>
! CHECK:           fir.store %[[VAL_10]] to %[[VAL_4]] : !fir.ref<!fir.logical<4>>
! CHECK:           omp.parallel {
! CHECK:             %[[VAL_11:.*]] = fir.alloca i32 {adapt.valuebyref, pinned}
! CHECK:             %[[VAL_12:.*]] = arith.constant 1 : i32
! CHECK:             %[[VAL_13:.*]] = arith.constant 100 : i32
! CHECK:             %[[VAL_14:.*]] = arith.constant 1 : i32
! CHECK:             omp.wsloop reduction(@neqv_reduction %[[VAL_2]] -> %[[VAL_15:.*]] : !fir.ref<!fir.logical<4>>, @neqv_reduction %[[VAL_3]] -> %[[VAL_16:.*]] : !fir.ref<!fir.logical<4>>, @neqv_reduction %[[VAL_4]] -> %[[VAL_17:.*]] : !fir.ref<!fir.logical<4>>)  for  (%[[VAL_18:.*]]) : i32 = (%[[VAL_12]]) to (%[[VAL_13]]) inclusive step (%[[VAL_14]]) {
! CHECK:               fir.store %[[VAL_18]] to %[[VAL_11]] : !fir.ref<i32>
! CHECK:               %[[VAL_19:.*]] = fir.load %[[VAL_15]] : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_20:.*]] = fir.load %[[VAL_11]] : !fir.ref<i32>
! CHECK:               %[[VAL_21:.*]] = fir.convert %[[VAL_20]] : (i32) -> i64
! CHECK:               %[[VAL_22:.*]] = arith.constant 1 : i64
! CHECK:               %[[VAL_23:.*]] = arith.subi %[[VAL_21]], %[[VAL_22]] : i64
! CHECK:               %[[VAL_24:.*]] = fir.coordinate_of %[[VAL_0]], %[[VAL_23]] : (!fir.ref<!fir.array<100x!fir.logical<4>>>, i64) -> !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_25:.*]] = fir.load %[[VAL_24]] : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_26:.*]] = fir.convert %[[VAL_19]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_27:.*]] = fir.convert %[[VAL_25]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_28:.*]] = arith.cmpi ne, %[[VAL_26]], %[[VAL_27]] : i1
! CHECK:               %[[VAL_29:.*]] = fir.convert %[[VAL_28]] : (i1) -> !fir.logical<4>
! CHECK:               fir.store %[[VAL_29]] to %[[VAL_15]] : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_30:.*]] = fir.load %[[VAL_16]] : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_31:.*]] = fir.load %[[VAL_11]] : !fir.ref<i32>
! CHECK:               %[[VAL_32:.*]] = fir.convert %[[VAL_31]] : (i32) -> i64
! CHECK:               %[[VAL_33:.*]] = arith.constant 1 : i64
! CHECK:               %[[VAL_34:.*]] = arith.subi %[[VAL_32]], %[[VAL_33]] : i64
! CHECK:               %[[VAL_35:.*]] = fir.coordinate_of %[[VAL_0]], %[[VAL_34]] : (!fir.ref<!fir.array<100x!fir.logical<4>>>, i64) -> !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_36:.*]] = fir.load %[[VAL_35]] : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_37:.*]] = fir.convert %[[VAL_30]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_38:.*]] = fir.convert %[[VAL_36]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_39:.*]] = arith.cmpi ne, %[[VAL_37]], %[[VAL_38]] : i1
! CHECK:               %[[VAL_40:.*]] = fir.convert %[[VAL_39]] : (i1) -> !fir.logical<4>
! CHECK:               fir.store %[[VAL_40]] to %[[VAL_16]] : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_41:.*]] = fir.load %[[VAL_17]] : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_42:.*]] = fir.load %[[VAL_11]] : !fir.ref<i32>
! CHECK:               %[[VAL_43:.*]] = fir.convert %[[VAL_42]] : (i32) -> i64
! CHECK:               %[[VAL_44:.*]] = arith.constant 1 : i64
! CHECK:               %[[VAL_45:.*]] = arith.subi %[[VAL_43]], %[[VAL_44]] : i64
! CHECK:               %[[VAL_46:.*]] = fir.coordinate_of %[[VAL_0]], %[[VAL_45]] : (!fir.ref<!fir.array<100x!fir.logical<4>>>, i64) -> !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_47:.*]] = fir.load %[[VAL_46]] : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_48:.*]] = fir.convert %[[VAL_41]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_49:.*]] = fir.convert %[[VAL_47]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_50:.*]] = arith.cmpi ne, %[[VAL_48]], %[[VAL_49]] : i1
! CHECK:               %[[VAL_51:.*]] = fir.convert %[[VAL_50]] : (i1) -> !fir.logical<4>
! CHECK:               fir.store %[[VAL_51]] to %[[VAL_17]] : !fir.ref<!fir.logical<4>>
! CHECK:               omp.yield
! CHECK:             omp.terminator
! CHECK:           return


subroutine multiple_reductions(w)
  logical :: x,y,z,w(100)
  x = .true.
  y = .true.
  z = .true.
  !$omp parallel
  !$omp do reduction(.neqv.:x,y,z)
  do i=1, 100
  x = x .neqv. w(i)
  y = y .neqv. w(i)
  z = z .neqv. w(i)
  end do
  !$omp end do
  !$omp end parallel
end subroutine
