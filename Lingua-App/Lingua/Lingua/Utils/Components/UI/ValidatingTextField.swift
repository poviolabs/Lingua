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
  
  @State private var localText: String
  @State private var errorMessage: String? = nil
  @FocusState private var isFocused: Bool
  
  init(title: String,
       validation: ValidationRule,
       isDisabled: Bool = false,
       text: Binding<String>,
       isValid: Binding<Bool>) {
    self.title = title
    self.validation = validation
    self.isDisabled = isDisabled
    self._text = text
    self._isValid = isValid
    self._localText = State(initialValue: text.wrappedValue)
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      TextField(title, text: $localText)
        .disabled(isDisabled)
        .cornerRadius(8)
        .focused($isFocused)
        .onChange(of: isFocused) { focused in
          if !focused {
            validate()
          }
        }
      
      if let errorMessage {
        Text(errorMessage)
          .foregroundColor(.red)
          .font(.caption)
      }
    }
    .onAppear {
      isValid = validation.validate(text)
    }
    .onChange(of: localText) { newValue in
      if text != newValue {
        text = newValue
      }
      validate()
    }
    .onChange(of: text) { newValue in
      if localText != newValue {
        localText = newValue
      }
      validate()
    }
  }
}

// MARK: - Private Methods
private extension ValidatingTextField {
  func validate() {
    isValid = validation.validate(localText)
    errorMessage = isValid ? nil : validation.error
  }
}
