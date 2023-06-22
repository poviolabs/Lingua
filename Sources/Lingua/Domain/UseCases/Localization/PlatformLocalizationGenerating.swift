import Foundation

protocol PlatformLocalizationGenerating {
  func generateLocalizationFiles(data: [LocalizationSheet], config: ToolConfig.Localization) throws
}
