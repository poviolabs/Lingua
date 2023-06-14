import XCTest
@testable import AssetGen

final class PlaceholderExtractorTests: XCTestCase {
  func testPlaceholderExtraction() {
    let extractor = PlaceholderExtractor()
    let translation = "Hello %@, you have %d unread messages and %f new notifications and %a."
    let placeholders = extractor.extractPlaceholders(from: translation)
    
    XCTAssertEqual(placeholders.count, 4)
    
    XCTAssertEqual(placeholders[0].index, 0)
    XCTAssertEqual(placeholders[0].type, "String")
    
    XCTAssertEqual(placeholders[1].index, 1)
    XCTAssertEqual(placeholders[1].type, "Int")
    
    XCTAssertEqual(placeholders[2].index, 2)
    XCTAssertEqual(placeholders[2].type, "Double")
    
    XCTAssertEqual(placeholders[3].index, 3)
    XCTAssertEqual(placeholders[3].type, "Any")
  }
}
