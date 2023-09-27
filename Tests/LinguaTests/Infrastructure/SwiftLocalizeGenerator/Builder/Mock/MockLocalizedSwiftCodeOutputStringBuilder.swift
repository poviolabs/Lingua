import Foundation
@testable import LinguaLib

final class MockLocalizedSwiftCodeOutputStringBuilder: LocalizedSwiftCodeOutputStringBuilder {
  var buildOutputResult: String = ""
  
  func buildOutput(sections: [String: Set<String>], translations: [String: [String: String]]) -> String {
    buildOutputResult
  }
}
