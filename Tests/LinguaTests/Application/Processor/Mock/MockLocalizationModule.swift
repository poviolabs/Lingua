import Foundation
@testable import LinguaLib

final class MockLocalizationModule: ModuleLocalizing {
  enum Message: Equatable {
    case localize(LocalizationPlatform)
  }
  private(set) var messages = [Message]()
  private let shouldThrow: Bool
  
  init(shouldThrow: Bool = false) {
    self.shouldThrow = shouldThrow
  }
  
  func localize(for platform: LocalizationPlatform) async throws {
    if shouldThrow {
      throw DirectoryOperationError.folderCreationFailed
    }
    messages.append(.localize(platform))
  }
}
