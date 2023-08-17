import XCTest
@testable import LinguaLib

final class LocalizedFilesGeneratorTests: XCTestCase {
  func test_generate_callsExpectedMethods_forAndroidPlatform() throws {
    let directoryOperator = MockDirectoryOperator()
    let filesGenerator = MockPlatformFilesGenerator()
    let localizationPlatform = LocalizationPlatform.android
    
    let sut = LocalizedFilesGenerator(
      directoryOperator: directoryOperator,
      filesGenerator: filesGenerator,
      localizationPlatform: localizationPlatform,
      fileCleanup: FileCleanupFactory.make(for: localizationPlatform)
    )
    
    let sheet = LocalizationSheet(language: "en", entries: [LocalizationEntry.create(plural: true)])
    let config = Config.Localization(apiKey: "key", sheetId: "id", outputDirectory: "path", localizedSwiftCode: .none)
    let outputDirectoryURL = try XCTUnwrap(URL(string: config.outputDirectory))
    directoryOperator.url = outputDirectoryURL
    
    try sut.generate(for: sheet, config: config)
    
    XCTAssertEqual(directoryOperator.messages,
                   [.createDirectory(named: localizationPlatform.folderName(for: sheet.languageCode),
                                     directory: config.outputDirectory),
                    .removeFiles(prefix: "Lingua", directory: outputDirectoryURL)])
  }
  
  func test_generate_callsExpectedMethods_forIOSPlatform() throws {
    let directoryOperator = MockDirectoryOperator()
    let filesGenerator = MockPlatformFilesGenerator()
    let localizationPlatform = LocalizationPlatform.ios
    
    let sut = LocalizedFilesGenerator(
      directoryOperator: directoryOperator,
      filesGenerator: filesGenerator,
      localizationPlatform: localizationPlatform,
      fileCleanup: FileCleanupFactory.make(for: localizationPlatform)
    )
    
    let sheet = LocalizationSheet(language: "en", entries: [LocalizationEntry.create(plural: true)])
    let config = Config.Localization(apiKey: "key", sheetId: "id", outputDirectory: "path", localizedSwiftCode: .none)
    let outputDirectoryURL = try XCTUnwrap(URL(string: config.outputDirectory))
    directoryOperator.url = outputDirectoryURL
    
    try sut.generate(for: sheet, config: config)
    
    XCTAssertEqual(directoryOperator.messages,
                   [.createDirectory(named: localizationPlatform.folderName(for: sheet.languageCode),
                                     directory: config.outputDirectory),
                    .removeAllFiles(directory: outputDirectoryURL)])
  }
}
