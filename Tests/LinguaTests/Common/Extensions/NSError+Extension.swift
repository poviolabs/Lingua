import Foundation

extension NSError {
  static func anyError(domain: String = "any error", code: Int = 0) -> NSError {
    NSError(domain: domain, code: code)
  }
}
