import Foundation
@testable import LinguaLib

final class MockPrinter: Printer {
 private(set) var messages = [String]()
  
  func print(_ items: Any...) {
    messages.append(items.map { "\($0)" }.joined(separator: " "))
  }
}
