//
//  LocalizationManager.swift
//  Lingua
//
//  Created by Egzon Arifi on 22/08/2023.
//

import Foundation
import LinguaLib

struct LocalizationManager {
  let directoryAccessor: DirectoryAccessor
  
  func localize(project: Project) async throws -> String {
    let _ = try await directoryAccessor.accessDirectory(fromBookmarkKey: project.bookmarkDataForDirectoryPath)
    let _ = try await directoryAccessor.accessDirectory(fromBookmarkKey: project.bookmarkDataForStringsDirectory)
    let _ = try await directoryAccessor.accessDirectory(fromBookmarkKey: project.bookmarkDataForOutputSwiftCodeFileDirectory)
    
    var localizedSwiftCode: Config.LocalizedSwiftCode?
    if !project.swiftCode.stringsDirectory.isEmpty,
       !project.swiftCode.outputSwiftCodeFileDirectory.isEmpty {
      localizedSwiftCode = .init(stringsDirectory: project.swiftCode.stringsDirectory,
                                 outputSwiftCodeFileDirectory: project.swiftCode.outputSwiftCodeFileDirectory)
    }
    
    let config = Config.Localization(apiKey: project.apiKey,
                                     sheetId: project.sheetId,
                                     outputDirectory: project.directoryPath,
                                     localizedSwiftCode: localizedSwiftCode)
    let module = LocalizationModuleFactory.make(config: config)
    
    try await module.localize(for: project.type)
    return Lingua.Projects.localizedMessage(project.title)
  }
}
