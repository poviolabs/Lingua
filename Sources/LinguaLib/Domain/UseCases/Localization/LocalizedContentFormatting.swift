import Foundation

/// A protocol that outlines methods for formatting localized content.
/// It provides methods to format a single `LocalizationEntry` and to wrap an already formatted content string.
public protocol LocalizedContentFormatting {
  func formatContent(for entry: LocalizationEntry) -> String
  func wrapContent(_ content: String) -> String
}
