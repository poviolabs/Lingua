import XCTest
@testable import AssetGen

final class IOSNonPluralFormatterTests: XCTestCase {
  func test_format_returnsIOSNonPluralContent() {
    let key = "test_key"
    let value = "test_value"
    let sut = IOSNonPluralFormatter()
    
    let content = sut.format(key: key, value: value)
    
    let expectedContent = "\"test_key\" = \"test_value\";"
    XCTAssertEqual(expectedContent, content)
  }
}
