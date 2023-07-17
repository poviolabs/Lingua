import Foundation
@testable import Lingua

class MockDirectoryOperator: DirectoryOperable {
  enum Message: Equatable {
    case createDirectory(named: String, directory: String)
    case removeFiles(prefix: String, directory: URL)
    case removeAllFiles(directory: URL)
  }
  
  private(set) var messages = [Message]()
  var url: URL = .anyURL()
  
  func createDirectory(named: String, in outputDirectory: String) throws -> URL {
    messages.append(.createDirectory(named: named, directory: outputDirectory))
    return url
  }
  
  func removeFiles(withPrefix prefix: String, in directory: URL) throws {
    messages.append(.removeFiles(prefix: prefix, directory: directory))
  }
  
  func removeAllFiles(in directory: URL) throws {
    messages.append(.removeAllFiles(directory: directory))
  }
}
