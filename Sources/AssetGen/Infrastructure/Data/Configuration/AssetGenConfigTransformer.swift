import Foundation

struct AssetGenConfigTransformer: Transformable {
  typealias Input = AssetGenConfigDto
  typealias Output = AssetGenConfig
  
  func transform(_ object: AssetGenConfigDto) throws -> AssetGenConfig {
    var localizationDto: AssetGenConfig.Localization?
    
    if let localization = object.localization {
      localizationDto = AssetGenConfig.Localization(apiKey: localization.apiKey,
                                                    sheetId: localization.sheetId,
                                                    outputDirectory: localization.outputDirectory)
    }
    
    return AssetGenConfig(localization: localizationDto)
  }
}
