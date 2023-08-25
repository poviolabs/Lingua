//
//  HUDOverlay.swift
//  Lingua
//
//  Created by Egzon Arifi on 22/08/2023.
//

import SwiftUI

struct HUDOverlay: View {
  let message: String
  let isError: Bool
  let delay: TimeInterval = 3
  var onDismiss: (() -> Void)? = nil
  
  var body: some View {
    ZStack {
      Color(NSColor.windowBackgroundColor)
        .opacity(0.8)
        .onTapGesture { dismiss() }
      
      VStack(spacing: 10) {
        Image("app_icon")
          .resizable()
          .scaledToFit()
          .frame(height: 60)
        Text(isError ? Lingua.General.error : Lingua.General.success)
          .font(.title)
          .bold()
          .foregroundColor(isError ? .red : .green)
        Text(message)
          .multilineTextAlignment(.center)
          .foregroundColor(.gray)
      }
      .padding()
      .background(Color(NSColor.windowBackgroundColor))
      .cornerRadius(10)
      .shadow(radius: 10)
      .padding(40)
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        dismiss()
      }
    }
  }
}

extension HUDOverlay {
  func dismiss() {
    withAnimation {
      onDismiss?()
    }
  }
}
