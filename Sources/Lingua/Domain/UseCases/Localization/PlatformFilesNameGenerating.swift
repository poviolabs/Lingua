import Foundation

protocol PlatformFilesNameGenerating {
  func createContent(for entries: [LocalizationEntry],
                     sectionName: String,
                     contentGenerator: LocalizedContentGenerating) -> [(String, String)]
}
