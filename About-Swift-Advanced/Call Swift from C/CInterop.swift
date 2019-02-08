
import Foundation

enum CInterop {
    
    static func wrap<Instance: AnyObject>(_ instance: Instance) -> OpaquePointer {
        return OpaquePointer(Unmanaged.passRetained(instance).toOpaque())
    }
    
    static func unwrap<Instance: AnyObject>(_ ref: OpaquePointer) -> Instance {
        return Unmanaged<Instance>.fromOpaque(UnsafeRawPointer(ref)).takeUnretainedValue()
    }
    
    static func release<Instance : AnyObject>(_ ref: OpaquePointer, type: Instance.Type) {
        Unmanaged<Instance>.fromOpaque(UnsafeRawPointer(ref)).release()
    }
    
}

extension UnsafePointer where Pointee == CChar {
    
    var string: String {
        return String(cString: self)
    }
    
}
