import Foundation
@testable import AssetGen

final class MockLocalizationModule: ModuleLocalizing {
  enum Message: Equatable {
    case localize(LocalizationPlatform)
  }
  private(set) var messages = [Message]()
  
  func localize(for platform: LocalizationPlatform) async throws {
    messages.append(.localize(platform))
  }
}
