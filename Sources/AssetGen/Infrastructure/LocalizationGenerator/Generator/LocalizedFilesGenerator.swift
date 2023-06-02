import Foundation

final class LocalizedFilesGenerator {
  private let directoryOperator: DirectoryOperable
  private let filesGenerator: PlatformFilesGenerating
  private let localizationPlatform: LocalizationPlatform
  
  init(directoryOperator: DirectoryOperable,
       filesGenerator: PlatformFilesGenerating,
       localizationPlatform: LocalizationPlatform) {
    self.directoryOperator = directoryOperator
    self.filesGenerator = filesGenerator
    self.localizationPlatform = localizationPlatform
  }
}

extension LocalizedFilesGenerator: LocalizedFilesGenerating {
  func generate(for sheet: LocalizationSheet, config: AssetGenConfig.Localization) throws {
    let languageCode = sheet.languageCode
    let folderName = localizationPlatform.folderName(for: languageCode)
    let outputFolder = try directoryOperator.createDirectory(named: folderName, in: config.outputDirectory)
    try directoryOperator.removeFiles(withPrefix: .packageName, in: outputFolder)
    
    let sections = Dictionary(grouping: sheet.entries, by: { $0.section })
    
    for (sectionName, sectionEntries) in sections {
      try filesGenerator.createPlatformFiles(for: sectionEntries,
                                             sectionName: sectionName.formatSheetSection(),
                                             outputFolder: outputFolder,
                                             language: sheet.language)
    }
  }
}
