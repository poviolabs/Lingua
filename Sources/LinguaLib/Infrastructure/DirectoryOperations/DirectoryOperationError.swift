import Foundation

public enum DirectoryOperationError: LocalizedError, Equatable {
  case folderCreationFailed(String)
  case removeItemFailed(String)
  
  public var errorDescription: String? {
    switch self {
    case .folderCreationFailed(let error):
      return "Failed to create the folder in given directory.\nReason: \(error)"
    case .removeItemFailed(let error):
      return "Failed to remove item in this folder.\nReason: \(error)"
    }
  }
}
