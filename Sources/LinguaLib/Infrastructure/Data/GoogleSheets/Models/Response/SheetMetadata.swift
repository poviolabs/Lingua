import Foundation

struct SheetMetadata: Codable, Equatable {
  let sheets: [Sheet]
  
  struct Sheet: Codable, Equatable {
    let properties: SheetProperties
    
    struct SheetProperties: Codable, Equatable {
      let title: String
    }
  }
}
