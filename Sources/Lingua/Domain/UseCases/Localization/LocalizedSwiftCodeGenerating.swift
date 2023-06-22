import Foundation

protocol LocalizedSwiftCodeGenerating {
  func generateCode(section: String, key: String, translation: String) -> String
}
