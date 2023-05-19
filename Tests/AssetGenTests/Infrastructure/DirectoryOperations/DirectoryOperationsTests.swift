import XCTest
@testable import AssetGen

final class DirectoryOperationsTests: XCTestCase {
  func test_createDirectory_createsDirectorySuccessfully() throws {
    let sut = makeSUT()
    let outputDirectory = NSTemporaryDirectory()
    let directoryName = "TestDirectory"
    
    let createdDirectoryURL = try sut.createDirectory(named: directoryName, in: outputDirectory)
    XCTAssertTrue(FileManager.default.fileExists(atPath: createdDirectoryURL.path))
  }
  
  func test_createDirectory_throwsError() {
    let errorFileManager = MockFileManager()
    errorFileManager.shouldThrowErrorOnCreateDirectory = true
    let sut = makeSUT(fileManager: errorFileManager)
    let outputDirectory = NSTemporaryDirectory()
    let directoryName = "TestDirectory"
    
    XCTAssertThrowsError(try sut.createDirectory(named: directoryName, in: outputDirectory)) { error in
      XCTAssertEqual(error as? DirectoryOperationError, DirectoryOperationError.folderCreationFailed)
    }
  }
  
  func test_clearFolder_clearsAllFiles() throws {
    let errorFileManager = MockFileManager()
    let sut = makeSUT(fileManager: errorFileManager)
    let outputDirectory = NSTemporaryDirectory()
    let directoryName = "TestDirectory"
    
    // Create a directory to clear
    let createdDirectoryURL = try sut.createDirectory(named: directoryName, in: outputDirectory)
    XCTAssertTrue(FileManager.default.fileExists(atPath: createdDirectoryURL.path))
    
    // Add a file to the directory
    let fileURL = createdDirectoryURL.appendingPathComponent("testFile.txt")
    FileManager.default.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
    XCTAssertTrue(FileManager.default.fileExists(atPath: fileURL.path))
    
    // Clear the folder
    try sut.clearFolder(at: createdDirectoryURL.path)
    
    // Verify the directory is deleted
    XCTAssertFalse(FileManager.default.fileExists(atPath: createdDirectoryURL.path))
  }
  
  func test_clearFolder_throwsError_onRemoveItem() throws {
    let errorFileManager = MockFileManager()
    errorFileManager.shouldThrowErrorOnRemoveItem = true
    let sut = makeSUT(fileManager: errorFileManager)
    let outputDirectory = NSTemporaryDirectory()
    let directoryName = "TestDirectory"
    
    // Create a directory to clear
    let createdDirectoryURL = try sut.createDirectory(named: directoryName, in: outputDirectory)
    XCTAssertTrue(FileManager.default.fileExists(atPath: createdDirectoryURL.path))
    
    // Test the error case
    XCTAssertThrowsError(try sut.clearFolder(at: createdDirectoryURL.path)) { error in
      XCTAssertEqual(error as? DirectoryOperationError, DirectoryOperationError.clearFolderFailed)
    }
  }
  
  func test_clearFolder_noThrow_whenFolderDoesNotExist() {
    let sut = makeSUT()
    let nonExistentDirectory = NSTemporaryDirectory().appending("NonExistentDirectory")
    
    XCTAssertFalse(FileManager.default.fileExists(atPath: nonExistentDirectory))
    
    XCTAssertNoThrow(try sut.clearFolder(at: nonExistentDirectory))
  }
}

internal extension DirectoryOperationsTests {
  func makeSUT(fileManager: FileManager = FileManager.default) -> DefaultDirectoryOperations {
    let mockFileManagerProvider = DefaultFileManager(fileManager: fileManager)
    return DefaultDirectoryOperations.makeDefault(fileManagerProvider: mockFileManagerProvider)
  }
}
