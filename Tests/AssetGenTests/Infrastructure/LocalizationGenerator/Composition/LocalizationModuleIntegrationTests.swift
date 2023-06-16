import XCTest
@testable import AssetGen

final class LocalizationModuleIntegrationTests: XCTestCase {
  func test_LocalizationModule_createsIOSFilesInTemporaryDirectory() async throws {
    try await test_LocalizationModule_createsFilesInTemporaryDirectory(platform: .ios,
                                                                       expectedFiles: ["General.strings",
                                                                                       "General.stringsdict",
                                                                                       "Lingua.swift"])
  }
  
  func test_LocalizationHandler_createsAndroidFilesInTemporaryDirectory() async throws {
    try await test_LocalizationModule_createsFilesInTemporaryDirectory(platform: .android,
                                                                       expectedFiles: ["\(String.packageName)-General.xml",
                                                                                       "\(String.packageName)-General-plural.xml"])
  }
}

private extension LocalizationModuleIntegrationTests {
  func test_LocalizationModule_createsFilesInTemporaryDirectory(platform: LocalizationPlatform,
                                                                expectedFiles: [String]) async throws {
    // Prepare temporary directory and configuration.
    let tempDirectoryURL = try prepareTemporaryDirectory()
    
    // Create a config for localization
    let folderName = platform.folderName(for: "en")
    let outputSwiftCodeFileDirectory = tempDirectoryURL.appendingPathComponent(folderName).path
    let localizedSwiftCode = AssetGenConfig.LocalizedSwiftCode(stringsDirectory: tempDirectoryURL.path,
                                                               outputSwiftCodeFileDirectory: outputSwiftCodeFileDirectory)
    let config = AssetGenConfig.Localization(apiKey: "key",
                                             sheetId: "id",
                                             outputDirectory: tempDirectoryURL.path,
                                             localizedSwiftCode: localizedSwiftCode)
    
    // Create a mock SheetDataLoader that uses the test configuration.
    let mockSheetDataLoader: (AssetGenConfig.Localization) -> SheetDataLoader = { config in
      let data = [LocalizationSheet(language: "en",
                                    entries: [
                                      LocalizationEntry.create(section: "General", key: "key_general", plural: false),
                                      LocalizationEntry.create(section: "General", key: "key_general", plural: true)
                                    ])]
      return MockSheetDataLoader(loadSheetsResult: .success(data))
    }
    
    // Build a LocalizationModule instance with the mock objects.
    let localizationModule = LocalizationModule(config: config, makeSheetDataLoader: mockSheetDataLoader)
    
    // Run the LocalizationModule to generate the files in the temporary directory.
    try await localizationModule.localize(for: platform)
    
    // Assert that the expected files are created.
    for fileName in expectedFiles {
      let fileURL = tempDirectoryURL.appendingPathComponent(folderName).appendingPathComponent(fileName)
      expectFileExists(at: fileURL)
    }
    
    // Delete the temporary directory after the test is completed.
    try FileManager.default.removeItem(at: tempDirectoryURL)
  }
  
  func prepareTemporaryDirectory() throws -> URL {
    let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString)
    try FileManager.default.createDirectory(at: tempDirectoryURL, withIntermediateDirectories: true, attributes: nil)
    
    return tempDirectoryURL
  }
  
  func expectFileExists(at fileURL: URL, file: StaticString = #filePath, line: UInt = #line) {
    XCTAssertTrue(FileManager.default.fileExists(atPath: fileURL.path), file: file, line: line)
  }
}
