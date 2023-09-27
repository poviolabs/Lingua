//
//  Binding+Project.swift
//  Lingua
//
//  Created by Egzon Arifi on 21/08/2023.
//

import SwiftUI

extension Binding where Value == Project? {
  func unwrapped(or defaultValue: Project) -> Binding<Project> {
    Binding<Project>(
      get: {
        return self.wrappedValue ?? defaultValue
      },
      set: {
        self.wrappedValue = $0
      }
    )
  }
}
