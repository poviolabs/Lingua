import XCTest
@testable import AssetGen

final class IOSNonPluralFormatterTests: XCTestCase {
  func test_formatContent() {
    let translations = [PluralCategory.one.rawValue: "test_one"]
    let entry = LocalizationEntry(section: "", key: "test_key", translations: translations)
    let sut = IOSNonPluralFormatter()
    
    let formattedString = sut.formatContent(for: entry)
    
    XCTAssertEqual(formattedString, "\"test_key\" = \"test_one\";")
  }
  
  func test_formatContent_returnEmptyStringForEmptyTranslation() {
    let translations: [String: String] = [:]
    let entry = LocalizationEntry(section: "", key: "test_one", translations: translations)
    let sut = makeSUT()
    
    let formattedString = sut.formatContent(for: entry)
    
    XCTAssertEqual(formattedString, "")
  }
  
  func test_wrapContent() {
    let content = "content"
    let sut = makeSUT()
    let wrappedContent = sut.wrapContent(content)
    
    XCTAssertEqual(content, wrappedContent)
  }
}

private extension IOSNonPluralFormatterTests {
  func makeSUT() -> IOSNonPluralFormatter {
    IOSNonPluralFormatter()
  }
}
