import Foundation

public protocol FileReading {
  func readData(from url: URL) async throws -> Data
}
