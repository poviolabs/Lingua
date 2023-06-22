import Foundation

struct AssetGenConfigDto: Equatable, Codable {
  let localization: Localization?
}

extension AssetGenConfigDto {
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
