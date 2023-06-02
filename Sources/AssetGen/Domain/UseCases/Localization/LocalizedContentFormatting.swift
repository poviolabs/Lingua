import Foundation

protocol LocalizedContentFormatting {
  func formatContent(for entry: LocalizationEntry) -> String
  func wrapContent(_ content: String) -> String
}
