import Foundation
@testable import Lingua

extension ToolConfig.Localization {
  static func make(apiKey: String = "key",
                   sheetId: String = "id",
                   outputDirectory: String = "path",
                   localizedSwiftCode: ToolConfig.LocalizedSwiftCode? = .none) -> ToolConfig.Localization {
    .init(apiKey: apiKey,
          sheetId: sheetId,
          outputDirectory: outputDirectory,
          localizedSwiftCode: localizedSwiftCode)
  }
}
