import Foundation

extension Logger {
  func printUsage() {
    log("""
        Usage:
        AssetGen <platform> <config_file_path/file.json>

        <platform> is required only for localization functionality and can be:
        1. ios
        2. android
        """,
        level: .info)
  }
}
