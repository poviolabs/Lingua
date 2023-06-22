import Foundation
@testable import Lingua

class MockFileManagerProvider: FileManagerProvider {
  var manager: FileManager
  
  init(fileManagerMock: FileManager) {
    self.manager = fileManagerMock
  }
  
  var fileManager: FileManager {
    manager
  }
}
