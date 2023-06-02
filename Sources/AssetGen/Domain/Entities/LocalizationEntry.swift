import Foundation

struct LocalizationEntry: Equatable {
  let section: String
  let key: String
  let translations: [String: String]
  
  var plural: Bool {
    translations.count > 1
  }
}
