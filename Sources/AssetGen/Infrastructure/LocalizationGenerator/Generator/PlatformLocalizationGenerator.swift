import Foundation

final class PlatformLocalizationGenerator: PlatformLocalizationGenerating {
  private let directoryOperator: DirectoryOperable
  private let localizedFileGenerator: LocalizedFilesGenerating
  
  init(directoryOperator: DirectoryOperable = DirectoryOperator.makeDefault(),
       localizedFileGenerator: LocalizedFilesGenerating) {
    self.directoryOperator = directoryOperator
    self.localizedFileGenerator = localizedFileGenerator
  }
  
  func generateLocalizationFiles(data: [LocalizationSheet], config: AssetGenConfig.Localization) throws {
    data.forEach { data in
      try? localizedFileGenerator.generate(for: data, config: config)
    }
  }
}
