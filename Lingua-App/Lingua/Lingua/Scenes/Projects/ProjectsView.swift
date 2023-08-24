//
//  ProjectsView.swift
//  Lingua
//
//  Created by Egzon Arifi on 17/08/2023.
//

import SwiftUI

struct ProjectsView: View {
  @ObservedObject private var viewModel = ProjectsViewModel()
  @State private var showDeleteAlert: Bool = false
  @State private var projectToDelete: (project: Project, index: Int)?
  
  var body: some View {
    NavigationSplitView {
      List(
        Array(zip(viewModel.projects.indices, viewModel.projects)),
        id: \.1.id,
        selection: $viewModel.selectedProject
      ) { index, project in
        NavigationLink(value: project) {
          ProjectItemView(project: project)
        }
        .swipeActions(edge: .trailing) {
          duplicateButton(for: project, at: index)
          deletionButton(for: project, at: index)
        }
        .contextMenu {
          duplicateButton(for: project, at: index)
          deletionButton(for: project, at: index)
        }
      }
      .navigationSplitViewColumnWidth(min: 250, ideal: 250, max: 400)
      .listStyle(DefaultListStyle())
      .toolbar {
        Button(action: {
          withAnimation {
            viewModel.createNewProject()
          }
        }) {
          Image(systemName: "plus")
        }
      }
    } detail: {
      if let project = viewModel.selectedProject {
        projectFormView(for: project)
      } else {
        Text(Lingua.Projects.placeholder)
      }
    }
    .onAppear { viewModel.selectFirstProject() }
    .alert(isPresented: $showDeleteAlert) {
      deletionAlert()
    }
    .overlay(ProgressOverlay(isProgressing: $viewModel.isLocalizing, text: Lingua.Projects.localizing))
    .overlay(hudResultOverlay())
    
  }
}

private extension ProjectsView {
  @ViewBuilder
  func projectFormView(for project: Project) -> some View {
    ProjectFormView(
      project: $viewModel.selectedProject.unwrapped(or: project),
      viewModel: viewModel,
      onSave: { updatedProject in
        viewModel.updateProject(updatedProject)
      },
      onDelete: { deletedProject in
        if let index = viewModel.projects.firstIndex(where: { $0.id == project.id }) {
          confirmDelete(for: deletedProject, index: index)
        }
      },
      onLocalize: { projectToLocalize in
        Task { await viewModel.localizeProject(projectToLocalize) }
      }
    )
    .navigationSplitViewColumnWidth(min: 400, ideal: 600)
  }
  
  @ViewBuilder
  func hudResultOverlay() -> some View {
    switch viewModel.localizationResult {
    case .success(let message):
      HUDOverlay(message: message, isError: false) {
        viewModel.localizationResult = nil
      }
    case .failure(let error):
      HUDOverlay(message: error.localizedDescription, isError: true) {
        viewModel.localizationResult = nil
      }
    case .none:
      EmptyView()
    }
  }
  
  @ViewBuilder
  func deletionButton(for project: Project, at index: Int) -> some View {
    Button(action: {
      confirmDelete(for: project, index: index)
    }) {
      Text(Lingua.General.delete)
      Image(systemName: "trash")
    }
    .tint(.red)
  }
  
  @ViewBuilder
  func duplicateButton(for project: Project, at index: Int) -> some View {
    Button(action: {
      viewModel.duplicate(project)
    }) {
      Text(Lingua.General.duplicate)
      Image(systemName: "doc.on.doc")
    }
    .tint(.blue)
  }
  
  func deletionAlert() -> Alert {
    Alert(
      title: Text(Lingua.Projects.deleteAlertTitle),
      message: Text(Lingua.Projects.deleteAlertMessage(projectToDelete?.project.title ?? Lingua.General.this)),
      primaryButton: .destructive(Text(Lingua.General.delete), action: {
        guard let index = projectToDelete?.index else { return }
        viewModel.deleteProject(at: index)
      }),
      secondaryButton: .cancel())
  }
  
  func confirmDelete(for project: Project, index: Int) {
    projectToDelete = (project, index)
    showDeleteAlert = true
  }
}
