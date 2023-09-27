import Foundation

public protocol DirectoryOperable {
  func createDirectory(named: String, in outputDirectory: String) throws -> URL
  func removeFiles(withPrefix prefix: String, in directory: URL) throws
  func removeAllFiles(in directory: URL) throws
}

public final class DirectoryOperator: DirectoryOperable {
  let fileManagerProvider: FileManagerProvider
  
  public init(fileManagerProvider: FileManagerProvider) {
    self.fileManagerProvider = fileManagerProvider
  }
  
  public func createDirectory(named directoryName: String, in outputDirectory: String) throws -> URL {
    let mainFolder = URL(fileURLWithPath: outputDirectory)
    let outputFolder = mainFolder.appendingPathComponent(directoryName)
    do {
      try fileManagerProvider.manager.createDirectory(at: outputFolder, withIntermediateDirectories: true, attributes: nil)
    } catch {
      throw DirectoryOperationError.folderCreationFailed
    }
    return outputFolder
  }
  
  public func removeFiles(withPrefix prefix: String, in directory: URL) throws {
    let fileManager = fileManagerProvider.manager
    
    let fileURLs = try fileManager.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
    
    for fileURL in fileURLs where fileURL.lastPathComponent.hasPrefix(prefix) {
      do {
        try fileManager.removeItem(at: fileURL)
      } catch {
        throw DirectoryOperationError.removeItemFailed
      }
    }
  }
  
  public func removeAllFiles(in directory: URL) throws {
    let fileManager = fileManagerProvider.manager
    
    let fileURLs = try fileManager.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
    
    for fileURL in fileURLs {
      do {
        try fileManager.removeItem(at: fileURL)
      } catch {
        throw DirectoryOperationError.removeItemFailed
      }
    }
  }
}

extension DirectoryOperator {
  static func makeDefault(fileManagerProvider: DefaultFileManager = .init()) -> DirectoryOperator {
    DirectoryOperator(fileManagerProvider: fileManagerProvider)
  }
}
