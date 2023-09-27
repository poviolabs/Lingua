import Foundation

struct AndroidStringEscaper: StringEscaping {
  func escapeSpecialCharacters(in string: String) -> String {
    var escapedString = string
    escapedString = escapedString.replacingOccurrences(of: "&", with: "&amp;")
    escapedString = escapedString.replacingOccurrences(of: "<", with: "&lt;")
    escapedString = escapedString.replacingOccurrences(of: ">", with: "&gt;")
    escapedString = escapedString.replacingOccurrences(of: "\"", with: "\\&quot;")
    escapedString = escapedString.replacingOccurrences(of: "'", with: "\\&apos;")
    
    return escapedString
  }
}
