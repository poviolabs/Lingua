import XCTest
@testable import LinguaLib

final class ConfigInitialFileGeneratorTests: XCTestCase {
  func test_generate_encodesConfigAndWritesFile() throws {
    let (sut, actors) = makeSUT()
    
    try sut.generate()
    
    let jsonEncoder = CustomJSONEncoder()
    let configDto = try actors.transformer.transform(actors.config)
    let encodedConfig = try XCTUnwrap(try? jsonEncoder.encode(configDto))
    let configString = try XCTUnwrap(String(data: encodedConfig, encoding: .utf8))
    
    XCTAssertEqual(actors.contentFilesCreator.writtenContent, [sut.fileName: configString])
  }
  
  func test_generate_throwsErrorOnFailure() {
    let (sut, _) = makeSUT(shouldFail: "error")
    
    XCTAssertThrowsError(try sut.generate())
  }
  
  func test_generate_handlesEmptyString() throws {
    let (sut, actors) = makeSUT(encoder: EmptyStringJSONEncoder())
    
    try sut.generate()
    
    XCTAssertEqual(actors.contentFilesCreator.writtenContent, [sut.fileName: ""])
  }
}

private extension ConfigInitialFileGeneratorTests {
  struct Actors {
    let contentFilesCreator: MockContentFilesCreator
    let config: Config
    let transformer: ConfigTransformer
    let fileName: String
  }
  
  func makeSUT(shouldFail: String? = .none, encoder: JSONEncoding? = nil) -> (sut: ConfigInitialFileGenerator, actors: Actors) {
    let contentFilesCreator = MockContentFilesCreator()
    contentFilesCreator.errorMessage = shouldFail
    let config = Config.createTemplateConfig()
    let transformer = ConfigTransformer()
    let fileName = "config.json"
    let sut = ConfigInitialFileGenerator(contentFilesCreator: contentFilesCreator,
                                         encoder: encoder ?? CustomJSONEncoder(),
                                         transformer: transformer,
                                         config: config,
                                         fileName: fileName)
    let actors = Actors(contentFilesCreator: contentFilesCreator,
                        config: config,
                        transformer: transformer,
                        fileName: fileName)
    return (sut, actors: actors)
  }
  
  struct EmptyStringJSONEncoder: JSONEncoding {
    func encode<T: Encodable>(_ value: T) throws -> Data {
      "".data(using: .utf8) ?? Data()
    }
  }
}
