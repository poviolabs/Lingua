//
//  ProjectsView.swift
//  Lingua
//
//  Created by Egzon Arifi on 17/08/2023.
//

import SwiftUI

struct ProjectsView: View {
  @EnvironmentObject private var viewModel: ProjectsViewModel
  @State private var columnVisibility = NavigationSplitViewVisibility.automatic

  var body: some View {
    NavigationSplitView(columnVisibility: $columnVisibility) {
      VStack {
        HStack {
          Image(systemName: "folder")
          Text("Projects")
        }
        Spacer()
      }
    } content: {
      CustomSearchBar(searchTerm: $viewModel.searchTerm)

      List(viewModel.filteredProjects, selection: $viewModel.selectedProjectId) { project in
        ProjectItemView(project: project)
          .swipeActions(edge: .trailing) {
            duplicateButton(for: project)
            deletionButton(for: project)
          }
          .contextMenu {
            duplicateButton(for: project)
            deletionButton(for: project)
          }
      }
      .navigationSplitViewColumnWidth(min: 340, ideal: 340, max: 500)
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
          .toolbar {
            Spacer()
          }
      } else {
        Text(Lingua.Projects.placeholder)
          .toolbar {
            Spacer()
          }
      }
    }
    .scrollContentBackground(.hidden)
    .onAppear {
      viewModel.selectFirstProject()
      columnVisibility = .doubleColumn
    }
    .alert(isPresented: $viewModel.showDeleteAlert) { deletionAlert() }
    .overlay(ProgressOverlay(
      isProgressing: $viewModel.isLocalizing,
      text: Lingua.Projects.localizing
    ))
    .overlay(hudResultOverlay())
  }
}

// MARK: - Private View Builders
private extension ProjectsView {
  func projectFormView(for project: Project) -> some View {
    ProjectFormView(
      viewModel: ProjectFormViewModel(project: project),
      isLocalizing: $viewModel.isLocalizing,
      onSave: { updatedProject in
        viewModel.updateProject(updatedProject)
      },
      onDelete: { deletedProject in
        confirmDelete(for: deletedProject)
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
  func deletionButton(for project: Project) -> some View {
    Button(action: {
      confirmDelete(for: project)
    }) {
      Text(Lingua.General.delete)
      Image(systemName: "trash")
    }
    .tint(.red)
  }
  
  @ViewBuilder
  func duplicateButton(for project: Project) -> some View {
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
      message: Text(Lingua.Projects.deleteAlertMessage(viewModel.projectToDelete?.title ?? Lingua.General.this)),
      primaryButton: .destructive(Text(Lingua.General.delete), action: {
        guard let project = viewModel.projectToDelete else { return }
        viewModel.deleteProject(project)
      }),
      secondaryButton: .cancel())
  }
  
  func confirmDelete(for project: Project) {
    viewModel.projectToDelete = project
    viewModel.showDeleteAlert = true
  }
}
