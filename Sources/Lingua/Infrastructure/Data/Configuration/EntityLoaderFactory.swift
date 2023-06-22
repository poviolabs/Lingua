import Foundation

struct EntityLoaderFactory {
  static func makeConfigLoader() -> EntityFileLoader<JSONDataParser<ConfigDto>, ConfigTransformer> {
    let parser = JSONDataParser<ConfigDto>()
    let transformer = ConfigTransformer()
    return EntityFileLoader(parser: parser, transformer: transformer)
  }
}
