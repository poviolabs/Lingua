import Foundation

struct DefaultLocalizedSwiftCodeOutputStringBuilder: LocalizedSwiftCodeOutputStringBuilder {
  private let codeGenerator: LocalizedSwiftCodeGenerating
  
  init(codeGenerator: LocalizedSwiftCodeGenerating = LocalizedSwiftCodeGenerator()) {
    self.codeGenerator = codeGenerator
  }
  
  func buildOutput(sections: [String: Set<String>], translations: [String: String]) -> String {
    let sectionsOutput = buildSectionsOutput(sections: sections, translations: translations)
    
    let output = """
           //swiftlint:disable all
           
           import Foundation
           
           enum \(String.packageName) {
           \(sectionsOutput)
               
           \tprivate static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
           \t\tlet format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
           \t\treturn String(format: format, locale: Locale.current, arguments: args)
           \t}
           }
           
           private final class BundleToken {
             static let bundle: Bundle = {
               #if SWIFT_PACKAGE
               return Bundle.module
               #else
               return Bundle(for: BundleToken.self)
               #endif
             }()
           }
           """
    return output
  }
}

private extension DefaultLocalizedSwiftCodeOutputStringBuilder {
  func buildSectionsOutput(sections: [String: Set<String>], translations: [String: String]) -> String {
    sections
      .keys
      .sorted()
      .map { section in
        guard let keys = sections[section] else { return "" }
        let keysOutput = buildKeysOutput(section: section, keys: keys, translations: translations)
        return "\tenum \(section.formatSheetSection()) {\n\(keysOutput)\n\t}"
      }
      .joined(separator: "\n\n")
  }
  
  func buildKeysOutput(section: String, keys: Set<String>, translations: [String: String]) -> String {
    keys
      .sorted()
      .map { key in
        let translation = translations[key] ?? ""
        return "\t\t" + codeGenerator.generateCode(section: section, key: key, translation: translation)
      }
      .joined(separator: "\n")
  }
}
