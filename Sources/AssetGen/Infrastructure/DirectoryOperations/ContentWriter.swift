import Foundation

protocol ContentWriter {
  func write(_ content: String, to url: URL) throws
}

final class DefaultContentWriter: ContentWriter {
  func write(_ content: String, to url: URL) throws {
    try content.write(to: url, atomically: true, encoding: .utf8)
  }
}
