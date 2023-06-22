import Foundation

protocol ContentWritable {
  func write(_ content: String, to url: URL) throws
}

final class FileContentWriter: ContentWritable {
  func write(_ content: String, to url: URL) throws {
    try content.write(to: url, atomically: true, encoding: .utf8)
  }
}
