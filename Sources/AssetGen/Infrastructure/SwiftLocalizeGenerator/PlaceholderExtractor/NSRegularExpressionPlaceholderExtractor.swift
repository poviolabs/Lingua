import Foundation

struct NSRegularExpressionPlaceholderExtractor: PlaceholderExtractorStrategy {
  func extractPlaceholders(from translation: String, pattern: String) -> [Placeholder] {
    guard let regex = try? NSRegularExpression(pattern: pattern) else { return [] }
    
    let matches = regex.matches(in: translation,
                                range: NSRange(location: 0, length: translation.count))
    
    return matches
      .enumerated()
      .compactMap { (index, match) -> Placeholder? in
        if let range = Range(match.range(at: 1), in: translation) {
          let placeholder = String(translation[range])
          let type = Placeholder.DataType(for: placeholder)
          
          return Placeholder(index: index, type: type)
        }
        return nil
      }
  }
}
