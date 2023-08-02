import XCTest
@testable import Lingua

final class AndroidStringEscaperTests: XCTestCase {
  func test_escapeSpecialCharacters_andCharacter() {
    expect(original: "This is a test & character", expected: "This is a test &amp; character")
  }
  
  func test_escapeSpecialCharacters_lessThanCharacter() {
    expect(original: "This is a test < character", expected: "This is a test &lt; character")
  }
  
  func test_escapeSpecialCharacters_greaterThanCharacter() {
    expect(original: "This is a test > character", expected: "This is a test &gt; character")
  }
  
  func test_escapeSpecialCharacters_doubleQuotes() {
    expect(original: "This is a \"test\"", expected: "This is a \\&quot;test\\&quot;")
  }
  
  func test_escapeSpecialCharacters_singleQuotes() {
    expect(original: "This is a 'test'", expected: "This is a \\&apos;test\\&apos;")
  }
}

private extension AndroidStringEscaperTests {
  func makeSUT() -> AndroidStringEscaper {
    .init()
  }
  
  func expect(original: String, expected: String, file: StaticString = #file, line: UInt = #line) {
    let escaper = makeSUT()
    let actual = escaper.escapeSpecialCharacters(in: original)
    XCTAssertEqual(actual, expected, file: file, line: line)
  }
}
