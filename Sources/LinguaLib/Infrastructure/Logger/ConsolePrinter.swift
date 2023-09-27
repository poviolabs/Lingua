import Foundation

struct ConsolePrinter: Printer {
  func print(_ items: Any...) {
    Swift.print(items.map { "\($0)" }.joined(separator: " "))
  }
}
