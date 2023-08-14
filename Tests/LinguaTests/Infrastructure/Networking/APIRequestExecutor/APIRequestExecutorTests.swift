import XCTest
@testable import Lingua

final class APIRequestExecutorTests: XCTestCase {
  func test_send_whenRequestSucceeds_returnsDecodedObject() async throws {
    let (sut, httpClient, _) = makeSUT()
    let expectedObject = anyDecodableObject()
    
    httpClient.data = expectedObject.data()
    httpClient.response = HTTPURLResponse.anyURLResponse()
    httpClient.error = nil
    
    let testRequest = TestRequest()
    let receivedObject: TestDecodable = try await sut.send(testRequest)
    XCTAssertEqual(receivedObject, expectedObject)
  }
  
  func test_send_whenRequestFails_throwsError() async {
    let (sut, httpClient, _) = makeSUT()
    let expectedError: NSError = .anyError()
    
    httpClient.data = nil
    httpClient.error = expectedError
    
    let testRequest = TestRequest()
    do {
      let _: TestDecodable = try await sut.send(testRequest)
      XCTFail("Expected error to be thrown")
    } catch {
      let error = error as NSError
      XCTAssertEqual(error.domain, expectedError.domain)
      XCTAssertEqual(error.code, expectedError.code)
    }
  }
  
  func test_send_whenNon200HTTPResponse_throwsInvalidHTTPResponseError() async throws {
    let (sut, httpClient, _) = makeSUT()
    let non200StatusCode = 404
    let responseData: Data = .anyData()
    
    httpClient.data = responseData
    httpClient.response = HTTPURLResponse.anyURLResponse(statusCode: non200StatusCode)
    httpClient.error = nil
    
    let testRequest = TestRequest()
    do {
      let _: TestDecodable = try await sut.send(testRequest)
      XCTFail("Expected InvalidHTTPResponseError to be thrown")
    } catch {
      let error = try XCTUnwrap(error as? InvalidHTTPResponseError)
      XCTAssertEqual(error.statusCode, non200StatusCode)
      XCTAssertEqual(error.localizedDescription, "Invalid HTTP response with status code: 404")
      XCTAssertEqual(error.data, responseData)
    }
  }
  
  func test_send_whenInvalidRequest_throwsAPIErrorInvalidRequest() async throws {
    let invalidBaseURLString = ""
    let httpClient = MockHTTPClient()
    let sut = APIRequestExecutor(requestBuilder: .init(baseURLString: invalidBaseURLString), httpClient: httpClient)
    let testRequest = TestRequest()
    
    do {
      let _: TestDecodable = try await sut.send(testRequest)
      XCTFail("Expected APIError.invalidRequest to be thrown")
    } catch {
      let error = try XCTUnwrap(error as? APIError)
      XCTAssertEqual(error, APIError.invalidRequest)
    }
  }
  
  func test_send_whenGoogleSheetsErrorReceived_throwsGoogleSheetsError() async throws {
    let (sut, httpClient, _) = makeSUT(errorHandler: GoogleSheetsErrorHandler())
    let googleSheetsErrorResponse = GoogleSheetErrorResponse(
      error: .init(code: 403, message: "Some Error Message", status: .permissionDenied)
    )
    let responseData = try? JSONEncoder().encode(googleSheetsErrorResponse)
    
    httpClient.data = responseData
    httpClient.response = HTTPURLResponse.anyURLResponse(statusCode: 403)
    httpClient.error = nil
    
    let testRequest = TestRequest()
    do {
      let _: TestDecodable = try await sut.send(testRequest)
      XCTFail("Expected GoogleSheetsError to be thrown")
    } catch {
      let error = try XCTUnwrap(error as? GoogleSheetsError)
      XCTAssertEqual(error.localizedDescription, """
Some Error Message
Additional info: Ensure that the Google Sheet you're trying to access has its sharing
settings configured to allow access to anyone with the link. You can do this by
clicking on "Share" in the upper right corner of the Google Sheet and
selecting "Anyone with the link."
""")
    }
  }
}

private extension APIRequestExecutorTests {
  func makeSUT(baseURLString: String = "https://testapi.com", errorHandler: APIErrorHandler? = nil) -> (sut: APIRequestExecutor, httpClient: MockHTTPClient, url: URL) {
    let url: URL = .anyURL()
    let httpClient = MockHTTPClient()
    let sut = APIRequestExecutor(requestBuilder: .init(baseURLString: baseURLString),
                                 httpClient: httpClient,
                                 errorHandler: errorHandler)
    return (sut, httpClient, url)
  }
}

private extension APIRequestExecutorTests {
  struct TestDecodable: Codable, Equatable {
    let value: String
    
    func data() -> Data {
      let encoder = JSONEncoder()
      return try! encoder.encode(self)
    }
  }
  
  func anyDecodableObject() -> TestDecodable {
    TestDecodable(value: "any value")
  }
}

private extension APIRequestExecutorTests {
  struct TestRequest: Request {
    typealias Response = TestDecodable
    
    var method: HTTPMethod {
      return .get
    }
    
    var path: String {
      return "/test"
    }
    
    var allHTTPHeaderFields: [String: String]? {
      ["test": "test"]
    }
  }
}
