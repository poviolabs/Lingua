//
//  ProjectFormViewModel.swift
//  Lingua
//
//  Created by Egzon Arifi on 14/11/2023.
//

import SwiftUI

class ProjectFormViewModel: ObservableObject {
  @Published var project: Project
  
  init(project: Project) {
    self.project = project
  }
}

