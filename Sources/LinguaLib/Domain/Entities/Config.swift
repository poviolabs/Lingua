import Foundation

public struct Config: Equatable {
  public let localization: Localization?
}

public extension Config {
  struct Localization: Equatable {
    let apiKey: String
    let sheetId: String
    let outputDirectory: String
    let localizedSwiftCode: LocalizedSwiftCode?
    
    public init(apiKey: String, sheetId: String, outputDirectory: String, localizedSwiftCode: LocalizedSwiftCode?) {
      self.apiKey = apiKey
      self.sheetId = sheetId
      self.outputDirectory = outputDirectory
      self.localizedSwiftCode = localizedSwiftCode
    }
  }
  
  struct LocalizedSwiftCode: Equatable {
    let stringsDirectory: String
    let outputSwiftCodeFileDirectory: String
    
    public init(stringsDirectory: String, outputSwiftCodeFileDirectory: String) {
      self.stringsDirectory = stringsDirectory
      self.outputSwiftCodeFileDirectory = outputSwiftCodeFileDirectory
    }
  }
}
