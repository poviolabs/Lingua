import Foundation
@testable import AssetGen

class FailingURLComponents: URLComponentsProvider {
  var queryItems: [URLQueryItem]?
  
  var url: URL? {
    return nil
  }
}
