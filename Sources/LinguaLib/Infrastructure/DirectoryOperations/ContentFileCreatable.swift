import Foundation

public protocol ContentFileCreatable {
  func createFiles(with content: String, fileName: String, outputFolder: URL) throws
  func createFilesInCurrentDirectory(with content: String, fileName: String) throws
}

public class ContentFileCreator: ContentFileCreatable {
  private let contentWriter: ContentWritable
  private let fileManagerProvider: FileManagerProvider
  
  public init(contentWriter: ContentWritable = FileContentWriter(),
       fileManagerProvider: FileManagerProvider = DefaultFileManager()) {
    self.contentWriter = contentWriter
    self.fileManagerProvider = fileManagerProvider
  }
  
  public func createFiles(with content: String, fileName: String, outputFolder: URL) throws {
    try contentWriter.write(content, to: outputFolder.appendingPathComponent(fileName))
  }
  
  public func createFilesInCurrentDirectory(with content: String, fileName: String) throws {
    let currentDirectoryURL = URL(fileURLWithPath: fileManagerProvider.manager.currentDirectoryPath)
    try createFiles(with: content, fileName: fileName, outputFolder: currentDirectoryURL)
  }
}
