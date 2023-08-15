import Foundation

/// A protocol that defines methods to handle and process a given file, and to derive a section name
public protocol FileProcessor {
  func canHandle(file: String) -> Bool
  func sectionName(for file: String) -> String?
  func processFile(section: String, path: String) -> (translations: [String: String], sections: Set<String>)
}
