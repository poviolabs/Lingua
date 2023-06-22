import Foundation

protocol LocalizedSwiftCodeOutputStringBuilder {
  func buildOutput(sections: [String: Set<String>], translations: [String: String]) -> String
}
