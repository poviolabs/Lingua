import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct URLRequestBuilder {
  let baseURLString: String
  
  init(baseURLString: String) {
    self.baseURLString = baseURLString
  }
  
  func build<R: Request>(from request: R) throws -> URLRequest {
    guard let url = URL(string: baseURLString)?.appendingPathComponent(request.path) else {
      throw APIError.invalidRequest
    }
    
    let finalURL = try buildURL(url: url, queryItems: request.queryItems)
    
    var urlRequest = URLRequest(url: finalURL)
    urlRequest.httpMethod = request.method.rawValue
    urlRequest.httpBody = request.body
    
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    request.allHTTPHeaderFields?.forEach {
      urlRequest.setValue($1, forHTTPHeaderField: $0)
    }
    
    return urlRequest
  }
  
  internal func buildURL(url: URL,
                         queryItems: [URLQueryItem]?,
                         componentsProvider: (_ url: URL) -> URLComponentsProvider = { url in
    URLComponents(url: url, resolvingAgainstBaseURL: false)!
  }) throws -> URL {
    
    var components = componentsProvider(url)
    components.queryItems = queryItems
    
    guard let finalURL = components.url else {
      throw APIError.invalidRequest
    }
    
    return finalURL
  }
}
