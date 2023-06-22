import Foundation

protocol PlatformLocalizationGenerating {
  func generateLocalizationFiles(data: [LocalizationSheet], config: Config.Localization) throws
}
