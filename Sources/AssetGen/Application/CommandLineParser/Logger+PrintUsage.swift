import Foundation

extension Logger {
  func printUsage() {
    log("""
        Usage:
        AssetGen <asset_generation_type>:<platform> <config_file_path>
        
        <asset_generation_type> can be:
        1. localization
        
        <platform> is required only for localization functionality and can be:
        1. ios
        2. android
        """,
        level: .info)
  }
}
