import XCTest
@testable import Lingua

final class PlaceholderExtractorTests: XCTestCase {
  func test_extractPlaceholders_withRegexPlaceholderExtractor() {
    let extractor = PlaceholderExtractor(strategy: RegexPlaceholderExtractor())
    verifyPlaceholders(extractor: extractor)
  }
  
  func test_extractPlaceholders_withNSRegularExpressionStrategy() {
    let extractor = PlaceholderExtractor(strategy: NSRegularExpressionPlaceholderExtractor())
    verifyPlaceholders(extractor: extractor)
  }
  
  func test_extractPlaceholders_withDefaultStrategy() {
    let extractor = PlaceholderExtractor.make()
    verifyPlaceholders(extractor: extractor)
  }
}
 
private extension PlaceholderExtractorTests {
  func verifyPlaceholders(extractor: PlaceholderExtractor) {
    let translation = "Hello %@, you have %d unread messages and %f new notifications and %a."
    let placeholders = extractor.extractPlaceholders(from: translation)
    
    XCTAssertEqual(placeholders.count, 4)
    
    XCTAssertEqual(placeholders[0].index, 0)
    XCTAssertEqual(placeholders[0].type.asDataType, "String")
    
    XCTAssertEqual(placeholders[1].index, 1)
    XCTAssertEqual(placeholders[1].type.asDataType, "Int")
    
    XCTAssertEqual(placeholders[2].index, 2)
    XCTAssertEqual(placeholders[2].type.asDataType, "Double")
    
    XCTAssertEqual(placeholders[3].index, 3)
    XCTAssertEqual(placeholders[3].type.asDataType, "Any")
  }
}
