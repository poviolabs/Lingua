import Foundation
@testable import AssetGen

final class MockLocalizedFilesGenerator: LocalizedFilesGenerating {
  enum Message: Equatable {
    case generate(sheet: LocalizationSheet, config: AssetGenConfig.Localization)
  }
  
  private(set) var messages = [Message]()
  
  func generate(for sheet: LocalizationSheet, config: AssetGenConfig.Localization) throws {
    messages.append(.generate(sheet: sheet, config: config))
  }
}
