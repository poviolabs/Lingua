//
//  LinguaApp.swift
//  Lingua
//
//  Created by Egzon Arifi on 17/08/2023.
//

import SwiftUI

@main
struct LinguaApp: App {
  @StateObject var viewModel = ProjectsViewModel()
  var commands: LinguaAppCommands {
    LinguaAppCommands(viewModel: viewModel)
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(viewModel)
    }
    .commands {
      commands.aboutApp()
      commands.projectCommands
    }
  }
}
