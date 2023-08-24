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
  
  @State private var apiKeyValid = false
  @State private var sheetIdValid = false
  @State private var titleValid = true
  @State private var outputPathValid = false
  @State private var stringsDirectoryValid = false
  @State private var outputSwiftCodeFileDirectoryValid = false
  
  var onSave: ((Project) -> Void)? = nil
  var onDelete: ((Project) -> Void)? = nil
  var onLocalize: ((Project) -> Void)? = nil
  
  var body: some View {
    VStack(alignment: .leading) {
      Form {
        basicConfigurationFormSection()
        swiftCodeFormSection()
        iOSInfoFormSection()
      }
      .navigationTitle(project.title)
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          localizeButton(for: project)
        }
      }
      .onChange(of: project) { newValue in
        onSave?(newValue)
      }
      .formStyle(.grouped)
      
      deleteButton(for: project).padding()
    }
    .padding()
  }
}

private extension ProjectFormView {
  var allFieldsValid: Bool {
    let basicValidation = apiKeyValid && sheetIdValid && titleValid && outputPathValid
    if project.type == .ios && project.swiftCodeEnabled {
      return basicValidation && stringsDirectoryValid && outputSwiftCodeFileDirectoryValid
    }
    return basicValidation
  }
  
  @ViewBuilder
  func basicConfigurationFormSection() -> some View {
    Section(header: Text(Lingua.ProjectForm.configurationSection).font(.headline)) {
      Picker(Lingua.ProjectForm.platformPickerTitle, selection: $project.type) {
        ForEach(LocalizationPlatform.allCases) { type in
          Text(type.title).tag(type)
        }
      }.padding([.leading], 8)
      
      ValidatingTextField(title: Lingua.ProjectForm.inputProjectName, validation: RequiredRule(), text: $project.title, isValid: $titleValid)
      ValidatingTextField(title: Lingua.ProjectForm.inputApiKey, validation: RequiredRule(), text: $project.apiKey, isValid: $apiKeyValid)
      ValidatingTextField(title: Lingua.ProjectForm.inputSheetId, validation: RequiredRule(), text: $project.sheetId, isValid: $sheetIdValid)
      
      DirectoryInputField(title: Lingua.ProjectForm.inputDirectoryOutput,
                          bookmarkDataKey: project.bookmarkDataForDirectoryPath,
                          directoryPath: $project.directoryPath,
                          isValid: $outputPathValid,
                          onDirectorySelected: updateDirectoryPaths)
    }
  }
  
  @ViewBuilder
  func swiftCodeFormSection() -> some View {
    if project.type == .ios {
      Section {
        Toggle(isOn: $project.swiftCodeEnabled) {
          Text(Lingua.ProjectForm.swiftCodeToggleTitle).bold()
        }
        
        if project.swiftCodeEnabled {
          VStack(alignment: .leading, spacing: 8) {
            Text(Lingua.ProjectForm.swiftCodeSection).font(.headline)
            Text(Lingua.ProjectForm.swiftCodeDescription)
              .font(.subheadline)
          }
          .padding(8)
          
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
    }
  }
  
  @ViewBuilder
  func iOSInfoFormSection() -> some View {
    if project.type == .ios {
      Section(Lingua.ProjectForm.infoHeader) {
        Text(Lingua.ProjectForm.iosLocalizationInfoMessage(project.title)).font(.subheadline)
      }
    }
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
      onLocalize?(project)
    }) {
      HStack {
        Image(systemName: "globe")
        Text(Lingua.ProjectForm.localizeButton)
      }
    }
    .disabled(!allFieldsValid || viewModel.isLocalizing)
  }
  
  func updateDirectoryPaths(for directory: String) {
    if project.swiftCode.outputSwiftCodeFileDirectory.isEmpty {
      project.swiftCode.outputSwiftCodeFileDirectory = directory
    }
    
    guard let directoryURL = URL(string: directory) else { return }
    try? directoryURL.saveBookmarkData(forKey: project.bookmarkDataForOutputSwiftCodeFileDirectory)
    
    guard project.swiftCode.stringsDirectory.isEmpty else { return }
    let directoryPath = directoryURL.path
    let fileManager = FileManager.default
    
    guard let subpaths = fileManager.subpaths(atPath: directoryPath) else { return }
    
    let enLprojPath = directoryPath.appending("/en.lproj")
    if subpaths.contains(where: { $0 == "en.lproj" }) || !subpaths.contains(where: { $0.hasSuffix(".lproj") }) {
      let enLprojURL = URL(fileURLWithPath: enLprojPath)
      project.swiftCode.stringsDirectory = enLprojURL.absoluteString
      try? enLprojURL.saveBookmarkData(forKey: project.bookmarkDataForStringsDirectory)
    } else if let firstLprojRelativePath = subpaths.first(where: { $0.hasSuffix(".lproj") }) {
      let firstLprojFullPath = directoryPath.appending("/\(firstLprojRelativePath)")
      let firstLprojFullURL = URL(fileURLWithPath: firstLprojFullPath)
      project.swiftCode.stringsDirectory = firstLprojFullURL.absoluteString
      try? firstLprojFullURL.saveBookmarkData(forKey: project.bookmarkDataForStringsDirectory)
    }
  }
}
