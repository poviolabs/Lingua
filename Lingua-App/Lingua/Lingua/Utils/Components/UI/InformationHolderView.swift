//
//  InformationHolderView.swift
//  Lingua
//
//  Created by Egzon Arifi on 24/08/2023.
//

import SwiftUI

struct InformationHolderView<Content: View, PopupContent: View>: View {
  let action: () -> PopupContent
  let content: Content
  
  @State private var isShowingPopup = false
  
  init(@ViewBuilder content: () -> Content, @ViewBuilder action: @escaping () -> PopupContent) {
    self.content = content()
    self.action = action
  }
  
  var body: some View {
    HStack() {
      content
      Spacer()
      Button(action: {
        isShowingPopup.toggle()
      }) {
        Image(systemName: "info.circle")
          .foregroundColor(.blue)
      }
      .buttonStyle(.plain)
      .popover(isPresented: $isShowingPopup, arrowEdge: .leading) {
        action()
      }
    }
  }
}
