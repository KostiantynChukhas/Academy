//
//  ScheduleCoordinator.swift
//  Academy
//
//  Created by Konstantin Chukhas on 12.11.2021.
//

import UIKit

protocol ScheduleCoordinatorTransitions: class {
}

class ScheduleCoordinator {
    enum Route {
        case `self`
        case back
//        case noInternet(controller: NoInternetConnectionViewController)
        case menu
        case detail(allGroupScheduleModel: GroupsModel)
    }
    
    private weak var presentedController: UIViewController?
    private weak var navigationController: UINavigationController?
    private weak var controller: ScheduleViewController? = Storyboard.schedule.instantiate()
    private weak var transitions: ScheduleCoordinatorTransitions?

    init(navigationController: UINavigationController?, transitions: ScheduleCoordinatorTransitions?, id: String) {
        self.navigationController = navigationController
        self.transitions = transitions
        controller?.viewModel = ScheduleViewModel(self, categoryId: id)
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -
extension ScheduleCoordinator {
    func route(to destination: Route) {
        switch destination {
        case .`self`: start()
        case .back: back()
//        case .noInternet: noInternet()
        case .menu: menu()
        case .detail(let allGroupScheduleModel): detail(allGroupScheduleModel: allGroupScheduleModel)
        }
    }
    
    func start() {
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: false)
        }
    }
    
    private func back() {
        navigationController?.popViewController(animated: true)
    }
    
    private func detail(allGroupScheduleModel: GroupsModel) {
        let coordinator = ScheduleDetailCoordinator(navigationController: navigationController, transitions: self, allGroupScheduleModel: allGroupScheduleModel)
        coordinator.start()
    }
    
    private func menu() {
        let coordinator = MenuCoordinator(navigationController: navigationController, transitions: self)
        coordinator.start()
    }
}

extension ScheduleCoordinator: MenuCoordinatorTransitions {
}
extension ScheduleCoordinator: ScheduleDetailCoordinatorTransitions {
}
