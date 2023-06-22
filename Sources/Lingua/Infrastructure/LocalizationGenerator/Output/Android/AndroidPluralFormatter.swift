import Foundation

struct AndroidPluralFormatter: LocalizedContentFormatting {
  func formatContent(for entry: LocalizationEntry) -> String {
    let sortedTranslations = entry.translations.sorted { $0.key < $1.key }
    let pluralItems = sortedTranslations.compactMap { (category, value) -> String? in
      guard !value.isEmpty else { return nil }
      return "\t\t<item quantity=\"\(category)\">\(value)</item>"
    }.joined(separator: "\n")
    
    let key = "\t<plurals name=\"\(entry.key)\">\n"
    let content = key + pluralItems + "\n\t</plurals>"
    return content
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
