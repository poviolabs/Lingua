import Foundation

enum CommandLineParsingError: Error, CustomStringConvertible {
  case notEnoughArguments
  case invalidAssetGenerationType
  case invalidPlatform
  case invalidConfigFilePath
  
  var description: String {
    switch self {
    case .notEnoughArguments:
      return "Not enough arguments provided."
    case .invalidAssetGenerationType:
      return "Invalid asset generation type."
    case .invalidPlatform:
      return "Invalid platform."
    case .invalidConfigFilePath:
      return "Invalid config file path. Must end with '.json'."
    }
  }
}
