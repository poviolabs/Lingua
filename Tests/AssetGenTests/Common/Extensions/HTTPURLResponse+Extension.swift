import Foundation

extension HTTPURLResponse {
  static func anyURLResponse(url: URL = .anyURL(), statusCode: Int = 200) -> HTTPURLResponse {
    HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
  }
}
