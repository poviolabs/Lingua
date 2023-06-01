import Foundation

enum DirectoryOperationError: LocalizedError {
  case folderCreationFailed
  case clearFolderFailed
  
  var errorDescription: String? {
    switch self {
    case .folderCreationFailed:
      return "Failed to create the folder in given directory"
    case .clearFolderFailed:
      return "Failed to clear items in this folder"
    }
  }
}
