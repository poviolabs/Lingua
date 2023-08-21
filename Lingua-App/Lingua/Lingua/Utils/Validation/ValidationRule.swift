//
//  ValidationRule.swift
//  Lingua
//
//  Created by Egzon Arifi on 21/08/2023.
//

import Foundation

public protocol ValidationRule {
  var error: String { get }
  func validate(_ input: String?) -> Bool
}
