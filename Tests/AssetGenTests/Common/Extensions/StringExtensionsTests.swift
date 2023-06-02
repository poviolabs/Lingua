import XCTest
@testable import AssetGen

final class StringExtensionsTests: XCTestCase {
  func test_formatSheetSection_handlesEmptyString() {
    let input = ""
    let expectedOutput = ""
    XCTAssertEqual(input.formatSheetSection(), expectedOutput)
  }
  
  func test_formatSheetSection_handlesSingleWord() {
    let input = "word"
    let expectedOutput = "word"
    XCTAssertEqual(input.formatSheetSection(), expectedOutput)
  }
  
  func test_formatSheetSection_handlesMultipleWordsWithSpace() {
    let input = "hello world"
    let expectedOutput = "helloWorld"
    XCTAssertEqual(input.formatSheetSection(), expectedOutput)
  }
  
  func test_formatSheetSection_handlesMultipleWordsWithUnderscore() {
    let input = "hello_world"
    let expectedOutput = "helloWorld"
    XCTAssertEqual(input.formatSheetSection(), expectedOutput)
  }
  
  func test_formatSheetSection_handlesMultipleWordsWithSpaceAndUnderscore() {
    let input = "hello world_foo_bar"
    let expectedOutput = "helloWorldFooBar"
    XCTAssertEqual(input.formatSheetSection(), expectedOutput)
  }
}
