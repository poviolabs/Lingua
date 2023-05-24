import Foundation
@testable import AssetGen

class MockDirectoryOperator: DirectoryOperable {
  enum Message: Equatable {
    case createDirectory(String, String)
    case clearFolder(String)
  }
  
  private(set) var messages = [Message]()
  var url: URL = .anyURL()
  
  func createDirectory(named: String, in outputDirectory: String) throws -> URL {
    messages.append(.createDirectory(named, outputDirectory))
    return url
  }
  
  func clearFolder(at path: String) throws {
    messages.append(.clearFolder(path))
  }
}
