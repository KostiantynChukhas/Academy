//
//  ProfileCoordinator.swift
//  Academy
//
//  Created by  on 31.03.2021.
//

import UIKit

protocol ProfileCoordinatorTransition: class {
    func didLogout()
}

class ProfileCoordinator {
    enum Route {
        case `self`
        case back
    }
    
    fileprivate weak var controller: ProfileViewController? = Storyboard.profile.instantiate()
    fileprivate let navigationController: UINavigationController?
    private weak var transitions: ProfileCoordinatorTransition?
    
    
    init(navigationController: UINavigationController?, transitions: ProfileCoordinatorTransition?) {
        self.navigationController = navigationController
        self.transitions = transitions
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        controller?.viewModel = ProfileViewModel(self)
    }
    
    func logout() {
        transitions?.didLogout()
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -

extension ProfileCoordinator {
    func route(to destination: Route) {
        switch destination {
        case .back: back()
        case .`self`: start()
        }
    }
    
    private func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
     func start() {
        if let controller = controller {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController?.setViewControllers([controller], animated: true)
        }
    }
}

