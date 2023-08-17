import XCTest
@testable import LinguaLib

final class AndroidPlaceholderMapperTests: XCTestCase {
  func test_mapPlaceholders_replacesNewlineWithEscapedNewline() {
    expect(input: "Hello\nWorld", toMapTo: "Hello\\nWorld")
  }

  func test_mapPlaceholders_handlesMultiplePlaceholders() {
    expect(input: "Hello %@, You have %d new messages and your score is %f",
           toMapTo: "Hello %1$s, You have %2$d new messages and your score is %3$f")
  }
}

private extension AndroidPlaceholderMapperTests {
  func expect(input: String, toMapTo expectedOutput: String, file: StaticString = #file, line: UInt = #line) {
    let sut = AndroidPlaceholderMapper()
    let output = sut.mapPlaceholders(input)
    XCTAssertEqual(output, expectedOutput, file: file, line: line)
  }
}
