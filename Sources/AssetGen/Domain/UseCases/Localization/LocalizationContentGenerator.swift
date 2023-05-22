import Foundation

protocol LocalizationContentGenerator {
  func createContent(for entries: [LocalizationEntry]) -> (nonPlural: String, plural: String)
}
