import Foundation

public struct JSONDataParser<T: Decodable>: DataParsing {
  public typealias Model = T
  private let jsonDecoder: JSONDecoding
  
  public init(jsonDecoder: JSONDecoding = JSONDecoder()) {
    self.jsonDecoder = jsonDecoder
  }
  
  public func parse(_ data: Data) throws -> Model {
    try jsonDecoder.decode(Model.self, from: data)
  }
}
