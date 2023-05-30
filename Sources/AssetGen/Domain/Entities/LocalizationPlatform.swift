import Foundation

enum LocalizationPlatform: String {
  case ios
  case android
}

extension LocalizationPlatform {
  func folderName(for languageCode: String) -> String {
    switch self {
    case .ios:
      return "\(languageCode).lproj"
    case .android:
      return "values-\(languageCode)"
    }
  }
}
