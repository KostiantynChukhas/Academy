//
//  SmsVerificationCoordinator.swift
//  Academy
//
//  Created by  on 31.03.2021.
//

import UIKit

protocol SmsVerificationCoordinatorTransitions: class {
    func didLoggedIn()
}

class SmsVerificationCoordinator {
    enum Route {
        case `self`(phone: String, authId: String)
        case home
        case back
    }
    
    weak var transitions: SmsVerificationCoordinatorTransitions?
    
    private weak var navigationController: UINavigationController?
    private weak var controller: SmsVerificationViewController? = Storyboard.smsVerification.instantiate()
    
    private var viewModel: SmsVerificationViewModelType? {
        return controller?.viewModel
    }
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -

extension SmsVerificationCoordinator {
    func route(to destination: Route) {
        switch destination {
        case .back: back()
        case .`self`(let phone, let authId): start(phone: phone, authId: authId)
        case .home: didLoggedIn()
        }
    }
    
    private func back() {
        navigationController?.popViewController(animated: true)
    }
    
    private func start(phone: String, authId: String) {
        controller?.viewModel = SmsVerificationViewModel(self, phone: phone, authId: authId)
        
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

// MARK: - Transitions -

extension SmsVerificationCoordinator {
    func didLoggedIn() {
        transitions?.didLoggedIn()
    }
}
