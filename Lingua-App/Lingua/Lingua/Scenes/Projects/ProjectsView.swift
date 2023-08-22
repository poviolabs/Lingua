//
//  ProjectsView.swift
//  Lingua
//
//  Created by Egzon Arifi on 17/08/2023.
//

import SwiftUI

struct ProjectsView: View {
  @ObservedObject private var viewModel = ProjectsViewModel()
  @State private var showingCreateProject: Bool = false
  @State private var showAlert: Bool = false
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
          deletionButton(for: project, at: index)
        }
        .contextMenu {
          deletionButton(for: project, at: index)
        }
      }
      .navigationSplitViewColumnWidth(min: 250, ideal: 250, max: 400)
      .listStyle(DefaultListStyle())
      .toolbar {
        Button(action: {
          showingCreateProject = true
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
    .sheet(isPresented: $showingCreateProject, content: {
      Text("New project")
    })
    .alert(isPresented: $showAlert) {
      deletionAlert()
    }
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
      }
    )
    .navigationSplitViewColumnWidth(min: 400, ideal: 600)
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
  
  func deletionAlert() -> Alert {
    Alert(
      title: Text(Lingua.Projects.deleteAlertTitle),
      message: Text(Lingua.Projects.deleteAlertMessage(projectToDelete?.project.title ?? Lingua.General.this)),
      primaryButton: .destructive(Text(Lingua.General.delete), action: {
        guard let index = projectToDelete?.index else { return }
        withAnimation {
          viewModel.deleteProject(at: index)
        }
      }),
      secondaryButton: .cancel())
  }
  
  func confirmDelete(for project: Project, index: Int) {
    projectToDelete = (project, index)
    showAlert = true
  }
}
