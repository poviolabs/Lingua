import Foundation

public protocol ModuleLocalizing {
  func localize(for platform: LocalizationPlatform) async throws
}

public final class LocalizationModule: ModuleLocalizing {
  private let config: Config.Localization
  private let makeSheetDataLoader: (Config.Localization) -> SheetDataLoader
  private let makeGenerator: (LocalizationPlatform) -> PlatformLocalizationGenerating
  private let makeLocalizedFileGenerator: (LocalizationPlatform) -> LocalizedCodeFileGenerating
  
  public init(config: Config.Localization,
       makeSheetDataLoader: @escaping (Config.Localization) -> SheetDataLoader,
       makePlatformGenerator: @escaping (LocalizationPlatform) -> PlatformLocalizationGenerating,
       makeLocalizedFileGenerator: @escaping (LocalizationPlatform) -> LocalizedCodeFileGenerating
  ) {
    self.config = config
    self.makeSheetDataLoader = makeSheetDataLoader
    self.makeGenerator = makePlatformGenerator
    self.makeLocalizedFileGenerator = makeLocalizedFileGenerator
  }
  
  public func localize(for platform: LocalizationPlatform) async throws {
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
