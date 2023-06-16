import XCTest
@testable import AssetGen

final class SwiftLocalizedCodeFileGeneratorTests: XCTestCase {
  func test_generate_callsDependenciesInCorrectOrder() {
    let mockLogger = MockLogger()
    let mockContentFilesCreator = MockContentFilesCreator()
    let sut = makeSUT(mockLogger: mockLogger,
                      mockContentFilesCreator: mockContentFilesCreator)
    
    sut.generate(from: "inputPath", outputPath: "outputPath")
    
    XCTAssertEqual(mockLogger.messages, [.message(message: "Created \(String.swiftLocalizedName) file", level: .success)])
    XCTAssertEqual(mockContentFilesCreator.writtenContent.count, 1)
    XCTAssertEqual(mockContentFilesCreator.writtenContent.first?.key, .swiftLocalizedName)
  }
  
  func test_generate_printsErrorOnCreateFilesFailure() {
    let mockLogger = MockLogger()
    let mockContentFilesCreator = MockContentFilesCreator()
    mockContentFilesCreator.shouldThrowError = true
    let sut = makeSUT(mockLogger: mockLogger,
                      mockContentFilesCreator: mockContentFilesCreator)
    
    sut.generate(from: "inputPath", outputPath: "outputPath")
    
    XCTAssertEqual(mockLogger.messages,
                   [.message(message: DirectoryOperationError.folderCreationFailed.errorDescription ?? "", level: .error)])
  }
}

private extension SwiftLocalizedCodeFileGeneratorTests {
  func makeSUT(
    mockFileProcessor: MergableFileProcessor = FileSectionAndTranslationProcessor(),
    mockLogger: Logger = MockLogger(),
    mockContentFilesCreator: ContentFileCreatable = MockContentFilesCreator(),
    mockOutputStringBuilder: LocalizedSwiftCodeOutputStringBuilder = MockLocalizedSwiftCodeOutputStringBuilder()
  ) -> SwiftLocalizedCodeFileGenerator {
    SwiftLocalizedCodeFileGenerator(fileProcessor: mockFileProcessor,
                                    contentFileCreator: mockContentFilesCreator,
                                    outputStringBuilder: mockOutputStringBuilder,
                                    logger: mockLogger,
                                    fileName: .swiftLocalizedName)
  }
}
