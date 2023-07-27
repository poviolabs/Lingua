import Foundation

enum CommandLineParsingError: LocalizedError {
  case notEnoughArguments
  case invalidPlatform
  case invalidConfigFilePath
  case invalidCommand
  
  var errorDescription: String? {
    switch self {
    case .notEnoughArguments:
      return "Not enough arguments provided."
    case .invalidPlatform:
      return "Invalid platform."
    case .invalidConfigFilePath:
      return "Invalid config file path. Must end with '.json'."
    case .invalidCommand:
      return "Invalid command."
    }
  }
}
