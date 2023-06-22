import Foundation

struct AndroidPlaceholderMapper: LocalizationPlaceholderMapping {
  func mapPlaceholders(_ text: String) -> String {
    let pattern = "(%[@AdeEfFgGiouxX%])|(\n)"
    guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return text }
    
    var result = text
    var currentIndex = 0
    var locationOffset = 0
    
    regex.enumerateMatches(in: text, options: [], range: NSRange(location: 0, length: text.count)) { (match, _, _) in
      guard let match = match else { return }
      
      let adjustedRange = NSRange(location: match.range.location - locationOffset, length: match.range.length)
      let matchedString = (result as NSString).substring(with: adjustedRange)
      
      if let androidPlaceholder = iOSToAndroidPlaceholders[matchedString] {
        currentIndex += 1
        let replacement = "%\(currentIndex)$\(androidPlaceholder)"
        result = (result as NSString).replacingCharacters(in: adjustedRange, with: replacement)
        locationOffset += match.range.length - replacement.count
      } else if matchedString == "\n" {
        let replacement = "\\n"
        result = (result as NSString).replacingCharacters(in: adjustedRange, with: replacement)
        locationOffset += match.range.length - replacement.count
      }
    }
    
    result = result.replacingOccurrences(of: "&", with: "&amp;")
    result = result.replacingOccurrences(of: "'", with: "\\'")
    return result
  }
  
  private let iOSToAndroidPlaceholders: [String: String] = [
    "%@": "s",
    "%A": "s",
    "%d": "d",
    "%i": "d",
    "%u": "d",
    "%o": "o",
    "%x": "x",
    "%X": "X",
    "%f": "f",
    "%F": "f",
    "%e": "e",
    "%E": "E",
    "%g": "g",
    "%G": "G"
  ]
}
