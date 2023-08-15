import Foundation

struct SwiftLocalizedCodeFileGenerator: LocalizedCodeFileGenerating {
  private let fileProcessor: MergableFileProcessor
  private let contentFileCreator: ContentFileCreatable
  private let outputStringBuilder: LocalizedSwiftCodeOutputStringBuilder
  private let logger: Logger
  private let fileName: String
  
  init(fileProcessor: MergableFileProcessor,
       contentFileCreator: ContentFileCreatable,
       outputStringBuilder: LocalizedSwiftCodeOutputStringBuilder,
       logger: Logger,
       fileName: String) {
    self.fileProcessor = fileProcessor
    self.contentFileCreator = contentFileCreator
    self.outputStringBuilder = outputStringBuilder
    self.logger = logger
    self.fileName = fileName
  }
  
  func generate(from path: String, outputPath: String) {
    let (sections, translations) = fileProcessor.processAndMergeFiles(at: path)
    
    let output = outputStringBuilder.buildOutput(sections: sections, translations: translations)
    
    do {
      try contentFileCreator.createFiles(with: output,
                                         fileName: fileName,
                                         outputFolder: URL(fileURLWithPath: outputPath))
      logger.log("Created \(fileName) file", level: .success)
    } catch {
      logger.log(error.localizedDescription, level: .error)
    }
  }
}
