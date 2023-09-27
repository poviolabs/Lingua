import XCTest
@testable import LinguaLib

final class LocalizationSheetDataDecoderTests: XCTestCase {
  func test_decode_withValidData_returnsCorrectSheet() {
    let sheetData = SheetDataResponse(values: [
      ["Section", "Key", "one", "two", "three"],
      ["TestSection", "TestKey", "", "TestTranslation"]
    ])
    let language = "en"
    let expectedSheet = LocalizationSheet(language: language, entries: [
      LocalizationEntry(section: "TestSection", key: "TestKey", translations: ["one": "TestTranslation"])
    ])
    
    let sut = LocalizationSheetDataDecoder()
    let sheet = sut.decode(sheetData: sheetData, sheetName: language)
    
    XCTAssertEqual(sheet, expectedSheet)
  }
  
  func test_decode_withInsufficientData_returnsEmptySheet() {
    let sheetData = SheetDataResponse(values: [
      ["Section", "Key"],
      ["TestSection", "TestKey"]
    ])
    let language = "en"
    let expectedSheet = LocalizationSheet(language: language, entries: [])
    
    let sut = LocalizationSheetDataDecoder()
    let sheet = sut.decode(sheetData: sheetData, sheetName: language)
    
    XCTAssertEqual(sheet, expectedSheet)
  }
}
