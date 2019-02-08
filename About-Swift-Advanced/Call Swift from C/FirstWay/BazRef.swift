
import Foundation

// Baz
@_cdecl("NLBazCreate")
func NLBazCreate(aString: UnsafePointer<CChar>, anInteger: Int32) -> UnsafeMutableRawPointer {
    let baz = Baz(aString: aString.string, anInteger: anInteger)
    return CInterop.wrap(baz)
}

@_cdecl("NLBazSetFooBar")
func NLBazSetFooBar(bazRef: UnsafeMutableRawPointer, fooBarRef: UnsafeMutableRawPointer) {
    let baz: Baz = CInterop.unwrap(bazRef)
    let fooBar: FooBar = CInterop.unwrap(fooBarRef)
    baz.fooBar = fooBar
}

@_cdecl("NLBazPrint")
func NLBazPrint(bazRef: UnsafeMutableRawPointer) {
    let baz: Baz = CInterop.unwrap(bazRef)
    baz.printBaz()
}

@_cdecl("NLBazRelease")
func NLBazRelease(bazRef: UnsafeMutableRawPointer) {
    CInterop.release(bazRef, type: Baz.self)
}


// FooBar
@_cdecl("NLFooBarCreate")
func NLFooBarCreate(anInteger: Int32) -> UnsafeMutableRawPointer {
    let foobar = FooBar(anInteger: anInteger)
    return CInterop.wrap(foobar)
}


@_cdecl("NLFooBarRelease")
func NLFooBarRelease(foobarRef: UnsafeMutableRawPointer) {
    CInterop.release(foobarRef, type: FooBar.self)
}
