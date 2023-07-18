import XCTest
@testable import Lingua

final class CommandLineParserTests: XCTestCase {
  private lazy var sut: CommandLineParser = {
    return makeSUT()
  }()
  
  func test_parse_throwsNotEnoughArgumentsError_forNotEnoughArguments() {
    let arguments = ["Lingua"]
    
    XCTAssertThrowsError(try sut.parse(arguments: arguments)) { error in
      XCTAssertEqual((error as? CommandLineParsingError)?.localizedDescription,
                     CommandLineParsingError.notEnoughArguments.localizedDescription)
    }
  }
  
  func test_parse_throwsInvalidPlatformError_forInvalidPlatform() {
    let arguments = ["Lingua", "localization_invalid", "config.json"]
    
    XCTAssertThrowsError(try sut.parse(arguments: arguments)) { error in
      XCTAssertEqual((error as? CommandLineParsingError)?.localizedDescription,
                     CommandLineParsingError.invalidPlatform.localizedDescription)
    }
  }
  
  func test_parse_throwsInvalidConfigFilePathError_forInvalidConfigFilePath() {
    let arguments = ["Lingua", "ios", "config.txt"]
    
    XCTAssertThrowsError(try sut.parse(arguments: arguments)) { error in
      XCTAssertEqual((error as? CommandLineParsingError)?.localizedDescription,
                     CommandLineParsingError.invalidConfigFilePath.localizedDescription)
    }
  }
  
  func test_parse_parsesArgumentsCorrectly_forValidArguments() throws {
    let arguments = ["Lingua", "ios", "config.json"]
        
    let commandLineArguments = try sut.parse(arguments: arguments)
    
    XCTAssertEqual(commandLineArguments.platform, .ios)
    XCTAssertEqual(commandLineArguments.configFilePath, "config.json")
  }
}

private extension CommandLineParserTests {
  func makeSUT() -> CommandLineParser {
    CommandLineParser()
  }
}
