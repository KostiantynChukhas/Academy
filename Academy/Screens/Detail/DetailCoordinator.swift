
import UIKit

protocol DetailCoordinatorTransitions: class {
}

protocol DetailCoordinatorType: class {
    func start()
    func dismiss()
}

class DetailCoordinator: DetailCoordinatorType {
    
    weak var rootNav: UINavigationController?
    weak var rootVC: UIViewController?
    private weak var controller: DetailViewController? = Storyboard.detail.instantiate()
    private weak var transitions: DetailCoordinatorTransitions?
    
    init(withRootNav navController: UINavigationController?,transitions: DetailCoordinatorTransitions?, cardNumber: String) {
        self.rootNav = navController
        self.transitions = transitions
        controller?.viewModel = DetailViewModel(self, cardNumber: cardNumber)
    }
    
    init(withRootVC rootVC: UIViewController?,
         transitions: DetailCoordinatorTransitions?, cardNumber: String) {
        self.rootVC = rootVC
        self.transitions = transitions
        controller?.viewModel = DetailViewModel(self, cardNumber: cardNumber)
    }
    
    func start() {
        if let controller = controller {
            rootNav?.pushViewController(controller, animated: true)
        }
    }
    
    func dismiss() {
        rootNav?.popViewController(animated: true)
    }

    
    deinit {
        printDeinit(self)
    }
}
