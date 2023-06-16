import Foundation

struct LocalizationModuleFactory {
  static func make(
    config: AssetGenConfig.Localization,
    makeSheetDataLoader: @escaping (AssetGenConfig.Localization) -> SheetDataLoader = { config in
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
