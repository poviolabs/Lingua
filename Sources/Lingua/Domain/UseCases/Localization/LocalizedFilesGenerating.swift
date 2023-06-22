import Foundation

protocol LocalizedFilesGenerating {
  func generate(for sheet: LocalizationSheet, config: Config.Localization) throws
}
