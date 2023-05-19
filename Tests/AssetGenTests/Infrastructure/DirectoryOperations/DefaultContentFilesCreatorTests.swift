import XCTest
@testable import AssetGen

final class DefaultContentFilesCreatorTests: XCTestCase {
  func test_createFiles_writesContentToFile() {
    let (sut, contentWriter) = makeSUT()
    let testContent = "Test content"
    let testFileName = "test.txt"
    let testOutputFolder = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    
    try? sut.createFiles(with: testContent, fileName: testFileName, outputFolder: testOutputFolder)
    
    let writtenContent = contentWriter.writtenContent
    XCTAssertEqual(writtenContent?.content, testContent)
    XCTAssertEqual(writtenContent?.destinationURL.lastPathComponent, testFileName)
  }
  
  func test_createFilesInCurrentDirectory_writesContentToFileInCurrentDirectory() {
    let (sut, contentWriter) = makeSUT()
    let testContent = "Test content"
    let testFileName = "test.txt"
    
    try? sut.createFilesInCurrentDirectory(with: testContent, fileName: testFileName)
    
    let writtenContent = contentWriter.writtenContent
    XCTAssertEqual(writtenContent?.content, testContent)
    XCTAssertEqual(writtenContent?.destinationURL.lastPathComponent, testFileName)
    
    // Verify that the file is written in the current directory
    let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    XCTAssertEqual(writtenContent?.destinationURL.deletingLastPathComponent(), currentDirectoryURL)
  }
  
}

private extension DefaultContentFilesCreatorTests {
  func makeSUT() -> (sut: DefaultContentFilesCreator, contentWriter: MockContentWriter) {
    let contentWriter = MockContentWriter()
    let sut = DefaultContentFilesCreator(contentWriter: contentWriter)
    return (sut, contentWriter)
  }
}
