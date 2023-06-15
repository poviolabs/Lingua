import XCTest
@testable import AssetGen

final class StringsFileProcessorTests: XCTestCase {
  func test_canHandle_returnsTrueForStringsFile() {
    let sut = makeSUT()
    XCTAssertTrue(sut.canHandle(file: "example.strings"))
  }
  
  func test_canHandle_returnsFalseForNonStringsFile() {
    let sut = makeSUT()
    XCTAssertFalse(sut.canHandle(file: "example.stringsdict"))
  }
  
  func test_sectionName_returnsCorrectSectionNameForStringsFile() {
    let sut = makeSUT()
    XCTAssertEqual(sut.sectionName(for: "example.strings"), "example")
  }
  
  func test_sectionName_returnsNilForNonStringsFile() {
    let sut = makeSUT()
    XCTAssertNil(sut.sectionName(for: "example.stringsdict"))
  }
  
  func test_processFile_returnsCorrectTranslationsAndSectionsForStringsFile() throws {
    let sut = makeSUT()
    let content = """
    "key1" = "value1";
    "key2" = "value2";
    """
    let fileURL = try createTemporaryFile(withContent: content)
    let result = sut.processFile(section: "example", path: fileURL.path)

    XCTAssertEqual(result.translations, ["key1": "value1", "key2": "value2"])
    XCTAssertEqual(result.sections, Set(["key1", "key2"]))
  }

  func test_processFile_returnsEmptyResultsForInvalidStringsFile() throws {
    let sut = makeSUT()
    let content = "invalid content"
    let fileURL = try createTemporaryFile(withContent: content)
    let result = sut.processFile(section: "example", path: fileURL.path)

    XCTAssertTrue(result.translations.isEmpty)
    XCTAssertTrue(result.sections.isEmpty)
  }
}

private extension StringsFileProcessorTests {
  func makeSUT() -> StringsFileProcessor {
    StringsFileProcessor()
  }
  
  func createTemporaryFile(withContent content: String) throws -> URL {
    let temporaryDirectory = FileManager.default.temporaryDirectory
    let fileName = UUID().uuidString
    let fileURL = temporaryDirectory.appendingPathComponent(fileName)
    
    try content.write(to: fileURL, atomically: true, encoding: .utf8)
    
    return fileURL
  }
}
