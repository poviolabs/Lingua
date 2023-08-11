import Foundation

struct IOSStringEscaper: StringEscaping {
  func escapeSpecialCharacters(in string: String) -> String {
    string.replacingOccurrences(of: "\"", with: "\\\"")
  }
}
