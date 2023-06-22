import Foundation

struct LocalizedSwiftFileGeneratorFactory {
  static func make() -> LocalizedCodeFileGenerating {
    let fileProcessor: MergableFileProcessor = FileSectionAndTranslationProcessor()
    let contentFileCreator: ContentFileCreatable = ContentFileCreator()
    let outputStringBuilder: LocalizedSwiftCodeOutputStringBuilder = DefaultLocalizedSwiftCodeOutputStringBuilder()
    let logger: Logger = ConsoleLogger.shared
    let fileName: String = .swiftLocalizedName
    
    let generator = SwiftLocalizedCodeFileGenerator(fileProcessor: fileProcessor,
                                                    contentFileCreator: contentFileCreator,
                                                    outputStringBuilder: outputStringBuilder,
                                                    logger: logger,
                                                    fileName: fileName)
    
    return generator
  }
  
  static func make(platform: LocalizationPlatform) -> LocalizedCodeFileGenerating {
    switch platform {
    case .ios:
      return LocalizedSwiftFileGeneratorFactory.make()
    case .android:
      return NullLocalizedCodeFileGenerator()
    }
  }
}
