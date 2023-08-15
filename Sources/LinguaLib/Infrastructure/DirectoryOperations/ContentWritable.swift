import Foundation

public protocol ContentWritable {
  func write(_ content: String, to url: URL) throws
}

public final class FileContentWriter: ContentWritable {
  public init() { }
  
  public func write(_ content: String, to url: URL) throws {
    try content.write(to: url, atomically: true, encoding: .utf8)
  }
}
