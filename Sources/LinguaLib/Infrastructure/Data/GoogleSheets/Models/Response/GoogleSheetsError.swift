import Foundation

struct GoogleSheetsError: LocalizedError {
  private let response: GoogleSheetErrorResponse
  
  init(from response: GoogleSheetErrorResponse) {
    self.response = response
  }
  
  var errorDescription: String? {
    "\(response.error.message)\n" + "Additional info: \(response.error.status.description)"
  }
}
