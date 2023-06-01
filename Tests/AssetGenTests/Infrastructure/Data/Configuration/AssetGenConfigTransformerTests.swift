import XCTest
@testable import AssetGen

final class AssetGenConfigTransformerTest: XCTestCase {
  func test_transform_mapsAssetGenConfigDto_toEntity() throws {
    let dto = AssetGenConfigDto(localization: .init(apiKey: "key", sheetId: "id", outputDirectory: "path"))
    let sut = AssetGenConfigTransformer()
    
    let entity = try sut.transform(dto)
    
    XCTAssertEqual(dto.localization?.apiKey, entity.localization?.apiKey)
    XCTAssertEqual(dto.localization?.sheetId, entity.localization?.sheetId)
    XCTAssertEqual(dto.localization?.outputDirectory, entity.localization?.outputDirectory)
  }
}
