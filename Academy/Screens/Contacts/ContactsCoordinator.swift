//
//  ContactsCoordinator.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

protocol ContactsCoordinatorTransitions: class {
}

class ContactsCoordinator {
    
    enum Route {
        case `self`
//        case noInternet(controller: NoInternetConnectionViewController)
        case menu
    }
    
    private weak var presentedController: UIViewController?
    private weak var navigationController: UINavigationController?
    private weak var controller: ContactsViewController? = Storyboard.contacts.instantiate()
    private weak var transitions: ContactsCoordinatorTransitions?

    init(navigationController: UINavigationController?, transitions: ContactsCoordinatorTransitions?) {
        self.navigationController = navigationController
        self.transitions = transitions
        controller?.viewModel = ContactsViewModel(self)
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -
extension ContactsCoordinator {
    func route(to destination: Route) {
        switch destination {
        case .`self`: start()
//        case .noInternet: noInternet()
        case .menu: menu()
        }
    }
    
    func start() {
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: false)
        }
    }
    
//    private func noInternet() {
//        let coordinator = NoInternetConnectionCoordinator(presentedController: controller)
//        coordinator.start()
//    }
   
    private func menu() {
        let coordinator = MenuCoordinator(navigationController: navigationController, transitions: self)
        coordinator.start()
    }
}

extension ContactsCoordinator: MenuCoordinatorTransitions {
}
