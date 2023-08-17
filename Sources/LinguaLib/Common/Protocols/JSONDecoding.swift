import Foundation

public protocol JSONDecoding {
  func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: JSONDecoding {}
