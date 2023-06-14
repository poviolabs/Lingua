import Foundation

protocol PlaceholderExtractorStrategy {
  func extractPlaceholders(from translation: String, pattern: String) -> [Placeholder]
}
