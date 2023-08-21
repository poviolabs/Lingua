//
//  RequiredRule.swift
//  Lingua
//
//  Created by Egzon Arifi on 21/08/2023.
//

import Foundation

struct RequiredRule: ValidationRule {
  let error: String
  
  init(error: String = "This field cannot be empty") {
    self.error = error
  }
  
  func validate(_ input: String?) -> Bool {
    guard let input = input else { return false }
    return !input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }
}
