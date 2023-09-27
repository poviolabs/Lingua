import Foundation

/// A protocol that defines a method to create contents for platform-specific localization files.
/// The method should take an array of `LocalizationEntry`, a `sectionName` and a `LocalizedContentGenerating`
/// instance as input, and return a collection of tuples, where each tuple represents the file's name and its content.
public protocol PlatformFilesNameGenerating {
  func createContent(for entries: [LocalizationEntry],
                     sectionName: String,
                     contentGenerator: LocalizedContentGenerating) -> [(String, String)]
}
