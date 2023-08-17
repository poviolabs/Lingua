import Foundation

struct IOSFileCleanupStrategy: FileCleanupStrategy {
  func removeFiles(using directoryOperator: DirectoryOperable, in folder: URL) throws {
    try directoryOperator.removeAllFiles(in: folder)
  }
}
