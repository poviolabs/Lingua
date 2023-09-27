import Foundation

public struct LocalizationModuleFactory {
  public static func make(
    config: Config.Localization,
    makeSheetDataLoader: @escaping (Config.Localization) -> SheetDataLoader = { config in
      GoogleSheetDataLoaderFactory.make(with: config)
    }
  ) -> ModuleLocalizing {
    let platformGenerator: (LocalizationPlatform) -> PlatformLocalizationGenerating = { platform in
      PlatformLocalizationGeneratorFactory.make(for: platform)
    }
    let localizedFileGenerator: (LocalizationPlatform) -> LocalizedCodeFileGenerating = { platform in
      LocalizedSwiftFileGeneratorFactory.make(platform: platform)
    }
    
    return LocalizationModule(
      config: config,
      makeSheetDataLoader: makeSheetDataLoader,
      makePlatformGenerator: platformGenerator,
      makeLocalizedFileGenerator: localizedFileGenerator
    )
  }
}
