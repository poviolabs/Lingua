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
  
  var onDirectorySelected: ((String) -> Void)? = nil
  
  var body: some View {
    HStack {
      ValidatingTextField(title: title, validation: RequiredRule(), isDisabled: true, text: $directoryPath, isValid: $isValid)
      Button(Lingua.ProjectForm.inputDirectoryButton) {
        chooseDirectory()
      }
    }
    .padding(.vertical, 5)
  }
}

private extension DirectoryInputField {
  func chooseDirectory() {
    let panel = NSOpenPanel()
    panel.canChooseFiles = false
    panel.canChooseDirectories = true
    panel.allowsMultipleSelection = false
    panel.prompt = Lingua.General.choose
    
    panel.begin { (result) in
      if let url = panel.urls.first {
        directoryPath = url.absoluteString
        saveBookmarkData(from: url)
      }
      onDirectorySelected?(directoryPath)
    }
  }
  
  func saveBookmarkData(from url: URL) {
    do {
      try url.saveBookmarkData(forKey: bookmarkDataKey)
    } catch {
      debugPrint(error.localizedDescription)
      directoryPath = ""
    }
  }
}
