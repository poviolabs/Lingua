import Foundation

protocol APIErrorHandler {
  func handleError<T: Decodable>(data: Data, statusCode: Int) throws -> T
}
