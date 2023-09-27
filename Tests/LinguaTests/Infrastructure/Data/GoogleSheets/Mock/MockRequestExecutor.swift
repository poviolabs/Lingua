import Foundation
@testable import LinguaLib

final class MockRequestExecutor: RequestExecutor {
  private(set) var receivedRequests: [any Request] = []
  var resultToReturn: Decodable?
  
  func send<R: Request>(_ request: R) async throws -> R.Response {
    receivedRequests.append(request)
    return resultToReturn as! R.Response
  }
}
