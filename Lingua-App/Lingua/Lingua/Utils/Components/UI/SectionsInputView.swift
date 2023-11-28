//
//  TagInputView.swift
//  Lingua
//
//  Created by Egzon Arifi on 26/11/2023.
//

import SwiftUI

struct SectionsInputView: View {
  @State var currentInput: String = ""
  @Binding var sections: [String]
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        TextField("Enter a section", text: $currentInput, onCommit: addSection)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
        
        Button(action: addSection) {
          Text("Add section")
        }
      }
      
      Divider()
      
      HStack {
        ForEach(sections, id: \.self) { tag in
          Button(action: {
            removeSection(tag)
          }, label: {
            Text(tag)
              .padding(.vertical, 4)
            
            Image(systemName: "xmark")
          })
        }
      }
    }
  }
  
  private func addSection() {
    if !currentInput.isEmpty {
      sections.append(currentInput)
      currentInput = ""
    }
  }
  
  private func removeSection(_ tag: String) {
    sections.removeAll { $0 == tag }
  }
}
