import Foundation
@testable import AssetGen

class MockContentWriter: ContentWritable {
  private(set) var writtenContent: (content: String, destinationURL: URL)?
  
  func write(_ content: String, to destinationURL: URL) throws {
    writtenContent = (content, destinationURL)
  }
}
