import Foundation

public protocol Logger {
  func log(_ message: String, level: LogLevel)
}
