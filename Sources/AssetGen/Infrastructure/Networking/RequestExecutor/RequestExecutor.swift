import Foundation

protocol RequestExecutor {
  func send<R: Request>(_ request: R) async throws -> R.Response
  func execute<T: Decodable>(with request: URLRequest) async throws -> T
}
