import Foundation

extension Data {
  static func anyData(string: String = "any data") -> Data {
    Data(string.utf8)
  }
}
