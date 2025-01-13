import XCTest
@testable import LinguaLib

final class DirectoryOperatorTests: XCTestCase {
  func test_createDirectory_createsDirectorySuccessfully() throws {
    let sut = makeSUT()
    let outputDirectory = NSTemporaryDirectory()
    let directoryName = "TestDirectory"
    
    let createdDirectoryURL = try sut.createDirectory(named: directoryName, in: outputDirectory)
    XCTAssertTrue(FileManager.default.fileExists(atPath: createdDirectoryURL.path))
  }
  
  func test_createDirectory_throwsError_onFailure() {
    let errorFileManager = MockFileManager()
    errorFileManager.onCreateDirectoryError = "Create_failed"
    let sut = makeSUT(fileManager: errorFileManager)
    let outputDirectory = NSTemporaryDirectory()
    let directoryName = "TestDirectory"
    
    XCTAssertThrowsError(try sut.createDirectory(named: directoryName, in: outputDirectory)) { error in
      XCTAssertEqual((error as? DirectoryOperationError), DirectoryOperationError.folderCreationFailed("Create_failed"))
    }
  }
  
  func test_createDirectory_throwsError_onEmptyDirectory() {
    let errorFileManager = MockFileManager()
    errorFileManager.onCreateDirectoryError = "Directory name is empty."
    let sut = makeSUT(fileManager: errorFileManager)
    let outputDirectory = NSTemporaryDirectory()
    let directoryName = ""
    
    XCTAssertThrowsError(try sut.createDirectory(named: directoryName, in: outputDirectory)) { error in
      XCTAssertEqual((error as? DirectoryOperationError)?.errorDescription, DirectoryOperationError.folderCreationFailed("Directory name is empty.").errorDescription)
    }
  }
  
  func test_removeFiles_clearsAllFiles() throws {
    let errorFileManager = MockFileManager()
    let sut = makeSUT(fileManager: errorFileManager)
    let outputDirectory = NSTemporaryDirectory()
    let directoryName = "TestDirectory"
    
    // Create a directory to clear
    let createdDirectoryURL = try sut.createDirectory(named: directoryName, in: outputDirectory)
    XCTAssertTrue(FileManager.default.fileExists(atPath: createdDirectoryURL.path))
    
    // Add a file to the directory
    let fileURL = createdDirectoryURL.appendingPathComponent("\(String.packageName)-testFile.txt")
    FileManager.default.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
    XCTAssertTrue(FileManager.default.fileExists(atPath: fileURL.path))
    
    // Remove files in directory
    try sut.removeFiles(withPrefix: .packageName, in: createdDirectoryURL)
    
    // Verify the directory is deleted
    XCTAssertFalse(FileManager.default.fileExists(atPath: fileURL.path))
  }
  
  func test_removeFiles_throwsError_onRemoveItem() throws {
    let errorFileManager = MockFileManager()
    errorFileManager.onRemoveItemError = "Remove_failed"
    let sut = makeSUT(fileManager: errorFileManager)
    let outputDirectory = NSTemporaryDirectory()
    let directoryName = "TestDirectory"
    
    // Create a directory to clear
    let createdDirectoryURL = try sut.createDirectory(named: directoryName, in: outputDirectory)
    XCTAssertTrue(FileManager.default.fileExists(atPath: createdDirectoryURL.path))
    
    // Add a file to the directory
    let fileURL = createdDirectoryURL.appendingPathComponent("\(String.packageName)-testFile.txt")
    FileManager.default.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
    XCTAssertTrue(FileManager.default.fileExists(atPath: fileURL.path))
    
    // Test the error case
    XCTAssertThrowsError(try sut.removeFiles(withPrefix: .packageName, in: createdDirectoryURL)) { error in
      XCTAssertEqual((error as? DirectoryOperationError)?.localizedDescription,
                     DirectoryOperationError.removeItemFailed("Remove_failed").localizedDescription)
    }
  }
}

internal extension DirectoryOperatorTests {
  func makeSUT(fileManager: FileManager = FileManager.default) -> DirectoryOperator {
    let mockFileManagerProvider = DefaultFileManager(manager: fileManager)
    return DirectoryOperator.makeDefault(fileManagerProvider: mockFileManagerProvider)
  }
}
