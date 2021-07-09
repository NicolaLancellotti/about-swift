//: [Previous](@previous)
//: # Codable
//: ## Encode and Decode Automatically
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
//: ## Encode and Decode Manually
//: ### JSON
"""
{
    "int_property":10,
    "array_property":[10, 11],
    "inner_property_containter":
        {
            "inner_property":"a"
        }
}
"""
//: ### Corresponding Structure
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
    
    var innerPropertyContainter = container.nestedContainer(keyedBy: InnerPropertyContainterKeys.self,
                                                            forKey: .innerPropertyContainter)
    try innerPropertyContainter.encode(innerProperty, forKey: .innerProperty)
    
    
    try container.encode(arrayProperty, forKey: .arrayProperty)
    // The same as:
    //  var container2 = container.nestedUnkeyedContainer(forKey: .arrayProperty)
    //  try arrayProperty.forEach { try container2.encode($0) }
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
    let values = try decoder.container(keyedBy: CodingKeys.self)
    intProperty = try values.decode(Int.self, forKey: .intProperty)
    
    let innerPropertyContainter = try values.nestedContainer(keyedBy: InnerPropertyContainterKeys.self, forKey: .innerPropertyContainter)
    innerProperty = try innerPropertyContainter.decode(String.self, forKey: .innerProperty)
    
    arrayProperty = try values.decode([Int].self, forKey: .arrayProperty)
    // The same as:
    //  var containter = try values.nestedUnkeyedContainer(forKey: .arrayProperty)
    //  arrayProperty = [Int]()
    //  if let count = containter.count {
    //    arrayProperty.reserveCapacity(count)
    //    for _ in 0..<count {
    //      let value = try containter.decode(Int.self)
    //      arrayProperty.append(value)
    //    }
    //  }
  }
}
//: ### Decode
do {
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
  
  let item: Item = fromJSON(json)!
  item.intProperty
  item.innerProperty
  item.arrayProperty
  item.nonCodableProperty
}
//: [Next](@next)
