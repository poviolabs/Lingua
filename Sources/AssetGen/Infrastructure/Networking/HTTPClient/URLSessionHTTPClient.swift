import Foundation

class URLSessionHTTPClient: HTTPClient {
  private let urlSession: URLSession
  
  init(urlSession: URLSession = URLSession.shared) {
    self.urlSession = urlSession
  }
  
  func fetchData(with request: URLRequest) async throws -> (Data, HTTPURLResponse) {
    let (data, response) = try await urlSession.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse else {
      throw InvalidHTTPResponseError(statusCode: 0, data: data)
    }
    
    return (data, httpResponse)
  }
}
