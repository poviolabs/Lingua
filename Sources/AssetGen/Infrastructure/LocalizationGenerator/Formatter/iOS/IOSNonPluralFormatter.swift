import Foundation

struct IOSNonPluralFormatter: NonPluralFormatting {
  func format(key: String, value: String) -> String {
    "\"\(key)\" = \"\(value)\";"
  }
}
