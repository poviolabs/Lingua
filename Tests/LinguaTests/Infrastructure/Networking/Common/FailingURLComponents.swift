import Foundation
@testable import LinguaLib

class FailingURLComponents: URLComponentsProvider {
  var queryItems: [URLQueryItem]?
  
  var url: URL? {
    return nil
  }
}
