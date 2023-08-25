//
//  DirectoryAccessor.swift
//  Lingua
//
//  Created by Egzon Arifi on 21/08/2023.
//

import Foundation

struct DirectoryAccessor {
  enum Error: Swift.Error {
    case bookmarkError
    case securityScopeError
  }
  
  func accessDirectory(fromBookmarkKey key: String, path: String) async throws {
    guard directoryExists(at: URL(fileURLWithPath: path)) else { return }
    
    guard let bookmarkData = UserDefaults.standard.data(forKey: key) else {
      throw Error.bookmarkError
    }
    
    var isStale: Bool = false
    do {
      let bookmarkURL = try URL(resolvingBookmarkData: bookmarkData,
                                options: .withSecurityScope,
                                relativeTo: nil,
                                bookmarkDataIsStale: &isStale)
      
      if isStale {
        throw Error.bookmarkError
      }
      
      if !bookmarkURL.startAccessingSecurityScopedResource() {
        throw Error.securityScopeError
      }
    } catch {
      throw error
    }
  }
  
  private func directoryExists(at url: URL) -> Bool {
    var isDirectory: ObjCBool = false
    if let directoryURL = URL(string: url.relativePath),
        FileManager.default.fileExists(atPath: directoryURL.path, isDirectory: &isDirectory) {
      return isDirectory.boolValue
    } else {
      return false
    }
  }
}
