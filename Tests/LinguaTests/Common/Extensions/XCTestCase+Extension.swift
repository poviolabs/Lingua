import XCTest

extension XCTestCase {
  func createTemporaryFile(withContent content: String) throws -> URL {
    let temporaryDirectory = FileManager.default.temporaryDirectory
    let fileName = UUID().uuidString
    let fileURL = temporaryDirectory.appendingPathComponent(fileName)
    
    try content.write(to: fileURL, atomically: true, encoding: .utf8)
    
    return fileURL
  }
}
