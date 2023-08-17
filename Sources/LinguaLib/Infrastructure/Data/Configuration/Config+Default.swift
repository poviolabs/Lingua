import Foundation

extension Config {
  static func createTemplateConfig() -> Config {
    .init(localization: .init(apiKey: "<google_api_key>",
                              sheetId: "<google_spreadsheet_id>",
                              outputDirectory: "path/to/Resources/Localization",
                              localizedSwiftCode: nil))
  }
}
