import Foundation

protocol FileCleanupStrategy {
  func removeFiles(using directoryOperator: DirectoryOperable, in folder: URL) throws
}
