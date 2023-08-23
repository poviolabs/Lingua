//
//  Project.swift
//  Lingua
//
//  Created by Egzon Arifi on 17/08/2023.
//

import SwiftUI
import LinguaLib

struct Project: Identifiable, Hashable, Equatable, Codable {
  var id: UUID
  var type: LocalizationPlatform
  var apiKey: String
  var sheetId: String
  var directoryPath: String
  var title: String
  var swiftCode: SwiftCode
  
  init(id: UUID,
       type: LocalizationPlatform,
       apiKey: String = "",
       sheetId: String = "",
       directoryPath: String = "",
       title: String = "",
       swiftCode: SwiftCode = .init(stringsDirectory: "", outputSwiftCodeFileDirectory: "")) {
    self.id = id
    self.type = type
    self.apiKey = apiKey
    self.sheetId = sheetId
    self.directoryPath = directoryPath
    self.title = title
    self.swiftCode = swiftCode
  }
}

extension Project {
  struct SwiftCode: Hashable, Equatable, Codable {
    var stringsDirectory: String
    var outputSwiftCodeFileDirectory: String
  }
  
  var bookmarkDataForDirectoryPath: String {
    directoryPath
  }
  
  var bookmarkDataForOutputSwiftCodeFileDirectory: String {
    swiftCode.outputSwiftCodeFileDirectory
  }
  
  var bookmarkDataForStringsDirectory: String {
    swiftCode.stringsDirectory
  }
  
  var icon: Image {
    switch type {
    case .ios:
      return Image(systemName: "apple.logo")
    case .android:
      return Image(systemName: "a.square.fill")
    }
  }
}
