import Foundation
@testable import AssetGen

struct MockNonPluralFormatter: NonPluralFormatting {
  func format(key: String, value: String) -> String {
    "\(key) = \(value)"
  }
}
