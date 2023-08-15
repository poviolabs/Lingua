import XCTest
@testable import LinguaLib

final class AndroidPlatformFilesNameGeneratorTests: XCTestCase {
  func test_createContent_returnsAndroidFileNames() {
    let sut = makeSUT()
    let entries = [LocalizationEntry.create(plural: true)]
    let section = "test_section"
    let mockContentGenerator = MockLocalizedContentGenerator()
    mockContentGenerator.content = ("non_plural", "plural")
    
    let fileInfos = sut.createContent(for: entries,
                                  sectionName: section,
                                  contentGenerator: mockContentGenerator)
    
    XCTAssertEqual(fileInfos.first?.0, "non_plural")
    XCTAssertEqual(fileInfos.first?.1, "\(String.packageName)-test_section.xml")
    XCTAssertEqual(fileInfos.last?.0, "plural")
    XCTAssertEqual(fileInfos.last?.1, "\(String.packageName)-test_section-plural.xml")
  }
}

extension AndroidPlatformFilesNameGeneratorTests {
  func makeSUT() -> AndroidPlatformFilesNameGenerator {
    AndroidPlatformFilesNameGenerator()
  }
}
