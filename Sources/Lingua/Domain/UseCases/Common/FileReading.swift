import Foundation

protocol FileReading {
  func readData(from url: URL) async throws -> Data
}
