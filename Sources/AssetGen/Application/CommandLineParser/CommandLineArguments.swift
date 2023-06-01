import Foundation

struct CommandLineArguments: Equatable {
  let generationType: AssetGenerationType
  let platform: LocalizationPlatform
  let configFilePath: String
}
