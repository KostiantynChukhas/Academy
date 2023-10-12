//
//  FilterCoachesCoordinator.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

protocol FilterCoachesCoordinatorTransitions: AnyObject {
    func selectFilter(_ positionName: [String])
}

class FilterCoachesCoordinator {
    
    enum Route {
        case `self`
        case menu
    }
    
    private weak var presentedController: UIViewController?
    private weak var navigationController: UINavigationController?
    private weak var controller: FilterCoachesViewController? = Storyboard.filterCoaches.instantiate()
    private weak var transitions: FilterCoachesCoordinatorTransitions?

    init(navigationController: UINavigationController?, transitions: FilterCoachesCoordinatorTransitions?, coachModel: [CoachModel]) {
        self.navigationController = navigationController
        self.transitions = transitions
        controller?.viewModel = FilterCoachesViewModel(self)
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -
extension FilterCoachesCoordinator {
    func route(to destination: Route) {
        switch destination {
        case .`self`: start()
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
    
    func selectFilter(_ positionName: [String]) {
        navigationController?.dismiss(animated: true, completion: { [weak self] in
            self?.transitions?.selectFilter(positionName)
        })
    }
 
    private func menu() {
        let coordinator = MenuCoordinator(navigationController: navigationController, transitions: self)
        coordinator.start()
    }
}

extension FilterCoachesCoordinator: MenuCoordinatorTransitions {
}
