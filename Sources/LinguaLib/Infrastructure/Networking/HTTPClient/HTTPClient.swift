import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol HTTPClient {
  func fetchData(with request: URLRequest) async throws -> (Data, HTTPURLResponse)
}

extension HTTPClient {
  func fetchData(from url: URL) async throws -> (Data, HTTPURLResponse) {
    try await fetchData(with: .init(url: url))
  }
}
