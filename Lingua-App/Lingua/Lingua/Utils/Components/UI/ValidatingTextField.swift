//
//  ValidatingTextField.swift
//  Lingua
//
//  Created by Egzon Arifi on 21/08/2023.
//

import SwiftUI

struct ValidatingTextField: View {
  var title: String
  var validation: ValidationRule
  var isDisabled: Bool = false
  @Binding var text: String
  @Binding var isValid: Bool
  
  @State private var errorMessage: String? = nil
  @FocusState private var isFocused: Bool
  
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      TextField(title, text: $text)
        .disabled(isDisabled)
        .onChange(of: text, perform: { value in
          isValid = validation.validate(value)
          errorMessage = isValid ? nil : validation.error
        })
        .focused($isFocused)
        .onChange(of: isFocused, perform: { focused in
          if !focused {
            validate()
          }
        })
      
      if let error = errorMessage {
        Text(error)
          .foregroundColor(.red)
          .font(.caption)
      }
    }
  }
}

private extension ValidatingTextField {
  func validate() {
    isValid = validation.validate(text)
    errorMessage = isValid ? nil : validation.error
  }
}
