import Foundation

/// A protocol that defines the contract for generating the output content for given platform.
protocol LocalizedOutputGenerating {
  func generateOutputContent(for entries: [LocalizationEntry]) -> String
}
