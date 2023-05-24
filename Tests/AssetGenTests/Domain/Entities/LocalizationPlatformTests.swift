import XCTest
@testable import AssetGen

final class LocalizationPlatformTests: XCTestCase {
  func test_folderName_returnsCorrectIOSFolderName() {
    let localizationPlatform = LocalizationPlatform.ios
    let languageCode = "en"
    XCTAssertEqual(localizationPlatform.folderName(for: languageCode), "en.lproj")
  }
}
