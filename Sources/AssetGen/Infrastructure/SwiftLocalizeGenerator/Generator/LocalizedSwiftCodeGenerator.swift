import Foundation

struct LocalizedSwiftCodeGenerator: LocalizedSwiftCodeGenerating {
  private let placeholderExtractor: PlaceholderExtractor
  
  init(placeholderExtractor: PlaceholderExtractor = PlaceholderExtractor.make()) {
    self.placeholderExtractor = placeholderExtractor
  }
  
  func generateCode(section: String, key: String, translation: String) -> String {
    let placeholders = placeholderExtractor.extractPlaceholders(from: translation)
    
    guard placeholders.isEmpty else {
      return generateFunctionCode(section: section, key: key, placeholders: placeholders)
    }
    
    return generateStaticPropertyCode(section: section, key: key)
  }
}

private extension LocalizedSwiftCodeGenerator {
  func generateStaticPropertyCode(section: String, key: String) -> String {
    "static let \(key.formatKey()) = tr(\"\(section)\", \"\(key)\")"
  }
  
  func generateFunctionCode(section: String, key: String, placeholders: [Placeholder]) -> String {
    var function = "static func \(key.formatKey())("
    
    for (index, placeholder) in placeholders.enumerated() {
      if index > 0 { function += ", " }
      function += "_ param\(index + 1): \(placeholder.type.asDataType)"
    }
    
    function += ") -> String {\n"
    function += "\t\t\treturn tr(\"\(section)\", \"\(key)\""
    
    for index in 0..<placeholders.count {
      function += ", param\(index + 1)"
    }
    
    function += ")\n\t\t}"
    
    return function
  }
}
