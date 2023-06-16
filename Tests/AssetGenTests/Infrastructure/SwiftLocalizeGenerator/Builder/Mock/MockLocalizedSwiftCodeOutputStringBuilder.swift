import Foundation
@testable import AssetGen

final class MockLocalizedSwiftCodeOutputStringBuilder: LocalizedSwiftCodeOutputStringBuilder {
  var buildOutputResult: String = ""
  
  func buildOutput(sections: [String: Set<String>], translations: [String: String]) -> String {
    buildOutputResult
  }
}
