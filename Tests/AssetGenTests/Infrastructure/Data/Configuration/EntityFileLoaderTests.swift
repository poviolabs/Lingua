import XCTest
@testable import AssetGen

final class EntityFileLoaderTests: XCTestCase {
  private let testValue = "test_value"
  
  func test_loadEntity_readsDataFromFileAndTransformsToEntity() async throws {
    let sut = makeSUT()
    let fileURL = try createTemporaryJSONFile()
    
    let entity = try await sut.loadEntity(from: fileURL.path)
    
    XCTAssertEqual(entity.key, testValue)
    
    removeTemporaryFile(at: fileURL)
  }
}

private extension EntityFileLoaderTests {
  struct TestDoubleDto: Codable {
    let key: String
  }
  
  struct TestDoubleEntity {
    let key: String
  }
  
  struct TestDoubleTranformer: Transformable {
    typealias Input = TestDoubleDto
    typealias Output = TestDoubleEntity
    
    func transform(_ object: TestDoubleDto) throws -> TestDoubleEntity {
      TestDoubleEntity(key: object.key)
    }
  }

  var testJsonData: Data {
    """
    {
        "key": "\(testValue)"
    }
    """.data(using: .utf8)!
  }
  
  func createTemporaryJSONFile() throws -> URL {
    let tempDir = FileManager.default.temporaryDirectory
    let fileURL = tempDir.appendingPathComponent("test.json")
    
    try testJsonData.write(to: fileURL)
    
    return fileURL
  }
  
  func removeTemporaryFile(at url: URL) {
    try? FileManager.default.removeItem(at: url)
  }
  
  func makeSUT() -> EntityFileLoader<JSONDataParser<TestDoubleDto>, TestDoubleTranformer> {
    let fileReader = FileReader()
    let parser = JSONDataParser<TestDoubleDto>()
    let transformer = TestDoubleTranformer()
    
    let sut = EntityFileLoader(fileReader: fileReader, parser: parser, transformer: transformer)
    
    return sut
  }
}
