import XCTest
@testable import LinguaLib

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
  
  func test_formatKey_returnsCorrectFormat() {
    let input = "test_key"
    let expectedOutput = "testKey"
    
    let output = input.formatKey()
    
    XCTAssertEqual(output, expectedOutput)
  }
  
  func test_camelCased_returnsCorrectCamelCasedFormat() {
    let input = "test_key"
    let expectedOutput = "testKey"
    
    let output = input.camelCased()
    
    XCTAssertEqual(output, expectedOutput)
  }
  
  func test_swiftIdentifier_convertsReservedWords() {
    let input = "class"
    let expectedOutput = "`class`"
    
    let output = input.swiftIdentifier()
    
    XCTAssertEqual(output, expectedOutput)
  }
  
  func test_swiftIdentifier_returnsSameStringIfNotReserved() {
    let input = "test_key"
    let expectedOutput = "test_key"
    
    let output = input.swiftIdentifier()
    
    XCTAssertEqual(output, expectedOutput)
  }
  
  func test_commentOut_addsDoubleSlashesBeforeEachLineOnIOS() {
    let fileHeader = """
         This file was generated with Lingua command line tool. Please do not change it!
         Source: https://github.com/poviolabs/Lingua
         """
    let expectedCommentedHeader = """
         // This file was generated with Lingua command line tool. Please do not change it!
         // Source: https://github.com/poviolabs/Lingua
         """
    let result = fileHeader.commentOut(for: .ios)
    XCTAssertEqual(result, expectedCommentedHeader)
  }
  
  func test_commentOut_addsCommentCommandForEachLineOnAndroid() {
    let fileHeader = """
         This file was generated with Lingua command line tool. Please do not change it!
         Source: https://github.com/poviolabs/Lingua
         """
    let expectedCommentedHeader = """
         <!-- This file was generated with Lingua command line tool. Please do not change it! -->
         <!-- Source: https://github.com/poviolabs/Lingua -->
         """
    let result = fileHeader.commentOut(for: .android)
    XCTAssertEqual(result, expectedCommentedHeader)
  }
}
