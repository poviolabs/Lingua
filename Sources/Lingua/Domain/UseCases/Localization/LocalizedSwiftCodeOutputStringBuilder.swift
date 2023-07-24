import Foundation

/// A protocol that defines a method to build a string output from given sections and translations data
protocol LocalizedSwiftCodeOutputStringBuilder {
  func buildOutput(sections: [String: Set<String>], translations: [String: String]) -> String
}
