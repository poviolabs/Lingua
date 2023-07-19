import Foundation

struct ConfigTransformer: Transformable {
  typealias Input = Config
  typealias Output = ConfigDto
  
  func transform(_ object: Config) throws -> ConfigDto {
    var localizationDto: ConfigDto.Localization?
    
    if let localization = object.localization {
      var localizedSwiftCode: ConfigDto.LocalizedSwiftCode?
      if let localizedSwiftCodeDto = localization.localizedSwiftCode {
        localizedSwiftCode = .init(stringsDirectory: localizedSwiftCodeDto.stringsDirectory,
                                   outputSwiftCodeFileDirectory: localizedSwiftCodeDto.outputSwiftCodeFileDirectory)
      }
      
      localizationDto = ConfigDto.Localization(apiKey: localization.apiKey,
                                               sheetId: localization.sheetId,
                                               outputDirectory: localization.outputDirectory,
                                               swiftCode: localizedSwiftCode)
    }
    
    return ConfigDto(localization: localizationDto)
  }
}
