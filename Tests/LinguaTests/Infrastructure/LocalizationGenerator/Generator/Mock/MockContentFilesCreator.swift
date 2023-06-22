import Foundation
@testable import Lingua

class MockContentFilesCreator: ContentFileCreatable {
  var writtenContent: [String: String] = [:]
  var shouldThrowError = false
  
  func createFiles(with content: String, fileName: String, outputFolder: URL) throws {
    try createFilesInCurrentDirectory(with: content, fileName: fileName)
  }
  
  func createFilesInCurrentDirectory(with content: String, fileName: String) throws {
    if shouldThrowError {
      throw DirectoryOperationError.folderCreationFailed
    }
    writtenContent[fileName] = content
  }
}
