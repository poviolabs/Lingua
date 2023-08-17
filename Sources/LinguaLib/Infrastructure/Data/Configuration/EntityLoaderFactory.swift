import Foundation

public struct EntityLoaderFactory {
  public static func makeConfigLoader() -> EntityFileLoader<JSONDataParser<ConfigDto>, ConfigDtoTransformer> {
    let parser = JSONDataParser<ConfigDto>()
    let transformer = ConfigDtoTransformer()
    return EntityFileLoader(parser: parser, transformer: transformer)
  }
}
