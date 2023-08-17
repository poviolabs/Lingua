import Foundation

public struct ConfigTransformer: Transformable {
  public typealias Input = Config
  public typealias Output = ConfigDto
  
  public func transform(_ object: Config) throws -> ConfigDto {
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
