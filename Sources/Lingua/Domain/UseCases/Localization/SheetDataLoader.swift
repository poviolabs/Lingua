import Foundation

protocol SheetDataLoader {
  func loadSheets() async throws -> [LocalizationSheet]
}
