import Foundation

struct StringsFileProcessor: FileProcessor {
  private let fileType = ".strings"
  
  func canHandle(file: String) -> Bool {
    file.hasSuffix(fileType)
  }
  
  func sectionName(for file: String) -> String? {
    canHandle(file: file) ? file.replacingOccurrences(of: fileType, with: "") : .none
  }
  
  func processFile(section: String, path: String) -> (translations: [String: String], sections: Set<String>) {
    guard let dict = NSDictionary(contentsOfFile: path) as? [String: String] else { return ([:], []) }
    let sections = Set(dict.keys)
    return (dict, sections)
  }
}
