import Foundation

struct NonPluralContentFormatter: LocalizedOutputGenerating {
  let formatter: NonPluralFormatting
  
  init(formatter: NonPluralFormatting) {
    self.formatter = formatter
  }
  
  func generateOutputContent(for entries: [LocalizationEntry]) -> String {
    let content = entries
      .compactMap { entry -> String? in
        guard let translation = entry.translations[PluralCategory.one.rawValue],
              !translation.isEmpty else { return nil }
        return formatter.format(key: entry.key, value: translation)
      }
      .joined(separator: "\n")
    
    return content
  }
}
