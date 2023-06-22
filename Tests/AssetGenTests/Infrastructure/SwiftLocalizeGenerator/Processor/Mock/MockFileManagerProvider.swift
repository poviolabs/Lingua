import Foundation
@testable import AssetGen

class MockFileManagerProvider: FileManagerProvider {
  var manager: FileManager
  
  init(fileManagerMock: FileManager) {
    self.manager = fileManagerMock
  }
  
  var fileManager: FileManager {
    manager
  }
}
