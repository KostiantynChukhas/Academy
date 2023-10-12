//
//  ScheduleCategoryCoordinator.swift
//  Academy
//
//  Created by Konstantin Chukhas on 13.12.2021.
//

import UIKit

protocol ScheduleCategoryCoordinatorTransitions: class {
}

class ScheduleCategoryCoordinator {
    enum Route {
        case `self`
        case menu
        case schedule(id: String)
    }
    
    private weak var presentedController: UIViewController?
    private weak var navigationController: UINavigationController?
    private weak var controller: ScheduleCategoryViewController? = Storyboard.scheduleCategory.instantiate()
    private weak var transitions: ScheduleCategoryCoordinatorTransitions?

    init(navigationController: UINavigationController?, transitions: ScheduleCategoryCoordinatorTransitions?) {
        self.navigationController = navigationController
        self.transitions = transitions
        controller?.viewModel = ScheduleCategoryViewModel(self)
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -
extension ScheduleCategoryCoordinator {
    func route(to destination: Route) {
        switch destination {
        case .`self`: start()
        case .menu: menu()
        case .schedule(let id): schedule(id: id)
        }
    }
    
    func start() {
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: false)
        }
    }
    
    private func schedule(id: String) {
        let coordinator = ScheduleCoordinator(navigationController: navigationController, transitions: self, id: id)
        coordinator.start()
    }
    
    private func menu() {
        let coordinator = MenuCoordinator(navigationController: navigationController, transitions: self)
        coordinator.start()
    }
}

extension ScheduleCategoryCoordinator: MenuCoordinatorTransitions {
}
extension ScheduleCategoryCoordinator: ScheduleCoordinatorTransitions {
}
