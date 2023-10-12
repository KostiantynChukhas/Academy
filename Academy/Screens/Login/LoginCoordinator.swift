//
//  LoginCoordinator.swift
//  Academy
//
//  Created by  on 31.03.2021.
//

import UIKit

protocol LoginCoordinatorTransitions: class {
    func didLoggedIn()
}

class LoginCoordinator {
    enum Route {
        case `self`
        case smsVerification(phone: String,authId: String)
        case registration
    }
    
    weak var transitions: LoginCoordinatorTransitions?
    
    private weak var navigationController: UINavigationController?
    private weak var controller: LoginViewController? = Storyboard.login.instantiate()
    
    private var viewModel: LoginViewModelType? {
        return controller?.viewModel
    }
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        controller?.viewModel = LoginViewModel(self)
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -

extension LoginCoordinator {
    func route(to destination: Route) {
        switch destination {
        case .`self`: start()
        case .smsVerification(let phone, let authId): smsVerification(phone: phone, authId: authId)
        case .registration: registration()
        }
    }
    
    private func start() {
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    private func smsVerification(phone: String, authId: String) {
        let coordinator = SmsVerificationCoordinator(navigationController: navigationController)
        coordinator.transitions = self
        coordinator.route(to: .`self`(phone: phone, authId: authId))
    }
    
    private func registration() {
        let coordinator = RegistrationCoordinator(navigationController: navigationController)
        coordinator.transitions = self
        coordinator.route(to: .`self`)
    }
}

// MARK: - SmsVerificationCoordinatorTransitions -

extension LoginCoordinator: SmsVerificationCoordinatorTransitions {
    func didLoggedIn() {
        transitions?.didLoggedIn()
    }
}

extension LoginCoordinator: RegistrationCoordinatorTransitions {
    
}

