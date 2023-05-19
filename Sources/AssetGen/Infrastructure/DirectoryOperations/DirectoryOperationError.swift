import Foundation

enum DirectoryOperationError: Error, CustomStringConvertible {
  case folderCreationFailed
  case clearFolderFailed
  
  var description: String {
    switch self {
    case .folderCreationFailed:
      return "Failed to create the folder in given directory"
    case .clearFolderFailed:
      return "Failed to clear items in this folder"
    }
  }
}
