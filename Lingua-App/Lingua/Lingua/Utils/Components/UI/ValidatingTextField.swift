//
//  ValidatingTextField.swift
//  Lingua
//
//  Created by Egzon Arifi on 21/08/2023.
//

import SwiftUI
import Combine

struct ValidatingTextField: View {
  var title: String
  var validation: ValidationRule
  var isDisabled: Bool = false
  @Binding var text: String
  @Binding var isValid: Bool
  
  @State private var localText: String
  @State private var errorMessage: String? = nil
  @FocusState private var isFocused: Bool
  @State private var textChangeCancellable: AnyCancellable?

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
        .focused($isFocused)
        .frame(minHeight: 20)
        .padding(.trailing)
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
    .contentShape(Rectangle())
    .onTapGesture {
      isFocused = true
    }
    .onAppear {
      isValid = validation.validate(text)
    }
    .onChange(of: localText) { newValue in
      textChangeCancellable?.cancel()
      textChangeCancellable = Just(newValue)
        .delay(for: 0.2, scheduler: RunLoop.main)
        .sink { delayedValue in
          if self.text != delayedValue {
            self.text = delayedValue
          }
          validate()
        }
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
