import Foundation

enum ProcessorError: LocalizedError {
  case missingLocalization
  case missingArguments
}

extension ProcessorError {
  var errorDescription: String? {
    switch self {
    case .missingLocalization:
      return "The config json file does not contain 'localization' object"
    case  .missingArguments:
      return "Some arguments are missing!"
    }
  }
}
