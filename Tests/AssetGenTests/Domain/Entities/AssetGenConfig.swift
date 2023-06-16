import Foundation
@testable import AssetGen

extension AssetGenConfig.Localization {
  static func make(apiKey: String = "key",
                   sheetId: String = "id",
                   outputDirectory: String = "path") -> AssetGenConfig.Localization {
    .init(apiKey: apiKey,
          sheetId: sheetId,
          outputDirectory: outputDirectory, localizedSwiftCode: .none)
  }
}
