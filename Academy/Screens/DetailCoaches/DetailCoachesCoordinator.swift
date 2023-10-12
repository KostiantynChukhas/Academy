//
//  DetailCoachesCoordinator.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

protocol DetailCoachesCoordinatorTransitions: class {
}

class DetailCoachesCoordinator {
    
    enum Route {
        case `self`
        case back
//        case noInternet(controller: NoInternetConnectionViewController)
        case menu
    }
    
    private weak var presentedController: UIViewController?
    private weak var navigationController: UINavigationController?
    private weak var controller: DetailCoachesViewController? = Storyboard.detailCoaches.instantiate()
    private weak var transitions: DetailCoachesCoordinatorTransitions?

    init(navigationController: UINavigationController?, transitions: DetailCoachesCoordinatorTransitions?, coachModel: CoachModel, imageDataAvatar: Data) {
        self.navigationController = navigationController
        self.transitions = transitions
        controller?.viewModel = DetailCoachesViewModel(self, coachModel: coachModel, imageDataAvatar: imageDataAvatar)
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -
extension DetailCoachesCoordinator {
    func route(to destination: Route) {
        switch destination {
        case .`self`: start()
        case .back: back()
//        case .noInternet: noInternet()
        case .menu: menu()
        }
    }
    
    func start() {
        if let controller = controller {
            navigationController?.modalPresentationStyle = .overCurrentContext
            navigationController?.modalTransitionStyle = .crossDissolve
            controller.modalPresentationStyle = .overCurrentContext
            
            navigationController?.present(controller, animated: false, completion: nil)
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
   
    private func back() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension DetailCoachesCoordinator: MenuCoordinatorTransitions {
}
