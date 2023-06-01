import Foundation

struct JSONDataParser<T: Decodable>: DataParsing {
  typealias Model = T
  private let jsonDecoder: JSONDecoding
  
  init(jsonDecoder: JSONDecoding = JSONDecoder()) {
    self.jsonDecoder = jsonDecoder
  }
  
  func parse(_ data: Data) throws -> Model {
    try jsonDecoder.decode(Model.self, from: data)
  }
}
