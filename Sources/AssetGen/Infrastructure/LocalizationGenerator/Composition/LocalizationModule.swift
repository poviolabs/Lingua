import Foundation

protocol ModuleLocalizing {
  func localize(for platform: LocalizationPlatform) async throws
}

final class LocalizationModule: ModuleLocalizing {
  private let config: AssetGenConfig.Localization
  private let makeSheetDataLoader: (AssetGenConfig.Localization) -> SheetDataLoader
  private let makeGenerator: (LocalizationPlatform) -> PlatformLocalizationGenerating
  private let makeLocalizedFileGenerator: (LocalizationPlatform) -> LocalizedCodeFileGenerating
  
  init(config: AssetGenConfig.Localization,
       makeSheetDataLoader: @escaping (AssetGenConfig.Localization) -> SheetDataLoader = { config in
    GoogleSheetDataLoaderFactory.make(with: config)
  },
       makePlatformGenerator: @escaping (LocalizationPlatform) -> PlatformLocalizationGenerating = { platform in
    PlatformLocalizationGeneratorFactory.make(for: platform)
  },
       makeLocalizedFileGenerator: @escaping (LocalizationPlatform) -> LocalizedCodeFileGenerating = { platform in
    LocalizedSwiftFileGeneratorFactory.make(platform: platform)
  }) {
    self.config = config
    self.makeSheetDataLoader = makeSheetDataLoader
    self.makeGenerator = makePlatformGenerator
    self.makeLocalizedFileGenerator = makeLocalizedFileGenerator
  }
  
  func localize(for platform: LocalizationPlatform) async throws {
    do {
      let sheetDataLoader = makeSheetDataLoader(config)
      let sheets = try await sheetDataLoader.loadSheets()
      let generator = makeGenerator(platform)
      try generator.generateLocalizationFiles(data: sheets, config: config)
      if let swiftCodeConfig = config.localizedSwiftCode {
        let swiftCodeGenerator = makeLocalizedFileGenerator(platform)
        swiftCodeGenerator.generate(from: swiftCodeConfig.stringsDirectory,
                                    outputPath: swiftCodeConfig.outputSwiftCodeFileDirectory)
      }
    } catch {
      throw error
    }
  }
}
