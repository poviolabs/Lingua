import Foundation
@testable import Lingua

final class MockLocalizedSwiftCodeOutputStringBuilder: LocalizedSwiftCodeOutputStringBuilder {
  var buildOutputResult: String = ""
  
  func buildOutput(sections: [String: Set<String>], translations: [String: String]) -> String {
    buildOutputResult
  }
}
