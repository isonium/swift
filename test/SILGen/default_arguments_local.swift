
// RUN: %target-swift-emit-silgen %s | %FileCheck %s

// CHECK-LABEL: sil hidden [ossa] @$s23default_arguments_local5outer1x1y1z1wySi_yXlypxtlF : $@convention(thin) <T> (Int, @guaranteed AnyObject, @in_guaranteed Any, @in_guaranteed T) -> ()
func outer<T>(x: Int, y: AnyObject, z: Any, w: T) {
  func local1(x: Int = x) {}
  func local2(y: AnyObject = y) {}
  func local3(z: Any = z) {}
  func local4(w: T = w) {}
  func local5<U>(u: U, w: T = w) {}

  // CHECK: [[FN:%.*]] = function_ref @$s23default_arguments_local5outer1x1y1z1wySi_yXlypxtlF6local1L_ACySi_tlFfA_ : $@convention(thin) (Int) -> Int
  // CHECK: [[ARG:%.*]] = apply [[FN]](%0) : $@convention(thin) (Int) -> Int
  // CHECK: [[LOCAL1:%.*]] = function_ref @$s23default_arguments_local5outer1x1y1z1wySi_yXlypxtlF6local1L_ACySi_tlF : $@convention(thin) (Int, Int) -> ()
  // CHECK: apply [[LOCAL1]]([[ARG]], %0) : $@convention(thin) (Int, Int) -> ()
  local1()

  // CHECK: [[FN:%.*]] = function_ref @$s23default_arguments_local5outer1x1y1z1wySi_yXlypxtlF6local2L_ADyyXl_tlFfA_ : $@convention(thin) (@guaranteed AnyObject) -> @owned AnyObject
  // CHECK: [[ARG:%.*]] = apply [[FN]](%1) : $@convention(thin) (@guaranteed AnyObject) -> @owned AnyObject
  // CHECK: [[LOCAL2:%.*]] = function_ref @$s23default_arguments_local5outer1x1y1z1wySi_yXlypxtlF6local2L_ADyyXl_tlF : $@convention(thin) (@guaranteed AnyObject, @guaranteed AnyObject) -> ()
  // CHECK: apply [[LOCAL2]]([[ARG]], %1) : $@convention(thin) (@guaranteed AnyObject, @guaranteed AnyObject) -> ()
  // CHECK: destroy_value [[ARG]] : $AnyObject
  local2()

  // CHECK: [[FN1:%.*]] = function_ref @$s23default_arguments_local5outer1x1y1z1wySi_yXlypxtlF6local3L_AEyyp_tlFfA_ : $@convention(thin) (@in_guaranteed Any) -> @out Any
  // CHECK: [[STACK:%.*]] = alloc_stack $Any
  // CHECK: apply [[FN1]]([[STACK]], %2) : $@convention(thin) (@in_guaranteed Any) -> @out Any
  // CHECK: [[FN2:%.*]] = function_ref @$s23default_arguments_local5outer1x1y1z1wySi_yXlypxtlF6local3L_AEyyp_tlF : $@convention(thin) (@in_guaranteed Any, @in_guaranteed Any) -> ()
  // CHECK: apply [[FN2]]([[STACK]], %2) : $@convention(thin) (@in_guaranteed Any, @in_guaranteed Any) -> ()
  // CHECK: destroy_addr [[STACK]] : $*Any
  // CHECK: dealloc_stack [[STACK]] : $*Any
  local3()

  local4()

  local5(u: "hi")
}

// CHECK-LABEL: sil private [ossa] @$s23default_arguments_local5outer1x1y1z1wySi_yXlypxtlF6local1L_ACySi_tlFfA_ : $@convention(thin) (Int) -> Int
// CHECK-LABEL: sil private [ossa] @$s23default_arguments_local5outer1x1y1z1wySi_yXlypxtlF6local1L_ACySi_tlF : $@convention(thin) (Int, Int) -> ()
// CHECK-LABEL: sil private [ossa] @$s23default_arguments_local5outer1x1y1z1wySi_yXlypxtlF6local2L_ADyyXl_tlFfA_ : $@convention(thin) (@guaranteed AnyObject) -> @owned AnyObject
// CHECK-LABEL: sil private [ossa] @$s23default_arguments_local5outer1x1y1z1wySi_yXlypxtlF6local2L_ADyyXl_tlF : $@convention(thin) (@guaranteed AnyObject, @guaranteed AnyObject) -> ()
// CHECK-LABEL: sil private [ossa] @$s23default_arguments_local5outer1x1y1z1wySi_yXlypxtlF6local3L_AEyyp_tlFfA_ : $@convention(thin) (@in_guaranteed Any) -> @out Any
// CHECK-LABEL: sil private [ossa] @$s23default_arguments_local5outer1x1y1z1wySi_yXlypxtlF6local3L_AEyyp_tlF : $@convention(thin) (@in_guaranteed Any, @in_guaranteed Any) -> ()
// CHECK-LABEL: sil private [ossa] @$s23default_arguments_local5outer1x1y1z1wySi_yXlypxtlF6local4L_AFyx_tlF : $@convention(thin) <T> (@in_guaranteed T, @in_guaranteed T) -> ()
// CHECK-LABEL: sil private [ossa] @$s23default_arguments_local5outer1x1y1z1wySi_yXlypxtlF6local5L_1uAFyqd___xtr__lFfA0_ : $@convention(thin) <T><U> (@in_guaranteed T) -> @out T

class ArtClass<T> {
  // CHECK-LABEL: sil hidden [ossa] @$s23default_arguments_local8ArtClassC10selfMethod1uyqd___tlF : $@convention(method) <T><U> (@in_guaranteed U, @guaranteed ArtClass<T>) -> ()
  func selfMethod<U>(u: U) {
    // CHECK-LABEL: sil private [ossa] @$s23default_arguments_local8ArtClassC10selfMethod1uyqd___tlF0C0L_1vAE1syqd0___qd__Sitr___lFfA1_ : $@convention(thin) <T><U><V> (@thick @dynamic_self ArtClass<T>.Type) -> Int
    // CHECK-LABEL: sil private [ossa] @$s23default_arguments_local8ArtClassC10selfMethod1uyqd___tlF0C0L_1vAE1syqd0___qd__Sitr___lF : $@convention(thin) <T><U><V> (@in_guaranteed V, @in_guaranteed U, Int, @thick @dynamic_self ArtClass<T>.Type) -> ()
    func local<V>(v: V, u: U, s: Int = Self.intMethod()) {}
  }

  static func intMethod() -> Int {
    return 0
  }
}
