//
//  URL+Extension.swift
//  Lingua
//
//  Created by Egzon Arifi on 24/08/2023.
//

import Foundation

extension URL {
  enum BookmarkError: Error {
    case noExistingDirectory
  }
  
  func saveBookmarkData(forKey key: String) throws {
    let fileManager = FileManager.default
    guard fileManager.fileExists(atPath: path) else {
      throw BookmarkError.noExistingDirectory
    }
    
    let bookmarkData = try? bookmarkData(options: .withSecurityScope,
                                         includingResourceValuesForKeys: nil,
                                         relativeTo: nil)
    UserDefaults.standard.set(bookmarkData, forKey: key)
  }
}
