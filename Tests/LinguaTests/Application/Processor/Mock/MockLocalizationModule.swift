import Foundation
@testable import LinguaLib

final class MockLocalizationModule: ModuleLocalizing {
  enum Message: Equatable {
    case localize(LocalizationPlatform)
  }
  private(set) var messages = [Message]()
  private let errorMessage: String?
  
  init(errorMessage: String?) {
    self.errorMessage = errorMessage
  }
  
  func localize(for platform: LocalizationPlatform) async throws {
    if let errorMessage {
      throw DirectoryOperationError.folderCreationFailed(errorMessage)
    }
    messages.append(.localize(platform))
  }
}
