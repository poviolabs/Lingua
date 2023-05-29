import XCTest
@testable import AssetGen

final class LocalizedOutputGeneratorTests: XCTestCase {
  func test_generateOutputContent_returnsValidTranslations() {
    let entries = createEntriesWithTranslations()
    let expected = expectedOutputWithTranslations()
    
    assertGenerateOutputContent(entries: entries, expected: expected)
  }
  
  func test_generateOutputContent_returnsEmptyContentWhenNoTranslations() {
    let entries = createEntriesWithEmptyTranslations()
    let expected = expectedOutputWithEmptyTranslations()
    
    assertGenerateOutputContent(entries: entries, expected: expected)
  }
  
  func test_generateOutputContent_returnsEmptyWhenNoEntries() {
    let entries: [LocalizationEntry] = []
    let expected = expectedOutputWithNoEntries()
    
    assertGenerateOutputContent(entries: entries, expected: expected)
  }
}

private extension LocalizedOutputGeneratorTests {
  func assertGenerateOutputContent(entries: [LocalizationEntry],
                                   expected: String,
                                   file: StaticString = #file,
                                   line: UInt = #line) {
    let generator = makeSUT()
    let result = generator.generateOutputContent(for: entries)
    XCTAssertEqual(result, expected, file: file, line: line)
  }
  
  func makeSUT() -> LocalizedOutputGenerator {
    LocalizedOutputGenerator(placeholderMapper: IOSPlaceholderMapper(), formatter: IOSPluralFormatter())
  }
  
  func createEntriesWithTranslations() -> [LocalizationEntry] {
    let entry1 = LocalizationEntry(section: "section1",
                                   key: "key1",
                                   translations: [PluralCategory.one.rawValue: "translation_one",
                                                  PluralCategory.other.rawValue: "translation_other"])
    let entry2 = LocalizationEntry(section: "section2",
                                   key: "key2",
                                   translations: [PluralCategory.other.rawValue: "translation2"])
    return [entry1, entry2]
  }
  
  func createEntriesWithEmptyTranslations() -> [LocalizationEntry] {
    let entry1 = LocalizationEntry(section: "section1",
                                   key: "key1",
                                   translations: [:])
    let entry2 = LocalizationEntry(section: "section2",
                                   key: "key2",
                                   translations: [:])
    return [entry1, entry2]
  }
  
  func expectedOutputWithTranslations() -> String {
      """
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
      \t<key>key1</key>
      \t<dict>
      \t\t<key>NSStringLocalizedFormatKey</key>
      \t\t<string>%#@key1@</string>
      \t\t<key>key1</key>
      \t\t<dict>
      \t\t\t<key>NSStringFormatSpecTypeKey</key>
      \t\t\t<string>NSStringPluralRuleType</string>
      \t\t\t<key>NSStringFormatValueTypeKey</key>
      \t\t\t<string>d</string>
      \t\t\t<key>one</key>
      \t\t\t<string>translation_one</string>
      \t\t\t<key>other</key>
      \t\t\t<string>translation_other</string>
      \t\t</dict>
      \t</dict>
      \t<key>key2</key>
      \t<dict>
      \t\t<key>NSStringLocalizedFormatKey</key>
      \t\t<string>%#@key2@</string>
      \t\t<key>key2</key>
      \t\t<dict>
      \t\t\t<key>NSStringFormatSpecTypeKey</key>
      \t\t\t<string>NSStringPluralRuleType</string>
      \t\t\t<key>NSStringFormatValueTypeKey</key>
      \t\t\t<string>d</string>
      \t\t\t<key>other</key>
      \t\t\t<string>translation2</string>
      \t\t</dict>
      \t</dict>
      </dict>
      </plist>
      """
  }
  
  func expectedOutputWithNoEntries() -> String { "" }
  func expectedOutputWithEmptyTranslations() -> String { "" }
}
