import XCTest
@testable import LinguaLib

final class LocalizationEntry_AndroidTests: XCTestCase {
  func test_androidKey_buildsSnakeCaseAndroidConvention() {
    let section = "section"
    let key = "key"
    let entry = LocalizationEntry.create(section: section,
                                         key: key,
                                         plural: true)
    let expectedKey = section + "_" + key
    
    XCTAssertEqual(entry.androidKey, expectedKey)
  }
}
