import XCTest
@testable import AssetGen

final class LocalizationSheetDataDecoderTests: XCTestCase {
  func test_decode_withValidData_returnsCorrectSheet() {
    let sheetData = SheetDataResponse(values: [
      ["Section", "Key", "Is Plural", "Unused", "Translation"],
      ["TestSection", "TestKey", "No", "Unused", "TestTranslation"]
    ])
    let language = "en"
    let expectedSheet = LocalizationSheet(language: language, entries: [
      LocalizationEntry(section: "TestSection", key: "TestKey", plural: false, translations: ["one": "TestTranslation"])
    ])
    
    let sut = LocalizationSheetDataDecoder()
    let sheet = sut.decode(sheetData: sheetData, sheetName: language)
    
    XCTAssertEqual(sheet, expectedSheet)
  }
  
  func test_decode_withInsufficientData_returnsEmptySheet() {
    let sheetData = SheetDataResponse(values: [
      ["Section", "Key", "Is Plural"],
      ["TestSection", "TestKey", "No"]
    ])
    let language = "en"
    let expectedSheet = LocalizationSheet(language: language, entries: [])
    
    let sut = LocalizationSheetDataDecoder()
    let sheet = sut.decode(sheetData: sheetData, sheetName: language)
    
    XCTAssertEqual(sheet, expectedSheet)
  }
}
