import Foundation
@testable import Lingua

final class MockConfigInitialFileGenerator: ConfigInitialFileGenerating {
  enum Message: Equatable {
    case generate
  }
  private(set) var messages = [Message]()
  private let shouldThrow: Bool
  
  init(shouldThrow: Bool = false) {
    self.shouldThrow = shouldThrow
  }
  
  func generate() throws {
    if shouldThrow {
      throw ConfigInitialFileGenerator.Error.failed
    }
    messages.append(.generate)
  }
}
