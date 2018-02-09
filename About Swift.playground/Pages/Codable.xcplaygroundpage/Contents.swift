//: [Previous](@previous)

//: # Codable
import Foundation

struct Item: Codable {
    var x: Double
    var y: Double
    
    enum CodingKeys: String, CodingKey {
        case x
        case y = "z"
    }
}

let items = [Item(x: 9.0, y: 10.0)]
//: ## Encode
let jsonData = try JSONEncoder().encode(items)
let jsonString = String(data: jsonData, encoding: .utf8)!
//: ## Decode
let jsonString2 = """
[
    {
        "x":9,
        "z":10
    }
]
"""


let jsonData2 = jsonString2.data(using: .utf8)!
let items2 = try! JSONDecoder().decode([Item].self, from: jsonData2)
items2[0].x
items2[0].y

//: [Next](@next)
