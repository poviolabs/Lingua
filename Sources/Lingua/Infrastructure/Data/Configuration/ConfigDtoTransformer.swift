import Foundation

struct ConfigDtoTransformer: Transformable {
  typealias Input = ConfigDto
  typealias Output = Config
  
  func transform(_ object: ConfigDto) throws -> Config {
    var localizationDto: Config.Localization?
    
    if let localization = object.localization {
      var localizedSwiftCode: Config.LocalizedSwiftCode?
      if let localizedSwiftCodeDto = localization.swiftCode {
        localizedSwiftCode = .init(stringsDirectory: localizedSwiftCodeDto.stringsDirectory,
                                   outputSwiftCodeFileDirectory: localizedSwiftCodeDto.outputSwiftCodeFileDirectory)
      }
      
      localizationDto = Config.Localization(apiKey: localization.apiKey,
                                                    sheetId: localization.sheetId,
                                                    outputDirectory: localization.outputDirectory,
                                                    localizedSwiftCode: localizedSwiftCode)
    }
    
    return Config(localization: localizationDto)
  }
}
