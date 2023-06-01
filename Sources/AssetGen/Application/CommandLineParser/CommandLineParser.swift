import Foundation

protocol CommandLineParsable {
  func parse(arguments: [String]) throws -> CommandLineArguments
}

final class CommandLineParser: CommandLineParsable {
  func parse(arguments: [String]) throws -> CommandLineArguments {
    guard arguments.count >= 3 else {
      throw CommandLineParsingError.notEnoughArguments
    }
    
    guard let assetGenerationType = parseAssetGenerationType(from: arguments[1]) else {
      throw CommandLineParsingError.invalidAssetGenerationType
    }
    
    let platform: LocalizationPlatform
    guard let parsedPlatform = parsePlatform(from: arguments[1], assetGenerationType: assetGenerationType) else {
      throw CommandLineParsingError.invalidPlatform
    }
    platform = parsedPlatform
    
    guard arguments[2].hasSuffix(".json") else {
      throw CommandLineParsingError.invalidConfigFilePath
    }
    
    return CommandLineArguments(generationType: assetGenerationType,
                                platform: platform,
                                configFilePath: arguments[2])
  }
}
 
private extension CommandLineParser {
  func parseAssetGenerationType(from argument: String) -> AssetGenerationType? {
    guard let value = argument.split(separator: ":").first.map(String.init) else { return .none }
    return AssetGenerationType(rawValue: value)
  }
  
  func parsePlatform(from argument: String, assetGenerationType: AssetGenerationType) -> LocalizationPlatform? {
    let platformRawValue = argument.replacingOccurrences(of: "\(assetGenerationType.rawValue):", with: "")
    return LocalizationPlatform(rawValue: platformRawValue)
  }
}
