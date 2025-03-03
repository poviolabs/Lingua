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
    guard !directoryName.isEmpty else {
      throw DirectoryOperationError.folderCreationFailed("Directory name is empty.")
    }
    
    guard let decodedPath = outputDirectory.removingPercentEncoding else {
      throw DirectoryOperationError.folderCreationFailed("Invalid output directory path.")
    }
    
    let mainFolder = URL(fileURLWithPath: decodedPath)
    let outputFolder = mainFolder.appendingPathComponent(directoryName)
    
    do {
      try fileManagerProvider.manager.createDirectory(at: outputFolder, withIntermediateDirectories: true, attributes: nil)
    } catch let error as DirectoryOperationError {
      throw error
    } catch {
      throw DirectoryOperationError.folderCreationFailed(error.localizedDescription)
    }
    
    return outputFolder
  }
  
  public func removeFiles(withPrefix prefix: String, in directory: URL) throws {
    let fileManager = fileManagerProvider.manager
    
    let fileURLs = try fileManager.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
    
    for fileURL in fileURLs where fileURL.lastPathComponent.hasPrefix(prefix) {
      do {
        try fileManager.removeItem(at: fileURL)
      } catch let error as DirectoryOperationError {
        throw error
      } catch {
        throw DirectoryOperationError.removeItemFailed(error.localizedDescription)
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
        throw DirectoryOperationError.removeItemFailed(error.localizedDescription)
      }
    }
  }
}

extension DirectoryOperator {
  static func makeDefault(fileManagerProvider: DefaultFileManager = .init()) -> DirectoryOperator {
    DirectoryOperator(fileManagerProvider: fileManagerProvider)
  }
}
