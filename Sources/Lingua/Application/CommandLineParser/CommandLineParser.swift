import Foundation

protocol CommandLineParsable {
  func parse(arguments: [String]) throws -> CommandLineArguments
}

final class CommandLineParser: CommandLineParsable {
  func parse(arguments: [String]) throws -> CommandLineArguments {
    try validateArgumentCount(arguments)
        
    let configFilePathArgument = arguments[2]
    let platform = try getPlatform(from: arguments[1])
    try validateConfigFilePath(configFilePathArgument)
    
    return CommandLineArguments(platform: platform, configFilePath: configFilePathArgument)
  }
}

private extension CommandLineParser {
  func validateArgumentCount(_ arguments: [String]) throws {
    guard arguments.count > 2 else {
      throw CommandLineParsingError.notEnoughArguments
    }
  }
  
  func getPlatform(from argument: String) throws -> LocalizationPlatform {
    guard let platform = LocalizationPlatform(rawValue: argument) else {
      throw CommandLineParsingError.invalidPlatform
    }
    return platform
  }
  
  func validateConfigFilePath(_ path: String) throws {
    guard path.hasSuffix(".json") else {
      throw CommandLineParsingError.invalidConfigFilePath
    }
  }
}
