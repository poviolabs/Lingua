import Foundation

enum ProcessorError: Error {
  case missingLocalization
}

extension ProcessorError: CustomStringConvertible {
  var description: String {
    switch self {
    case .missingLocalization:
      return "The config json file does not contain 'localization' object"
    }
  }
}
