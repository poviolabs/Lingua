import Foundation

struct RegexPlaceholderExtractor: PlaceholderExtractorStrategy {  
  func extractPlaceholders(from translation: String, pattern: String) -> [Placeholder] {
    guard #available(macOS 13.0, *), let regex = try? Regex(pattern) else { return [] }
    
    let matches = translation.ranges(of: regex)
    
    return matches
      .enumerated()
      .compactMap { (index, range) -> Placeholder? in
        let placeholder = String(translation[range])
        let type = Placeholder.DataType(for: placeholder)
        
        return Placeholder(index: index, type: type)
      }
  }
}
