import Foundation

struct PlatformFilesNameGeneratorFactory {
  static func make(platform: LocalizationPlatform) -> PlatformFilesNameGenerating {
    switch platform {
    case .ios:
      return IOSPlatformFilesNameGenerator()
    }
  }
}
