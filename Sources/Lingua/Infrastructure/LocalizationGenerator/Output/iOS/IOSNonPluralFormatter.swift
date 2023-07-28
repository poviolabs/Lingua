import Foundation

struct IOSNonPluralFormatter: LocalizedContentFormatting {
  func formatContent(for entry: LocalizationEntry) -> String {
    guard let translation = entry.translations[PluralCategory.one.rawValue],
          !translation.isEmpty else { return "" }
    return "\"\(entry.key)\" = \"\(translation)\";"
  }
  
  func wrapContent(_ content: String) -> String {
    [String.fileHeader.commentOut(for: .ios), content].joined(separator: "\n")
  }
}
