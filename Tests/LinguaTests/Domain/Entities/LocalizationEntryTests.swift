import XCTest
@testable import LinguaLib

final class LocalizationEntryTests: XCTestCase {
  func test_plural_returnsTrue_forMultipleTranslations() {
    let localizationEntry = LocalizationEntry(section: "test",
                                              key: "test",
                                              translations: ["test1": "value1", "test2": "value2"])
    XCTAssertTrue(localizationEntry.plural)
  }
  
  func test_plural_returnsTrue_forSingleTranslation() {
    let localizationEntry = LocalizationEntry(section: "test",
                                              key: "test",
                                              translations: ["test1": "value1"])
    XCTAssertFalse(localizationEntry.plural)
  }
}
