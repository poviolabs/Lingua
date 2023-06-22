import Foundation

struct ToolConfigTransformer: Transformable {
  typealias Input = ToolConfigDto
  typealias Output = ToolConfig
  
  func transform(_ object: ToolConfigDto) throws -> ToolConfig {
    var localizationDto: ToolConfig.Localization?
    
    if let localization = object.localization {
      var localizedSwiftCode: ToolConfig.LocalizedSwiftCode?
      if let localizedSwiftCodeDto = localization.swiftCode {
        localizedSwiftCode = .init(stringsDirectory: localizedSwiftCodeDto.stringsDirectory,
                                   outputSwiftCodeFileDirectory: localizedSwiftCodeDto.outputSwiftCodeFileDirectory)
      }
      
      localizationDto = ToolConfig.Localization(apiKey: localization.apiKey,
                                                    sheetId: localization.sheetId,
                                                    outputDirectory: localization.outputDirectory,
                                                    localizedSwiftCode: localizedSwiftCode)
    }
    
    return ToolConfig(localization: localizationDto)
  }
}
