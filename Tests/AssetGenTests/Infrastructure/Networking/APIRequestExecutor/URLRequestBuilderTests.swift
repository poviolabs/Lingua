import XCTest
@testable import AssetGen

final class URLRequestBuilderTests: XCTestCase {
  private let sut = URLRequestBuilder(baseURLString: "https://example.com")
  
  func test_build_whenValidRequest_returnsURLRequest() throws {
    let request = MockRequest()
    
    let urlRequest = try sut.build(from: request)
    
    XCTAssertEqual(urlRequest.httpMethod, "GET")
    XCTAssertEqual(urlRequest.url?.absoluteString, "https://example.com/mock-path?key=value")
  }
  
  func test_build_allHTTPHeaderFields_returnsURLRequest() throws {
    let request = MockRequestWithHeaders()
    
    let urlRequest = try sut.build(from: request)
    
    XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "key"), "value")
  }
  
  func test_buildURL_throwsInvalidRequest() throws {
    let urlString = "https://example.com"
    let url = URL(string: urlString)!
    XCTAssertNotNil(url)
    
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
    
    var method: HTTPMethod { return .get }
    var path: String { return "/mock-path" }
    var body: Data? { return "{\"key\":\"value\"}".data(using: .utf8) }
    var contentType: String? { return "application/json" }
    var queryItems: [URLQueryItem]? { [.init(name: "key", value: "value")] }
  }
  
  struct MockRequestWithHeaders: Request {
    typealias Response = String
    
    var method: HTTPMethod { return .get }
    var path: String { return "/mock-path" }
    var allHTTPHeaderFields: [String : String]? { ["key": "value"] }
  }
}
