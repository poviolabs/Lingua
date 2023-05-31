import Foundation

protocol Transformer {
  associatedtype Input
  associatedtype Output
  
  func transform(_ object: Input) throws -> Output
}
