import Foundation

struct AndroidFileCleanupStrategy: FileCleanupStrategy {
  func removeFiles(using directoryOperator: DirectoryOperable, in folder: URL) throws {
    try directoryOperator.removeFiles(withPrefix: .packageName, in: folder)
  }
}
