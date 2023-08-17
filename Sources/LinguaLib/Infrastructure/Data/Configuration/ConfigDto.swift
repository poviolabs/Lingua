import Foundation

public struct ConfigDto: Equatable, Codable {
  public let localization: Localization?
}

public extension ConfigDto {
  struct Localization: Equatable, Codable {
    let apiKey: String
    let sheetId: String
    let outputDirectory: String
    let swiftCode: LocalizedSwiftCode?
  }
  
  struct LocalizedSwiftCode: Equatable, Codable {
    let stringsDirectory: String
    let outputSwiftCodeFileDirectory: String
  }
}
