

import Foundation
import PromiseKit

class AcademyAPI {
    
    static var apiPrefix: String {
        return "https://api.aihelps.com/v1/"
    }
    
    static var aplicationId: String {
        return "66f4608f-c2da-4a01-a81a-f6a3bd89a185"
    }
    
    static var applicationSecret: String {
        return "406a6386-aac4-4bce-b239-d44dcd780b93"
    }
    
    static var dataBaseCode: String {
        return "339642"
    }
    
    static func request(part: String) -> String {
        return "\(apiPrefix)\(part)"
    }
    
    typealias Completion<Request: AcademyRequest> = (Swift.Result<Request.Response, Error>) -> Void
    
    let refreshQueue = DispatchQueue(label: "com.org.com.refresh_queue", attributes: .concurrent)
    private let client: HTTPClient
    private var _isTokenRefreshing = false
    private var isTokenRefreshing: Bool {
        get { return refreshQueue.sync { _isTokenRefreshing } }
        set { refreshQueue.async(flags: .barrier) { self._isTokenRefreshing = newValue } }
    }
    
    private var _savedRequests: [DispatchWorkItem] = []
    private var savedRequests: [DispatchWorkItem] {
        get { return refreshQueue.sync { _savedRequests } }
        set { refreshQueue.async(flags: .barrier) { self._savedRequests = newValue } }
    }
    
    init(session: URLHTTPSession = URLSession.shared) {
        self.client = .init(session: session)
    }
    
    func send<Request: AcademyRequest>(_ request: Request, completion: @escaping Completion<Request>) {
        guard isTokenRefreshing == false else {
            saveRequest { [weak self] in
                self?.send(request, completion: completion)
            }
            return
        }
        client.send(request, requestBuilder: { try request.buildURLRequest(auth()) }, compeltion: { [weak self] result in
                self?.refreshTokenIfNeeded(request: request, result: result, completion: completion)
            })
    }
    
    func refreshTokenIfNeeded<Request: AcademyRequest>(request: Request, result: Swift.Result<(Data, HTTPURLResponse), HTTPRequestError>, completion: @escaping Completion<Request>) {
//        guard
//            case let .success((_, response)) = result else { //}, response.statusCode == 401 else {
            completion(transformResult(request: request, result: result))
//            return
//        }
        
//        saveRequest { [weak self] in
//            self?.send(request, completion: completion)
//        }
//        startRefresh(request: request, completion: completion)
    }
    
    private func transformResult<Request: AcademyRequest>(
        request: Request,
        result: Swift.Result<(Data, HTTPURLResponse), HTTPRequestError>
    ) -> Swift.Result<Request.Response, Error> {
        switch result {
        case let .success((data, response)):
            switch response.statusCode {
            case 200...399:
                do {
                    return .success(try request.response(data: data, urlResponse: response))
                } catch {
                    return .failure(AcademyAPIError.unknown)
                }
            case 400...:
                do {
                    return .failure(try request.failure(data: data, urlResponse: response))
                } catch {
                    return .failure(AcademyAPIError.unknown)
                }
            default:
                return .failure(AcademyAPIError.unknown)
            }
        case .failure(let error):
            switch error {
            case .requestError(let error):
                print(error.localizedDescription)
                return .failure(AcademyAPIError.unknown)
            case
                .invalidBaseURL,
                .responseError,
                .nonHTTPResponse:
                return .failure(AcademyAPIError.unknown)
            }
        }
    }
    
    private func startRefresh<Request: AcademyRequest>(
        request: Request,
        completion: @escaping Completion<Request>
    ) {
//        guard
//            let credentials = KeychainService.read(),
//            isTokenRefreshing == false
//        else
//        { return }
//
//        let request = RefreshTokenRequest(token: credentials.refreshToken)
//        isTokenRefreshing = true
//        client.send(
//            request,
//            requestBuilder: { try request.buildURLRequest(nil) }
//        ) { [weak self] result in
//            guard let `self` = self else { return }
//            self.isTokenRefreshing = false
//            let dispatcher = StoreLocator.shared.dispatchAndWait
//            let newResult = self.transformResult(request: request, result: result)
//            switch newResult {
//            case .success(let response):
//                self.handleSucces(response, dispatcher)
//                self.executeAllSavedRequests()
//            case .failure(let error):
//                self.handleFailure(error, dispatcher)
//            }
//        }
    }
    
    private func saveRequest(_ perform: @escaping () -> Void) {
        savedRequests.append(DispatchWorkItem { perform() })
    }
    
    private func executeAllSavedRequests() {
        savedRequests.forEach { $0.perform() }
        savedRequests.removeAll()
    }
    
    private func auth() -> HTTPRequestAuth? {
        let defaults = UserDefaults.standard
        
        guard let token = defaults.value(forKey: Defines.Keys.accessTokenKey) as? String, !token.isEmpty else { return nil }
        return HTTPRequestAuth(key: "Authorization", value: "Bearer \(token)")
    }
    
    deinit {
        printDeinit(self)
    }
    
}
