import Foundation

/// A protocol that outlines a method to generate localization files for a platform from given localization sheets and configuration
public protocol PlatformLocalizationGenerating {
  func generateLocalizationFiles(data: [LocalizationSheet], config: Config.Localization) throws
}
