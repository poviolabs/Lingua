import XCTest
@testable import LinguaLib

final class URLRequestBuilderTests: XCTestCase {
  private let sut = URLRequestBuilder(baseURLString: "https://example.com")
  
  func test_build_whenValidRequest_returnsURLRequest() throws {
    let httpMethod = HTTPMethod.get
    let request = MockRequest(method: httpMethod)
    
    let urlRequest = try sut.build(from: request)
    
    XCTAssertEqual(urlRequest.httpMethod, httpMethod.rawValue)
    XCTAssertEqual(urlRequest.url?.absoluteString, "https://example.com/mock-path?key=value")
  }
  
  func test_build_allHTTPHeaderFields_returnsURLRequest() throws {
    let headers = ["key": "value"]
    let request = MockRequestWithHeaders(path: "/mock-path", allHTTPHeaderFields: headers)
    
    let urlRequest = try sut.build(from: request)
    
    XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "key"), headers["key"])
  }
  
  func test_buildURL_throwsInvalidRequest() throws {
    let urlString = "https://example.com"
    let url = try XCTUnwrap(URL(string: urlString))
    
    do {
      let _ = try sut.buildURL(url: url, queryItems: [], componentsProvider: { _ in FailingURLComponents() })
      XCTFail("Expected buildURL to throw APIError.invalidRequest")
    } catch {
      let error = try XCTUnwrap(error as? APIError)
      XCTAssertEqual(error, APIError.invalidRequest)
    }
  }
}

private extension URLRequestBuilderTests {
  struct MockRequest: Request {
    typealias Response = String
    
    var method: HTTPMethod
    var path: String { return "/mock-path" }
    var body: Data? { return "{\"key\":\"value\"}".data(using: .utf8) }
    var queryItems: [URLQueryItem]? { [.init(name: "key", value: "value")] }
    
    init(method: HTTPMethod = .get) {
      self.method = method
    }
  }
  
  struct MockRequestWithHeaders: Request {
    typealias Response = String
    
    var method: HTTPMethod
    var path: String
    var allHTTPHeaderFields: [String : String]?
    
    init(method: HTTPMethod = .get, path: String, allHTTPHeaderFields: [String : String]? = nil) {
      self.method = method
      self.path = path
      self.allHTTPHeaderFields = allHTTPHeaderFields
    }
  }
}
