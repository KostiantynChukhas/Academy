//
//  TabBarCoordinator.swift
//  Academy
//
//  Created by Konstantin Chukhas on 29.11.2021.
//

import Foundation
import UIKit

enum TabBarItems: Int {
    case tabMain = 0
    case tabProfile
}

protocol TabBarCoordinatorTransitions: class {
    func didLogout()
}

protocol TabBarItemCoordinatorType {
    var rootController: UINavigationController { get }
    var tabBarItem: UITabBarItem { get }
}


class TabBarCoordinator: NSObject {
    private weak var window: UIWindow?
    private weak var transitions: TabBarCoordinatorTransitions?
    
    private let tabBarController = UITabBarController()
    private var tabCoordinators: [TabBarItemCoordinatorType] = []
    
    
    init(window: UIWindow, transitions: TabBarCoordinatorTransitions?) {
        super.init()
        self.window = window
        self.transitions = transitions
        
        tabBarController.tabBar.tintColor = Style.Color.primaryColor
        tabBarController.tabBar.barTintColor = Style.Color.backgroundColor
        tabBarController.tabBar.isTranslucent = false
        self.tabBarController.tabBar.backgroundColor = Style.Color.backgroundColor
        tabBarController.tabBar.unselectedItemTintColor = .white
        tabBarController.tabBar.itemPositioning = .fill
        
        let firstTabCoord = MainTabCoordinator(transitions: self)
        firstTabCoord.start()
        
        let secondTabCoord = ProfileTabCoordinator(transitions: self)
        secondTabCoord.start()
        
        tabCoordinators = [firstTabCoord, secondTabCoord]
        tabBarController.viewControllers = tabCoordinators.map({ $0.rootController })
        
    }
    
    func start(animated: Bool = false) {
        guard let window = window else { return }
        tabBarController.delegate = self
        
        if animated { // from login
            UIView.transition(with: window, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: { [weak self] in
                window.rootViewController = self?.tabBarController
            }, completion: nil)
        } else {
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }
    
    deinit {
        print("TabBarCoordinator deinit")
    }
    
}

// MARK: - TabBarCoordinator {
extension TabBarCoordinator {
    
    func getTabCoordinator<T>(index: TabBarItems) -> T? {
        let tabIndex = index.rawValue
        if tabIndex < tabCoordinators.count {
            return tabCoordinators[tabIndex] as? T
        }
        return nil
    }
    
    func selectTab(index: TabBarItems) {
        let tabIndex = index.rawValue
        tabBarController.selectedIndex = tabIndex
        let root = getTabCoordinatorRootNavigation(index: index)
//        root?.popViewController(animated: true)
        root?.popToRootViewController(animated: true)
    }
    
    private func getTabCoordinatorRootNavigation(index: TabBarItems) -> UINavigationController? {
        let tabIndex = index.rawValue
        if tabIndex < tabCoordinators.count {
            let tabItem = tabCoordinators[tabIndex]
            return tabItem.rootController
        }
        return nil
    }
    
}

extension TabBarCoordinator: MainTabCoordinatorTransitions{
    func didShowCatalog() {
//        self.selectTab(index: .tabCatalog)
    }
}

extension TabBarCoordinator: ProfileTabCoordinatorTransitions {
    func didLogout() {
        transitions?.didLogout()
    }
}

extension TabBarCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        switch viewController {
        case getTabCoordinatorRootNavigation(index: .tabMain):
            let root = getTabCoordinatorRootNavigation(index: .tabProfile)
            root?.popToRootViewController(animated: true)
            return true
        case getTabCoordinatorRootNavigation(index: .tabProfile):
            let root = getTabCoordinatorRootNavigation(index: .tabProfile)
            root?.popToRootViewController(animated: true)
            return true
        default:
            return true
        }
    }
}
