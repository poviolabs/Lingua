import XCTest
@testable import LinguaLib

final class LocalizedContentGeneratorTests: XCTestCase {
  func test_createContent_returnsPluralAndNonPluralDictContent() {
    let nonPluralEntry = createEntriesWithTranslations(plural: false)
    let pluralEntry = createEntriesWithTranslations(plural: true)
    let entries = nonPluralEntry + pluralEntry
    
    let sut = makeSUT()
    let result = sut.createContent(for: entries)
    
    XCTAssertEqual(result.nonPlural, "nonPluralContent")
    XCTAssertEqual(result.plural, "pluralContent")
  }
  
  func test_createContent_withEmptyEntries_returnsEmptyStrings() {
    let entries: [LocalizationEntry] = []
    
    let sut = makeSUT()
    let result = sut.createContent(for: entries)
    
    XCTAssertEqual(result.nonPlural, "")
    XCTAssertEqual(result.plural, "")
  }
  
  func test_createContent_withOnlyNonPluralEntries_returnsStringsContentOnly() {
    let nonPluralEntry1 = createEntriesWithTranslations(plural: false)
    let nonPluralEntry2 = createEntriesWithTranslations(plural: false)
    let entries = nonPluralEntry1 + nonPluralEntry2
    
    let sut = makeSUT()
    let result = sut.createContent(for: entries)
    
    XCTAssertEqual(result.nonPlural, "nonPluralContent")
    XCTAssertEqual(result.plural, "")
  }
  
  func test_createContent_withOnlyPluralEntries_returnsStringsDictContentOnly() {
    let pluralEntry1 = createEntriesWithTranslations(plural: true)
    let pluralEntry2 = createEntriesWithTranslations(plural: true)
    let entries = pluralEntry1 + pluralEntry2
    
    let sut = makeSUT()
    let result = sut.createContent(for: entries)
    
    XCTAssertEqual(result.nonPlural, "")
    XCTAssertEqual(result.plural, "pluralContent")
  }
}
  
private extension LocalizedContentGeneratorTests {
  func makeSUT() -> LocalizedContentGenerator {
    let stringsOutputGenerator = MockLocalizedOutputGenerator(outputClosure: { entries in
      return entries.filter { !$0.plural }.isEmpty ? "" : "nonPluralContent"
    })
    
    let stringsDictOutputGenerator = MockLocalizedOutputGenerator(outputClosure: { entries in
      return entries.filter { $0.plural }.isEmpty ? "" : "pluralContent"
    })
    
    return LocalizedContentGenerator(nonPluralOutputGenerator: stringsOutputGenerator,
                                               pluralOutputGenerator: stringsDictOutputGenerator)
  }
  
  func createEntriesWithTranslations(plural: Bool = false) -> [LocalizationEntry] {
    let entry1 = LocalizationEntry.create(plural: plural)
    let entry2 = LocalizationEntry.create(plural: plural)
    return [entry1, entry2]
  }
}
