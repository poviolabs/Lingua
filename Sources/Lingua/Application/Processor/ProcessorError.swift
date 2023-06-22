import Foundation

enum ProcessorError: LocalizedError {
  case missingLocalization
}

extension ProcessorError {
  var errorDescription: String? {
    switch self {
    case .missingLocalization:
      return "The config json file does not contain 'localization' object"
    }
  }
}
