import Foundation

/// A protocol that defines the contract creating the localization plural/nonPlural content.
public protocol LocalizedContentGenerating {
  func createContent(for entries: [LocalizationEntry]) -> (nonPlural: String, plural: String)
}
