import Foundation

struct LocalizationEntry: Equatable {
  let section: String
  let key: String
  let plural: Bool
  let translations: [String: String]
}
