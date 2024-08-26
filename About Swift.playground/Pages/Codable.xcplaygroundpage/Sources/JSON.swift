import Foundation

public func toJSON<T: Encodable>(_ value: T) -> String? {
  guard let jsonData = try? JSONEncoder().encode(value) else { return nil }
  return String(data: jsonData, encoding: .utf8)!
}


public func fromJSON<T: Decodable>(_ string: String) -> T? {
  guard let data = string.data(using: .utf8) else { return nil }
  return try? JSONDecoder().decode(T.self, from: data)
}
