import Foundation

struct InvalidHTTPResponseError: Error, CustomStringConvertible {
  let statusCode: Int
  let data: Data?
  
  var description: String {
    "Invalid HTTP response with status code: \(statusCode)"
  }
}
