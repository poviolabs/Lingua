import Foundation

/// A protocol that defines the contract for loading sheet data
protocol SheetDataLoader {
  func loadSheets() async throws -> [LocalizationSheet]
}
