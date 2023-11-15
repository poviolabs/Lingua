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
  private var sortedProjects: [Project] {
    projects.sorted(by: {
      $0.lastLocalizedAt ?? Date.distantPast > $1.lastLocalizedAt ?? Date.distantPast
    })
  }
  var filteredProjects: [Project] {
    guard !searchTerm.isEmpty else { return sortedProjects }
    return sortedProjects.filter { $0.title.localizedCaseInsensitiveContains(searchTerm) }
  }
  @Published var searchTerm: String = ""
  var selectedProject: Project? {
    projects.first(where: { $0.id == selectedProjectId })
  }
  @Published var isLocalizing: Bool = false
  @Published var showDeleteAlert: Bool = false
  @Published var projectToDelete: Project?
  @Published var localizationResult: Result<String, Error>?
  @Published var selectedProjectId: UUID?
  
  private let localizationManager = LocalizationManager(directoryAccessor: DirectoryAccessor())
}

// MARK: - Public Methods
extension ProjectsViewModel {
  func deleteProject(_ project: Project) {
    guard let index = projects.firstIndex(where: { $0.id == project.id }) else { return }
    if projects[index] == selectedProject {
      selectedProjectId = nil
    }
    projects.remove(at: index)
  }
  
  func addProject(_ project: Project) {
    projects.append(project)
  }
  
  func updateProject(_ project: Project) {
    guard let index = projects.firstIndex(where: { $0.id == project.id }) else { return }
    projects[index] = project
    
    if selectedProject?.id == project.id {
      updateSelectedProject(project)
    }
  }
  
  func createNewProject() {
    let newProject = Project(id: UUID(), type: .ios, title: Lingua.Projects.newProject)
    projects.append(newProject)
    updateSelectedProject(newProject)
  }
  
  func duplicate(_ project: Project) {
    let newProject = Project(id: UUID(),
                             type: project.type,
                             apiKey: project.apiKey,
                             sheetId: project.sheetId,
                             title: Lingua.Projects.copyProject(project.title))
    projects.append(newProject)
    updateSelectedProject(newProject)
  }
  
  func selectFirstProject() {
    guard let firstProject = filteredProjects.first else { return }
    updateSelectedProject(firstProject)
  }
  
  @MainActor
  func updateSyncDate(for project: Project) {
    if let index = projects.firstIndex(where: { $0.id == project.id }) {
      var updatedProject = project
      updatedProject.lastLocalizedAt = Date()
      projects[index] = updatedProject
    
      updateSelectedProject(updatedProject)
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

// MARK: - Private methods
private extension ProjectsViewModel {
  func updateSelectedProject(_ project: Project) {
    withAnimation(.easeIn(duration: 0.5)) {
      self.selectedProjectId = project.id
    }
  }
}
