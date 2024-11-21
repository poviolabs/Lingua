import XCTest
@testable import LinguaLib

final class LocalizedPlatformFilesGeneratorTests: XCTestCase {
  func test_createPlatformFiles_createsFilesSuccessfully() throws {
    let (contentGenerator, filesCreator) = makeContentGeneratorAndCreator(shouldFilesCreatorThrowError: .none)
    let fileExtension = "txt"
    let fileNameGenerator = MockPlatformFilesNameGenerator(fileExtension: fileExtension)
    let sut = makeSUT(contentGenerator: contentGenerator, filesCreator: filesCreator, fileNameGenerator: fileNameGenerator)
    let entries: [LocalizationEntry] = [.create(plural: true)]
    let outputFolder = URL(fileURLWithPath: NSTemporaryDirectory())
    
    try sut.createPlatformFiles(for: entries, sectionName: "SectionName", outputFolder: outputFolder, language: "en")
    
    XCTAssertEqual(contentGenerator.createdEntries, entries)
    XCTAssertEqual(filesCreator.writtenContent["SectionName.\(fileExtension)"], "stringsContent")
    XCTAssertEqual(filesCreator.writtenContent["SectionName-plural.\(fileExtension)"], "stringsDictContent")
  }
  
  func test_createPlatformFiles_throwsErrorAndLogsMessage_onCreateFilesFailure() {
    let (contentGenerator, filesCreator) = makeContentGeneratorAndCreator(shouldFilesCreatorThrowError: "Error_message")
    let sut = makeSUT(contentGenerator: contentGenerator, filesCreator: filesCreator)
    let entries: [LocalizationEntry] = [.create(plural: true)]
    let outputFolder = URL(fileURLWithPath: NSTemporaryDirectory())
    
    XCTAssertThrowsError(try sut.createPlatformFiles(for: entries,
                                                     sectionName: "SectionName",
                                                     outputFolder: outputFolder,
                                                     language: "en")) { error in
      XCTAssertEqual(error as? DirectoryOperationError, DirectoryOperationError.folderCreationFailed("Error_message"))
    }
  }
  
  func makeContentGeneratorAndCreator(
    shouldFilesCreatorThrowError: String?
  ) -> (contentGenerator: MockLocalizedContentGenerator, filesCreator: MockContentFilesCreator) {
    let contentGenerator = MockLocalizedContentGenerator()
    contentGenerator.content = ("stringsContent", "stringsDictContent")
    let filesCreator = MockContentFilesCreator()
    filesCreator.shouldThrowError = shouldFilesCreatorThrowError
    return (contentGenerator, filesCreator)
  }
}

private extension LocalizedPlatformFilesGeneratorTests {
  func makeSUT(contentGenerator: LocalizedContentGenerating = MockLocalizedContentGenerator(),
               filesCreator: ContentFileCreatable = MockContentFilesCreator(),
               fileNameGenerator: PlatformFilesNameGenerating = MockPlatformFilesNameGenerator()) -> LocalizedPlatformFilesGenerator {
    LocalizedPlatformFilesGenerator(contentGenerator: contentGenerator,
                                    filesCreator: filesCreator,
                                    fileNameGenerator: fileNameGenerator)
  }
}
