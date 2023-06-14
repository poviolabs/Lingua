import Foundation

enum PlaceholderType {
  case string
  case int
  case double
  case any
  
  init(for placeholder: String) {
    switch placeholder {
    case "%@", "%A":
      self = .string
    case "%d", "%i", "%u", "%o", "%x", "%X":
      self = .int
    case "%f", "%F", "%e", "%E", "%g", "%G":
      self = .double
    default:
      self = .any
    }
  }
  
  var asDataType: String {
    switch self {
    case .string:
      return "String"
    case .int:
      return "Int"
    case .double:
      return "Double"
    case .any:
      return "Any"
    }
  }
}
