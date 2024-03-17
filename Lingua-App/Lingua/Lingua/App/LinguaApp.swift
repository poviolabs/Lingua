//
//  LinguaApp.swift
//  Lingua
//
//  Created by Egzon Arifi on 17/08/2023.
//

import SwiftUI

@main
struct LinguaApp: App {
  @Environment(\.openWindow) private var openWindow
  @StateObject var viewModel = ProjectsViewModel()
  var commands: LinguaAppCommands {
    LinguaAppCommands(viewModel: viewModel)
  }
  
  var body: some Scene {
    WindowGroup(id: Window.main.rawValue) {
      ContentView()
        .environmentObject(viewModel)
    }
    .commands {
      commands.aboutApp()
      commands.projectCommands
    }
    
    MenuBarExtra(String.packageName, image: "lingua_menu_bar_icon") {
      VStack(spacing: 0) {
        ProjectListView(shouldAddLocalizeButton: true)
          .environmentObject(viewModel)

        Divider()

        HStack(alignment: .center) {
          Button(Lingua.App.settings) {
            openMainWindow()
          }
          .frame(height: 26)
          .buttonStyle(.plain)
          .padding(.horizontal, 16)
          .padding(.vertical, 4)

          Spacer()
        }
      }
    }
    .menuBarExtraStyle(.window)
  }

  func openMainWindow() {
    // Don't open the main app if the window is already opened
    guard let windows = NSWindow.windowNumbers(),
            windows.count <= 3 else { return }
    openWindow(id: Window.main.rawValue)
  }
}
