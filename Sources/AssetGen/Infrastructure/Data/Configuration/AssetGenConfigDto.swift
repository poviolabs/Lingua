import Foundation

struct AssetGenConfigDto: Equatable, Codable {
  let localization: Localization?
}

extension AssetGenConfigDto {
  struct Localization: Equatable, Codable {
    let apiKey: String
    let sheetId: String
    let outputDirectory: String
  }
}
