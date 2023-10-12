
import UIKit

protocol MenuCoordinatorTransitions: class {
}


class MenuCoordinator {
    
    enum Route {
        case `self`
        case dismiss
        case schedule
        case contacts
        case coaches
        case cards
        case home
    }
    
    weak var navigationController: UINavigationController?
    weak var viewController: UIViewController?
    private weak var controller: MenuViewController? = Storyboard.menu.instantiate()
    private weak var transitions: MenuCoordinatorTransitions?
    
    init(navigationController: UINavigationController?, transitions: MenuCoordinatorTransitions?) {
        self.navigationController = navigationController
        self.transitions = transitions
        controller?.viewModel = MenuViewModel(self)
    }
    
    deinit {
        printDeinit(self)
    }
}

//Navigation
extension MenuCoordinator {
    func route(to destination: Route) {
        switch destination {
        case .`self`: start()
        case .dismiss: dismiss()
        case .schedule: schedule()
        case .contacts: contacts()
        case .coaches: coaches()
        case .cards: cards()
        case .home: home()
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
    
    private func dismiss() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    private func schedule() {
        let coordinator = ScheduleCategoryCoordinator(navigationController: navigationController, transitions: self)
        coordinator.start()
    }
    
    private func contacts() {
        let coordinator = ContactsCoordinator(navigationController: navigationController, transitions: self)
        coordinator.start()
    }
    
    private func coaches() {
        let coordinator = CoachesCoordinator(navigationController: navigationController, transitions: self)
        coordinator.start()
    }
    
    private func cards() {
        let coordinator = MyCardsCoordinator(navigationController: navigationController, transitions: self)
        coordinator.start()
    }
    
    private func home() {
        let coordinator = HomeCoordinator(navigationController: navigationController, transitions: self)
        coordinator.start()
    }
}

extension MenuCoordinator: ScheduleCategoryCoordinatorTransitions {
}
extension MenuCoordinator: ContactsCoordinatorTransitions {
}
extension MenuCoordinator: CoachesCoordinatorTransitions {
}
extension MenuCoordinator: MyCardsCoordinatorTransitions {
}
extension MenuCoordinator: HomeCoordinatorTransitions {
}


