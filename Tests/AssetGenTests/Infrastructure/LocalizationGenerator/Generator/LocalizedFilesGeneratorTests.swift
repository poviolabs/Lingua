import XCTest
@testable import AssetGen

final class LocalizedFilesGeneratorTests: XCTestCase {
  func test_generate_callsExpectedMethods() throws {
    let directoryOperator = MockDirectoryOperator()
    let filesGenerator = MockPlatformFilesGenerator()
    let localizationPlatform = LocalizationPlatform.ios
    
    let sut = LocalizedFilesGenerator(
      directoryOperator: directoryOperator,
      filesGenerator: filesGenerator,
      localizationPlatform: localizationPlatform
    )
    
    let sheet = LocalizationSheet(language: "en", entries: [LocalizationEntry.create(plural: true)])
    let config = AssetGenConfig.Localization(apiKey: "key", sheetId: "id", outputDirectory: "path")
    let outputDirectoryURL = try XCTUnwrap(URL(string: config.outputDirectory))
    directoryOperator.url = outputDirectoryURL
    
    try sut.generate(for: sheet, config: config)
    
    XCTAssertEqual(directoryOperator.messages,
                   [.createDirectory(named: localizationPlatform.folderName(for: sheet.languageCode),
                                     directory: config.outputDirectory),
                    .removeFiles(prefix: "AssetGen", directory: outputDirectoryURL)])
  }
}
