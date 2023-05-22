import Foundation
@testable import AssetGen

class MockLocalizationOutputGenerator: LocalizationOutputGenerator {
  private let outputClosure: ([LocalizationEntry]) -> String
  
  init(outputClosure: @escaping ([LocalizationEntry]) -> String) {
    self.outputClosure = outputClosure
  }
  
  func generateOutputContent(for entries: [LocalizationEntry]) -> String {
    outputClosure(entries)
  }
}
