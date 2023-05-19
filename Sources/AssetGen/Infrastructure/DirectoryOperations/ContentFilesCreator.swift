import Foundation

protocol ContentFilesCreator {
  func createFiles(with content: String, fileName: String, outputFolder: URL) throws
  func createFilesInCurrentDirectory(with content: String, fileName: String) throws
}

class DefaultContentFilesCreator: ContentFilesCreator {
  private let contentWriter: ContentWriter
  private let fileManager: FileManagerProvider
  
  init(contentWriter: ContentWriter = DefaultContentWriter(),
       fileManager: FileManagerProvider = DefaultFileManager()) {
    self.contentWriter = contentWriter
    self.fileManager = fileManager
  }
  
  func createFiles(with content: String, fileName: String, outputFolder: URL) throws {
    try contentWriter.write(content, to: outputFolder.appendingPathComponent(fileName))
  }
  
  func createFilesInCurrentDirectory(with content: String, fileName: String) throws {
    let currentDirectoryURL = URL(fileURLWithPath: fileManager.fileManager.currentDirectoryPath)
    try createFiles(with: content, fileName: fileName, outputFolder: currentDirectoryURL)
  }
}
