

import Foundation

protocol MenuViewModelType {
    func route(to route: MenuCoordinator.Route)
}

class MenuViewModel: MenuViewModelType {
    
    fileprivate let coordinator: MenuCoordinator
    
    init(_ coordinator: MenuCoordinator) {
        self.coordinator = coordinator
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - Navigation -

extension MenuViewModel {
    func route(to route: MenuCoordinator.Route) {
        coordinator.route(to: route)
    }
}
