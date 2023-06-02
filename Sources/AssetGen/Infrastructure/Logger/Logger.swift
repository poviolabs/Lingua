import Foundation

protocol Logger {
  func log(_ message: String, level: LogLevel)
}
