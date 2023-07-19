import Foundation

final class ConfigInitialFileGenerator: ConfigInitialFileGenerating {
  private let contentFilesCreator: ContentFileCreatable
  private let encoder: JSONEncoding
  private let transformer: ConfigTransformer
  private let config: Config
  internal let fileName: String
  
  init(contentFilesCreator: ContentFileCreatable,
       encoder: JSONEncoding,
       transformer: ConfigTransformer,
       config: Config,
       fileName: String) {
    self.contentFilesCreator = contentFilesCreator
    self.encoder = encoder
    self.transformer = transformer
    self.config = config
    self.fileName = fileName
  }
  
  func generate() throws {
    let configData = try encodeConfig()
    try writeConfigFile(with: configData)
  }
  
  private func encodeConfig() throws -> Data {
    let configDto = try transformer.transform(config)
    return try encoder.encode(configDto)
  }
  
  private func writeConfigFile(with data: Data) throws {
    guard let content = String(data: data, encoding: .utf8) else {
      throw Error.malformedContent
    }
    
    do {
      try contentFilesCreator.createFilesInCurrentDirectory(with: content, fileName: fileName)
    } catch {
      throw Error.failed
    }
  }
}

extension ConfigInitialFileGenerator {
  enum Error: LocalizedError {
    case failed
    case malformedContent
    
    var errorDescription: String? {
      switch self {
      case .failed:
        return "The config json file couldn't be created"
      case .malformedContent:
        return "The config file data is malformed"
      }
    }
  }
}

extension ConfigInitialFileGenerator {
  static func make() -> ConfigInitialFileGenerating {
    ConfigInitialFileGenerator(contentFilesCreator: ContentFileCreator(),
                               encoder: CustomJSONEncoder(),
                               transformer: ConfigTransformer(),
                               config: .createTemplateConfig(),
                               fileName: "lingua_config.json")
  }
}
