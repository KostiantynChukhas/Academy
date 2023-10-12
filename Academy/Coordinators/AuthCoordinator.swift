//
//  AuthCoordinator.swift
//  Academy
//
//  Created by  on 31.03.2021.
//

import UIKit

protocol AuthCoordinatorTransitions: class {
    func didLoggedIn()
}

class AuthCoordinator {
    private var window: UIWindow
    
    weak var transitions: AuthCoordinatorTransitions?
    
    private lazy var root: UINavigationController = {
        let root = UINavigationController()
        root.setNavigationBarHidden(true, animated: false)
        return root
    }()
    
    private var coordinator: LoginCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = root
        
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        coordinator = LoginCoordinator(navigationController: root)
        coordinator?.transitions = self
        coordinator?.route(to: .`self`)
    }
}

// MARK: - LoginCoordinatorTransitions -

extension AuthCoordinator: LoginCoordinatorTransitions {
    func didLoggedIn() {
        transitions?.didLoggedIn()
    }
}
