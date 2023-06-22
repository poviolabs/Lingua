import XCTest
@testable import Lingua

final class LocalizationProcessorTests: XCTestCase {
  func test_process_invokesDependenciesCorrectly() async throws {
    let (sut, actors) = makeSUT()
    let tempDirectoryURL = try createTemporaryDirectoryURL()
    let configPath = try createTemporaryConfigFile(data: createConfigData(in: tempDirectoryURL), tempDirectoryURL: tempDirectoryURL)
    let arguments = ["AssetGen", "ios", configPath.path]
    
    try await sut.process(arguments: arguments)
    
    XCTAssertEqual(actors.logger.messages, [.message(message: "Processing arguments...", level: .info),
                                            .message(message: "Loading configuration file...", level: .info),
                                            .message(message: "Initializing localization module...", level: .info),
                                            .message(message: "Starting localization...", level: .info),
                                            .message(message: "Localization completed!", level: .success)])
    XCTAssertEqual(actors.mockLocalizationModule.messages, [.localize(.ios)])
  }
  
  func test_process_throwsErrorWhenLocalizationConfigIsMissing() async throws {
    let (sut, actors) = makeSUT()
    let tempDirectoryURL = try createTemporaryDirectoryURL()
    let configPath = try createTemporaryConfigFile(data: createInvalidConfigData(), tempDirectoryURL: tempDirectoryURL)
    let arguments = ["AssetGen", "ios", configPath.path]
    
    do {
      try await sut.process(arguments: arguments)
    } catch {
      XCTAssertEqual(actors.logger.messages, [.message(message: "Processing arguments...", level: .info),
                                              .message(message: "Loading configuration file...", level: .info),
                                              .message(message: ProcessorError.missingLocalization.localizedDescription, level: .error),
                                              .message(message: printUsage, level: .info)])
      XCTAssertEqual(actors.mockLocalizationModule.messages, [])
    }
  }
  
  func test_process_throwsErrorWhenModuleLocalizationFails() async throws {
    let localizationModule = MockLocalizationModule(shouldThrow: true)
    let (sut, actors) = makeSUT(localizationModule: localizationModule)
    let tempDirectoryURL = try createTemporaryDirectoryURL()
    let configPath = try createTemporaryConfigFile(data: createConfigData(in: tempDirectoryURL), tempDirectoryURL: tempDirectoryURL)
    let arguments = ["AssetGen", "ios", configPath.path]
    
    do {
      try await sut.process(arguments: arguments)
    } catch {
      XCTAssertEqual(actors.logger.messages, [.message(message: "Processing arguments...", level: .info),
                                              .message(message: "Loading configuration file...", level: .info),
                                              .message(message: "Initializing localization module...", level: .info),
                                              .message(message: "Starting localization...", level: .info),
                                              .message(message: DirectoryOperationError.folderCreationFailed.localizedDescription, level: .error),
                                              .message(message: printUsage, level: .info)])
      XCTAssertEqual(actors.mockLocalizationModule.messages, [])
    }
  }
}

private extension LocalizationProcessorTests {
  struct Actors {
    let argumentParser: CommandLineParser
    let logger: MockLogger
    let mockLocalizationModule: MockLocalizationModule
  }
  
  func makeSUT(localizationModule: MockLocalizationModule = MockLocalizationModule()) -> (sut: LocalizationProcessor, actors: Actors) {
    let argumentParser = CommandLineParser()
    let logger = MockLogger()
    
    let actors = Actors(argumentParser: argumentParser,
                        logger: logger,
                        mockLocalizationModule: localizationModule)
    
    let sut = ProcessorFactory().makeLocalizationProcessor(argumentParser: argumentParser,
                                                           logger: logger,
                                                           localizationModuleFactory: { _ in localizationModule })
    
    return (sut, actors)
  }
  
  func createTemporaryConfigFile(data: Data, tempDirectoryURL: URL) throws -> URL {
    let configFileURL = tempDirectoryURL.appendingPathComponent("config.json")
    try data.write(to: configFileURL)
    
    return configFileURL
  }
  
  func createTemporaryDirectoryURL() throws -> URL {
    let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString)
    try FileManager.default.createDirectory(at: tempDirectoryURL, withIntermediateDirectories: true, attributes: nil)
    
    return tempDirectoryURL
  }
  
  func createConfigData(in directoryURL: URL) -> Data {
    """
    {
      "localization": {
        "apiKey": "key",
        "sheetId": "id",
        "outputDirectory": "\(directoryURL)"
      }
    }
    """.data(using: .utf8)!
  }
  
  func createInvalidConfigData() -> Data {
    """
    {
      "test": "test"
    }
    """.data(using: .utf8)!
  }
  
  var printUsage: String {
    """
    Usage:
    AssetGen <platform> <config_file_path/file.json>

    <platform> is required only for localization functionality and can be:
    1. ios
    2. android
    """
  }
}
