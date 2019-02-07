
import Foundation

enum CInterop {
    static func wrap<Instance: AnyObject>(_ instance: Instance) -> UnsafeMutableRawPointer {
        return Unmanaged.passRetained(instance).toOpaque()
    }
    
    static func unwrap<Instance: AnyObject>(_ ref: UnsafeRawPointer) -> Instance {
        return Unmanaged<Instance>.fromOpaque(ref).takeUnretainedValue()
    }
    
    static func release<Instance : AnyObject>(_ ref: UnsafeRawPointer, type: Instance.Type) {
        Unmanaged<Instance>.fromOpaque(ref).release()
    }
}

extension UnsafePointer where Pointee == CChar {
    
    var string: String {
        return String(cString: self)
    }
}
