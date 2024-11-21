import Foundation

final class PlatformLocalizationGenerator: PlatformLocalizationGenerating {
  private let directoryOperator: DirectoryOperable
  private let localizedFileGenerator: LocalizedFilesGenerating
  
  init(directoryOperator: DirectoryOperable = DirectoryOperator.makeDefault(),
       localizedFileGenerator: LocalizedFilesGenerating) {
    self.directoryOperator = directoryOperator
    self.localizedFileGenerator = localizedFileGenerator
  }
  
  func generateLocalizationFiles(data: [LocalizationSheet], config: Config.Localization) throws {
    try data.forEach { data in
      do {
        try localizedFileGenerator.generate(for: data, config: config)
      } catch {
        throw error
      }
    }
  }
}
