//
//  SmsVerificationViewModel.swift
//  Academy
//
//  Created by  on 31.03.2021.
//

import Foundation

protocol SmsVerificationViewModelType {
    var phone: String { get }
    
    func login(code: String, completion: @escaping (Result<SmsVerificationModel,Error>) -> Void)
    func resend()
    
    func route(to route: SmsVerificationCoordinator.Route)
}

class SmsVerificationViewModel: SmsVerificationViewModelType {
    private let coordinator: SmsVerificationCoordinator
    
    private var userService: UserServiceType = ServiceHolder.shared.get(by: UserService.self)
    
    let phone: String
    let authId: String
    
    init(_ coordinator: SmsVerificationCoordinator, phone: String, authId: String) {
        self.coordinator = coordinator
        
        self.phone = phone
        self.authId = authId
    }
    
    func login(code: String, completion: @escaping (Result<SmsVerificationModel,Error>) -> Void) {
        userService.smsVerification(authId: authId, code: code) { [weak self] result in
            switch result {
            case .success(let model):
                UserDefaults.standard.setValue(model.accessToken, forKey: Defines.Keys.accessTokenKey)
                UserDefaults.standard.setValue(model.refreshToken, forKey: Defines.Keys.refreshTokenKey)
                UserDefaults.standard.synchronize()
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func resend() {
        let trimmedPhone = phone.replacingOccurrences(of: " ", with: "")
        userService.login(userPhone: trimmedPhone, completion: { _ in })
    }
    
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -

extension SmsVerificationViewModel {
    
    func route(to route: SmsVerificationCoordinator.Route) {
        coordinator.route(to: route)
    }
    
}
