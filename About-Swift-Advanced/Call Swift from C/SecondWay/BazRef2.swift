
import Foundation

enum LibImpl {
    
    enum BazImpl {
        static let create: @convention(c)(UnsafePointer<CChar>, Int32) -> UnsafeMutableRawPointer = { aString, anInteger in
            let baz = Baz(aString: aString.string, anInteger: anInteger)
            return CInterop.wrap(baz)
        }
        
        static let setFooBar: @convention(c)(UnsafeMutableRawPointer, UnsafeMutableRawPointer) -> Void = { bazRef, fooBarRef in
            let baz: Baz = CInterop.unwrap(bazRef)
            let fooBar: FooBar = CInterop.unwrap(fooBarRef)
            baz.fooBar = fooBar
        }
        
        static let print: @convention(c)(UnsafeMutableRawPointer) -> Void = { bazRef in
            let baz: Baz = CInterop.unwrap(bazRef)
            baz.printBaz()
        }
        
        static let release: @convention(c)(UnsafeMutableRawPointer) -> Void = { bazRef in
            CInterop.release(bazRef, type: Baz.self)
        }
    }
    
    enum FooBarImpl {
    
        static let create: @convention(c)(Int32) -> UnsafeMutableRawPointer = { anInteger in
            let foobar = FooBar(anInteger: anInteger)
            return CInterop.wrap(foobar)
        }
        
        static let release: @convention(c)(UnsafeMutableRawPointer) -> Void = { foobarRef in
            CInterop.release(foobarRef, type: FooBar.self)
        }
    }
    
}

private var lib = Lib(baz: CBaz(create: LibImpl.BazImpl.create,
                                 release: LibImpl.BazImpl.release,
                                 print: LibImpl.BazImpl.print,
                                 setFooBar: LibImpl.BazImpl.setFooBar),
                      fooBar: CFooBar(create: LibImpl.FooBarImpl.create,
                                       release: LibImpl.FooBarImpl.release))


@_cdecl("getLib")
func getLib() -> UnsafePointer<Lib> {
    func getPointer(_ p: UnsafePointer<Lib>) -> UnsafePointer<Lib> {
        return p
    }
    return getPointer(&lib)
}
