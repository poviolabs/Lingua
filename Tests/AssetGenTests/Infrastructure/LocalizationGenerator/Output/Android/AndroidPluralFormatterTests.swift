import XCTest
@testable import AssetGen

final class AndroidPluralFormatterTests: XCTestCase {
  func test_formatContent_formatsSingleEntryCorrectly() {
    let entry = LocalizationEntry(section: "section",
                                  key: "messages",
                                  translations: ["one": "%d new message", "other": "%d new messages"])
    let expectedOutput = "\t<plurals name=\"messages\">\n\t\t<item quantity=\"one\">%d new message</item>\n\t\t<item quantity=\"other\">%d new messages</item>\n\t</plurals>"
    
    let sut = makeSUT()
    
    XCTAssertEqual(sut.formatContent(for: entry), expectedOutput)
  }
  
  func test_formatContent_skipsEmptyValues() {
    let entry = LocalizationEntry(section: "section",
                                  key: "messages",
                                  translations: ["one": "", "other": "%d new messages"])
    let expectedOutput = "\t<plurals name=\"messages\">\n\t\t<item quantity=\"other\">%d new messages</item>\n\t</plurals>"
    let sut = makeSUT()
    
    XCTAssertEqual(sut.formatContent(for: entry), expectedOutput)
  }
  
  func test_wrapContent_wrapsContentCorrectly() {
    let content = "\t<plurals name=\"messages\">\n\t\t<item quantity=\"one\">%d new message</item>\n\t\t<item quantity=\"other\">%d new messages</item>\n\t</plurals>"
    let expectedOutput = """
         <?xml version="1.0" encoding="utf-8"?>
         <resources>
         \(content)
         </resources>
         """
    let sut = makeSUT()
    
    XCTAssertEqual(sut.wrapContent(content), expectedOutput)
  }
}

private extension AndroidPluralFormatterTests {
  func makeSUT() -> AndroidPluralFormatter {
    AndroidPluralFormatter()
  }
}
