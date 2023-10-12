//
//  HomeCoordinator.swift
//  Academy
//
//  Created by  on 31.03.2021.
//

import UIKit

protocol HomeCoordinatorTransitions: class {
}

class HomeCoordinator {
    enum Route {
        case `self`
        case back
        case details(cardNumber: String)
        case noInternet(controller: NoInternetConnectionViewController)
        case menu
    }
    
    fileprivate weak var controller: HomeViewController? = Storyboard.home.instantiate()
    fileprivate let navigationController: UINavigationController?
    private weak var transitions: HomeCoordinatorTransitions?
    
    init(navigationController: UINavigationController?, transitions: HomeCoordinatorTransitions?) {
        self.navigationController = navigationController
        self.transitions = transitions
        
        let backButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButtonItem
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        controller?.viewModel = HomeViewModel(self)
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -

extension HomeCoordinator {
    func route(to destination: Route) {
        switch destination {
        case .back: back()
        case .`self`: start()
        case .details(let cardNumber): details(cardNumber: cardNumber)
        case .noInternet: noInternet()
        case .menu: menu()
        }
    }
    
    private func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func start() {
        if let controller = controller {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    private func noInternet() {
        if let controller = controller {
            let coordinator = NoInternetConnectionCoordinator(presentedController: controller)
            coordinator.start()
        }
    }
    
    private func details(cardNumber: String) {
        let coordinator = DetailCoordinator(withRootNav: self.navigationController, transitions: nil, cardNumber: cardNumber)
        coordinator.start()
    }
    private func menu() {
        let coordinator = MenuCoordinator(navigationController: self.navigationController, transitions: self)
        coordinator.start()
    }
}

extension HomeCoordinator: MenuCoordinatorTransitions {
}
