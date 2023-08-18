//
//  LocalizationPlatform+Extension.swift
//  Lingua
//
//  Created by Egzon Arifi on 17/08/2023.
//

import Foundation
import LinguaLib

extension LocalizationPlatform {
  var title: String {
    switch self {
    case .ios:
      return "iOS"
    case .android:
      return "Android"
    }
  }
}
