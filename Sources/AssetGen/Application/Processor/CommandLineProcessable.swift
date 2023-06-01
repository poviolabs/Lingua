import Foundation

protocol CommandLineProcessable {
  func process(arguments: [String]) async throws
}
