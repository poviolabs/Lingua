import Foundation

protocol PlatformLocalizationGenerating {
  func generateLocalizationFiles(data: [LocalizationSheet], config: AssetGenConfig.Localization) throws
}
