import Foundation

extension String {
  static let packageName = "AssetGen"
  
  func formatSheetSection() -> String {
    self
      .components(separatedBy: CharacterSet(charactersIn: " _"))
      .enumerated()
      .reduce(into: "") { result, indexAndWord in
        let (index, word) = indexAndWord
        result += index == 0 ? word : word.capitalized
      }
  }
  
  func formatKey() -> String {
    camelCased().swiftIdentifier()
  }
  
  func camelCased() -> String {
    let items = split(separator: "_")
    var camelCase = ""
    
    for (index, item) in items.enumerated() {
      camelCase += index > 0 ? item.capitalized : item.lowercased()
    }
    
    return camelCase
  }
  
  func swiftIdentifier() -> String {
    let reservedWords = [
      "class", "deinit", "enum", "extension", "func", "import", "init", "inout", "let", "continue",
      "operator", "private", "protocol", "public", "static", "struct", "subscript", "typealias", "var"
    ]
    
    return reservedWords.contains(self) ? "`\(self)`" : self
  }
}
