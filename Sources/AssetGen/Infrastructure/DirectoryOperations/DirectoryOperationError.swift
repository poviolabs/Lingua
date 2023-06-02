import Foundation

enum DirectoryOperationError: LocalizedError {
  case folderCreationFailed
  case removeItemFailed
  
  var errorDescription: String? {
    switch self {
    case .folderCreationFailed:
      return "Failed to create the folder in given directory"
    case .removeItemFailed:
      return "Failed to remove item in this folder"
    }
  }
}
