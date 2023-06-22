import Foundation
@testable import Lingua

final class MockLocalizedFilesGenerator: LocalizedFilesGenerating {
  enum Message: Equatable {
    case generate(sheet: LocalizationSheet, config: ToolConfig.Localization)
  }
  
  private(set) var messages = [Message]()
  
  func generate(for sheet: LocalizationSheet, config: ToolConfig.Localization) throws {
    messages.append(.generate(sheet: sheet, config: config))
  }
}
