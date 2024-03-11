! RUN: bbc -emit-hlfir -fopenmp %s -o - | FileCheck %s
! RUN: %flang_fc1 -emit-hlfir -fopenmp %s -o - | FileCheck %s

! NOTE: Assertions have been autogenerated by utils/generate-test-checks.py

! CHECK-LABEL:   omp.reduction.declare @and_reduction : !fir.logical<4> init {
! CHECK:         ^bb0(%[[VAL_0:.*]]: !fir.logical<4>):
! CHECK:           %[[VAL_1:.*]] = arith.constant true
! CHECK:           %[[VAL_2:.*]] = fir.convert %[[VAL_1]] : (i1) -> !fir.logical<4>
! CHECK:           omp.yield(%[[VAL_2]] : !fir.logical<4>)

! CHECK-LABEL:   } combiner {
! CHECK:         ^bb0(%[[VAL_0:.*]]: !fir.logical<4>, %[[VAL_1:.*]]: !fir.logical<4>):
! CHECK:           %[[VAL_2:.*]] = fir.convert %[[VAL_0]] : (!fir.logical<4>) -> i1
! CHECK:           %[[VAL_3:.*]] = fir.convert %[[VAL_1]] : (!fir.logical<4>) -> i1
! CHECK:           %[[VAL_4:.*]] = arith.andi %[[VAL_2]], %[[VAL_3]] : i1
! CHECK:           %[[VAL_5:.*]] = fir.convert %[[VAL_4]] : (i1) -> !fir.logical<4>
! CHECK:           omp.yield(%[[VAL_5]] : !fir.logical<4>)
! CHECK:         }

! CHECK-LABEL:   func.func @_QPsimple_reduction(
! CHECK-SAME:                                   %[[VAL_0:.*]]: !fir.ref<!fir.array<100x!fir.logical<4>>> {fir.bindc_name = "y"}) {
! CHECK:           %[[VAL_1:.*]] = fir.alloca i32 {bindc_name = "i", uniq_name = "_QFsimple_reductionEi"}
! CHECK:           %[[VAL_2:.*]]:2 = hlfir.declare %[[VAL_1]] {uniq_name = "_QFsimple_reductionEi"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           %[[VAL_3:.*]] = fir.alloca !fir.logical<4> {bindc_name = "x", uniq_name = "_QFsimple_reductionEx"}
! CHECK:           %[[VAL_4:.*]]:2 = hlfir.declare %[[VAL_3]] {uniq_name = "_QFsimple_reductionEx"} : (!fir.ref<!fir.logical<4>>) -> (!fir.ref<!fir.logical<4>>, !fir.ref<!fir.logical<4>>)
! CHECK:           %[[VAL_5:.*]] = arith.constant 100 : index
! CHECK:           %[[VAL_6:.*]] = fir.shape %[[VAL_5]] : (index) -> !fir.shape<1>
! CHECK:           %[[VAL_7:.*]]:2 = hlfir.declare %[[VAL_0]](%[[VAL_6]]) {uniq_name = "_QFsimple_reductionEy"} : (!fir.ref<!fir.array<100x!fir.logical<4>>>, !fir.shape<1>) -> (!fir.ref<!fir.array<100x!fir.logical<4>>>, !fir.ref<!fir.array<100x!fir.logical<4>>>)
! CHECK:           %[[VAL_8:.*]] = arith.constant true
! CHECK:           %[[VAL_9:.*]] = fir.convert %[[VAL_8]] : (i1) -> !fir.logical<4>
! CHECK:           hlfir.assign %[[VAL_9]] to %[[VAL_4]]#0 : !fir.logical<4>, !fir.ref<!fir.logical<4>>
! CHECK:           omp.parallel {
! CHECK:             %[[VAL_10:.*]] = fir.alloca i32 {adapt.valuebyref, pinned}
! CHECK:             %[[VAL_11:.*]]:2 = hlfir.declare %[[VAL_10]] {uniq_name = "_QFsimple_reductionEi"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:             %[[VAL_12:.*]] = arith.constant 1 : i32
! CHECK:             %[[VAL_13:.*]] = arith.constant 100 : i32
! CHECK:             %[[VAL_14:.*]] = arith.constant 1 : i32
! CHECK:             omp.wsloop reduction(@and_reduction %[[VAL_4]]#0 -> %[[VAL_15:.*]] : !fir.ref<!fir.logical<4>>)  for  (%[[VAL_16:.*]]) : i32 = (%[[VAL_12]]) to (%[[VAL_13]]) inclusive step (%[[VAL_14]]) {
! CHECK:               fir.store %[[VAL_16]] to %[[VAL_11]]#1 : !fir.ref<i32>
! CHECK:               %[[VAL_17:.*]]:2 = hlfir.declare %[[VAL_15]] {uniq_name = "_QFsimple_reductionEx"} : (!fir.ref<!fir.logical<4>>) -> (!fir.ref<!fir.logical<4>>, !fir.ref<!fir.logical<4>>)
! CHECK:               %[[VAL_18:.*]] = fir.load %[[VAL_17]]#0 : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_19:.*]] = fir.load %[[VAL_11]]#0 : !fir.ref<i32>
! CHECK:               %[[VAL_20:.*]] = fir.convert %[[VAL_19]] : (i32) -> i64
! CHECK:               %[[VAL_21:.*]] = hlfir.designate %[[VAL_7]]#0 (%[[VAL_20]])  : (!fir.ref<!fir.array<100x!fir.logical<4>>>, i64) -> !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_22:.*]] = fir.load %[[VAL_21]] : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_23:.*]] = fir.convert %[[VAL_18]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_24:.*]] = fir.convert %[[VAL_22]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_25:.*]] = arith.andi %[[VAL_23]], %[[VAL_24]] : i1
! CHECK:               %[[VAL_26:.*]] = fir.convert %[[VAL_25]] : (i1) -> !fir.logical<4>
! CHECK:               hlfir.assign %[[VAL_26]] to %[[VAL_17]]#0 : !fir.logical<4>, !fir.ref<!fir.logical<4>>
! CHECK:               omp.yield
! CHECK:             omp.terminator
! CHECK:           return

subroutine simple_reduction(y)
  logical :: x, y(100)
  x = .true.
  !$omp parallel
  !$omp do reduction(.and.:x)
  do i=1, 100
     x = x .and. y(i)
  end do
  !$omp end do
  !$omp end parallel
end subroutine simple_reduction


! CHECK-LABEL:   func.func @_QPsimple_reduction_switch_order(
! CHECK-SAME:                                                %[[VAL_0:.*]]: !fir.ref<!fir.array<100x!fir.logical<4>>> {fir.bindc_name = "y"}) {
! CHECK:           %[[VAL_1:.*]] = fir.alloca i32 {bindc_name = "i", uniq_name = "_QFsimple_reduction_switch_orderEi"}
! CHECK:           %[[VAL_2:.*]]:2 = hlfir.declare %[[VAL_1]] {uniq_name = "_QFsimple_reduction_switch_orderEi"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           %[[VAL_3:.*]] = fir.alloca !fir.logical<4> {bindc_name = "x", uniq_name = "_QFsimple_reduction_switch_orderEx"}
! CHECK:           %[[VAL_4:.*]]:2 = hlfir.declare %[[VAL_3]] {uniq_name = "_QFsimple_reduction_switch_orderEx"} : (!fir.ref<!fir.logical<4>>) -> (!fir.ref<!fir.logical<4>>, !fir.ref<!fir.logical<4>>)
! CHECK:           %[[VAL_5:.*]] = arith.constant 100 : index
! CHECK:           %[[VAL_6:.*]] = fir.shape %[[VAL_5]] : (index) -> !fir.shape<1>
! CHECK:           %[[VAL_7:.*]]:2 = hlfir.declare %[[VAL_0]](%[[VAL_6]]) {uniq_name = "_QFsimple_reduction_switch_orderEy"} : (!fir.ref<!fir.array<100x!fir.logical<4>>>, !fir.shape<1>) -> (!fir.ref<!fir.array<100x!fir.logical<4>>>, !fir.ref<!fir.array<100x!fir.logical<4>>>)
! CHECK:           %[[VAL_8:.*]] = arith.constant true
! CHECK:           %[[VAL_9:.*]] = fir.convert %[[VAL_8]] : (i1) -> !fir.logical<4>
! CHECK:           hlfir.assign %[[VAL_9]] to %[[VAL_4]]#0 : !fir.logical<4>, !fir.ref<!fir.logical<4>>
! CHECK:           omp.parallel {
! CHECK:             %[[VAL_10:.*]] = fir.alloca i32 {adapt.valuebyref, pinned}
! CHECK:             %[[VAL_11:.*]]:2 = hlfir.declare %[[VAL_10]] {uniq_name = "_QFsimple_reduction_switch_orderEi"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:             %[[VAL_12:.*]] = arith.constant 1 : i32
! CHECK:             %[[VAL_13:.*]] = arith.constant 100 : i32
! CHECK:             %[[VAL_14:.*]] = arith.constant 1 : i32
! CHECK:             omp.wsloop reduction(@and_reduction %[[VAL_4]]#0 -> %[[VAL_15:.*]] : !fir.ref<!fir.logical<4>>)  for  (%[[VAL_16:.*]]) : i32 = (%[[VAL_12]]) to (%[[VAL_13]]) inclusive step (%[[VAL_14]]) {
! CHECK:               fir.store %[[VAL_16]] to %[[VAL_11]]#1 : !fir.ref<i32>
! CHECK:               %[[VAL_17:.*]]:2 = hlfir.declare %[[VAL_15]] {uniq_name = "_QFsimple_reduction_switch_orderEx"} : (!fir.ref<!fir.logical<4>>) -> (!fir.ref<!fir.logical<4>>, !fir.ref<!fir.logical<4>>)
! CHECK:               %[[VAL_18:.*]] = fir.load %[[VAL_11]]#0 : !fir.ref<i32>
! CHECK:               %[[VAL_19:.*]] = fir.convert %[[VAL_18]] : (i32) -> i64
! CHECK:               %[[VAL_20:.*]] = hlfir.designate %[[VAL_7]]#0 (%[[VAL_19]])  : (!fir.ref<!fir.array<100x!fir.logical<4>>>, i64) -> !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_21:.*]] = fir.load %[[VAL_20]] : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_22:.*]] = fir.load %[[VAL_17]]#0 : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_23:.*]] = fir.convert %[[VAL_21]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_24:.*]] = fir.convert %[[VAL_22]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_25:.*]] = arith.andi %[[VAL_23]], %[[VAL_24]] : i1
! CHECK:               %[[VAL_26:.*]] = fir.convert %[[VAL_25]] : (i1) -> !fir.logical<4>
! CHECK:               hlfir.assign %[[VAL_26]] to %[[VAL_17]]#0 : !fir.logical<4>, !fir.ref<!fir.logical<4>>
! CHECK:               omp.yield
! CHECK:             omp.terminator
! CHECK:           return

subroutine simple_reduction_switch_order(y)
  logical :: x, y(100)
  x = .true.
  !$omp parallel
  !$omp do reduction(.and.:x)
  do i=1, 100
  x = y(i) .and. x
  end do
  !$omp end do
  !$omp end parallel
end subroutine

! CHECK-LABEL:   func.func @_QPmultiple_reductions(
! CHECK-SAME:                                      %[[VAL_0:.*]]: !fir.ref<!fir.array<100x!fir.logical<4>>> {fir.bindc_name = "w"}) {
! CHECK:           %[[VAL_1:.*]] = fir.alloca i32 {bindc_name = "i", uniq_name = "_QFmultiple_reductionsEi"}
! CHECK:           %[[VAL_2:.*]]:2 = hlfir.declare %[[VAL_1]] {uniq_name = "_QFmultiple_reductionsEi"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           %[[VAL_3:.*]] = arith.constant 100 : index
! CHECK:           %[[VAL_4:.*]] = fir.shape %[[VAL_3]] : (index) -> !fir.shape<1>
! CHECK:           %[[VAL_5:.*]]:2 = hlfir.declare %[[VAL_0]](%[[VAL_4]]) {uniq_name = "_QFmultiple_reductionsEw"} : (!fir.ref<!fir.array<100x!fir.logical<4>>>, !fir.shape<1>) -> (!fir.ref<!fir.array<100x!fir.logical<4>>>, !fir.ref<!fir.array<100x!fir.logical<4>>>)
! CHECK:           %[[VAL_6:.*]] = fir.alloca !fir.logical<4> {bindc_name = "x", uniq_name = "_QFmultiple_reductionsEx"}
! CHECK:           %[[VAL_7:.*]]:2 = hlfir.declare %[[VAL_6]] {uniq_name = "_QFmultiple_reductionsEx"} : (!fir.ref<!fir.logical<4>>) -> (!fir.ref<!fir.logical<4>>, !fir.ref<!fir.logical<4>>)
! CHECK:           %[[VAL_8:.*]] = fir.alloca !fir.logical<4> {bindc_name = "y", uniq_name = "_QFmultiple_reductionsEy"}
! CHECK:           %[[VAL_9:.*]]:2 = hlfir.declare %[[VAL_8]] {uniq_name = "_QFmultiple_reductionsEy"} : (!fir.ref<!fir.logical<4>>) -> (!fir.ref<!fir.logical<4>>, !fir.ref<!fir.logical<4>>)
! CHECK:           %[[VAL_10:.*]] = fir.alloca !fir.logical<4> {bindc_name = "z", uniq_name = "_QFmultiple_reductionsEz"}
! CHECK:           %[[VAL_11:.*]]:2 = hlfir.declare %[[VAL_10]] {uniq_name = "_QFmultiple_reductionsEz"} : (!fir.ref<!fir.logical<4>>) -> (!fir.ref<!fir.logical<4>>, !fir.ref<!fir.logical<4>>)
! CHECK:           %[[VAL_12:.*]] = arith.constant true
! CHECK:           %[[VAL_13:.*]] = fir.convert %[[VAL_12]] : (i1) -> !fir.logical<4>
! CHECK:           hlfir.assign %[[VAL_13]] to %[[VAL_7]]#0 : !fir.logical<4>, !fir.ref<!fir.logical<4>>
! CHECK:           %[[VAL_14:.*]] = arith.constant true
! CHECK:           %[[VAL_15:.*]] = fir.convert %[[VAL_14]] : (i1) -> !fir.logical<4>
! CHECK:           hlfir.assign %[[VAL_15]] to %[[VAL_9]]#0 : !fir.logical<4>, !fir.ref<!fir.logical<4>>
! CHECK:           %[[VAL_16:.*]] = arith.constant true
! CHECK:           %[[VAL_17:.*]] = fir.convert %[[VAL_16]] : (i1) -> !fir.logical<4>
! CHECK:           hlfir.assign %[[VAL_17]] to %[[VAL_11]]#0 : !fir.logical<4>, !fir.ref<!fir.logical<4>>
! CHECK:           omp.parallel {
! CHECK:             %[[VAL_18:.*]] = fir.alloca i32 {adapt.valuebyref, pinned}
! CHECK:             %[[VAL_19:.*]]:2 = hlfir.declare %[[VAL_18]] {uniq_name = "_QFmultiple_reductionsEi"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:             %[[VAL_20:.*]] = arith.constant 1 : i32
! CHECK:             %[[VAL_21:.*]] = arith.constant 100 : i32
! CHECK:             %[[VAL_22:.*]] = arith.constant 1 : i32
! CHECK:             omp.wsloop reduction(@and_reduction %[[VAL_7]]#0 -> %[[VAL_23:.*]] : !fir.ref<!fir.logical<4>>, @and_reduction %[[VAL_9]]#0 -> %[[VAL_24:.*]] : !fir.ref<!fir.logical<4>>, @and_reduction %[[VAL_11]]#0 -> %[[VAL_25:.*]] : !fir.ref<!fir.logical<4>>)  for  (%[[VAL_26:.*]]) : i32 = (%[[VAL_20]]) to (%[[VAL_21]]) inclusive step (%[[VAL_22]]) {
! CHECK:               fir.store %[[VAL_26]] to %[[VAL_19]]#1 : !fir.ref<i32>
! CHECK:               %[[VAL_27:.*]]:2 = hlfir.declare %[[VAL_23]] {uniq_name = "_QFmultiple_reductionsEx"} : (!fir.ref<!fir.logical<4>>) -> (!fir.ref<!fir.logical<4>>, !fir.ref<!fir.logical<4>>)
! CHECK:               %[[VAL_28:.*]]:2 = hlfir.declare %[[VAL_24]] {uniq_name = "_QFmultiple_reductionsEy"} : (!fir.ref<!fir.logical<4>>) -> (!fir.ref<!fir.logical<4>>, !fir.ref<!fir.logical<4>>)
! CHECK:               %[[VAL_29:.*]]:2 = hlfir.declare %[[VAL_25]] {uniq_name = "_QFmultiple_reductionsEz"} : (!fir.ref<!fir.logical<4>>) -> (!fir.ref<!fir.logical<4>>, !fir.ref<!fir.logical<4>>)
! CHECK:               %[[VAL_30:.*]] = fir.load %[[VAL_27]]#0 : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_31:.*]] = fir.load %[[VAL_19]]#0 : !fir.ref<i32>
! CHECK:               %[[VAL_32:.*]] = fir.convert %[[VAL_31]] : (i32) -> i64
! CHECK:               %[[VAL_33:.*]] = hlfir.designate %[[VAL_5]]#0 (%[[VAL_32]])  : (!fir.ref<!fir.array<100x!fir.logical<4>>>, i64) -> !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_34:.*]] = fir.load %[[VAL_33]] : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_35:.*]] = fir.convert %[[VAL_30]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_36:.*]] = fir.convert %[[VAL_34]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_37:.*]] = arith.andi %[[VAL_35]], %[[VAL_36]] : i1
! CHECK:               %[[VAL_38:.*]] = fir.convert %[[VAL_37]] : (i1) -> !fir.logical<4>
! CHECK:               hlfir.assign %[[VAL_38]] to %[[VAL_27]]#0 : !fir.logical<4>, !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_39:.*]] = fir.load %[[VAL_28]]#0 : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_40:.*]] = fir.load %[[VAL_19]]#0 : !fir.ref<i32>
! CHECK:               %[[VAL_41:.*]] = fir.convert %[[VAL_40]] : (i32) -> i64
! CHECK:               %[[VAL_42:.*]] = hlfir.designate %[[VAL_5]]#0 (%[[VAL_41]])  : (!fir.ref<!fir.array<100x!fir.logical<4>>>, i64) -> !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_43:.*]] = fir.load %[[VAL_42]] : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_44:.*]] = fir.convert %[[VAL_39]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_45:.*]] = fir.convert %[[VAL_43]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_46:.*]] = arith.andi %[[VAL_44]], %[[VAL_45]] : i1
! CHECK:               %[[VAL_47:.*]] = fir.convert %[[VAL_46]] : (i1) -> !fir.logical<4>
! CHECK:               hlfir.assign %[[VAL_47]] to %[[VAL_28]]#0 : !fir.logical<4>, !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_48:.*]] = fir.load %[[VAL_29]]#0 : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_49:.*]] = fir.load %[[VAL_19]]#0 : !fir.ref<i32>
! CHECK:               %[[VAL_50:.*]] = fir.convert %[[VAL_49]] : (i32) -> i64
! CHECK:               %[[VAL_51:.*]] = hlfir.designate %[[VAL_5]]#0 (%[[VAL_50]])  : (!fir.ref<!fir.array<100x!fir.logical<4>>>, i64) -> !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_52:.*]] = fir.load %[[VAL_51]] : !fir.ref<!fir.logical<4>>
! CHECK:               %[[VAL_53:.*]] = fir.convert %[[VAL_48]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_54:.*]] = fir.convert %[[VAL_52]] : (!fir.logical<4>) -> i1
! CHECK:               %[[VAL_55:.*]] = arith.andi %[[VAL_53]], %[[VAL_54]] : i1
! CHECK:               %[[VAL_56:.*]] = fir.convert %[[VAL_55]] : (i1) -> !fir.logical<4>
! CHECK:               hlfir.assign %[[VAL_56]] to %[[VAL_29]]#0 : !fir.logical<4>, !fir.ref<!fir.logical<4>>
! CHECK:               omp.yield
! CHECK:             omp.terminator
! CHECK:           return



subroutine multiple_reductions(w)
  logical :: x,y,z,w(100)
  x = .true.
  y = .true.
  z = .true.
  !$omp parallel
  !$omp do reduction(.and.:x,y,z)
  do i=1, 100
  x = x .and. w(i)
  y = y .and. w(i)
  z = z .and. w(i)
  end do
  !$omp end do
  !$omp end parallel
end subroutine

