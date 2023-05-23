import Foundation

protocol LocalizedContentGenerating {
  func createContent(for entries: [LocalizationEntry]) -> (nonPlural: String, plural: String)
}
