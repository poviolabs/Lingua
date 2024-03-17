import Foundation

final class LocalizedFilesGenerator {
  private let directoryOperator: DirectoryOperable
  private let filesGenerator: PlatformFilesGenerating
  private let localizationPlatform: LocalizationPlatform
  private let fileCleanup: FileCleanupStrategy
  
  init(directoryOperator: DirectoryOperable,
       filesGenerator: PlatformFilesGenerating,
       localizationPlatform: LocalizationPlatform,
       fileCleanup: FileCleanupStrategy) {
    self.directoryOperator = directoryOperator
    self.filesGenerator = filesGenerator
    self.localizationPlatform = localizationPlatform
    self.fileCleanup = fileCleanup
  }
}

extension LocalizedFilesGenerator: LocalizedFilesGenerating {
  func generate(for sheet: LocalizationSheet, config: Config.Localization) throws {
    let languageCode = sheet.languageCode
    let folderName = localizationPlatform.folderName(for: languageCode)
    let outputFolder = try directoryOperator.createDirectory(named: folderName, in: config.outputDirectory)
    try fileCleanup.removeFiles(using: directoryOperator, in: outputFolder)
    
    let sections = Dictionary(grouping: sheet.entries, by: { $0.section })
    
    for (sectionName, sectionEntries) in sections {
      if let allowedSections = config.allowedSections,
          !allowedSections.contains(where: { $0.lowercased() == sectionName.lowercased() }) {
        continue
      }
      try filesGenerator.createPlatformFiles(for: sectionEntries,
                                             sectionName: sectionName.formatSheetSection(),
                                             outputFolder: outputFolder,
                                             language: sheet.language)
    }
  }
}
