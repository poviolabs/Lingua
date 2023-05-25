import Foundation

protocol PluralFormatting {
  func wrapIn(content: String) -> String
  func composeContent(for entry: LocalizationEntry) -> (key: String, content: String)
}
