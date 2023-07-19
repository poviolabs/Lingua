import Foundation

final class LocalizedPlatformFilesGenerator: PlatformFilesGenerating {
  private let contentGenerator: LocalizedContentGenerating
  private let filesCreator: ContentFileCreatable
  private let fileNameGenerator: PlatformFilesNameGenerating
  
  init(contentGenerator: LocalizedContentGenerating,
       filesCreator: ContentFileCreatable,
       fileNameGenerator: PlatformFilesNameGenerating) {
    self.contentGenerator = contentGenerator
    self.filesCreator = filesCreator
    self.fileNameGenerator = fileNameGenerator
  }
  
  func createPlatformFiles(for entries: [LocalizationEntry], sectionName: String, outputFolder: URL, language: String) throws {
    let fileInfos = fileNameGenerator.createContent(for: entries, sectionName: sectionName, contentGenerator: contentGenerator)
    
    for (content, fileName) in fileInfos {
      guard !content.isEmpty else { continue }
      
      do {
        try filesCreator.createFiles(with: String.fileHeader + content, fileName: fileName, outputFolder: outputFolder)
      } catch {
        throw error
      }
    }
  }
}
