import Foundation

struct LocalizedContentGeneratorFactory {
  static func make(platform: LocalizationPlatform) -> LocalizedContentGenerating {
    switch platform {
    case .ios:
      let nonPluralOutputGenerator = LocalizedOutputGenerator(placeholderMapper: IOSPlaceholderMapper(),
                                                              formatter: IOSNonPluralFormatter())
      let pluralOutputGenerator = LocalizedOutputGenerator(placeholderMapper: IOSPlaceholderMapper(),
                                                           formatter: IOSPluralFormatter())
      return LocalizedContentGenerator(nonPluralOutputGenerator: nonPluralOutputGenerator,
                                       pluralOutputGenerator: pluralOutputGenerator)
    }
  }
}
