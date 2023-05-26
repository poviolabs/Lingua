import Foundation

struct LocalizedContentGeneratorFactory {
  static func make(platform: LocalizationPlatform) -> LocalizedContentGenerating {
    switch platform {
    case .ios:
      return LocalizedContentGenerator(nonPluralOutputGenerator: NonPluralContentFormatter(formatter: IOSNonPluralFormatter()),
                                       pluralOutputGenerator: PluralContentFormatter(formatter: IOSPluralFormatter()))
    }
  }
}
