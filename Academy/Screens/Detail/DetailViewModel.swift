
import Foundation

protocol DetailViewModelType {
    func back()
    func getCardNumber() -> String
}

class DetailViewModel: DetailViewModelType {
    
    fileprivate let coordinator: DetailCoordinatorType
//    private var clientModel: ClientModel
    private var cardNumber: String
    
    init(_ coordinator: DetailCoordinatorType, cardNumber: String) {
        self.coordinator = coordinator
        self.cardNumber = cardNumber
    }
    
    func getCardNumber() -> String {
        return cardNumber
    }
    
    func back() {
        coordinator.dismiss()
    }
    
    deinit {
        printDeinit(self)
    }
}
