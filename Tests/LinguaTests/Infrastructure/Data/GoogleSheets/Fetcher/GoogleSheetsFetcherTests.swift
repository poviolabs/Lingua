import XCTest
@testable import Lingua

final class GoogleSheetsFetcherTests: XCTestCase {
  func test_fetchSheetNames_sendsCorrectRequest() async throws {
    let (sut, executor) = makeSUT()
    
    let expectedResult = SheetMetadata(sheets: [])
    executor.resultToReturn = expectedResult
    
    _ = try await sut.fetchSheetNames()
    
    let expectedRequest = SheetNamesRequest(config: config)
    XCTAssertEqual(executor.receivedRequests as? [SheetNamesRequest], [expectedRequest])
  }
  
  func test_fetchSheetData_sendsCorrectRequest() async throws {
    let (sut, executor) = makeSUT()
    
    let expectedResult = SheetDataResponse(values: [["test"]])
    executor.resultToReturn = expectedResult
    
    let result = try await sut.fetchSheetData(sheetName: "test")
    
    XCTAssertEqual(result, expectedResult)
    
    let expectedRequest = SheetDataRequest(sheetName: "test", config: config)
    XCTAssertEqual(executor.receivedRequests as? [SheetDataRequest], [expectedRequest])
  }
  
  func test_sheetDataRequest_isConfiguredCorrectly() {
    let config = GoogleSheetsAPIConfig(apiKey: "testKey", sheetId: "testId")
    let sheetName = "testSheet"
    let expectedPath = "/\(config.sheetId)/values/\(sheetName)!A:Z"
    let expectedQueryItems = [URLQueryItem(name: "key", value: config.apiKey)]
    
    let request = SheetDataRequest(sheetName: sheetName, config: config)
    
    XCTAssertEqual(request.method, .get)
    XCTAssertEqual(request.path, expectedPath)
    XCTAssertEqual(request.queryItems, expectedQueryItems)
  }
  
  func test_sheetNamesRequest_isConfiguredCorrectly() {
    let config = GoogleSheetsAPIConfig(apiKey: "testKey", sheetId: "testId")
    let expectedPath = config.sheetId
    let expectedQueryItems = [URLQueryItem(name: "key", value: config.apiKey)]
    
    let request = SheetNamesRequest(config: config)
    
    XCTAssertEqual(request.method, .get)
    XCTAssertEqual(request.path, expectedPath)
    XCTAssertEqual(request.queryItems, expectedQueryItems)
  }
}

extension GoogleSheetsFetcherTests {
  var config: GoogleSheetsAPIConfig { .init(apiKey: "test", sheetId: "test") }
  
  func makeSUT() -> (sut: GoogleSheetsFetcher, executor: MockRequestExecutor) {
    let executor = MockRequestExecutor()
    let sut = GoogleSheetsFetcher(config: config, requestExecutor: executor)
    
    return (sut, executor)
  }
}
