//
//  DirectoryInputField.swift
//  Lingua
//
//  Created by Egzon Arifi on 21/08/2023.
//

import SwiftUI

struct DirectoryInputField: View {
  var title: String
  var bookmarkDataKey: String
  
  @Binding var directoryPath: String
  @Binding var isValid: Bool
  
  var body: some View {
    HStack {
      ValidatingTextField(title: title, validation: RequiredRule(), isDisabled: true, text: $directoryPath, isValid: $isValid)
      Button("Choose Directory") {
        chooseDirectory()
      }
    }
    .padding(.vertical, 5)
  }
  
  func chooseDirectory() {
    let panel = NSOpenPanel()
    panel.canChooseFiles = false
    panel.canChooseDirectories = true
    panel.allowsMultipleSelection = false
    panel.prompt = "Choose"
    
    panel.begin { (result) in
      if result == .OK, let url = panel.urls.first {
        directoryPath = url.path
        saveBookmarkData(from: url)
      }
    }
  }
  
  private func saveBookmarkData(from url: URL) {
    let bookmarkData = try? url.bookmarkData(options: .withSecurityScope,
                                             includingResourceValuesForKeys: nil,
                                             relativeTo: nil)
    UserDefaults.standard.set(bookmarkData, forKey: bookmarkDataKey)
  }
}
