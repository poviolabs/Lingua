import Foundation

struct PlatformLocalizationGeneratorFactory {
  static func make(for platform: LocalizationPlatform) -> PlatformLocalizationGenerating {
    let localizedFileGenerator = LocalizedFilesGeneratorFactory.make(localizationPlatform: platform)
    return PlatformLocalizationGenerator(localizedFileGenerator: localizedFileGenerator)
  }
}
