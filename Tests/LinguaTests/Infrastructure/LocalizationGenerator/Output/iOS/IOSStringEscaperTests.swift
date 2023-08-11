import XCTest
@testable import Lingua

final class IOSStringEscaperTests: XCTestCase {
  func test_escapeSpecialCharacters_backslash() {
    expect(original: "This is a test\\", expected: "This is a test\\")
  }
  
  func test_escapeSpecialCharacters_quotes() {
    expect(original: "This is a \"test\"", expected: "This is a \\\"test\\\"")
  }
  
  func test_escapeSpecialCharacters_multipleCharacters() {
    expect(original: "This is a \"test\" @ multiple \n characters",
           expected: "This is a \\\"test\\\" @ multiple \n characters")
  }
}

private extension IOSStringEscaperTests {
  func makeSUT() -> IOSStringEscaper {
    .init()
  }
  
  func expect(original: String, expected: String, file: StaticString = #file, line: UInt = #line) {
    let escaper = makeSUT()
    let actual = escaper.escapeSpecialCharacters(in: original)
    XCTAssertEqual(actual, expected, file: file, line: line)
  }
}
