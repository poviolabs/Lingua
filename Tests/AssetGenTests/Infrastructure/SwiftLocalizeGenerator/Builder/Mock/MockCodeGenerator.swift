import Foundation
@testable import AssetGen

final class MockCodeGenerator: LocalizedSwiftCodeGenerating {
  var generateCodeCalled = false
  var generateCodeSection: String?
  var generateCodeKey: String?
  var generateCodeTranslation: String?
  
  func generateCode(section: String, key: String, translation: String) -> String {
    generateCodeCalled = true
    generateCodeSection = section
    generateCodeKey = key
    generateCodeTranslation = translation
    
    return "generatedCode(\(section), \(key), \(translation))"
  }
}
