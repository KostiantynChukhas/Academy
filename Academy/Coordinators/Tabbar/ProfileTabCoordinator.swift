//
//  ProfileTabCoordinator.swift
//  Academy
//
//  Created by Konstantin Chukhas on 29.11.2021.
//

import Foundation
import Foundation
import UIKit
protocol ProfileTabCoordinatorTransitions: class {
    func didLogout()
}

protocol ProfileTabCoordinatorType {}

class ProfileTabCoordinator: NSObject, ProfileTabCoordinatorType, TabBarItemCoordinatorType {
    
    let rootController = UINavigationController()
    var tabBarItem = UITabBarItem(title: " Профіль", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile"))
    private weak var transitions: ProfileTabCoordinatorTransitions?
    
    init(transitions: ProfileTabCoordinatorTransitions?) {
        self.transitions = transitions
        super.init()
    }
    
    func start() {
        
        rootController.tabBarItem = tabBarItem
        rootController.navigationBar.barTintColor = .white
        rootController.navigationBar.isTranslucent = false
        rootController.view.backgroundColor = .white
        
        let profileCoordinator = ProfileCoordinator(navigationController: rootController, transitions: self)
        profileCoordinator.start()
    }
    deinit {
        print("ProfileTabCoordinator deinit")
    }
    
}

extension ProfileTabCoordinator: ProfileCoordinatorTransition {
    func didShopChanged() {}
    
    func didLogout() {
        transitions?.didLogout()
    }
}


