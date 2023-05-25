import XCTest
@testable import AssetGen

final class PlatformLocalizationGeneratorTests: XCTestCase {
  func test_generateLocalizationFiles_clearsFolderAndCreatesFiles() {
    let mockDirectoryOperator = MockDirectoryOperator()
    let mockGenerator = MockLocalizedFilesGenerator()
    let config = AssetGenConfig.Localization(apiKey: "key", sheetId: "id", outputDirectory: "/path")
    let sheet = LocalizationSheet(language: "en", entries: [.create(plural: true)])
    let data: [LocalizationSheet] = [sheet]
    let sut = makeSUT(directoryOperator: mockDirectoryOperator, generator: mockGenerator)
    
    XCTAssertNoThrow(try sut.generateLocalizationFiles(data: data, config: config))
    
    XCTAssertEqual(mockDirectoryOperator.messages, [.clearFolder(config.outputDirectory)])
    XCTAssertEqual(mockGenerator.messages, [.generate(sheet: sheet, config: config)])
  }
}

private extension PlatformLocalizationGeneratorTests {
  func makeSUT(
    directoryOperator: DirectoryOperable,
    generator: LocalizedFilesGenerating
  ) -> PlatformLocalizationGenerator {
    PlatformLocalizationGenerator(directoryOperator: directoryOperator, localizedFileGenerator: generator)
  }
}
