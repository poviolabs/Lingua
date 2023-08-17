import XCTest
@testable import LinguaLib

final class LocalizationPlatformTests: XCTestCase {
  func test_folderName_returnsCorrectIOSFolderName() {
    let localizationPlatform = LocalizationPlatform.ios
    let languageCode = "en"
    XCTAssertEqual(localizationPlatform.folderName(for: languageCode), "\(languageCode).lproj")
  }
  
  func test_folderName_returnsCorrectAndroidFolderName() {
    let localizationPlatform = LocalizationPlatform.android
    XCTAssertEqual(localizationPlatform.folderName(for: "en"), "values")
    XCTAssertEqual(localizationPlatform.folderName(for: "de"), "values-de")
  }
}
