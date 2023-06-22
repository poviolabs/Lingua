import XCTest
@testable import Lingua

final class LocalizationModuleTests: XCTestCase {
  private let config: ToolConfig.Localization = .make(localizedSwiftCode: .init(stringsDirectory: "path",
                                                                                    outputSwiftCodeFileDirectory: "path"))
  
  func test_localize_invokesCorrectMethodsOfDependencies() async throws {
    let mockSheetDataLoader = MockSheetDataLoader(loadSheetsResult: .success(sheetData))
    let mockPlatformLocalizationGenerator = MockPlatformLocalizationGenerator()
    let mockLocalizedSwiftCodeGenerator = MockLocalizedSwiftCodeGenerator()
    
    let sut = makeSUT(config: config,
                      makeSheetDataLoader: { _ in mockSheetDataLoader },
                      makePlatformGenerator: { _ in mockPlatformLocalizationGenerator },
                      makeLocalizedFileGenerator: { _ in mockLocalizedSwiftCodeGenerator })
    try await sut.localize(for: .ios)
    
    XCTAssertEqual(mockSheetDataLoader.messages, sheetData)
    XCTAssertEqual(mockPlatformLocalizationGenerator.messages, [.generate(data: sheetData, config: config)])
    XCTAssertEqual(mockLocalizedSwiftCodeGenerator.messages,
                   [.path(path: config.localizedSwiftCode?.stringsDirectory,
                          outputPath: config.localizedSwiftCode?.outputSwiftCodeFileDirectory)])
  }
  
  func test_localize_throwsError_onLoadSheetsFailure() async {
    let error = NSError.anyError()
    let mockSheetDataLoader = MockSheetDataLoader(loadSheetsResult: .failure(error))
    let mockPlatformLocalizationGenerator = MockPlatformLocalizationGenerator()
    let mockLocalizedSwiftCodeGenerator = MockLocalizedSwiftCodeGenerator()
    
    let sut = makeSUT(config: config,
                      makeSheetDataLoader: { _ in mockSheetDataLoader },
                      makePlatformGenerator: { _ in mockPlatformLocalizationGenerator },
                      makeLocalizedFileGenerator: { _ in mockLocalizedSwiftCodeGenerator })
    
    do {
      try await sut.localize(for: .ios)
      XCTFail("Expected localize to throw error")
    } catch {
      XCTAssertEqual(error as NSError, error as NSError)
    }
    XCTAssertTrue(mockPlatformLocalizationGenerator.messages.isEmpty)
    XCTAssertTrue(mockLocalizedSwiftCodeGenerator.messages.isEmpty)
  }
  
  func test_localize_throwsError_onGenerateLocalizationFilesFailure() async {
    let mockSheetDataLoader = MockSheetDataLoader(loadSheetsResult: .success(sheetData))
    let mockPlatformLocalizationGenerator = MockPlatformLocalizationGenerator(shouldThrowError: true)
    let mockLocalizedSwiftCodeGenerator = MockLocalizedSwiftCodeGenerator()
    
    let sut = makeSUT(config: config,
                      makeSheetDataLoader: { _ in mockSheetDataLoader },
                      makePlatformGenerator: { _ in mockPlatformLocalizationGenerator },
                      makeLocalizedFileGenerator: { _ in mockLocalizedSwiftCodeGenerator })
    
    do {
      try await sut.localize(for: .ios)
      XCTFail("Expected localize to throw error")
    } catch {
      XCTAssertEqual(error as NSError, error as NSError)
    }
    XCTAssertTrue(mockPlatformLocalizationGenerator.messages.isEmpty)
    XCTAssertTrue(mockLocalizedSwiftCodeGenerator.messages.isEmpty)
  }
}

private extension LocalizationModuleTests {
  var sheetData: [LocalizationSheet] {
    [LocalizationSheet(language: "en", entries: [LocalizationEntry.create(plural: true)])]
  }
  
  func makeSUT(config: ToolConfig.Localization,
               makeSheetDataLoader: @escaping (ToolConfig.Localization) -> SheetDataLoader,
               makePlatformGenerator: @escaping (LocalizationPlatform) -> PlatformLocalizationGenerating,
               makeLocalizedFileGenerator: @escaping (LocalizationPlatform) -> LocalizedCodeFileGenerating
  ) -> LocalizationModule {
    LocalizationModule(config: config,
                       makeSheetDataLoader: makeSheetDataLoader,
                       makePlatformGenerator: makePlatformGenerator,
                       makeLocalizedFileGenerator: makeLocalizedFileGenerator)
  }
}
