import Foundation

protocol DataParser {
  associatedtype Model
  func parse(_ data: Data) throws -> Model
}
