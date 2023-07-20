import Foundation

/// A protocol that lays down a method to generate localized code files from a given input and output path
protocol LocalizedCodeFileGenerating {
  func generate(from path: String, outputPath: String)
}
