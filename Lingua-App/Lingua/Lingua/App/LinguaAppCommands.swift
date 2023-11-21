//
//  LinguaAppCommands.swift
//  Lingua
//
//  Created by Egzon Arifi on 16/10/2023.
//

import SwiftUI

struct LinguaAppCommands {
  @ObservedObject var viewModel: ProjectsViewModel
  
  var projectCommands: some Commands {
    CommandMenu(Lingua.ProjectMenu.title) {
      newProjectButton()
      localizeProjectButton()
      duplicateProjectButton()
      deleteProjectButton()
    }
  }
}

// MARK: - AboutApp
extension LinguaAppCommands {
  func aboutApp() -> CommandGroup<Button<Text>> {
    CommandGroup(replacing: .appInfo) {
      Button(Lingua.App.about) {
        NSApplication.shared.orderFrontStandardAboutPanel(
          options: [
            NSApplication.AboutPanelOptionKey.credits: NSAttributedString(
              string: Lingua.App.description,
              attributes: [
                NSAttributedString.Key.font: NSFont.boldSystemFont(
                  ofSize: NSFont.smallSystemFontSize)
              ]
            ),
            NSApplication.AboutPanelOptionKey(
              rawValue: Lingua.App.copyright
            ): Lingua.App.copyrightYear
          ]
        )
      }
    }
  }
}

// MARK: - Project Menu
private extension LinguaAppCommands {
  func newProjectButton() -> some View {
    Button(action: {
      withAnimation {
        viewModel.createNewProject()
      }
    }) {
      Text(Lingua.ProjectMenu.new)
    }
    .keyboardShortcut("n", modifiers: [.command, .shift])
  }
  
  func localizeProjectButton() -> some View {
    Button(action: {
      guard let selectedProject = viewModel.selectedProject else { return }
      Task { await viewModel.localizeProject(selectedProject) }
    }) {
      Text(Lingua.ProjectMenu.localize)
    }
    .keyboardShortcut("l", modifiers: [.command, .shift])
    .disabled(!(viewModel.selectedProject?.isValid() ?? false))
  }
  
  func duplicateProjectButton() -> some View {
    Button(action: {
      guard let selectedProject = viewModel.selectedProject else { return }
      viewModel.duplicate(selectedProject)
    }) {
      Text(Lingua.ProjectMenu.duplicate)
    }
    .keyboardShortcut("d", modifiers: [.command, .shift])
    .disabled(viewModel.selectedProject == nil)
  }
  
  func deleteProjectButton() -> some View {
    Button(action: {
      viewModel.projectToDelete = viewModel.selectedProject
      viewModel.showDeleteAlert = true
    }) {
      Text(Lingua.ProjectMenu.delete)
    }
    .keyboardShortcut(.delete, modifiers: [.command])
    .disabled(viewModel.selectedProject == nil)
  }
}
