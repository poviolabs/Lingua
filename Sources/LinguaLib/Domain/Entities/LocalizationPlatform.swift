import Foundation

public enum LocalizationPlatform: String {
  case ios
  case android
}

extension LocalizationPlatform {
  func folderName(for languageCode: String) -> String {
    switch self {
    case .ios:
      return "\(languageCode).lproj"
    case .android:
      return androidFolderName(for: languageCode)
    }
  }
  
  private func androidFolderName(for languageCode: String) -> String {
    let defaultLanguageCode = "en"
    
    guard languageCode != defaultLanguageCode else {
      return "values"
    }
    
    return "values-\(languageCode)"
  }
}
