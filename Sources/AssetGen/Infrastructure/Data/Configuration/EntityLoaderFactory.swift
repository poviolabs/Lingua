import Foundation

struct EntityLoaderFactory {
  static func makeAssetGenConfigLoader() -> EntityFileLoader<JSONDataParser<AssetGenConfigDto>, AssetGenConfigTransformer> {
    let parser = JSONDataParser<AssetGenConfigDto>()
    let transformer = AssetGenConfigTransformer()
    return EntityFileLoader(parser: parser, transformer: transformer)
  }
}
