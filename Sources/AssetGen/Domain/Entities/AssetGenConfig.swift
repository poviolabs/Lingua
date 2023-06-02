import Foundation

struct AssetGenConfig: Equatable {
  let localization: Localization?
}

extension AssetGenConfig {
  struct Localization: Equatable {
    let apiKey: String
    let sheetId: String
    let outputDirectory: String
  }
}
