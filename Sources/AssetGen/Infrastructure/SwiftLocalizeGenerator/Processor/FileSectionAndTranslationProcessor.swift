import Foundation

struct FileSectionAndTranslationProcessor: MergableFileProcessor {
  private let fileManagerProvider: FileManagerProvider
  private let fileProcessors: [FileProcessor]
  
  init(fileManagerProvider: FileManagerProvider = DefaultFileManager(),
       fileProcessors: [FileProcessor] = [StringsFileProcessor(), StringsDictFileProcessor()]) {
    self.fileManagerProvider = fileManagerProvider
    self.fileProcessors = fileProcessors
  }
  
  func processAndMergeFiles(at path: String) -> (sections: [String: Set<String>], translations: [String: String]) {
    let enumerator = fileManagerProvider.manager.enumerator(atPath: path)

    var allResults: [(String, Set<String>, [String: String])] = []
    
    while let file = enumerator?.nextObject() as? String {
      let filePath = URL(fileURLWithPath: path).appendingPathComponent(file).path
      let results = fileProcessors
        .filter { $0.canHandle(file: file) }
        .compactMap { processor -> (String, Set<String>, [String: String])? in
          guard let section = processor.sectionName(for: file) else { return nil }
          let result = processor.processFile(section: section, path: filePath)
          return (section, result.sections, result.translations)
        }
      
      allResults.append(contentsOf: results)
    }
    
    return merge(results: allResults)
  }
}

private extension FileSectionAndTranslationProcessor {
  func merge(results: [(String, Set<String>, [String: String])]) -> (sections: [String: Set<String>], translations: [String: String]) {
     var sections: [String: Set<String>] = [:]
     var translations: [String: String] = [:]
     
     for (section, resultSections, resultTranslations) in results {
       // Merge sections
       if let existingSections = sections[section] {
         sections[section] = existingSections.union(resultSections)
       } else {
         sections[section] = resultSections
       }
       
       // Merge translations
       translations.merge(resultTranslations) { (_, new) in new }
     }
     
     return (sections, translations)
   }
}

