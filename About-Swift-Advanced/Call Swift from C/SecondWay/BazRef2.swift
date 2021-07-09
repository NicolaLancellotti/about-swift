import Foundation

enum LibImpl {
  
  enum BazImpl {
    static let create: @convention(c)(UnsafePointer<CChar>, Int32) -> OpaquePointer = { aString, anInteger in
      let baz = Baz(aString: aString.string, anInteger: anInteger)
      return CInterop.wrap(baz)
    }
    
    static let setFooBar: @convention(c)(OpaquePointer, OpaquePointer) -> Void = { bazRef, fooBarRef in
      let baz: Baz = CInterop.unwrap(bazRef)
      let fooBar: FooBar = CInterop.unwrap(fooBarRef)
      baz.fooBar = fooBar
    }
    
    static let print: @convention(c)(OpaquePointer) -> Void = { bazRef in
      let baz: Baz = CInterop.unwrap(bazRef)
      baz.printBaz()
    }
    
    static let release: @convention(c)(OpaquePointer) -> Void = { bazRef in
      CInterop.release(bazRef, type: Baz.self)
    }
  }
  
  enum FooBarImpl {
    
    static let create: @convention(c)(Int32) -> OpaquePointer = { anInteger in
      let foobar = FooBar(anInteger: anInteger)
      return CInterop.wrap(foobar)
    }
    
    static let release: @convention(c)(OpaquePointer) -> Void = { foobarRef in
      CInterop.release(foobarRef, type: FooBar.self)
    }
  }
  
  static var lib = Lib(baz: CBaz(create: BazImpl.create,
                                 release: BazImpl.release,
                                 print: BazImpl.print,
                                 setFooBar: BazImpl.setFooBar),
                       fooBar: CFooBar(create: FooBarImpl.create,
                                       release: FooBarImpl.release))
}


@_cdecl("getLib")
func getLib() -> UnsafePointer<Lib> {
  func getPointer(_ p: UnsafePointer<Lib>) -> UnsafePointer<Lib> {
    return p
  }
  return getPointer(&LibImpl.lib)
}
