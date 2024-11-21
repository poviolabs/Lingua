import Foundation
@testable import LinguaLib

final class MockFileManager: FileManager {
  let files: [String]
  var shouldThrowErrorOnRemoveItem: String?
  var shouldThrowErrorOnCreateDirectory: String?
  
  init(files: [String] = []) {
    self.files = files
  }
  
  override func enumerator(atPath path: String) -> FileManager.DirectoryEnumerator? {
    DirectoryEnumeratorStub(files: files)
  }
  
  override func createDirectory(at url: URL,
                                withIntermediateDirectories createIntermediates: Bool,
                                attributes: [FileAttributeKey : Any]? = nil) throws {
    if let shouldThrowErrorOnCreateDirectory {
      throw DirectoryOperationError.folderCreationFailed(shouldThrowErrorOnCreateDirectory)
    } else {
      try super.createDirectory(at: url, withIntermediateDirectories: createIntermediates, attributes: attributes)
    }
  }
  
  override func removeItem(at URL: URL) throws {
    if let shouldThrowErrorOnRemoveItem {
      throw DirectoryOperationError.removeItemFailed(shouldThrowErrorOnRemoveItem)
    } else {
      try super.removeItem(at: URL)
    }
  }
}
