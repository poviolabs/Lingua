import Foundation

protocol GoogleSheetsFetchable {
  func fetchSheetNames() async throws -> SheetMetadata
  func fetchSheetData(sheetName: String) async throws -> SheetDataResponse
}
