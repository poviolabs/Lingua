import Foundation

struct PluralTranslationBuilder: TranslationBuilder {
  func buildTranslations(from row: [String]) -> [String: String] {
    let pluralCategories: [String] = PluralCategory.allCases.map { $0.rawValue }
    let pluralValues: [String] = Array(row.dropFirst(3).prefix(6))
    return Dictionary(uniqueKeysWithValues: zip(pluralCategories, pluralValues))
  }
}
