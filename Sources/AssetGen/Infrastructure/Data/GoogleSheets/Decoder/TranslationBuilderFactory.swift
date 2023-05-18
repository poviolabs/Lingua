import Foundation

struct TranslationBuilderFactory {
  static func makeTranslationBuilder(isPlural: Bool) -> TranslationBuilder {
    isPlural ? PluralTranslationBuilder() : NonPluralTranslationBuilder()
  }
}
