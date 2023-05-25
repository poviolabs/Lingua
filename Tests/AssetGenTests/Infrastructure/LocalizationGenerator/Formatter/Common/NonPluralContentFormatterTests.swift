import XCTest
@testable import AssetGen

final class NonPluralContentFormatterTests: XCTestCase {
  func test_generateOutputContent_returnsNonPluralContent() {
    let entries = [LocalizationEntry(section: "section", key: "key", translations: ["one" : "one"])]
    let sut = makeSUT()
    
    let content = sut.generateOutputContent(for: entries)
    
    let expectedContent = "key = one"
    XCTAssertEqual(expectedContent, content)
  }
  
  func test_generateOutputContent_returnsEmptyForPluralContent() {
    let entries = [LocalizationEntry(section: "section", key: "key", translations: ["few" : "few"])]
    let sut = makeSUT()
    
    let content = sut.generateOutputContent(for: entries)
    
    let expectedContent = ""
    XCTAssertEqual(expectedContent, content)
  }
}

private extension NonPluralContentFormatterTests {
  func makeSUT(formatter: NonPluralFormatting = MockNonPluralFormatter()) -> NonPluralContentFormatter {
    NonPluralContentFormatter(formatter: formatter)
  }
}
