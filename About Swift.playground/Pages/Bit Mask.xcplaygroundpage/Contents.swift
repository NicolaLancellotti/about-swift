//: [Previous](@previous)

//: # OptionSet
struct MyFontStyle : OptionSet {
    let rawValue : Int // conforms to the BitwiseOperations protocol
    static let bold             = MyFontStyle(rawValue: 1 << 0)
    static let italic           = MyFontStyle(rawValue: 1 << 1)
    static let underline        = MyFontStyle(rawValue: 1 << 2)
    static let strikethrough    = MyFontStyle(rawValue: 1 << 3)
}

var style: MyFontStyle
style = []
style = .underline
style = [.bold, .italic]

style.formUnion([.bold, .italic])
style.insert(.strikethrough)
style.remove(.bold)
style.contains(.italic)
//: [Next](@next)
