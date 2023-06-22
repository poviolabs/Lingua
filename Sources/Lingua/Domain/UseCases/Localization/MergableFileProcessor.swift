import Foundation

protocol MergableFileProcessor {
  func processAndMergeFiles(at path: String) -> (sections: [String: Set<String>], translations: [String: String])
}
