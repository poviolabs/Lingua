import XCTest
@testable import Lingua

final class StringsDictFileProcessorTests: XCTestCase {
  func test_canHandle_returnsTrueForStringsDictFile() {
    let sut = makeSUT()
    XCTAssertTrue(sut.canHandle(file: "example.stringsdict"))
  }
  
  func test_canHandle_returnsFalseForNonStringsDictFile() {
    let sut = makeSUT()
    XCTAssertFalse(sut.canHandle(file: "example.strings"))
  }
  
  func test_sectionName_returnsCorrectSectionNameForStringsDictFile() {
    let sut = makeSUT()
    XCTAssertEqual(sut.sectionName(for: "example.stringsdict"), "example")
  }
  
  func test_sectionName_returnsNilForNonStringsDictFile() {
    let sut = makeSUT()
    XCTAssertNil(sut.sectionName(for: "example.strings"))
  }
  
  func test_processFile_returnsCorrectTranslationsAndSectionsForStringsDictFile() throws {
    let sut = makeSUT()
    let content = """
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>key1</key>
        <dict>
          <key>NSStringLocalizedFormatKey</key>
          <string>%#@key1@</string>
          <key>key1</key>
          <dict>
            <key>NSStringFormatSpecTypeKey</key>
            <string>NSStringPluralRuleType</string>
            <key>NSStringFormatValueTypeKey</key>
            <string>d</string>
            <key>other</key>
            <string>value1</string>
          </dict>
        </dict>
      </dict>
      </plist>
      """
    let fileURL = try createTemporaryFile(withContent: content)
    let result = sut.processFile(section: "example", path: fileURL.path)
    
    XCTAssertEqual(result.translations, ["key1": "value1%d"])
    XCTAssertEqual(result.sections, Set(["key1"]))
  }
  
  func test_processFile_returnsEmptyResultsForInvalidStringsDictFile() throws {
    let sut = makeSUT()
    let content = "invalid content"
    let fileURL = try createTemporaryFile(withContent: content)
    let result = sut.processFile(section: "example", path: fileURL.path)
    
    XCTAssertTrue(result.translations.isEmpty)
    XCTAssertTrue(result.sections.isEmpty)
  }
}

private extension StringsDictFileProcessorTests {
  func makeSUT() -> StringsDictFileProcessor {
    StringsDictFileProcessor()
  }
}
