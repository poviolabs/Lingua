import Foundation
@testable import AssetGen

final class MockFileProcessor: FileProcessor {
  func canHandle(file: String) -> Bool {
    true
  }
  
  func sectionName(for file: String) -> String? {
    file
  }
  
  func processFile(section: String, path: String) -> (translations: [String: String], sections: Set<String>) {
    (["translation1": "translationValue1"], Set(["section1"]))
  }
}
