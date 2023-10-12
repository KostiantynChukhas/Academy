//
//  LoginViewModel.swift
//  Academy
//
//  Created by  on 31.03.2021.
//

import Foundation

protocol LoginViewModelType {
    func login(phone: String, completion: @escaping ((Result<String, Error>) -> Void))
    func route(to route: LoginCoordinator.Route)
}

class LoginViewModel: LoginViewModelType {
    private var coordinator: LoginCoordinator
    private var userService: UserServiceType
    
    init(_ coordinator: LoginCoordinator) {
        self.coordinator = coordinator
        self.userService = ServiceHolder.shared.get(by: UserService.self)
    }
    
    func login(phone: String, completion: @escaping ((Result<String, Error>) -> Void)) {
        let trimPhone = phone.replacingOccurrences(of: " ", with: "")
        
        userService.login(userPhone: trimPhone, completion: completion)
    }
    
    func route(to route: LoginCoordinator.Route) {
        coordinator.route(to: route)
    }
    
    func login() {
        coordinator.didLoggedIn()
    }
    
    deinit {
        printDeinit(self)
    }
}
