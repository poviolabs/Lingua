import Foundation

struct PlaceholderExtractor {
  private let strategy: PlaceholderExtractorStrategy
  
  init(strategy: PlaceholderExtractorStrategy) {
    self.strategy = strategy
  }
  
  func extractPlaceholders(from translation: String) -> [Placeholder] {
    let pattern = "(%([0-9]*\\$)?(\\d*\\$)?[@\\w]+)"
    return strategy.extractPlaceholders(from: translation, pattern: pattern)
  }
}

extension PlaceholderExtractor {
  static func make() -> PlaceholderExtractor {
    if #available(macOS 13.0, *) {
      return PlaceholderExtractor(strategy: RegexPlaceholderExtractor())
    } else {
      return PlaceholderExtractor(strategy: NSRegularExpressionPlaceholderExtractor())
    }
  }
}
