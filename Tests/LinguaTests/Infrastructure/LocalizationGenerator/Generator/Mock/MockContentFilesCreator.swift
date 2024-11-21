import Foundation
@testable import LinguaLib

class MockContentFilesCreator: ContentFileCreatable {
  var writtenContent: [String: String] = [:]
  var shouldThrowError: String?
  
  func createFiles(with content: String, fileName: String, outputFolder: URL) throws {
    try createFilesInCurrentDirectory(with: content, fileName: fileName)
  }
  
  func createFilesInCurrentDirectory(with content: String, fileName: String) throws {
    if let shouldThrowError {
      throw DirectoryOperationError.folderCreationFailed(shouldThrowError)
    }
    writtenContent[fileName] = content
  }
}
