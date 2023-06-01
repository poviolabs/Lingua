import XCTest
@testable import AssetGen

final class CommandLineParserTests: XCTestCase {
  private lazy var sut: CommandLineParser = {
    return makeSUT()
  }()
  
  func test_parse_returnsNotEnoughArgumentsError_forNotEnoughArguments() {
    let arguments = ["AssetGen"]
    
    XCTAssertThrowsError(try sut.parse(arguments: arguments)) { error in
      XCTAssertEqual(error as? CommandLineParsingError, .notEnoughArguments)
    }
  }
  
  func test_parse_returnsInvalidAssetGenerationTypeError_forInvalidAssetGenerationType() {
    let arguments = ["AssetGen", "invalid:ios", "config.json"]
    
    XCTAssertThrowsError(try sut.parse(arguments: arguments)) { error in
      XCTAssertEqual(error as? CommandLineParsingError, .invalidAssetGenerationType)
    }
  }
  
  func test_parse_returnsInvalidAssetGenerationTypeError_forInvalidAssetGenerationTypeAndPlaform() {
    let arguments = ["AssetGen", "", "config.json"]
    
    XCTAssertThrowsError(try sut.parse(arguments: arguments)) { error in
      XCTAssertEqual(error as? CommandLineParsingError, .invalidAssetGenerationType)
    }
  }
  
  func test_parse_returnsInvalidPlatformError_forInvalidPlatform() {
    let arguments = ["AssetGen", "localization:invalid", "config.json"]
    
    XCTAssertThrowsError(try sut.parse(arguments: arguments)) { error in
      XCTAssertEqual(error as? CommandLineParsingError, .invalidPlatform)
    }
  }
  
  func test_parse_returnsInvalidConfigFilePathError_forInvalidConfigFilePath() {
    let arguments = ["AssetGen", "localization:ios", "config.txt"]
    
    XCTAssertThrowsError(try sut.parse(arguments: arguments)) { error in
      XCTAssertEqual(error as? CommandLineParsingError, .invalidConfigFilePath)
    }
  }
  
  func test_parse_returnsSuccess_forValidArguments() {
    let arguments = ["AssetGen", "localization:ios", "config.json"]
    
    XCTAssertNoThrow(try sut.parse(arguments: arguments))
    
    let commandLineArguments = try? sut.parse(arguments: arguments)
    XCTAssertEqual(commandLineArguments?.generationType, .localization)
    XCTAssertEqual(commandLineArguments?.platform, .ios)
    XCTAssertEqual(commandLineArguments?.configFilePath, "config.json")
  }
}

private extension CommandLineParserTests {
  func makeSUT() -> CommandLineParser {
    CommandLineParser()
  }
}
