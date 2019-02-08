
import Foundation

// Baz
@_cdecl("NLBazCreate")
func NLBazCreate(aString: UnsafePointer<CChar>, anInteger: Int32) -> OpaquePointer {
    let baz = Baz(aString: aString.string, anInteger: anInteger)
    return CInterop.wrap(baz)
}

@_cdecl("NLBazSetFooBar")
func NLBazSetFooBar(bazRef: OpaquePointer, fooBarRef: OpaquePointer) {
    let baz: Baz = CInterop.unwrap(bazRef)
    let fooBar: FooBar = CInterop.unwrap(fooBarRef)
    baz.fooBar = fooBar
}

@_cdecl("NLBazPrint")
func NLBazPrint(bazRef: OpaquePointer) {
    let baz: Baz = CInterop.unwrap(bazRef)
    baz.printBaz()
}

@_cdecl("NLBazRelease")
func NLBazRelease(bazRef: OpaquePointer) {
    CInterop.release(bazRef, type: Baz.self)
}


// FooBar
@_cdecl("NLFooBarCreate")
func NLFooBarCreate(anInteger: Int32) -> OpaquePointer {
    let foobar = FooBar(anInteger: anInteger)
    return CInterop.wrap(foobar)
}


@_cdecl("NLFooBarRelease")
func NLFooBarRelease(foobarRef: OpaquePointer) {
    CInterop.release(foobarRef, type: FooBar.self)
}
