import Foundation

final class DefaultLocalizationContentGenerator: LocalizationContentGenerator {
  private let nonPluralOutputGenerator: LocalizationOutputGenerator
  private let pluralOutputGenerator: LocalizationOutputGenerator
  
  init(nonPluralOutputGenerator: LocalizationOutputGenerator, pluralOutputGenerator: LocalizationOutputGenerator) {
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
