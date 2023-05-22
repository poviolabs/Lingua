import Foundation

protocol LocalizationOutputGenerator {
  func generateOutputContent(for entries: [LocalizationEntry]) -> String
}
