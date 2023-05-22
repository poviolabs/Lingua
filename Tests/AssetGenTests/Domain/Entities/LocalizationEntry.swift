import Foundation
@testable import AssetGen

extension LocalizationEntry {
  static func create(plural: Bool) -> LocalizationEntry {
    var translations = [PluralCategory.one.rawValue: "translationOne"]
    if plural {
      translations.updateValue("translationOther", forKey: PluralCategory.other.rawValue)
    }
    return LocalizationEntry(section: "section1",
                             key: "key1",
                             translations: translations)
  }
}
