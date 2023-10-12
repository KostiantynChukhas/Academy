//
//  ScheduleFilterCoordinator.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

protocol ScheduleFilterCoordinatorTransitions: class {
}

class ScheduleFilterCoordinator {
        enum Route {
            case `self`
            case back
        }
        
        private weak var presentedController: UIViewController?
        private weak var navigationController: UINavigationController?
        private weak var controller: ScheduleFilterViewController? = Storyboard.scheduleFilter.instantiate()
        private weak var transitions: ScheduleFilterCoordinatorTransitions?

        init(navigationController: UINavigationController?, transitions: ScheduleFilterCoordinatorTransitions?) {
            self.navigationController = navigationController
            self.transitions = transitions
            controller?.viewModel = ScheduleFilterViewModel(self)
        }
        
        deinit {
            printDeinit(self)
        }
    }

// MARK: - Navigation -

extension ScheduleFilterCoordinator {
    func route(to destination: Route) {
        switch destination {
        case .`self`: start()
        case .back: back()
//        case .noInternet: noInternet()
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
    
    private func back() {
            navigationController?.dismiss(animated: true, completion: nil)
        }
}
