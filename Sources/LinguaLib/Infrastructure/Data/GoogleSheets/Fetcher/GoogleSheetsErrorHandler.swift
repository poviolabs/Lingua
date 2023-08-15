import Foundation

final class GoogleSheetsErrorHandler: APIErrorHandler {
  private let decoder: JSONDecoding
  
  init(decoder: JSONDecoding = JSONDecoder()) {
    self.decoder = decoder
  }
  
  func handleError<T: Decodable>(data: Data, statusCode: Int) throws -> T {
    if let googleError = try? decoder.decode(GoogleSheetErrorResponse.self, from: data) {
      throw GoogleSheetsError(from: googleError)
    } else {
      throw InvalidHTTPResponseError(statusCode: statusCode, data: data)
    }
  }
}
