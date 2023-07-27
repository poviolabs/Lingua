import Foundation

/// A protocol that dictates a method to create platform-specific localization files from given localization entries
protocol PlatformFilesGenerating {
  func createPlatformFiles(for entries: [LocalizationEntry], sectionName: String, outputFolder: URL, language: String) throws
}
