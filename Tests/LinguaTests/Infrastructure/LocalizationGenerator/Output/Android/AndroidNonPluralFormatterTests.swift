import XCTest
@testable import LinguaLib

final class AndroidNonPluralFormatterTests: XCTestCase {
  func test_formatContent_formatsEntryCorrectly() {
    let entry = LocalizationEntry(section: "section", key: "message", translations: ["one": "You have a new message"])
    let expectedOutput = "\t<string name=\"section_message\">You have a new message</string>"
    let sut = makeSUT()
    
    XCTAssertEqual(sut.formatContent(for: entry), expectedOutput)
  }
  
  func test_formatContent_returnsEmptyStringForMissingTranslation() {
    let entry = LocalizationEntry(section: "section", key: "message", translations: [:])
    let expectedOutput = ""
    let sut = makeSUT()
    
    XCTAssertEqual(sut.formatContent(for: entry), expectedOutput)
  }
  
  func test_formatContent_returnsEmptyStringForEmptyTranslation() {
    let entry = LocalizationEntry(section: "section", key: "message", translations: ["one": ""])
    let expectedOutput = ""
    let sut = makeSUT()
    
    XCTAssertEqual(sut.formatContent(for: entry), expectedOutput)
  }
  
  func test_wrapContent_wrapsContentCorrectly() {
    let content = "\t<string name=\"message\">You have a new message</string>"
    let expectedOutput = """
         <?xml version="1.0" encoding="utf-8"?>
         <!-- This file was generated with Lingua command line tool. Please do not change it! -->
         <!-- Source: https://github.com/poviolabs/Lingua -->
         <resources>
         \(content)
         </resources>
         """
    let sut = makeSUT()
    
    XCTAssertEqual(sut.wrapContent(content), expectedOutput)
  }
}

private extension AndroidNonPluralFormatterTests {
  func makeSUT() -> AndroidNonPluralFormatter {
    AndroidNonPluralFormatter()
  }
}
