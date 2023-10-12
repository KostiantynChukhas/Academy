//
//  CoachesCoordinator.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

protocol CoachesCoordinatorTransitions: class {
}

class CoachesCoordinator {
    
    enum Route {
        case `self`
//        case noInternet(controller: NoInternetConnectionViewController)
        case filter(coachModel: [CoachModel])
        case menu
        case detail(coachModel: CoachModel, imageDataAvatar: Data)
    }
    
    private weak var presentedController: UIViewController?
    private weak var navigationController: UINavigationController?
    private weak var controller: CoachesViewController? = Storyboard.coaches.instantiate()
    private weak var transitions: CoachesCoordinatorTransitions?

    init(navigationController: UINavigationController?, transitions: CoachesCoordinatorTransitions?) {
        self.navigationController = navigationController
        self.transitions = transitions
        controller?.viewModel = CoachesViewModel(self)
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -
extension CoachesCoordinator {
    func route(to destination: Route) {
        switch destination {
        case .`self`: start()
//        case .noInternet: noInternet()
        case .menu: menu()
        case .detail(let coachModel, let imageDataAvatar): detail(coachModel: coachModel, imageDataAvatar: imageDataAvatar)
        case .filter(let coachModel): filter(coachModel: coachModel)
        }
    }
    
    func start() {
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: false)
        }
    }
    
    private func menu() {
        let coordinator = MenuCoordinator(navigationController: navigationController, transitions: self)
        coordinator.start()
    }
    
    private func filter(coachModel: [CoachModel]) {
        let coordinator = FilterCoachesCoordinator(navigationController: navigationController, transitions: self, coachModel: coachModel)
        coordinator.start()
    }
    
    private func detail(coachModel: CoachModel, imageDataAvatar: Data) {
        let coordinator = DetailCoachesCoordinator(navigationController: navigationController, transitions: self, coachModel: coachModel, imageDataAvatar: imageDataAvatar)
        coordinator.start()
    }
}

extension CoachesCoordinator: MenuCoordinatorTransitions {
}
extension CoachesCoordinator: DetailCoachesCoordinatorTransitions {
}
extension CoachesCoordinator: FilterCoachesCoordinatorTransitions {
    func selectFilter(_ positionName: [String]) {
        controller?.viewModel.selectFilter(positionName)
    }
    
}


