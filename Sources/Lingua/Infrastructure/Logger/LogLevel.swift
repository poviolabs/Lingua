import Foundation

enum LogLevel {
  case info
  case success
  case warning
  case error
}

extension LogLevel {
  var ANSIColor: String {
    switch self {
    case .info:
      return "\u{001B}[0;36mINFO"
    case .success:
      return "\u{001B}[0;32mSUCCESS"
    case .warning:
      return "\u{001B}[0;33mWARNING"
    case .error:
      return "\u{001B}[0;31mERROR"
    }
  }
}
