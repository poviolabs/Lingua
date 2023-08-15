import Foundation

struct LocalizedFilesGeneratorFactory {
  static func make(localizationPlatform: LocalizationPlatform) -> LocalizedFilesGenerating {
    let contentGenerator = LocalizedContentGeneratorFactory.make(platform: localizationPlatform)
    
    let contentWriter = FileContentWriter()
    let filesCreator = ContentFileCreator(contentWriter: contentWriter)
    
    let fileNameGenerator = PlatformFilesNameGeneratorFactory.make(platform: localizationPlatform)
    
    let filesGenerator = LocalizedPlatformFilesGenerator(contentGenerator: contentGenerator,
                                                         filesCreator: filesCreator,
                                                         fileNameGenerator: fileNameGenerator)
    
    let directoryManager = DirectoryOperator.makeDefault()
    let fileCleanupStrategy = FileCleanupFactory.make(for: localizationPlatform)
    let generator = LocalizedFilesGenerator(directoryOperator: directoryManager,
                                            filesGenerator: filesGenerator,
                                            localizationPlatform: localizationPlatform,
                                            fileCleanup: fileCleanupStrategy)
    
    return generator
  }
}
