import Foundation

struct ProcessorFactory {
  func makeLocalizationProcessor(
    argumentParser: CommandLineParsable = CommandLineParser(),
    logger: Logger = ConsoleLogger.shared,
    entityFileLoader: EntityFileLoader<JSONDataParser<AssetGenConfigDto>, AssetGenConfigTransformer> = EntityLoaderFactory.makeAssetGenConfigLoader(),
    localizationModuleFactory: @escaping (AssetGenConfig.Localization) -> ModuleLocalizing = { config in
      LocalizationModuleFactory.make(config: config)
    }
  ) -> LocalizationProcessor {
    LocalizationProcessor(argumentParser: argumentParser,
                          logger: logger,
                          entityFileLoader: entityFileLoader,
                          localizationModuleFactory: localizationModuleFactory)
  }
}
