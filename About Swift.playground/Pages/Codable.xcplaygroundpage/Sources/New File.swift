import Foundation

public func toJSON<T: Encodable>(_ value: T) -> String? {
    guard let jsonData = try? JSONEncoder().encode(value) else {
        return nil
    }
    return String(data: jsonData, encoding: .utf8)!
}


public func fromJSON<T: Decodable>(_ string: String) -> T? {
    let data = string.data(using: .utf8)!
    return try? JSONDecoder().decode(T.self, from: data)
}



