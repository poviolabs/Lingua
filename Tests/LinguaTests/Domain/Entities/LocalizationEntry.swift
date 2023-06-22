import Foundation
@testable import Lingua

extension LocalizationEntry {
  static func create(section: String = "section1",
                     key: String = "key1",
                     plural: Bool) -> LocalizationEntry {
    var translations = [PluralCategory.one.rawValue: "translationOne"]
    if plural {
      translations.updateValue("translationOther", forKey: PluralCategory.other.rawValue)
    }
    return LocalizationEntry(section: section,
                             key: key,
                             translations: translations)
  }
}
