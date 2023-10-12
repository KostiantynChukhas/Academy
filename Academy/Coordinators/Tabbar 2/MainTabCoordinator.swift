//
//  MainTabCoordinator.swift
//  Academy
//
//  Created by Konstantin Chukhas on 29.11.2021.
//

import Foundation
import UIKit

protocol MainTabCoordinatorTransitions: class {
    func didLogout()
}

protocol MainTabCoordinatorType {
}

class MainTabCoordinator: MainTabCoordinatorType, TabBarItemCoordinatorType {
    let rootController = UINavigationController()
    var tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
    private weak var transitions: MainTabCoordinatorTransitions?
    
    init(transitions: MainTabCoordinatorTransitions?) {
        self.transitions = transitions
    }
    
    func start() {
        
        rootController.tabBarItem = tabBarItem
        rootController.navigationBar.barTintColor = Style.Color.primaryColor
        rootController.navigationBar.isTranslucent = false
//        rootController.view.backgroundColor = Style.Color.backgroundColor
        
        let coordinator = HomeCoordinator(navigationController: rootController, transitions: self)
        //MainCoordinator(navigationController: rootController, transitions: self)
        coordinator.start()
    }
    
    deinit {
        print("MainTabCoordinator deinit")
    }
    
}

extension MainTabCoordinator: HomeCoordinatorTransitions {
   
    func didLogout() {
        transitions?.didLogout()
    }
    
}
