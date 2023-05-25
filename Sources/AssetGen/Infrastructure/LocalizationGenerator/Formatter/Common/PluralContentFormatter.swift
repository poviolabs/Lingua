import Foundation

struct PluralContentFormatter: LocalizedOutputGenerating {
  let formatter: PluralFormatting
  
  init(formatter: PluralFormatting) {
    self.formatter = formatter
  }
  
  func generateOutputContent(for entries: [LocalizationEntry]) -> String {
    let plistContent = entries
      .filter { !$0.translations.filter { !$0.value.isEmpty }.isEmpty }
      .compactMap { entry -> String? in
        let (key, value) = formatter.composeContent(for: entry)
        return key.isEmpty ? nil : "\(key)\(value)"
      }
      .joined(separator: "")
    
    return plistContent.isEmpty ? "" : formatter.wrapIn(content: plistContent)
  }
}
