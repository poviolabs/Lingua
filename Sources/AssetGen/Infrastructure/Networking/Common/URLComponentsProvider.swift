import Foundation

protocol URLComponentsProvider {
  var queryItems: [URLQueryItem]? { get set }
  var url: URL? { get }
}

extension URLComponents: URLComponentsProvider {}
