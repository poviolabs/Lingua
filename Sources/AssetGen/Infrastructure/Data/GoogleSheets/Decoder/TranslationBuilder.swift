import Foundation

protocol TranslationBuilder {
  func buildTranslations(from row: [String]) -> [String: String]
}
