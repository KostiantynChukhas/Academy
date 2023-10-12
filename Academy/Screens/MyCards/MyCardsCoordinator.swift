//
//  MyCardsCoordinator.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

protocol MyCardsCoordinatorTransitions: class {
}

class MyCardsCoordinator {
    enum Route {
        case `self`
        //        case noInternet(controller: NoInternetConnectionViewController)
        case menu
        case groupCards
    }
    
    private weak var presentedController: UIViewController?
    private weak var navigationController: UINavigationController?
    private weak var controller: MyCardsViewController? = Storyboard.myCards.instantiate()
    private weak var transitions: MyCardsCoordinatorTransitions?
    
    init(navigationController: UINavigationController?, transitions: MyCardsCoordinatorTransitions?) {
        self.navigationController = navigationController
        self.transitions = transitions
        controller?.viewModel = MyCardsViewModel(self)
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -
extension MyCardsCoordinator {
    func route(to destination: Route) {
        switch destination {
        case .`self`: start()
        //        case .noInternet: noInternet()
        case .menu: menu()
        case .groupCards: groupCards()
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
    
    private func groupCards() {
        let coordinator = GroupCardsCoordinator(navigationController: navigationController, transitions: self)
        coordinator.start()
    }
}

extension MyCardsCoordinator: MenuCoordinatorTransitions {
}
extension MyCardsCoordinator: GroupCardsCoordinatorTransitions {
}
