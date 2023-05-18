import XCTest
@testable import AssetGen

final class GoogleSheetDataLoaderTests: XCTestCase {
  func test_loadSheets_withValidData_returnsLocalizationSheets() async throws {
    let sheetMetadata = SheetMetadata(sheets: [
      SheetMetadata.Sheet(properties: SheetMetadata.Sheet.SheetProperties(title: "Sheet1")),
      SheetMetadata.Sheet(properties: SheetMetadata.Sheet.SheetProperties(title: "Sheet2"))
    ])
    let sheetDataResponse = SheetDataResponse(values: [
      ["Section", "Key", "Unused", "Translation"],
      ["test_section", "test_key", "", "test_translation"]
    ])
    let fetcher = MockGoogleSheetsFetcher(sheetMetadata: sheetMetadata, sheetData: sheetDataResponse)
    let sut = makeSUT(fetcher: fetcher)
    
    let result = try await sut.loadSheets()
    
    XCTAssertEqual(result.count, 2)
    XCTAssertEqual(result[0].language, "Sheet1")
    XCTAssertEqual(result[0].entries.count, 1)
    XCTAssertEqual(result[0].entries[0].section, "test_section")
    XCTAssertEqual(result[0].entries[0].key, "test_key")
    XCTAssertEqual(result[0].entries[0].translations, ["one": "test_translation"])
  }
  
  func test_loadSheets_withEmptyData_returnsEmptyArray() async throws {
    let sheetMetadata = SheetMetadata(sheets: [])
    let sheetDataResponse = SheetDataResponse(values: [])
    let fetcher = MockGoogleSheetsFetcher(sheetMetadata: sheetMetadata, sheetData: sheetDataResponse)
    let sut = makeSUT(fetcher: fetcher)
    
    let result = try await sut.loadSheets()
    
    XCTAssertEqual(result.count, 0)
  }
}

private extension GoogleSheetDataLoaderTests {
  func makeSUT(fetcher: GoogleSheetsFetchable, sheetDataDecoder: SheetDataDecoder = LocalizationSheetDataDecoder()) -> SheetDataLoader {
    GoogleSheetDataLoader(fetcher: fetcher, sheetDataDecoder: sheetDataDecoder)
  }
}
