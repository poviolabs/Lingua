import Foundation
@testable import AssetGen

class MockFileManager: FileManager {
  var shouldThrowErrorOnRemoveItem = false
  var shouldThrowErrorOnCreateDirectory = false
  
  override func createDirectory(at url: URL,
                                withIntermediateDirectories createIntermediates: Bool,
                                attributes: [FileAttributeKey : Any]? = nil) throws {
    if shouldThrowErrorOnCreateDirectory {
      throw DirectoryOperationError.folderCreationFailed
    } else {
      try super.createDirectory(at: url, withIntermediateDirectories: createIntermediates, attributes: attributes)
    }
  }
  
  override func removeItem(at URL: URL) throws {
    if shouldThrowErrorOnRemoveItem {
      throw NSError(domain: NSCocoaErrorDomain, code: NSFileWriteUnknownError, userInfo: nil)
    } else {
      try super.removeItem(at: URL)
    }
  }
}
