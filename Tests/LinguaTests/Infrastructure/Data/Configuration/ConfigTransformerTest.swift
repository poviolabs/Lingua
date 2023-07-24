import XCTest
@testable import Lingua

final class ConfigTransformerTest: XCTestCase {
  func test_transform_mapsConfigDto_toEntity() throws {
    let dto = ConfigDto(localization: .init(apiKey: "key",
                                                sheetId: "id",
                                                outputDirectory: "path",
                                                swiftCode: .init(stringsDirectory: "test",
                                                                 outputSwiftCodeFileDirectory: "test_ouput")))
    let sut = ConfigDtoTransformer()
    
    let entity = try sut.transform(dto)
    
    XCTAssertEqual(dto.localization?.apiKey, entity.localization?.apiKey)
    XCTAssertEqual(dto.localization?.sheetId, entity.localization?.sheetId)
    XCTAssertEqual(dto.localization?.outputDirectory, entity.localization?.outputDirectory)
    XCTAssertEqual(dto.localization?.swiftCode?.stringsDirectory, entity.localization?.localizedSwiftCode?.stringsDirectory)
    XCTAssertEqual(dto.localization?.swiftCode?.outputSwiftCodeFileDirectory,
                   entity.localization?.localizedSwiftCode?.outputSwiftCodeFileDirectory)
  }
  
  func test_transform_mapsConfigDto_toEntity_whenSwiftCodeIsMissing() throws {
    let dto = ConfigDto(localization: .init(apiKey: "key", sheetId: "id", outputDirectory: "path", swiftCode: .none))
    let sut = ConfigDtoTransformer()
    
    let entity = try sut.transform(dto)
    
    XCTAssertEqual(dto.localization?.apiKey, entity.localization?.apiKey)
    XCTAssertEqual(dto.localization?.sheetId, entity.localization?.sheetId)
    XCTAssertEqual(dto.localization?.outputDirectory, entity.localization?.outputDirectory)
    XCTAssertNil(entity.localization?.localizedSwiftCode)
  }
}
