import Foundation

struct InvalidHTTPResponseError: LocalizedError {
  let statusCode: Int
  let data: Data?
  
  var errorDescription: String? {
    "Invalid HTTP response with status code: \(statusCode)"
  }
}
