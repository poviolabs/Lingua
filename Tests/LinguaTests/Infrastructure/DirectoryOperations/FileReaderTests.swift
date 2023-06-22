import XCTest
@testable import Lingua

final class FileReaderTests: XCTestCase {
  func test_readData_readsCorrectDataFromFile() async throws {
    let sut = makeSUT()
    let tempFileURL = createTemporaryFile(with: "Test Content")
    let expectedData = try Data(contentsOf: tempFileURL)
    
    let actualData = try await sut.readData(from: tempFileURL)
    
    XCTAssertEqual(actualData, expectedData)
    
    removeTemporaryFile(at: tempFileURL)
  }
  
  func test_readData_throwsErrorWhenFileDoesNotExist() async throws {
    let sut = makeSUT()
    let nonExistingURL = URL(fileURLWithPath: "/path/to/non/existing/file")
    
    do {
      let _ = try await sut.readData(from: nonExistingURL)
      XCTFail("Expected readData to throw an error when file does not exist")
    } catch {
      // Successful test case, no further action.
    }
  }
}

private extension FileReaderTests {
  func makeSUT() -> FileReader {
    FileReader()
  }
  
  func createTemporaryFile(with content: String) -> URL {
    let tempDir = FileManager.default.temporaryDirectory
    let fileURL = tempDir.appendingPathComponent(UUID().uuidString)
    let data = content.data(using: .utf8)!
    try! data.write(to: fileURL)
    return fileURL
  }
  
  func removeTemporaryFile(at url: URL) {
    try? FileManager.default.removeItem(at: url)
  }
}
