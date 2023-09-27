import Foundation

/// A protocol that provides a method to generate Swift code for localization from given section, key, and translation
public protocol LocalizedSwiftCodeGenerating {
  func generateCode(section: String, key: String, translation: String) -> String
}
