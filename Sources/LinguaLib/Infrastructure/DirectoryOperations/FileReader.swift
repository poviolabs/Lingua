import Foundation

public struct FileReader: FileReading {
  public init() { }
  
  public func readData(from url: URL) async throws -> Data {
    try await withCheckedThrowingContinuation { continuation in
      Task(priority: .userInitiated) {
        do {
          let data = try Data(contentsOf: url)
          continuation.resume(returning: data)
        } catch {
          continuation.resume(throwing: error)
        }
      }
    }
  }
}
