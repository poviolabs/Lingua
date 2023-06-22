import Foundation
@testable import Lingua

final class MockLocalizedContentGenerator: LocalizedContentGenerating {
  private(set) var createdEntries = [LocalizationEntry]()
  var content: (nonPlural: String, plural: String) = ("non_plural", "plural")
  
  func createContent(for entries: [LocalizationEntry]) -> (nonPlural: String, plural: String) {
    createdEntries.append(contentsOf: entries)
    return content
  }
}
