import Foundation

struct AndroidNonPluralFormatter: LocalizedContentFormatting {
  func formatContent(for entry: LocalizationEntry) -> String {
    guard let translation = entry.translations[PluralCategory.one.rawValue],
          !translation.isEmpty else { return "" }
    return "\t<string name=\"\(entry.androidKey)\">\(translation)</string>"
  }
  
  func wrapContent(_ content: String) -> String {
    """
    <?xml version="1.0" encoding="utf-8"?>
    <resources>
    \(content)
    </resources>
    """
  }
}
