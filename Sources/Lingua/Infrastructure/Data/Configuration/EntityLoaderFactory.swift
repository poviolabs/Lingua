import Foundation

struct EntityLoaderFactory {
  static func makeConfigLoader() -> EntityFileLoader<JSONDataParser<ConfigDto>, ConfigDtoTransformer> {
    let parser = JSONDataParser<ConfigDto>()
    let transformer = ConfigDtoTransformer()
    return EntityFileLoader(parser: parser, transformer: transformer)
  }
}
