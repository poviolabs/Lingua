import XCTest
@testable import AssetGen

final class FileContentWriterTests: XCTestCase {
  private var testFileURL: URL?
  
  override func setUpWithError() throws {
    let tempDir = FileManager.default.temporaryDirectory
    testFileURL = tempDir.appendingPathComponent("testFile.txt")
  }
  
  override func tearDownWithError() throws {
    if let url = testFileURL {
      try? FileManager.default.removeItem(at: url)
    }
  }
  
  func test_write_writesContentToFile() throws {
    let content = "This is a test string."
    let sut = makeSUT()
    
    let url = try XCTUnwrap(testFileURL)
    try sut.write(content, to: url)
    
    let writtenContent = try String(contentsOf: url, encoding: .utf8)
    XCTAssertEqual(writtenContent, content)
  }
  
  func test_write_throwsErrorForInvalidURL() throws {
    let content = "This is a test string."
    let invalidURL = URL(fileURLWithPath: "/invalid/path/testFile.txt")
    let sut = makeSUT()
    
    XCTAssertThrowsError(try sut.write(content, to: invalidURL)) { error in
      XCTAssertTrue(error is CocoaError)
    }
  }
}
  
private extension FileContentWriterTests {
  func makeSUT() -> ContentWritable {
    FileContentWriter()
  }
}
