import XCTest
@testable import AssetGen

final class LocalizationModuleTests: XCTestCase {
  private let config: AssetGenConfig.Localization = .make()
  
  func test_localize_composesDependenciesCorrectly() async throws {
    let mockSheetDataLoader = MockSheetDataLoader(loadSheetsResult: .success(sheetData))
    let mockPlatformLocalizationGenerator = MockPlatformLocalizationGenerator()
    
    let sut = makeSUT(config: config,
                      makeSheetDataLoader: { _ in mockSheetDataLoader },
                      makePlatformGenerator: { _ in mockPlatformLocalizationGenerator })
    try await sut.localize(for: .ios)
    
    XCTAssertEqual(mockSheetDataLoader.messages, sheetData)
    XCTAssertEqual(mockPlatformLocalizationGenerator.messages, [.generate(data: sheetData, config: config)])
  }
  
  func test_localize_throwsSheetLoadingError() async {
    let error = NSError.anyError()
    let mockSheetDataLoader = MockSheetDataLoader(loadSheetsResult: .failure(error))
    let mockPlatformLocalizationGenerator = MockPlatformLocalizationGenerator()
    
    let sut = makeSUT(config: config,
                      makeSheetDataLoader: { _ in mockSheetDataLoader },
                      makePlatformGenerator: { _ in mockPlatformLocalizationGenerator })
    
    do {
      try await sut.localize(for: .ios)
      XCTFail("Expected localize to throw error")
    } catch {
      XCTAssertEqual(error as NSError, error as NSError)
    }
    XCTAssertTrue(mockPlatformLocalizationGenerator.messages.isEmpty)
  }
  
  func test_localize_throwsPlatformGeneratorError() async {
    let mockSheetDataLoader = MockSheetDataLoader(loadSheetsResult: .success(sheetData))
    let mockPlatformLocalizationGenerator = MockPlatformLocalizationGenerator(shouldThrowError: true)
    
    let sut = makeSUT(config: config,
                      makeSheetDataLoader: { _ in mockSheetDataLoader },
                      makePlatformGenerator: { _ in mockPlatformLocalizationGenerator })
    
    do {
      try await sut.localize(for: .ios)
      XCTFail("Expected localize to throw error")
    } catch {
      XCTAssertEqual(error as NSError, error as NSError)
    }
    XCTAssertTrue(mockPlatformLocalizationGenerator.messages.isEmpty)
  }
}

private extension LocalizationModuleTests {
  var sheetData: [LocalizationSheet] {
    [LocalizationSheet(language: "en", entries: [LocalizationEntry.create(plural: true)])]
  }
  
  func makeSUT(config: AssetGenConfig.Localization,
               makeSheetDataLoader: @escaping (AssetGenConfig.Localization) -> SheetDataLoader,
               makePlatformGenerator: @escaping (LocalizationPlatform) -> PlatformLocalizationGenerating
  ) -> LocalizationModule {
    LocalizationModule(config: config,
                       makeSheetDataLoader: makeSheetDataLoader,
                       makePlatformGenerator: makePlatformGenerator)
  }
}
