import XCTest
@testable import Lingua

final class MockPlatformLocalizationGenerator: PlatformLocalizationGenerating {
  enum Message: Equatable {
    case generate(data: [LocalizationSheet], config: Config.Localization)
  }
  
  private(set) var messages = [Message]()
  private let shouldThrowError: Bool
  
  init(shouldThrowError: Bool = false) {
    self.shouldThrowError = shouldThrowError
  }
  
  func generateLocalizationFiles(data: [LocalizationSheet],
                                 config: Config.Localization) throws {
    if shouldThrowError {
      throw NSError.anyError()
    } else {
      messages.append(.generate(data: data, config: config))
    }
  }
}
