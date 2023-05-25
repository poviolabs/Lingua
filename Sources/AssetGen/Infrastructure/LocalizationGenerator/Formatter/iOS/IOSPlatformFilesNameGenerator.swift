import Foundation
 
struct IOSPlatformFilesNameGenerator: PlatformFilesNameGenerating {
  func createContent(for entries: [LocalizationEntry],
                     sectionName: String,
                     contentGenerator: LocalizedContentGenerating) -> [(String, String)] {
    let (stringsContent, stringsDictContent) = contentGenerator.createContent(for: entries)
    return [
      (stringsContent, "\(sectionName).strings"),
      (stringsDictContent, "\(sectionName).stringsdict"),
    ]
  }
}

