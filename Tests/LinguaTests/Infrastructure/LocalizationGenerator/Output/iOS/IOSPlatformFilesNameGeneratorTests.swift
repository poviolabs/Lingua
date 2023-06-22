import XCTest
@testable import Lingua

final class IOSPlatformFilesNameGeneratorTests: XCTestCase {
  func test_createContent_returnsIOSFileNames() {
    let sut = makeSUT()
    let entries = [LocalizationEntry.create(plural: true)]
    let section = "test_section"
    let mockContentGenerator = MockLocalizedContentGenerator()
    mockContentGenerator.content = ("non_plural", "plural")
    
    let fileInfos = sut.createContent(for: entries,
                                  sectionName: section,
                                  contentGenerator: mockContentGenerator)
    XCTAssertEqual(fileInfos.first?.0, "non_plural")
    XCTAssertEqual(fileInfos.first?.1, "test_section.strings")
    XCTAssertEqual(fileInfos.last?.0, "plural")
    XCTAssertEqual(fileInfos.last?.1, "test_section.stringsdict")
  }
}

extension IOSPlatformFilesNameGeneratorTests {
  func makeSUT() -> IOSPlatformFilesNameGenerator {
    IOSPlatformFilesNameGenerator()
  }
}
