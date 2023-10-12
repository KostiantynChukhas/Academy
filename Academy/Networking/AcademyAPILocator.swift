
import Foundation

enum AcademyAPILocator {
  static var shared: AcademyAPI {
    guard let instance = instance else { fatalError("HydraAPI not populated") }
    return instance
  }
  private static var instance: AcademyAPI?
  static func populate(instance: AcademyAPI) {
    self.instance = instance
  }
}

typealias Fetcher<Request: AcademyRequest> = (
  _ request: Request,
  _ completion: @escaping (Result<Request.Response, Error>) -> Void
  ) -> Void

protocol DataFetcher {
  func send<Request: AcademyRequest>(
    _ request: Request,
    completion: @escaping (Result<Request.Response, Error>) -> Void
  )
}

extension AcademyAPI: DataFetcher {}
