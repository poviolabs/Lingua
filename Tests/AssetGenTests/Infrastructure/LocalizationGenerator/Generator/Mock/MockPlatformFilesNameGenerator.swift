import Foundation
@testable import AssetGen

final class MockPlatformFilesNameGenerator: PlatformFilesNameGenerating {
  private let fileExtension: String
  
  init(fileExtension: String = "txt") {
    self.fileExtension = fileExtension
  }
  
  func createContent(for entries: [LocalizationEntry], sectionName: String, contentGenerator: AssetGen.LocalizedContentGenerating) -> [(String, String)] {
    let (stringsContent, stringsDictContent) = contentGenerator.createContent(for: entries)
    return [
      (stringsContent, "\(sectionName).\(fileExtension)"),
      (stringsDictContent, "\(sectionName)-plural.\(fileExtension)"),
    ]
  }
}
