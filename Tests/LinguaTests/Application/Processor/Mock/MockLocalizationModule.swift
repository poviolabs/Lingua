import Foundation
@testable import LinguaLib

final class MockLocalizationModule: ModuleLocalizing {
  enum Message: Equatable {
    case localize(LocalizationPlatform)
  }
  private(set) var messages = [Message]()
  private let shouldThrow: String?
  
  init(shouldThrow: String?) {
    self.shouldThrow = shouldThrow
  }
  
  func localize(for platform: LocalizationPlatform) async throws {
    if let shouldThrow {
      throw DirectoryOperationError.folderCreationFailed(shouldThrow)
    }
    messages.append(.localize(platform))
  }
}
