//
//  CustomSearchBar.swift
//  Lingua
//
//  Created by Egzon Arifi on 25/08/2023.
//

import SwiftUI

struct CustomSearchBar: View {
  @Binding var searchTerm: String
  
  var body: some View {
    HStack(spacing: 4) {
      Image(systemName: "magnifyingglass")
        .foregroundColor(Color.primary)
        .padding([.leading], 4)
      
      TextField(Lingua.General.search, text: $searchTerm)
        .textFieldStyle(PlainTextFieldStyle())
        .padding(4)
        .focusable(false)
      
      if !searchTerm.isEmpty {
        Button(action: {
          searchTerm = ""
        }) {
          Image(systemName: "xmark.circle.fill")
            .foregroundColor(.gray)
        }
        .buttonStyle(BorderlessButtonStyle())
        .padding([.trailing], 4)
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 4)
        .fill(Color(NSColor.lightGray).opacity(0.2))
        .overlay(
          RoundedRectangle(cornerRadius: 4)
            .stroke(Color(NSColor.lightGray).opacity(0.2), lineWidth: 1)
        )
    )
    .padding(8)
  }
}
