import Foundation
import LinguaLib

public struct CommandLineArguments: Equatable {
  public let command: Command?
  public let platform: LocalizationPlatform?
  public let configFilePath: String?
}
