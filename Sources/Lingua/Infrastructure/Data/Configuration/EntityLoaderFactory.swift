import Foundation

struct EntityLoaderFactory {
  static func makeToolConfigLoader() -> EntityFileLoader<JSONDataParser<ToolConfigDto>, ToolConfigTransformer> {
    let parser = JSONDataParser<ToolConfigDto>()
    let transformer = ToolConfigTransformer()
    return EntityFileLoader(parser: parser, transformer: transformer)
  }
}
