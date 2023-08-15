import XCTest
@testable import LinguaLib

final class PlatformLocalizationGeneratorTests: XCTestCase {
  func test_generateLocalizationFiles_clearsFolderAndCreatesFiles() throws {
    let mockDirectoryOperator = MockDirectoryOperator()
    let mockGenerator = MockLocalizedFilesGenerator()
    let config = Config.Localization(apiKey: "key", sheetId: "id", outputDirectory: "/path", localizedSwiftCode: .none)
    let sheet = LocalizationSheet(language: "en", entries: [.create(plural: true)])
    let data: [LocalizationSheet] = [sheet]
    let sut = makeSUT(directoryOperator: mockDirectoryOperator, generator: mockGenerator)
    
    XCTAssertNoThrow(try sut.generateLocalizationFiles(data: data, config: config))
    
    XCTAssertTrue(mockDirectoryOperator.messages.isEmpty)
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
