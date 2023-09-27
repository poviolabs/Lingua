import Foundation

public enum DirectoryOperationError: LocalizedError {
  case folderCreationFailed
  case removeItemFailed
  
  public var errorDescription: String? {
    switch self {
    case .folderCreationFailed:
      return "Failed to create the folder in given directory"
    case .removeItemFailed:
      return "Failed to remove item in this folder"
    }
  }
}
