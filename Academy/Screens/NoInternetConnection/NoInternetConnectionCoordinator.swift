

import UIKit

protocol NoInternetConnectionCoordinatorTransitions: class {
}

protocol NoInternetConnectionCoordinatorType: class {
}

class NoInternetConnectionCoordinator: NoInternetConnectionCoordinatorType {
    
    private weak var presentedController: UIViewController?
    private weak var controller: NoInternetConnectionViewController? = Storyboard.noInternet.instantiate()
    weak var transitions: NoInternetConnectionCoordinatorTransitions?
    
    private var navigationController = UINavigationController()
    
    init(presentedController: UIViewController, transitions: NoInternetConnectionCoordinatorTransitions? = nil) {
        self.presentedController = presentedController
        self.transitions = transitions
        self.controller?.viewModel = NoInternetConnectionViewModel(self)
    }
    
    func start() {
        guard let controller = controller else { return }
        
        navigationController.setViewControllers([controller], animated: false)
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.setNavigationBarHidden(true, animated: false)
        
        presentedController?.present(navigationController, animated: true, completion: nil)
    }

    
    deinit {
        printDeinit(self)
    }
}
