import Foundation

protocol LocalizedFilesGenerating {
  func generate(for sheet: LocalizationSheet, config: AssetGenConfig.Localization) throws
}
