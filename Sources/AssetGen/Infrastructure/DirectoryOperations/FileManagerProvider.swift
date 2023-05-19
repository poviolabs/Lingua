import Foundation

protocol FileManagerProvider {
  var fileManager: FileManager { get }
}

final class DefaultFileManager: FileManagerProvider {
  var fileManager: FileManager
  
  init(fileManager: FileManager = .default) {
    self.fileManager = fileManager
  }
}
