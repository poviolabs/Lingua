import Foundation

public enum Command: String {
  case ios
  case android
  case config
  case initializer = "init"
  case version = "--version"
  case abbreviatedVersion = "-v"
}
