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
    let allowedSections: [String]?
    
    public init(
      apiKey: String,
      sheetId: String,
      outputDirectory: String,
      localizedSwiftCode: LocalizedSwiftCode?,
      allowedSections: [String]? = nil
    ) {
      self.apiKey = apiKey
      self.sheetId = sheetId
      self.outputDirectory = outputDirectory
      self.localizedSwiftCode = localizedSwiftCode
      self.allowedSections = allowedSections
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
