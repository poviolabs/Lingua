import Foundation

final class LocalizationModule {
  private let config: AssetGenConfig.Localization
  private let makeSheetDataLoader: (AssetGenConfig.Localization) -> SheetDataLoader
  private let makeGenerator: (LocalizationPlatform) -> PlatformLocalizationGenerating
  
  init(config: AssetGenConfig.Localization,
       makeSheetDataLoader: @escaping (AssetGenConfig.Localization) -> SheetDataLoader = { config in
    GoogleSheetDataLoader.make(with: config)
  },
       makePlatformGenerator: @escaping (LocalizationPlatform) -> PlatformLocalizationGenerating = { platform in
    PlatformLocalizationGeneratorFactory.make(for: platform)
  }) {
    self.config = config
    self.makeSheetDataLoader = makeSheetDataLoader
    self.makeGenerator = makePlatformGenerator
  }
  
  func localize(for platform: LocalizationPlatform) async throws {
    do {
      let sheetDataLoader = makeSheetDataLoader(config)
      let sheets = try await sheetDataLoader.loadSheets()
      let generator = makeGenerator(platform)
      try generator.generateLocalizationFiles(data: sheets, config: config)
    } catch {
      throw error
    }
  }
}
