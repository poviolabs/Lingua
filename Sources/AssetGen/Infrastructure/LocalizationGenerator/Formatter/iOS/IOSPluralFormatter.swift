import Foundation

struct IOSPluralFormatter: PluralFormatting {
  func wrapIn(content: String) -> String {
     """
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
    \(content)
    </dict>
    </plist>
    """
  }
  
  func composeContent(for entry: LocalizationEntry) -> (key: String, content: String) {
    var dictContent = "\t<dict>\n"
    dictContent += "\t\t<key>NSStringLocalizedFormatKey</key>\n"
    dictContent += "\t\t<string>%#@\(entry.key)@</string>\n"
    dictContent += "\t\t<key>\(entry.key)</key>\n"
    dictContent += "\t\t<dict>\n"
    dictContent += "\t\t\t<key>NSStringFormatSpecTypeKey</key>\n"
    dictContent += "\t\t\t<string>NSStringPluralRuleType</string>\n"
    dictContent += "\t\t\t<key>NSStringFormatValueTypeKey</key>\n"
    dictContent += "\t\t\t<string>d</string>\n"
    entry.translations.sorted { $0.key < $1.key }.forEach { key, translation in
      if !key.isEmpty && !translation.isEmpty {
        dictContent += "\t\t\t<key>\(key)</key>\n"
        dictContent += "\t\t\t<string>\(translation)</string>\n"
      }
    }
    dictContent += "\t\t</dict>\n"
    dictContent += "\t</dict>\n"
    let key = "\t<key>\(entry.key)</key>\n"
    return (key, dictContent)
  }
}
