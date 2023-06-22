import Foundation

protocol DataParsing {
  associatedtype Model
  func parse(_ data: Data) throws -> Model
}
