import Foundation

protocol LocalizedOutputGenerating {
  func generateOutputContent(for entries: [LocalizationEntry]) -> String
}
