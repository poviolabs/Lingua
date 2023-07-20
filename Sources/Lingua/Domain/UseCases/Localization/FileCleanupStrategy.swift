import Foundation

/// A protocol that defines a strategy to clean up files in a specific folder using a directory operator
protocol FileCleanupStrategy {
  func removeFiles(using directoryOperator: DirectoryOperable, in folder: URL) throws
}
