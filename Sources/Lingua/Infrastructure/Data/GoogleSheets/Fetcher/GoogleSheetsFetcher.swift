import Foundation

final class GoogleSheetsFetcher {
  private let config: GoogleSheetsAPIConfig
  private let requestExecutor: RequestExecutor
  
  init(config: GoogleSheetsAPIConfig, requestExecutor: RequestExecutor) {
    self.config = config
    self.requestExecutor = requestExecutor
  }
}

extension GoogleSheetsFetcher: GoogleSheetsFetchable {
  func fetchSheetNames() async throws -> SheetMetadata {
    let request = SheetNamesRequest(config: config)
    return try await requestExecutor.send(request)
  }
  
  func fetchSheetData(sheetName: String) async throws -> SheetDataResponse {
    let request = SheetDataRequest(sheetName: sheetName, config: config)
    return try await requestExecutor.send(request)
  }
}

