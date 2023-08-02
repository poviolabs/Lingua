import Foundation

struct LocalizedContentGeneratorFactory {
  static func make(platform: LocalizationPlatform) -> LocalizedContentGenerating {
    switch platform {
    case .ios:
      let stringEscaper = IOSStringEscaper()
      let nonPluralOutputGenerator = LocalizedOutputGenerator(placeholderMapper: IOSPlaceholderMapper(),
                                                              formatter: IOSNonPluralFormatter(),
                                                              stringEscaper: stringEscaper)
      let pluralOutputGenerator = LocalizedOutputGenerator(placeholderMapper: IOSPlaceholderMapper(),
                                                           formatter: IOSPluralFormatter(),
                                                           stringEscaper: stringEscaper)
      return LocalizedContentGenerator(nonPluralOutputGenerator: nonPluralOutputGenerator,
                                       pluralOutputGenerator: pluralOutputGenerator)
      
    case .android:
      let stringEscaper = AndroidStringEscaper()
      let nonPluralOutputGenerator = LocalizedOutputGenerator(placeholderMapper: AndroidPlaceholderMapper(),
                                                              formatter: AndroidNonPluralFormatter(),
                                                              stringEscaper: stringEscaper)
      let pluralOutputGenerator = LocalizedOutputGenerator(placeholderMapper: AndroidPlaceholderMapper(),
                                                           formatter: AndroidPluralFormatter(),
                                                           stringEscaper: stringEscaper)
      return LocalizedContentGenerator(nonPluralOutputGenerator: nonPluralOutputGenerator,
                                       pluralOutputGenerator: pluralOutputGenerator)
    }
  }
}
