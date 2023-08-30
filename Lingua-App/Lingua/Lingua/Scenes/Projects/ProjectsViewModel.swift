//
//  ProjectsViewModel.swift
//  Lingua
//
//  Created by Egzon Arifi on 18/08/2023.
//

import SwiftUI

class ProjectsViewModel: ObservableObject {
  @Published var projects: [Project] = UserDefaults.getProjects() {
    didSet { UserDefaults.setProjects(projects) }
  }
  var sortedProjects: [Project] {
      projects.sorted(by: { $0.lastLocalizedAt ?? Date.distantPast > $1.lastLocalizedAt ?? Date.distantPast })
  }
  @Published var selectedProject: Project?
  @Published var isLocalizing: Bool = false
  @Published var localizationResult: Result<String, Error>?
  
  private let localizationManager = LocalizationManager(directoryAccessor: DirectoryAccessor())
  
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
  
  func selectFirstProject() {
    selectedProject = sortedProjects.first
  }
  
  func updateSyncDate(for project: Project) {
    if let index = projects.firstIndex(where: { $0.id == project.id }) {
      var updatedProject = projects[index]
      updatedProject.lastLocalizedAt = Date()
      projects[index] = updatedProject
      
      withAnimation {
        selectedProject = updatedProject
      }
    }
  }
  
  @MainActor
  func localizeProject(_ project: Project) async {
    withAnimation {
      isLocalizing = true
      localizationResult = nil
    }
    
    do {
      let message = try await localizationManager.localize(project: project)
      updateSyncDate(for: project)
      localizationResult = .success(message)
    } catch {
      localizationResult = .failure(error)
    }
    
    withAnimation {
      isLocalizing = false
    }
  }
}
