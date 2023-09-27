import Foundation
import LinguaLib

protocol CommandLineParsable {
  func parse(arguments: [String]) throws -> CommandLineArguments
}

final class CommandLineParser: CommandLineParsable {
  func parse(arguments: [String]) throws -> CommandLineArguments {
    try validateArgumentCount(arguments, count: 1)
    
    let firstArgument = arguments[1].lowercased()
    let firstCommand = Command(rawValue: firstArgument)
    
    switch firstCommand {
    case .ios, .android:
      try validateArgumentCount(arguments, count: 2)
      let configFilePathArgument = arguments[2]
      let platform = try getPlatform(from: firstArgument)
      try validateConfigFilePath(configFilePathArgument)
      return CommandLineArguments(command: firstCommand, platform: platform, configFilePath: configFilePathArgument)
      
    case .config:
      try validateArgumentCount(arguments, count: 2)
      guard Command(rawValue: arguments[2].lowercased()) == .initializer else {
        throw CommandLineParsingError.invalidCommand
      }
      return CommandLineArguments(command: firstCommand, platform: nil, configFilePath: nil)
      
    case .version, .abbreviatedVersion:
      return CommandLineArguments(command: firstCommand, platform: nil, configFilePath: nil)
    default:
      throw CommandLineParsingError.invalidCommand
    }
  }
}
 
private extension CommandLineParser {
  func validateArgumentCount(_ arguments: [String], count: Int) throws {
    guard arguments.count > count else {
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
