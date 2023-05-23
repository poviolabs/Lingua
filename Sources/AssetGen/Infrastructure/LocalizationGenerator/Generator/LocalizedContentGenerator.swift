import Foundation

final class LocalizedContentGenerator: LocalizedContentGenerating {
  private let nonPluralOutputGenerator: LocalizedOutputGenerating
  private let pluralOutputGenerator: LocalizedOutputGenerating
  
  init(nonPluralOutputGenerator: LocalizedOutputGenerating, pluralOutputGenerator: LocalizedOutputGenerating) {
    self.nonPluralOutputGenerator = nonPluralOutputGenerator
    self.pluralOutputGenerator = pluralOutputGenerator
  }
  
  func createContent(for entries: [LocalizationEntry]) -> (nonPlural: String, plural: String) {
    let nonPluralEntries = entries.filter { !$0.plural }
    let pluralEntries = entries.filter { $0.plural }
    let nonPluralContent = nonPluralOutputGenerator.generateOutputContent(for: nonPluralEntries)
    let pluralContent = pluralOutputGenerator.generateOutputContent(for: pluralEntries)
    
    return (nonPluralContent, pluralContent)
  }
}
