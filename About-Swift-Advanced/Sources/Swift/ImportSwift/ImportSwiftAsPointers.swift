import Foundation
import ImportSwiftHeaders

private enum LibImpl {
  
  enum OwnerImpl {
    static let create: @convention(c)(_ string: UnsafePointer<CChar>,
                                      _ integer: Int32) -> OpaquePointer =
    { string, integer in
      let owner = Owner(string: string.swiftString, integer: integer)
      return CInterop.wrap(owner)
    }
    
    static let setValue: @convention(c)(_ instanceRef: OpaquePointer,
                                        _ valueRef: OpaquePointer) -> Void =
    { instanceRef, valueRef in
      let owner: Owner = CInterop.unwrap(instanceRef)
      let value: Value = CInterop.unwrap(valueRef)
      owner.value = value
    }
    
    static let dump: @convention(c)(_ instanceRef: OpaquePointer) -> Void =
    { instanceRef in
      let owner: Owner = CInterop.unwrap(instanceRef)
      owner.dump()
    }
    
    static let release: @convention(c)(_ instanceRef: OpaquePointer) -> Void =
    { instanceRef in
      CInterop.release(instanceRef, type: Owner.self)
    }
  }
  
  enum ValueImpl {
    
    static let create: @convention(c)(_ value: Int32) -> OpaquePointer =
    { value in
      let instance = Value(integer: value)
      return CInterop.wrap(instance)
    }
    
    static let release: @convention(c)(_ instanceRef: OpaquePointer) -> Void =
    { instanceRef in
      CInterop.release(instanceRef, type: Value.self)
    }
  }
  
  @MainActor
  static var lib = Lib(owner: COwner(create: OwnerImpl.create,
                                     release: OwnerImpl.release,
                                     dump: OwnerImpl.dump,
                                     setValue: OwnerImpl.setValue),
                       value: CValue(create: ValueImpl.create,
                                     release: ValueImpl.release))
}


@MainActor
@_cdecl("getLib")
func getLib() -> UnsafePointer<Lib> {
  return UnsafePointer<Lib>(&LibImpl.lib)
}
