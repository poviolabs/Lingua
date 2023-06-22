import Foundation
@testable import Lingua

extension Config.Localization {
  static func make(apiKey: String = "key",
                   sheetId: String = "id",
                   outputDirectory: String = "path",
                   localizedSwiftCode: Config.LocalizedSwiftCode? = .none) -> Config.Localization {
    .init(apiKey: apiKey,
          sheetId: sheetId,
          outputDirectory: outputDirectory,
          localizedSwiftCode: localizedSwiftCode)
  }
}
