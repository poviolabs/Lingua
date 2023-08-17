import Foundation

public protocol JSONEncoding {
  func encode<T: Encodable>(_ value: T) throws -> Data
}

extension JSONEncoder: JSONEncoding {}
