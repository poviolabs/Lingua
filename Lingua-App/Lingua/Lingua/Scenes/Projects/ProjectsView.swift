//
//  ProjectsView.swift
//  Lingua
//
//  Created by Egzon Arifi on 17/08/2023.
//

import SwiftUI

struct ProjectsView: View {
  @State private var viewModel = ProjectsViewModel()
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
        Text(project.title)
      } else {
        Text("Select a project or add a new one.")
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
  func deletionButton(for project: Project, at index: Int) -> some View {
    Button(action: {
      confirmDelete(for: project, index: index)
    }) {
      Text("Delete")
      Image(systemName: "trash")
    }
    .tint(.red)
  }
  
  func deletionAlert() -> Alert {
    Alert(
      title: Text("Confirmation"),
      message: Text("Are you sure you want to delete \(projectToDelete?.project.title ?? "this") project?"),
      primaryButton: .destructive(Text("Delete"), action: {
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
