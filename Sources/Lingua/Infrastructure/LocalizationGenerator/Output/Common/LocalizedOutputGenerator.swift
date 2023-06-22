import Foundation

struct LocalizedOutputGenerator: LocalizedOutputGenerating {
  private let placeholderMapper: LocalizationPlaceholderMapping
  private let formatter: LocalizedContentFormatting
  
  init(placeholderMapper: LocalizationPlaceholderMapping,
       formatter: LocalizedContentFormatting) {
    self.placeholderMapper = placeholderMapper
    self.formatter = formatter
  }
  
  func generateOutputContent(for entries: [LocalizationEntry]) -> String {
    let content = entries
      .filter { !$0.translations.filter { !$0.value.isEmpty }.isEmpty }
      .compactMap { entry -> String? in
        var updatedEntryTranslations = [String: String]()
        entry.translations.forEach { category, value in
          if !value.isEmpty {
            let mappedValue = placeholderMapper.mapPlaceholders(value)
            updatedEntryTranslations[category] = mappedValue
          }
        }
        let updatedEntry = LocalizationEntry(section: entry.section,
                                             key: entry.key,
                                             translations: updatedEntryTranslations)
        let formattedContent = formatter.formatContent(for: updatedEntry)
        return formattedContent
      }
      .joined(separator: "\n")
    
    return content.isEmpty ? "" : formatter.wrapContent(content)
  }
}
