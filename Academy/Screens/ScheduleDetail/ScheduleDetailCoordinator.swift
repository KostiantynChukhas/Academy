//
//  ScheduleDetailCoordinator.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

protocol ScheduleDetailCoordinatorTransitions: class {
}

class ScheduleDetailCoordinator {
    
    enum Route {
        case `self`
        case back
//        case noInternet(controller: NoInternetConnectionViewController)
        case menu
        case filter
    }
    
    private weak var presentedController: UIViewController?
    private weak var navigationController: UINavigationController?
    private weak var controller: ScheduleDetailViewController? = Storyboard.scheduleDetail.instantiate()
    private weak var transitions: ScheduleDetailCoordinatorTransitions?
    
    init(navigationController: UINavigationController?, transitions: ScheduleDetailCoordinatorTransitions?, allGroupScheduleModel: GroupsModel) {
        self.navigationController = navigationController
        self.transitions = transitions
        controller?.viewModel = ScheduleDetailViewModel(self, allGroupScheduleModel: allGroupScheduleModel)
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -

extension ScheduleDetailCoordinator {
    func route(to destination: Route) {
        switch destination {
        case .`self`: start()
//        case .noInternet: noInternet()
        case .menu: menu()
        case .back: back()
        case .filter: filter()
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
    
    private func filter() {
        let coordinator = ScheduleFilterCoordinator(navigationController: navigationController, transitions: self)
        coordinator.start()
    }
    
    private func back() {
        navigationController?.popViewController(animated: true)
    }
}

extension ScheduleDetailCoordinator: MenuCoordinatorTransitions {
}
extension ScheduleDetailCoordinator: ScheduleFilterCoordinatorTransitions {
}

