import Foundation

struct AssetGenConfigTransformer: Transformable {
  typealias Input = AssetGenConfigDto
  typealias Output = AssetGenConfig
  
  func transform(_ object: AssetGenConfigDto) throws -> AssetGenConfig {
    var localizationDto: AssetGenConfig.Localization?
    
    if let localization = object.localization {
      var localizedSwiftCode: AssetGenConfig.LocalizedSwiftCode?
      if let localizedSwiftCodeDto = localization.swiftCode {
        localizedSwiftCode = .init(stringsDirectory: localizedSwiftCodeDto.stringsDirectory,
                                   outputSwiftCodeFileDirectory: localizedSwiftCodeDto.outputSwiftCodeFileDirectory)
      }
      
      localizationDto = AssetGenConfig.Localization(apiKey: localization.apiKey,
                                                    sheetId: localization.sheetId,
                                                    outputDirectory: localization.outputDirectory,
                                                    localizedSwiftCode: localizedSwiftCode)
    }
    
    return AssetGenConfig(localization: localizationDto)
  }
}
