import Foundation

struct AndroidPlatformFilesNameGenerator: PlatformFilesNameGenerating {
  func createContent(for entries: [LocalizationEntry],
                     sectionName: String,
                     contentGenerator: LocalizedContentGenerating) -> [(String, String)] {
    let (nonPluralContent, pluralContent) = contentGenerator.createContent(for: entries)
    return [
      (nonPluralContent, "\(String.packageName)-\(sectionName).xml"),
      (pluralContent, "\(String.packageName)-\(sectionName)-plural.xml"),
    ]
  }
}
