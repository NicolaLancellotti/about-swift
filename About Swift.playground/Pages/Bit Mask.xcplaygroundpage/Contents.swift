//: [Previous](@previous)

//: # OptionSet
struct MyFontStyle : OptionSet {
    let rawValue : Int // conforms to the BitwiseOperations protocol
    static let Bold             = MyFontStyle(rawValue: 1 << 0)
    static let Italic           = MyFontStyle(rawValue: 1 << 1)
    static let Underline        = MyFontStyle(rawValue: 1 << 2)
    static let Strikethrough    = MyFontStyle(rawValue: 1 << 3)
}

var style: MyFontStyle
style = []
style = .Underline
style = [.Bold, .Italic]

style.contains(MyFontStyle.Italic)
//: [Next](@next)
