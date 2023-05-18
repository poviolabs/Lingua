import XCTest
@testable import AssetGen

final class TranslationBuilderTests: XCTestCase {
  func test_NonPluralTranslationBuilder_createsCorrectTranslation() {
    let sut = makeSUT(isPlural: false)
    let row = ["section", "key", "no", "unused", "translation"]
    let expectedTranslations = ["one": "translation"]
    
    let translations = sut.buildTranslations(from: row)
    
    XCTAssertEqual(translations, expectedTranslations)
  }
  
  func test_PluralTranslationBuilder_createsCorrectTranslations() {
    let sut = makeSUT(isPlural: true)
    let row = ["section", "key", "yes", "zero", "one", "two", "few", "many", "other"]
    let expectedTranslations: [String: String] = [
      "zero": "zero",
      "one": "one",
      "two": "two",
      "few": "few",
      "many": "many",
      "other": "other"
    ]
    
    let translations = sut.buildTranslations(from: row)
    
    XCTAssertEqual(translations, expectedTranslations)
  }
  
  func test_NonPluralTranslationBuilder_withInsufficientData_returnsEmptyTranslations() {
    let sut = makeSUT(isPlural: false)
    let row = ["section", "key", "no"]
    let expectedTranslations: [String: String] = [:]
    
    let translations = sut.buildTranslations(from: row)
    
    XCTAssertEqual(translations, expectedTranslations)
  }
  
  func test_PluralTranslationBuilder_withInsufficientData_returnsEmptyTranslations() {
    let sut = makeSUT(isPlural: true)
    let row = ["section", "key", "yes"]
    let expectedTranslations: [String: String] = [:]
    
    let translations = sut.buildTranslations(from: row)
    
    XCTAssertEqual(translations, expectedTranslations)
  }
  
  func test_PluralTranslationBuilder_withPartialData_returnsPartialTranslations() {
    let sut = makeSUT(isPlural: true)
    let row = ["section", "key", "yes", "zero", "one", "two"]
    let expectedTranslations: [String: String] = [
      "zero": "zero",
      "one": "one",
      "two": "two"
    ]
    
    let translations = sut.buildTranslations(from: row)
    
    XCTAssertEqual(translations, expectedTranslations)
  }
}

extension TranslationBuilderTests {
  private func makeSUT(isPlural: Bool) -> TranslationBuilder {
    TranslationBuilderFactory.makeTranslationBuilder(isPlural: isPlural)
  }
}
