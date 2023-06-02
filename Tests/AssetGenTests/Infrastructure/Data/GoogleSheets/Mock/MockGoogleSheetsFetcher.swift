import Foundation
@testable import AssetGen

final class MockGoogleSheetsFetcher: GoogleSheetsFetchable {
  let sheetMetadata: SheetMetadata
  let sheetData: SheetDataResponse
  
  init(sheetMetadata: SheetMetadata, sheetData: SheetDataResponse) {
    self.sheetMetadata = sheetMetadata
    self.sheetData = sheetData
  }
  
  func fetchSheetNames() async throws -> SheetMetadata {
    sheetMetadata
  }
  
  func fetchSheetData(sheetName: String) async throws -> SheetDataResponse {
    sheetData
  }
}
