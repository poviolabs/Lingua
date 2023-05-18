import Foundation

struct NonPluralTranslationBuilder: TranslationBuilder {
  func buildTranslations(from row: [String]) -> [String: String] {
    guard row.count >= 5 else { return [:] }
    return [PluralCategory.one.rawValue: row[4]]
  }
}
