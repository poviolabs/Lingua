import Foundation
@testable import Lingua

class MockPlatformFilesGenerator: PlatformFilesGenerating {
  var createPlatformFilesCallCount = 0
  
  func createPlatformFiles(for entries: [LocalizationEntry],
                           sectionName: String,
                           outputFolder: URL,
                           language: String) throws {
    createPlatformFilesCallCount += 1
  }
}
