import Foundation

struct SheetNamesRequest: Request {
  typealias Response = SheetMetadata
  
  var method: HTTPMethod { .get }
  
  var path: String
  
  var queryItems: [URLQueryItem]?
}

extension SheetNamesRequest: Equatable {
  init(config: GoogleSheetsAPIConfig) {
    self.init(path: config.sheetId,
              queryItems: [.init(name: "key", value: config.apiKey)])
  }
}
