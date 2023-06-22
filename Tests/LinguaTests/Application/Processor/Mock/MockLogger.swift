import Foundation
@testable import Lingua

final class MockLogger: Logger {
  enum Message: Equatable {
    case message(message: String, level: LogLevel)
  }
  
  private(set) var messages = [Message]()
  
  func log(_ message: String, level: LogLevel) {
    messages.append(.message(message: message, level: level))
  }
}
