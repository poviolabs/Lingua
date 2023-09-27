import Foundation

struct Placeholder {
  let index: Int
  let type: DataType
}

extension Placeholder {
  enum DataType {
    case string
    case int
    case double
    case any
    
    init(for placeholder: String) {
      guard let identifier = placeholder.dropFirst().first else {
        self = .any
        return
      }
      
      switch identifier {
      case "s", "S", "@":
        self = .string
      case "d", "i", "u", "o", "x", "X":
        self = .int
      case "f", "F", "e", "E", "g", "G":
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
}
