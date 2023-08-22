//
//  ProjectFormView.swift
//  Lingua
//
//  Created by Egzon Arifi on 21/08/2023.
//

import SwiftUI
import LinguaLib

struct ProjectFormView: View {
  @Binding var project: Project
  @ObservedObject var viewModel: ProjectsViewModel
  
  @State private var apiKeyValid = true
  @State private var sheetIdValid = true
  @State private var titleValid = true
  @State private var outputPathValid = true
  @State private var stringsDirectoryValid = true
  @State private var outputSwiftCodeFileDirectoryValid = true

  var onSave: ((Project) -> Void)? = nil
  var onDelete: ((Project) -> Void)? = nil
  var onSync: ((Project) -> Void)? = nil
  
  var body: some View {
    Form {
      Section(header: Text(Lingua.ProjectForm.configurationSection).font(.headline)) {
        Divider()
        Picker(Lingua.ProjectForm.platformPickerTitle, selection: $project.type) {
          ForEach(LocalizationPlatform.allCases) { type in
            Text(type.title).tag(type)
          }
        }
        
        ValidatingTextField(title: Lingua.ProjectForm.inputProjectName, validation: RequiredRule(), text: $project.title, isValid: $titleValid)
        ValidatingTextField(title: Lingua.ProjectForm.inputApiKey, validation: RequiredRule(), text: $project.apiKey, isValid: $apiKeyValid)
        ValidatingTextField(title: Lingua.ProjectForm.inputSheetId, validation: RequiredRule(), text: $project.sheetId, isValid: $sheetIdValid)
        DirectoryInputField(title: Lingua.ProjectForm.inputDirectoryOutput,
                            bookmarkDataKey: project.bookmarkDataForDirectoryPath,
                            directoryPath: $project.directoryPath,
                            isValid: $outputPathValid)
      }
      
      if project.type == .ios {
        Divider()
        Section(header: Text(Lingua.ProjectForm.swiftCodeSection).font(.headline)) {
          Text(Lingua.ProjectForm.swiftCodeDescription)
            .font(.subheadline)
            .padding([.top, .bottom], 8)
          
          DirectoryInputField(title: Lingua.ProjectForm.stringsDirectory,
                              bookmarkDataKey: project.bookmarkDataForStringsDirectory,
                              directoryPath: $project.swiftCode.stringsDirectory,
                              isValid: $stringsDirectoryValid)
          DirectoryInputField(title: Lingua.ProjectForm.linguaSwiftOutputDirectory,
                              bookmarkDataKey: project.bookmarkDataForOutputSwiftCodeFileDirectory ,
                              directoryPath: $project.swiftCode.outputSwiftCodeFileDirectory,
                              isValid: $outputSwiftCodeFileDirectoryValid)
        }
      }
      
      Spacer()
      deleteButton(for: project).padding()
    }
    .padding()
    .navigationTitle(project.title)
    .toolbar {
      ToolbarItem(placement: .primaryAction) {
        localizeButton(for: project)
      }
    }
    .onChange(of: project) { newValue in
      onSave?(newValue)
    }
  }
}

private extension ProjectFormView {
  var allFieldsValid: Bool {
    let basicValidation = apiKeyValid && sheetIdValid && titleValid && outputPathValid
    if project.type == .ios {
      return basicValidation && stringsDirectoryValid && outputSwiftCodeFileDirectoryValid
    }
    return basicValidation
  }
  
  @ViewBuilder
  func deleteButton(for project: Project) -> some View {
    Button(action: {
      onDelete?(project)
    }, label: {
      Image(systemName: "trash")
        .foregroundColor(.red)
      Text(Lingua.General.delete)
        .foregroundColor(.red)
    })
  }
  
  @ViewBuilder
  func localizeButton(for project: Project) -> some View {
    Button(action: {
      // Localize project
    }) {
      HStack {
        Image(systemName: "globe")
        Text(Lingua.ProjectForm.localizeButton)
      }
    }
    .disabled(!allFieldsValid)
  }
}
