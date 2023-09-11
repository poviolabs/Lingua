import Foundation

/// A protocol that specifies a method to process and merge multiple files at a given path into a structured data representation
public protocol MergableFileProcessor {
  func processAndMergeFiles(at path: String) -> (sections: [String: Set<String>], translations: [String: [String: String]])
}
