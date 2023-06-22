import Foundation

protocol PlatformFilesGenerating {
  func createPlatformFiles(for entries: [LocalizationEntry], sectionName: String, outputFolder: URL, language: String) throws
}
