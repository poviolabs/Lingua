import Foundation

protocol DirectoryOperations {
  func createDirectory(named: String, in outputDirectory: String) throws -> URL
  func clearFolder(at path: String) throws
}

final class DefaultDirectoryOperations: DirectoryOperations {
  let fileManagerProvider: FileManagerProvider
  
  init(fileManagerProvider: FileManagerProvider) {
    self.fileManagerProvider = fileManagerProvider
  }
  
  func createDirectory(named directoryName: String, in outputDirectory: String) throws -> URL {
    let mainFolder = URL(fileURLWithPath: outputDirectory)
    let outputFolder = mainFolder.appendingPathComponent(directoryName)
    do {
      try fileManagerProvider.fileManager.createDirectory(at: outputFolder, withIntermediateDirectories: true, attributes: nil)
    } catch {
      throw DirectoryOperationError.folderCreationFailed
    }
    return outputFolder
  }
  
  func clearFolder(at path: String) throws {
    let mainFolder = URL(fileURLWithPath: path)
    guard fileManagerProvider.fileManager.fileExists(atPath: mainFolder.path) else { return }
    
    do {
      try fileManagerProvider.fileManager.removeItem(at: mainFolder)
    } catch {
      throw DirectoryOperationError.clearFolderFailed
    }
  }
}

extension DefaultDirectoryOperations {
  static func makeDefault(fileManagerProvider: DefaultFileManager = .init()) -> DefaultDirectoryOperations {
    return DefaultDirectoryOperations(fileManagerProvider: fileManagerProvider)
  }
}
