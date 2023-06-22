import Foundation

struct ProcessorFactory {
  func makeLocalizationProcessor(
    argumentParser: CommandLineParsable = CommandLineParser(),
    logger: Logger = ConsoleLogger.shared,
    entityFileLoader: EntityFileLoader<JSONDataParser<ConfigDto>, ConfigTransformer> = EntityLoaderFactory.makeConfigLoader(),
    localizationModuleFactory: @escaping (Config.Localization) -> ModuleLocalizing = { config in
      LocalizationModuleFactory.make(config: config)
    }
  ) -> LocalizationProcessor {
    LocalizationProcessor(argumentParser: argumentParser,
                          logger: logger,
                          entityFileLoader: entityFileLoader,
                          localizationModuleFactory: localizationModuleFactory)
  }
}
