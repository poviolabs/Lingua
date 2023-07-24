import Foundation

extension LocalizationEntry {
  var androidKey: String {
    (section + "_" + key).lowercased()
  }
}
