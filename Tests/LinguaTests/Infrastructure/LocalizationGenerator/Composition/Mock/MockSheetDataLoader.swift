import XCTest
@testable import Lingua

final class MockSheetDataLoader: SheetDataLoader {
  var loadSheetsResult: Result<[LocalizationSheet], Error>
  private(set) var messages = [LocalizationSheet]()
  
  init(loadSheetsResult: Result<[LocalizationSheet], Error> = .success([])) {
    self.loadSheetsResult = loadSheetsResult
  }
  
  func loadSheets() async throws -> [LocalizationSheet] {
    switch loadSheetsResult {
    case .success(let sheets):
      messages.append(contentsOf: sheets)
      return sheets
    case .failure(let error):
      throw error
    }
  }
}
