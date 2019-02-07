
import Foundation

@_cdecl("NLBazCreate")
func NLBazCreate(aString: UnsafePointer<CChar>, anInteger: Int32) -> UnsafeMutableRawPointer {
    let baz = Baz(aString: aString.string, anInteger: anInteger)
    return CInterop.wrap(baz)
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
