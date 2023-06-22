import Foundation
@testable import Lingua

final class MockLocalizedSwiftCodeGenerator: LocalizedCodeFileGenerating {
  enum Message: Equatable {
    case path(path: String?, outputPath: String?)
  }
  
  private(set) var messages = [Message]()
  
  func generate(from path: String, outputPath: String) {
    messages.append(.path(path: path, outputPath: outputPath))
  }
}
