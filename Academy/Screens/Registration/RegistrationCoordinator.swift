//
//  RegistrationCoordinator.swift
//  Academy
//
//  Created by   on 24.04.2021.
//

import UIKit

protocol RegistrationCoordinatorTransitions: class {
    func didLoggedIn()
}

class RegistrationCoordinator {
    
    enum Route {
        case `self`
        case home
    }
    
    weak var transitions: RegistrationCoordinatorTransitions?
    
    private weak var navigationController: UINavigationController?
    private weak var controller: RegistrationViewController? = Storyboard.registration.instantiate()
    
    private var viewModel: RegistrationViewModelType? {
        return controller?.viewModel
    }
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        controller?.viewModel = RegistrationViewModel(self)
    }

    
    deinit {
        print("RegistrationCoordinator - deinit")
    }
}

extension RegistrationCoordinator {
    
    func route(to destination: Route) {
        switch destination {
        case .`self`: start()
        case .home: didLoggedIn()
        }
    }
    
    private func back() {
        navigationController?.popViewController(animated: true)
    }
    
    private func start() {
        controller?.viewModel = RegistrationViewModel(self)
        
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
// MARK: - Transitions -

extension RegistrationCoordinator {
    func didLoggedIn() {
        transitions?.didLoggedIn()
    }
}
