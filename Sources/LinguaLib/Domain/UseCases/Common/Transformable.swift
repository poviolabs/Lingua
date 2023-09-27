import Foundation

public protocol Transformable {
  associatedtype Input
  associatedtype Output
  
  func transform(_ object: Input) throws -> Output
}
