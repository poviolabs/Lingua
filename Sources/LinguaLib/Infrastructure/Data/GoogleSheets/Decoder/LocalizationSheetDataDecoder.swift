import Foundation

protocol SheetDataDecoder {
  func decode(sheetData: SheetDataResponse, sheetName: String) -> LocalizationSheet
}

struct LocalizationSheetDataDecoder: SheetDataDecoder {
  typealias Sheet = (name: String, entries: [LocalizationEntry])
  private let translationBuilder: TranslationBuilder
  private let sectionIndex = 0
  private let keyIndex = 1
  private let metadataNumberOfColumns = 2
  
  init(translationBuilder: TranslationBuilder = SheetTranslationBuilder()) {
    self.translationBuilder = translationBuilder
  }
  
  func decode(sheetData: SheetDataResponse, sheetName: String) -> LocalizationSheet {
    let entriesWithoutSheetHeaders = sheetData.values.dropFirst().compactMap(createEntry)
    return LocalizationSheet(language: sheetName, entries: entriesWithoutSheetHeaders)
  }
}

private extension LocalizationSheetDataDecoder {
  func createEntry(from row: [String]) -> LocalizationEntry? {
    guard row.count > metadataNumberOfColumns else { return nil }
    
    let section = row[sectionIndex]
    let key = row[keyIndex]
    let translations = translationBuilder.buildTranslations(from: row)
    
    return LocalizationEntry(section: section, key: key, translations: translations)
  }
}
