import Foundation

// MARK: - Owner

@_cdecl("OwnerCreate")
func OwnerCreate(string: UnsafePointer<CChar>, integer: Int32) -> OpaquePointer {
  let instance = Owner(string: string.swiftString, integer: integer)
  return CInterop.wrap(instance)
}

@_cdecl("OwnerSetValue")
func OwnerSetValue(instanceRef: OpaquePointer, valueRef: OpaquePointer) {
  let instance: Owner = CInterop.unwrap(instanceRef)
  let value: Value = CInterop.unwrap(valueRef)
  instance.value = value
}

@_cdecl("OwnerDump")
func OwnerDump(instanceRef: OpaquePointer) {
  let instance: Owner = CInterop.unwrap(instanceRef)
  instance.dump()
}

@_cdecl("OwnerRelease")
func OwnerRelease(instanceRef: OpaquePointer) {
  CInterop.release(instanceRef, type: Owner.self)
}

// MARK: - Value

@_cdecl("ValueCreate")
func ValueCreate(integer: Int32) -> OpaquePointer {
  let instance = Value(integer: integer)
  return CInterop.wrap(instance)
}


@_cdecl("ValueRelease")
func ValueRelease(instanceRef: OpaquePointer) {
  CInterop.release(instanceRef, type: Value.self)
}
