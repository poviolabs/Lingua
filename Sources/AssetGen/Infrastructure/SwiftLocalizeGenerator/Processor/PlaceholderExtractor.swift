import Foundation

struct PlaceholderExtractor {
  func extractPlaceholders(from translation: String) -> [Placeholder] {
    let pattern = "(%([0-9]*\\$)?(\\d*\\$)?[@diufFeEgGxXoOcsaAbBhH]+)"
    guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return [] }
    
    let matches = regex.matches(in: translation, options: [], range: NSRange(location: 0, length: translation.count))
    
    return matches.enumerated().compactMap { (index, match) -> Placeholder? in
      if let range = Range(match.range(at: 1), in: translation) {
        let placeholder = String(translation[range])
        let type = PlaceholderType(for: placeholder).asDataType
        
        return Placeholder(index: index, type: type)
      }
      return nil
    }
  }
}

extension PlaceholderExtractor {
  struct Placeholder {
    let index: Int
    let type: String
  }
}
