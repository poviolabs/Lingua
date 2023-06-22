import Foundation

struct SheetDataRequest: Request {
  typealias Response = SheetDataResponse
  
  var method: HTTPMethod { .get }
  
  var path: String
  
  var queryItems: [URLQueryItem]?
}

extension SheetDataRequest: Equatable {
  init(sheetName: String, config: GoogleSheetsAPIConfig) {
    self.init(path: "/\(config.sheetId)/values/\(sheetName)!A:Z",
              queryItems: [.init(name: "key", value: config.apiKey)])
  }
}
