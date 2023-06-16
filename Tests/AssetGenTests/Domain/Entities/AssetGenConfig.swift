import Foundation
@testable import AssetGen

extension AssetGenConfig.Localization {
  static func make(apiKey: String = "key",
                   sheetId: String = "id",
                   outputDirectory: String = "path",
                   localizedSwiftCode: AssetGenConfig.LocalizedSwiftCode? = .none) -> AssetGenConfig.Localization {
    .init(apiKey: apiKey,
          sheetId: sheetId,
          outputDirectory: outputDirectory,
          localizedSwiftCode: localizedSwiftCode)
  }
}
