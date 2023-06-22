import Foundation

class MockURLProtocol: URLProtocol {
  static var mockData: Data?
  static var mockError: Error?
  static var mockResponse: URLResponse?
  
  override class func canInit(with request: URLRequest) -> Bool {
    return true
  }
  
  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }
  
  override func startLoading() {
    if let response = MockURLProtocol.mockResponse {
      client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
    }
    
    if let error = MockURLProtocol.mockError {
      client?.urlProtocol(self, didFailWithError: error)
    } else if let data = MockURLProtocol.mockData {
      client?.urlProtocol(self, didLoad: data)
    }
    
    client?.urlProtocolDidFinishLoading(self)
  }
  
  override func stopLoading() {}
}
