import Foundation

extension URL {
  static func anyURL(string: String = "https://any-url.com") -> URL {
    URL(string: string)!
  }
}
