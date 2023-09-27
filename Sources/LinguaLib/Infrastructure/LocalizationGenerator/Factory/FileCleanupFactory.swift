import Foundation

struct FileCleanupFactory {
  static func make(for localizationPlatform: LocalizationPlatform) -> FileCleanupStrategy {
    switch localizationPlatform {
    case .ios:
      return IOSFileCleanupStrategy()
    case .android:
      return AndroidFileCleanupStrategy()
    }
  }
}
