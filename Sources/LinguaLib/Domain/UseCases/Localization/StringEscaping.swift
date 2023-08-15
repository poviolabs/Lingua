import Foundation

public protocol StringEscaping {
  func escapeSpecialCharacters(in string: String) -> String
}
