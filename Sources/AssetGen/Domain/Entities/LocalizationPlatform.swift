import Foundation

enum LocalizationPlatform: String {
  case ios
}

extension LocalizationPlatform {
  func folderName(for languageCode: String) -> String {
    switch self {
    case .ios:
      return "\(languageCode).lproj"
    }
  }
}
