

import Foundation

protocol NoInternetConnectionViewModelType {
    
}

class NoInternetConnectionViewModel: NoInternetConnectionViewModelType {
    
    fileprivate let coordinator: NoInternetConnectionCoordinatorType
    
    init(_ coordinator: NoInternetConnectionCoordinatorType) {
        self.coordinator = coordinator
    }
    
    deinit {
        printDeinit(self)
    }
}
