import XCTest
@testable import AssetGen

final class LocalizedSwiftCodeGeneratorTests: XCTestCase {
  func test_generateCode_createsFunctionCode_whenUsingStringFormatSpecifiers() {
    let sut = makeSUT()
    let code = sut.generateCode(section: "section", key: "key", translation: "translation %d %@")
    let expectedCode = """
         \tstatic func key(_ param1: Int, _ param2: String) -> String {
         \t\treturn tr("section", "key", param1, param2)
         }
         """
    XCTAssertEqual(code, expectedCode)
  }
  
  func test_generateCode_createsStaticPropertyCode_forNoStringFormatSpecifiers() {
    let sut = makeSUT()
    let code = sut.generateCode(section: "section", key: "key", translation: "translation")
    XCTAssertEqual(code, "\tstatic let key = tr(\"section\", \"key\")")
  }
}

private extension LocalizedSwiftCodeGeneratorTests {
  private func makeSUT() -> LocalizedSwiftCodeGenerator {
    LocalizedSwiftCodeGenerator()
  }
}
