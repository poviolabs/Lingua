import Foundation

protocol SheetDataDecoder {
  func decode(sheetData: SheetDataResponse, sheetName: String) -> LocalizationSheet
}

struct LocalizationSheetDataDecoder: SheetDataDecoder {
  typealias Sheet = (name: String, entries: [LocalizationEntry])
  
  func decode(sheetData: SheetDataResponse, sheetName: String) -> LocalizationSheet {
    let entries = sheetData.values.dropFirst().compactMap(createEntry)
    return LocalizationSheet(language: sheetName, entries: entries)
  }
}

private extension LocalizationSheetDataDecoder {
  func createEntry(from row: [String]) -> LocalizationEntry? {
    guard row.count >= 4 else { return nil }
    
    let section = row[0]
    let key = row[1]
    let isPlural = row[2].lowercased() == "yes"
    let translations = createTranslations(from: row, isPlural: isPlural)
    
    return LocalizationEntry(section: section, key: key, plural: isPlural, translations: translations)
  }
  
  func createTranslations(from row: [String], isPlural: Bool) -> [String: String] {
    let translationBuilder = TranslationBuilderFactory.makeTranslationBuilder(isPlural: isPlural)
    return translationBuilder.buildTranslations(from: row)
  }
}
