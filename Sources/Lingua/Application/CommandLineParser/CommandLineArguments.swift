import Foundation

struct CommandLineArguments: Equatable {
  let command: Command?
  let platform: LocalizationPlatform?
  let configFilePath: String?
}
