import XCTest
@testable import Lingua

final class PlaceholderExtractorTests: XCTestCase {
  func testStringPlaceholderExtraction() {
    expect(testString: "Hello %@, how are you? You've %s and %S", expectedTypes: ["String", "String", "String"])
  }
  
  func testIntPlaceholderExtraction() {
    expect(testString: "Your age is %d and you've %x and %i", expectedTypes: ["Int", "Int", "Int"])
  }
  
  func testDoublePlaceholderExtraction() {
    expect(testString: "The area is %f and you've %e and %G", expectedTypes: ["Double", "Double", "Double"])
  }
  
  func testUnknownPlaceholderExtraction() {
    expect(testString: "Here is a mysterious %Z placeholder", expectedTypes: ["Any"])
  }
  
  func testMultiplePlaceholdersExtraction() {
    expect(sut: PlaceholderExtractor(strategy: NSRegularExpressionPlaceholderExtractor()),
           testString: "Hello %@, you are %d years old and your average grade is %f.",
           expectedTypes: ["String", "Int", "Double"])
  }
  
  func testMultipleCharacterIntPlaceholderExtraction() {
    expect(testString: "There are %dd and %dh, %@!", expectedTypes: ["Int", "Int", "String"])
  }
}

private extension PlaceholderExtractorTests {
  func expect(sut: PlaceholderExtractor = .make() ,testString: String, expectedTypes: [String]) {
    let placeholders = sut.extractPlaceholders(from: testString)
    
    for (index, expectedType) in expectedTypes.enumerated() {
      XCTAssertEqual(placeholders[index].type.asDataType, expectedType)
    }
  }
}
