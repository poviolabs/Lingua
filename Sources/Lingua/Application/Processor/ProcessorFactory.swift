import Foundation

struct ProcessorFactory {
  func makeLocalizationProcessor(
    argumentParser: CommandLineParsable = CommandLineParser(),
    logger: Logger = ConsoleLogger.shared,
    entityFileLoader: EntityFileLoader<JSONDataParser<ConfigDto>, ConfigDtoTransformer> = EntityLoaderFactory.makeConfigLoader(),
    localizationModuleFactory: @escaping (Config.Localization) -> ModuleLocalizing = { config in
      LocalizationModuleFactory.make(config: config)
    },
    configFileGenerator: ConfigInitialFileGenerating = ConfigInitialFileGenerator.make()
  ) -> LocalizationProcessor {
    LocalizationProcessor(argumentParser: argumentParser,
                          logger: logger,
                          entityFileLoader: entityFileLoader,
                          localizationModuleFactory: localizationModuleFactory,
                          configFileGenerator: configFileGenerator)
  }
}
