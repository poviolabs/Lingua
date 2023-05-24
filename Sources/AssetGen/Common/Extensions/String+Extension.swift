import Foundation

extension String {
  func formatSheetSection() -> String {
    return self
      .components(separatedBy: CharacterSet(charactersIn: " _"))
      .enumerated()
      .reduce(into: "") { result, indexAndWord in
        let (index, word) = indexAndWord
        result += index == 0 ? word : word.capitalized
      }
  }
}
