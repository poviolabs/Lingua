//
//  ProjectRow.swift
//  Lingua
//
//  Created by Egzon Arifi on 17/08/2023.
//

import SwiftUI

struct ProjectItemView: View {
  var project: Project
  
  var body: some View {
    HStack {
      project.icon
        .resizable()
        .scaledToFit()
        .frame(width: 30, height: 30)
      
      VStack(alignment: .leading) {
        Text(project.title)
          .font(.headline)
        Text(project.type.title)
          .font(.subheadline)
      }
      
      Spacer()
    }
    .padding(.vertical, 10)
  }
}
