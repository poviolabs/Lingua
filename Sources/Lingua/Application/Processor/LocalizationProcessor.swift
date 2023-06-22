import Foundation

final class LocalizationProcessor: CommandLineProcessable {
  private let argumentParser: CommandLineParsable
  private let logger: Logger
  private let entityFileLoader: EntityFileLoader<JSONDataParser<ConfigDto>, ConfigTransformer>
  private let localizationModuleFactory: (Config.Localization) -> ModuleLocalizing
  
  init(argumentParser: CommandLineParsable,
       logger: Logger,
       entityFileLoader: EntityFileLoader<JSONDataParser<ConfigDto>, ConfigTransformer>,
       localizationModuleFactory: @escaping (Config.Localization) -> ModuleLocalizing) {
    self.argumentParser = argumentParser
    self.logger = logger
    self.entityFileLoader = entityFileLoader
    self.localizationModuleFactory = localizationModuleFactory
  }
  
  func process(arguments: [String]) async throws {
    do {
      logger.log("Processing arguments...", level: .info)
      
      let arguments = try argumentParser.parse(arguments: arguments)
      
      logger.log("Loading configuration file...", level: .info)
      
      let config: Config = try await entityFileLoader.loadEntity(from: arguments.configFilePath)
      
      guard let localization = config.localization else {
        throw ProcessorError.missingLocalization
      }
      
      logger.log("Initializing localization module...", level: .info)
      
      let localizationModule = localizationModuleFactory(localization)
      
      logger.log("Starting localization...", level: .info)
      
      try await localizationModule.localize(for: arguments.platform)
      
      logger.log("Localization completed!", level: .success)
    } catch let error as ProcessorError {
      logger.log(error.localizedDescription, level: .error)
      logger.printUsage()
      throw error
    } catch {
      logger.log(error.localizedDescription, level: .error)
      logger.printUsage()
      throw error
    }
  }
}
