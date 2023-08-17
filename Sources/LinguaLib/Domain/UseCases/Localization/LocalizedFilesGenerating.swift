import Foundation

/// A protocol that defines a method to generate localized files from a given localization sheet and configuration
public protocol LocalizedFilesGenerating {
  func generate(for sheet: LocalizationSheet, config: Config.Localization) throws
}
