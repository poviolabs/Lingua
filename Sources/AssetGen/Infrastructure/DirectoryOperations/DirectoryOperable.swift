import Foundation

protocol DirectoryOperable {
  func createDirectory(named: String, in outputDirectory: String) throws -> URL
  func clearFolder(at path: String) throws
}

final class DirectoryOperator: DirectoryOperable {
  let fileManagerProvider: FileManagerProvider
  
  init(fileManagerProvider: FileManagerProvider) {
    self.fileManagerProvider = fileManagerProvider
  }
  
  func createDirectory(named directoryName: String, in outputDirectory: String) throws -> URL {
    let mainFolder = URL(fileURLWithPath: outputDirectory)
    let outputFolder = mainFolder.appendingPathComponent(directoryName)
    do {
      try fileManagerProvider.manager.createDirectory(at: outputFolder, withIntermediateDirectories: true, attributes: nil)
    } catch {
      throw DirectoryOperationError.folderCreationFailed
    }
    return outputFolder
  }
  
  func clearFolder(at path: String) throws {
    let mainFolder = URL(fileURLWithPath: path)
    guard fileManagerProvider.manager.fileExists(atPath: mainFolder.path) else { return }
    
    do {
      try fileManagerProvider.manager.removeItem(at: mainFolder)
    } catch {
      throw DirectoryOperationError.clearFolderFailed
    }
  }
}

extension DirectoryOperator {
  static func makeDefault(fileManagerProvider: DefaultFileManager = .init()) -> DirectoryOperator {
    return DirectoryOperator(fileManagerProvider: fileManagerProvider)
  }
}
