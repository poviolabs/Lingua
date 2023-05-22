import Foundation

protocol FileManagerProvider {
  var manager: FileManager { get }
}

final class DefaultFileManager: FileManagerProvider {
  var manager: FileManager
  
  init(manager: FileManager = .default) {
    self.manager = manager
  }
}
