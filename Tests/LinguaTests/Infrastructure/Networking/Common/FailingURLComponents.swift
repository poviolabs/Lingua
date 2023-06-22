import Foundation
@testable import Lingua

class FailingURLComponents: URLComponentsProvider {
  var queryItems: [URLQueryItem]?
  
  var url: URL? {
    return nil
  }
}
