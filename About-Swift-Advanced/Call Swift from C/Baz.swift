
import Foundation

class Baz {
    let aString: String
    let anInteger: Int32
    
    init(aString: String, anInteger: Int32) {
        self.aString = aString
        self.anInteger = anInteger
        print("Baz created")
    }
    
    func printBaz() {
        print("aString: \(aString), anInteger: \(anInteger)")
    }
    
    deinit {
        print("Baz released")
    }
    
}
