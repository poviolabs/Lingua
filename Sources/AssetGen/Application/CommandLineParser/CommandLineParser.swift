import Foundation

protocol CommandLineParsable {
  func parse(arguments: [String]) throws -> CommandLineArguments
}

final class CommandLineParser: CommandLineParsable {
  func parse(arguments: [String]) throws -> CommandLineArguments {
    try validateArgumentCount(arguments)
    
    let assetGenerationTypeArgument = arguments[1]
    let configFilePathArgument = arguments[2]
    
    let assetGenerationType = try getAssetGenerationType(from: assetGenerationTypeArgument)
    let platform = try getPlatform(from: assetGenerationTypeArgument, assetGenerationType: assetGenerationType)
    try validateConfigFilePath(configFilePathArgument)
    
    return CommandLineArguments(generationType: assetGenerationType,
                                platform: platform,
                                configFilePath: configFilePathArgument)
  }
}

private extension CommandLineParser {
  func validateArgumentCount(_ arguments: [String]) throws {
    guard arguments.count >= 3 else {
      throw CommandLineParsingError.notEnoughArguments
    }
  }
  
  func getAssetGenerationType(from argument: String) throws -> AssetGenerationType {
    guard let assetGenerationType = parseAssetGenerationType(from: argument) else {
      throw CommandLineParsingError.invalidAssetGenerationType
    }
    return assetGenerationType
  }
  
  func getPlatform(from argument: String, assetGenerationType: AssetGenerationType) throws -> LocalizationPlatform {
    guard let platform = parsePlatform(from: argument, assetGenerationType: assetGenerationType) else {
      throw CommandLineParsingError.invalidPlatform
    }
    return platform
  }
  
  func validateConfigFilePath(_ path: String) throws {
    guard path.hasSuffix(".json") else {
      throw CommandLineParsingError.invalidConfigFilePath
    }
  }
  
  func parseAssetGenerationType(from argument: String) -> AssetGenerationType? {
    guard let value = argument.split(separator: ":").first.map(String.init) else { return .none }
    return AssetGenerationType(rawValue: value)
  }
  
  func parsePlatform(from argument: String, assetGenerationType: AssetGenerationType) -> LocalizationPlatform? {
    let platformRawValue = argument.replacingOccurrences(of: "\(assetGenerationType.rawValue):", with: "")
    return LocalizationPlatform(rawValue: platformRawValue)
  }
}
