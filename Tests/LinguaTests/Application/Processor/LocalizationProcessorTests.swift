import XCTest
import LinguaLib
@testable import Lingua

final class LocalizationProcessorTests: XCTestCase {
  func test_process_invokesDependenciesCorrectly() async throws {
    let (sut, actors) = makeSUT()
    let tempDirectoryURL = try createTemporaryDirectoryURL()
    let configPath = try createTemporaryConfigFile(data: createConfigData(in: tempDirectoryURL), tempDirectoryURL: tempDirectoryURL)
    let arguments = ["Lingua", "ios", configPath.path]
    
    try await sut.process(arguments: arguments)
    
    XCTAssertEqual(actors.logger.messages, [.message(message: "Loading configuration file...", level: .info),
                                            .message(message: "Initializing localization module...", level: .info),
                                            .message(message: "Starting localization...", level: .info),
                                            .message(message: "Localization completed!", level: .success)])
    XCTAssertEqual(actors.mockLocalizationModule.messages, [.localize(.ios)])
  }
  
  func test_process_throwsErrorWhenLocalizationConfigIsMissing() async throws {
    let (sut, actors) = makeSUT()
    let tempDirectoryURL = try createTemporaryDirectoryURL()
    let configPath = try createTemporaryConfigFile(data: createInvalidConfigData(), tempDirectoryURL: tempDirectoryURL)
    let arguments = ["Lingua", "ios", configPath.path]
    
    do {
      try await sut.process(arguments: arguments)
    } catch {
      XCTAssertEqual(actors.logger.messages, [.message(message: "Loading configuration file...", level: .info),
                                              .message(message: ProcessorError.missingLocalization.localizedDescription, level: .error),
                                              .message(message: printUsage, level: .info)])
      XCTAssertEqual(actors.mockLocalizationModule.messages, [])
    }
  }
  
  func test_process_throwsErrorWhenModuleLocalizationFails() async throws {
    let localizationModule = MockLocalizationModule(errorMessage: "Error_message")
    let (sut, actors) = makeSUT(localizationModule: localizationModule)
    let tempDirectoryURL = try createTemporaryDirectoryURL()
    let configPath = try createTemporaryConfigFile(data: createConfigData(in: tempDirectoryURL), tempDirectoryURL: tempDirectoryURL)
    let arguments = ["Lingua", "ios", configPath.path]
    
    do {
      try await sut.process(arguments: arguments)
    } catch {
      XCTAssertEqual(actors.logger.messages, [.message(message: "Loading configuration file...", level: .info),
                                              .message(message: "Initializing localization module...", level: .info),
                                              .message(message: "Starting localization...", level: .info),
                                              .message(message: DirectoryOperationError.folderCreationFailed("Error_message").localizedDescription, level: .error)])
      XCTAssertEqual(actors.mockLocalizationModule.messages, [])
    }
  }
  
  func test_process_invokesConfigInitialFileGenerator() async throws {
    let (sut, actors) = makeSUT()

    let arguments = ["Lingua", "config", "init"]
    
    try await sut.process(arguments: arguments)
    
    XCTAssertEqual(actors.logger.messages, [.message(message: "Lingua config file is created.", level: .success)])
    XCTAssertTrue(actors.mockLocalizationModule.messages.isEmpty)
  }
  
  func test_process_throwsError_whenConfigInitialFileGeneratorFails() async throws {
    let (sut, actors) = makeSUT(configFileGenerator: MockConfigInitialFileGenerator(shouldThrow: true))
  
    let arguments = ["Lingua", "config", "init"]
    
    do {
      try await sut.process(arguments: arguments)
      XCTFail("It should fail")
    } catch {
      XCTAssertEqual(actors.logger.messages, [.message(message: "The config json file couldn't be created", level: .error)])
      XCTAssertTrue(actors.mockLocalizationModule.messages.isEmpty)
    }
  }
}

private extension LocalizationProcessorTests {
  struct Actors {
    let argumentParser: CommandLineParser
    let logger: MockLogger
    let mockLocalizationModule: MockLocalizationModule
  }
  
  func makeSUT(localizationModule: MockLocalizationModule = MockLocalizationModule(errorMessage: .none),
               configFileGenerator: ConfigInitialFileGenerating = ConfigInitialFileGenerator.make()) -> (sut: LocalizationProcessor, actors: Actors) {
    let argumentParser = CommandLineParser()
    let logger = MockLogger()
    
    let actors = Actors(argumentParser: argumentParser,
                        logger: logger,
                        mockLocalizationModule: localizationModule)
    
    let sut = ProcessorFactory().makeLocalizationProcessor(argumentParser: argumentParser,
                                                           logger: logger,
                                                           localizationModuleFactory: { _ in localizationModule },
                                                           configFileGenerator: configFileGenerator)
    
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
    Lingua <platform> <config_file_path/file.json>

    <platform> is required only for localization functionality and can be:
    1. ios
    2. android
    """
  }
}
