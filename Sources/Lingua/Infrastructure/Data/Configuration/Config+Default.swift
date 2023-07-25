import Foundation

extension Config {
  static func createTemplateConfig() -> Config {
    .init(localization: .init(apiKey: "<your_api_key>",
                              sheetId: "<your_sheet_id>",
                              outputDirectory: "path/to/Resources/Localization",
                              localizedSwiftCode: nil))
  }
}
