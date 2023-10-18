//
//  ContentView.swift
//  Lingua
//
//  Created by Egzon Arifi on 17/08/2023.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject private var viewModel: ProjectsViewModel

  var body: some View {
    ProjectsView()
      .environmentObject(viewModel)
  }
}
