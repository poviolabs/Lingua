import Foundation

protocol FileProcessor {
  func canHandle(file: String) -> Bool
  func sectionName(for file: String) -> String?
  func processFile(section: String, path: String) -> (translations: [String: String], sections: Set<String>)
}
