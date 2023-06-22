import Foundation
@testable import Lingua

class MockHTTPClient: HTTPClient {
  var data: Data?
  var response: HTTPURLResponse?
  var error: Error?
  
  func fetchData(with request: URLRequest) async throws -> (Data, HTTPURLResponse) {
    if let error = error {
      throw error
    }
    
    return (data!, response!)
  }
}
