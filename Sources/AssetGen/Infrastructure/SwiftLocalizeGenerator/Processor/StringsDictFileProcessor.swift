import Foundation

struct StringsDictFileProcessor: FileProcessor {
  private let fileType = ".stringsdict"
  private let placeholderExtractor: PlaceholderExtractor
  
  init(placeholderExtractor: PlaceholderExtractor = PlaceholderExtractor()) {
    self.placeholderExtractor = placeholderExtractor
  }
  
  func canHandle(file: String) -> Bool {
    file.hasSuffix(fileType)
  }
  
  func sectionName(for file: String) -> String? {
    canHandle(file: file) ? file.replacingOccurrences(of: fileType, with: "") : .none
  }
  
  func processFile(section: String, path: String) -> (translations: [String: String], sections: Set<String>) {
    guard let dict = NSDictionary(contentsOfFile: path) as? [String: NSDictionary] else { return ([:], []) }
    var translations: [String: String] = [:]
    var sections: Set<String> = []
    
    dict.forEach { key, valueDict in
      if let translation = processTranslation(from: valueDict, forKey: key) {
        sections.insert(key)
        translations[key] = translation
      }
    }
    
    return (translations, sections)
  }
}

private extension StringsDictFileProcessor {
  func processTranslation(from valueDict: NSDictionary, forKey key: String) -> String? {
    guard let innerDict = valueDict[key] as? [String: AnyObject] else { return nil }
    let preferredRules = PluralCategory.allCases.map { $0.rawValue }
    
    for rule in preferredRules {
      guard let ruleValue = innerDict[rule] as? String else { continue }
      
      if placeholderExtractor.extractPlaceholders(from: ruleValue).isEmpty,
         let formatValueKey = innerDict["NSStringFormatValueTypeKey"] {
        return ruleValue + "%\(formatValueKey)"
      }
      return ruleValue
    }
    
    return nil
  }
}
