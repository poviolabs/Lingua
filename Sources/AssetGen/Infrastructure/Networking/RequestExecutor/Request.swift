import Foundation

protocol Request {
  associatedtype Response: Decodable
  
  var path: String { get }
  var method: HTTPMethod { get }
  var queryItems: [URLQueryItem]? { get }
  var body: Data? { get }
  var allHTTPHeaderFields: [String: String]? { get }
}

extension Request {
  var queryItems: [URLQueryItem]? { nil }
  var body: Data? { nil }
  var allHTTPHeaderFields: [String: String]? { nil }
}
