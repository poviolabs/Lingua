import Foundation

struct GoogleSheetErrorResponse: Codable {
  let error: ErrorResponse
  
  struct ErrorResponse: Codable {
    let code: Int
    let message: String
    let status: Status
  }
  
  enum Status: String, Codable {
    case permissionDenied = "PERMISSION_DENIED"
    case notFound = "NOT_FOUND"
    case invalidArgument = "INVALID_ARGUMENT"
    
    var description: String {
      switch self {
      case .permissionDenied:
        return """
Ensure that the Google Sheet you're trying to access has its sharing
settings configured to allow access to anyone with the link. You can do this by
clicking on \"Share\" in the upper right corner of the Google Sheet and
selecting \"Anyone with the link.\"
"""
      case .notFound:
        return """
The resource you're trying to access couldn't be found.
Please ensure you're looking in the right place and the sheet id is correct.
"""
      case .invalidArgument:
        return """
It seems there was an error with the data provided.
Please check your inputs and try again.
"""
      }
    }
  }
}
