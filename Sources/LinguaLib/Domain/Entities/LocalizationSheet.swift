import Foundation

public struct LocalizationSheet: Equatable {
  let language: String
  let entries: [LocalizationEntry]
}

extension LocalizationSheet {
  var languageCode: String {
    String(language.prefix(2))
  }
}
