import Foundation

struct IOSStringEscaper: StringEscaping {
  func escapeSpecialCharacters(in string: String) -> String {
    var escapedString = string
    escapedString = escapedString.replacingOccurrences(of: "\\", with: "\\\\")
    escapedString = escapedString.replacingOccurrences(of: "\"", with: "\\\"")
    escapedString = escapedString.replacingOccurrences(of: "@", with: "\\@")
    return escapedString
  }
}
