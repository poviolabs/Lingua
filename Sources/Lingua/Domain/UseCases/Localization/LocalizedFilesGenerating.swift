import Foundation

protocol LocalizedFilesGenerating {
  func generate(for sheet: LocalizationSheet, config: ToolConfig.Localization) throws
}
