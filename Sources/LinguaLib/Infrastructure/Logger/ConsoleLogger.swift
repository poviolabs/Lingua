import Foundation

public class ConsoleLogger: Logger {
  public static let shared = ConsoleLogger()
  
  private let printer: Printer
  private var logLevel: LogLevel
  
  init(printer: Printer = ConsolePrinter(),
       logLevel: LogLevel = .info) {
    self.printer = printer
    self.logLevel = logLevel
  }
  
  public func log(_ message: String, level: LogLevel) {
    printer.print("\(level.ANSIColor): \(message)")
  }
}
