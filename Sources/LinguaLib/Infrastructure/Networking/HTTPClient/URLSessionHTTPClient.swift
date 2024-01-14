import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class URLSessionHTTPClient: HTTPClient {
  private let urlSession: URLSession
  
  init(urlSession: URLSession = URLSession.shared) {
    self.urlSession = urlSession
  }
  
  func fetchData(with request: URLRequest) async throws -> (Data, HTTPURLResponse) {
#if canImport(FoundationNetworking)
    return try await makeData(for: request)
#else
    let (data, response) = try await urlSession.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse else {
      throw InvalidHTTPResponseError(statusCode: 0, data: data)
    }
    return (data, httpResponse)
#endif
  }
}

private extension URLSessionHTTPClient {
  func makeData(for request: URLRequest) async throws -> (Data, HTTPURLResponse) {
    try await withCheckedThrowingContinuation { continuation in
      let task = urlSession.dataTask(with: request) { data, response, error in
        if let error = error {
          continuation.resume(throwing: error)
          return
        }
        guard let data = data, let httpResponse = response as? HTTPURLResponse else {
          continuation.resume(throwing: URLError(.badServerResponse))
          return
        }
        continuation.resume(returning: (data, httpResponse))
      }
      task.resume()
    }
  }
}
