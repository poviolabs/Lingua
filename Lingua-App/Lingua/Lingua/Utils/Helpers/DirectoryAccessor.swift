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
  
  func accessDirectory(fromBookmarkKey key: String) async throws -> URL {
    if let bookmarkData = UserDefaults.standard.data(forKey: key) {
      var isStale: Bool = false
      do {
        let bookmarkURL = try URL(resolvingBookmarkData: bookmarkData,
                                  options: .withSecurityScope,
                                  relativeTo: nil,
                                  bookmarkDataIsStale: &isStale)
        
        if isStale {
          throw Error.bookmarkError
        }
        
        if bookmarkURL.startAccessingSecurityScopedResource() {
          return bookmarkURL
        } else {
          throw Error.securityScopeError
        }
      } catch {
        throw error
      }
    }
    throw Error.bookmarkError
  }
}
