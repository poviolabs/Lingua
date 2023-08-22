//
//  ProjectsViewModel.swift
//  Lingua
//
//  Created by Egzon Arifi on 18/08/2023.
//

import SwiftUI

class ProjectsViewModel: ObservableObject {
  @Published var projects: [Project] = []
  @Published var selectedProject: Project?
  
  func deleteProject(at index: Int) {
    if projects[index] == selectedProject {
      selectedProject = nil
    }
    projects.remove(at: index)
  }
  
  func addProject(_ project: Project) {
    projects.append(project)
  }
  
  func updateProject(_ project: Project) {
    guard let index = projects.firstIndex(where: { $0.id == project.id }) else { return }
    projects[index] = project
  }
  
  func createNewProject() {
    let newProject = Project(id: UUID(), type: .ios, title: Lingua.Projects.newProject)
    projects.append(newProject)
    selectedProject = newProject
  }
  
  func duplicate(_ project: Project) {
    let newProject = Project(id: UUID(),
                             type: project.type,
                             apiKey: project.apiKey,
                             sheetId: project.sheetId,
                             title: Lingua.Projects.copyProject(project.title))
    projects.append(newProject)
    selectedProject = newProject
  }
}

