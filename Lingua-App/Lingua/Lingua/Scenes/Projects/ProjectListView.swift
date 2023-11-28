//
//  ProjectListView.swift
//  Lingua
//
//  Created by Yll Fejziu on 24/11/2023.
//

import SwiftUI

struct ProjectListView: View {
  @EnvironmentObject private var viewModel: ProjectsViewModel
  var shouldAddLocalizeButton: Bool = false

  var body: some View {
    CustomSearchBar(searchTerm: $viewModel.searchTerm)

    List(viewModel.filteredProjects, selection: $viewModel.selectedProjectId) { project in
      HStack {
        ProjectItemView(project: project)
          .swipeActions(edge: .trailing) {
            duplicateButton(for: project)
              .shouldAddView(!shouldAddLocalizeButton)
            deletionButton(for: project)
              .shouldAddView(!shouldAddLocalizeButton)
          }
          .contextMenu {
            duplicateButton(for: project)
              .shouldAddView(!shouldAddLocalizeButton)
            deletionButton(for: project)
              .shouldAddView(!shouldAddLocalizeButton)
          }

        Button(action: {
          Task { await viewModel.localizeProject(project) }
        }) {
          HStack {
            Image(systemName: "globe")
            Text(Lingua.ProjectForm.localizeButton)
          }
        }
        .shouldAddView(shouldAddLocalizeButton)
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
      .shouldAddView(!shouldAddLocalizeButton)
    }
    .overlay {
      ProgressView()
        .shouldAddView(shouldAddLocalizeButton && viewModel.isLocalizing)
    }
    .disabled(viewModel.isLocalizing)
    .opacity(viewModel.isLocalizing ? 0.5 : 1)
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
}

extension ProjectListView {
  @ViewBuilder
  func deletionButton(for project: Project) -> some View {
    Button(action: {
      viewModel.confirmDelete(for: project)
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
}
