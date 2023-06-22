import Foundation

final class DirectoryEnumeratorStub: FileManager.DirectoryEnumerator {
  let files: [String]
  private var currentIndex: Int = 0
  
  init(files: [String]) {
    self.files = files
    super.init()
  }
  
  override func nextObject() -> Any? {
    guard currentIndex < files.count else { return nil }
    let nextFile = files[currentIndex]
    currentIndex += 1
    return nextFile
  }
}
