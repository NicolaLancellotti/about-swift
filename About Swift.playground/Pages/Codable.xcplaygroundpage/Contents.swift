//: [Previous](@previous)
//: # Codable
//: ## Encode and decode automatically
struct Point: Codable {
  var x: Double
  var y: Double
}
//: ### Encode
do {
  let points = [Point(x: 1.0, y: 2.0), Point(x: 3.0, y: 4.0)]
  toJSON(points)
}
//: ### Decode
do {
  let json = """
    [
        {
            "x":5,
            "y":6
        },
        {
            "x":7,
            "y":8
        }
    ]
    """
  
  let points: [Point] = fromJSON(json)!
  points[0].x
  points[0].y
  points[1].x
  points[1].y
}
//: ## Encode and decode manually
//: ### JSON
let json = """
{
    "int_property":10,
    "array_property":[10, 11],
    "inner_property_containter":
        {
            "inner_property":"a"
        }
}
"""
//: ### Corresponding structure
struct Item {
  
  var intProperty: Int
  var arrayProperty: [Int]
  var innerProperty: String
  
  var nonCodableProperty: Bool = false
  
  enum CodingKeys: String, CodingKey {
    case intProperty = "int_property"
    case arrayProperty = "array_property"
    case innerPropertyContainter = "inner_property_containter"
  }
  
  enum InnerPropertyContainterKeys: String, CodingKey {
    case innerProperty = "inner_property"
  }
  
}
//: ### Encodable
extension Item: Encodable {
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(intProperty, forKey: .intProperty)
    
    var innerContainter = container
      .nestedContainer(keyedBy: InnerPropertyContainterKeys.self,
                       forKey: .innerPropertyContainter)
    try innerContainter.encode(innerProperty, forKey: .innerProperty)
    
    try container.encode(arrayProperty, forKey: .arrayProperty)
    // The same as:
    //  var arrayContainer = container.nestedUnkeyedContainer(forKey: .arrayProperty)
    //  try arrayProperty.forEach { try arrayContainer.encode($0) }
  }
}
//: ### Encode
do {
  let item = Item(intProperty: 10,
                  arrayProperty: [1, 2],
                  innerProperty: "a",
                  nonCodableProperty: false)
  toJSON(item)
}
//: ### Decodable
extension Item: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.intProperty = try container.decode(Int.self, forKey: .intProperty)
    
    let innerContainter = try container
      .nestedContainer(keyedBy: InnerPropertyContainterKeys.self,
                       forKey: .innerPropertyContainter)
    self.innerProperty = try innerContainter.decode(String.self,
                                                    forKey: .innerProperty)
    
    arrayProperty = try container.decode([Int].self, forKey: .arrayProperty)
    // The same as:
    //  var arrayContainer = try container.nestedUnkeyedContainer(forKey: .arrayProperty)
    //  self.arrayProperty = [Int]()
    //  if let count = containter.count {
    //    arrayProperty.reserveCapacity(count)
    //    for _ in 0..<count {
    //      arrayProperty.append(try arrayContainer.decode(Int.self))
    //    }
    //  }
  }
}
//: ### Decode
do {
  let item: Item = fromJSON(json)!
  item.intProperty
  item.innerProperty
  item.arrayProperty
  item.nonCodableProperty
}
//: [Next](@next)
