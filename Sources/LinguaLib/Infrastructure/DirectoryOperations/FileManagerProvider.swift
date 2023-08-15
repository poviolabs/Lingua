import Foundation

public protocol FileManagerProvider {
  var manager: FileManager { get }
}

public final class DefaultFileManager: FileManagerProvider {
  public var manager: FileManager
  
  public init(manager: FileManager = .default) {
    self.manager = manager
  }
}
