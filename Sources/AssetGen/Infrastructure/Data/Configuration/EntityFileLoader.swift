import Foundation

final class EntityFileLoader<T: DataParsing, U: Transformable> where T.Model == U.Input {
  private let fileReader: FileReading
  private let parser: T
  private let transformer: U
  
  init(fileReader: FileReading = FileReader(), parser: T, transformer: U) {
    self.fileReader = fileReader
    self.parser = parser
    self.transformer = transformer
  }
  
  func loadEntity(from filePath: String) async throws -> U.Output {
    let url = URL(fileURLWithPath: filePath)
    let data = try await fileReader.readData(from: url)
    let model = try parser.parse(data)
    return try transformer.transform(model)
  }
}
