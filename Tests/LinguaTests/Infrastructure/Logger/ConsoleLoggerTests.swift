import XCTest
@testable import Lingua

final class ConsoleLoggerTests: XCTestCase {
  func test_log_printsMessagesWithLogLevel() {
    let mockPrinter = MockPrinter()
    let logger = ConsoleLogger(printer: mockPrinter)
    
    logger.log("Info message", level: .info)
    logger.log("Success message", level: .success)
    logger.log("Warning message", level: .warning)
    logger.log("Error message", level: .error)
    
    XCTAssertEqual(mockPrinter.messages, ["\u{001B}[0;36mINFO: Info message",
                                          "\u{001B}[0;32mSUCCESS: Success message",
                                          "\u{001B}[0;33mWARNING: Warning message",
                                          "\u{001B}[0;31mERROR: Error message"])
  }
}
