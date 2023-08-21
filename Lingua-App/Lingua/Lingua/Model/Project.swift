//
//  Project.swift
//  Lingua
//
//  Created by Egzon Arifi on 17/08/2023.
//

import SwiftUI
import LinguaLib

struct Project: Identifiable, Hashable {
  var id: UUID
  var type: LocalizationPlatform
  var apiKey: String
  var sheetId: String
  var directoryPath: String
  var title: String
  
  var icon: Image {
    switch type {
    case .ios:
      return Image(systemName: "apple.logo")
    case .android:
      return Image(systemName: "a.square.fill")
    }
  }
}
