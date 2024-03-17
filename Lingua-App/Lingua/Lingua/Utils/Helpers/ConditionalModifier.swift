//
//  ConditionalModifier.swift
//  Lingua
//
//  Created by Yll Fejziu on 24/11/2023.
//

import SwiftUI

struct ConditionalModifier: ViewModifier {
  var shouldShow: Bool

  func body(content: Content) -> some View {
    if shouldShow {
      content
    }
  }
}

extension View {
  func shouldAddView(_ condition: Bool) -> some View {
    self.modifier(ConditionalModifier(shouldShow: condition))
  }
}
