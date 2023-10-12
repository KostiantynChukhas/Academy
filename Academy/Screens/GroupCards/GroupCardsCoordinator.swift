//
//  GroupCardsCoordinator.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

protocol GroupCardsCoordinatorTransitions: class {
}

class GroupCardsCoordinator {
    enum Route {
        case `self`
//        case noInternet(controller: NoInternetConnectionViewController)
        case menu
        case cards
    }
    
    private weak var presentedController: UIViewController?
    private weak var navigationController: UINavigationController?
    private weak var controller: GroupCardsViewController? = Storyboard.groupCards.instantiate()
    private weak var transitions: GroupCardsCoordinatorTransitions?

    init(navigationController: UINavigationController?, transitions: GroupCardsCoordinatorTransitions?) {
        self.navigationController = navigationController
        self.transitions = transitions
        controller?.viewModel = GroupCardsViewModel(self)
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -
extension GroupCardsCoordinator {
    func route(to destination: Route) {
        switch destination {
        case .`self`: start()
//        case .noInternet: noInternet()
        case .menu: menu()
        case .cards: cards()
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
    
    private func cards() {
        let coordinator = MyCardsCoordinator(navigationController: navigationController, transitions: self)
        coordinator.start()
    }
}

extension GroupCardsCoordinator: MenuCoordinatorTransitions {
}

extension GroupCardsCoordinator: MyCardsCoordinatorTransitions {
}
