import Foundation

/// A protocol that defines the contract for loading sheet data
public protocol SheetDataLoader {
  func loadSheets() async throws -> [LocalizationSheet]
}
