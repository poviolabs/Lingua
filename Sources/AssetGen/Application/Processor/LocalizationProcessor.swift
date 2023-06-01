import Foundation

final class LocalizationProcessor: CommandLineProcessable {
  private let argumentParser: CommandLineParsable
  private let logger: Logger
  private let entityFileLoader: EntityFileLoader<JSONDataParser<AssetGenConfigDto>, AssetGenConfigTransformer>
  private let localizationModuleFactory: (AssetGenConfig.Localization) -> ModuleLocalizing
  
  init(argumentParser: CommandLineParsable,
       logger: Logger,
       entityFileLoader: EntityFileLoader<JSONDataParser<AssetGenConfigDto>, AssetGenConfigTransformer>,
       localizationModuleFactory: @escaping (AssetGenConfig.Localization) -> ModuleLocalizing) {
    self.argumentParser = argumentParser
    self.logger = logger
    self.entityFileLoader = entityFileLoader
    self.localizationModuleFactory = localizationModuleFactory
  }
  
  func process(arguments: [String]) async throws {
    do {
      let arguments = try argumentParser.parse(arguments: arguments)
      let config: AssetGenConfig = try await entityFileLoader.loadEntity(from: arguments.configFilePath)
      if let localization = config.localization {
        let localizationModule = localizationModuleFactory(localization)
        try await localizationModule.localize(for: arguments.platform)
      } else {
        throw ProcessorError.missingLocalization
      }
      
      logger.log("Localization completed!", level: .success)
    } catch {
      let errorDescription = (error as CustomStringConvertible).description
      logger.log(errorDescription, level: .error)
      logger.printUsage()
      throw error
    }
  }
}
