import Foundation

extension String {
  func formatSheetSection() -> String {
    self
      .components(separatedBy: CharacterSet(charactersIn: " _"))
      .enumerated()
      .reduce(into: "") { result, indexAndWord in
        let (index, word) = indexAndWord
        result += index == 0 ? word : word.capitalized
      }
  }
}
